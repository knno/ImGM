import { ImGMAbort } from "./class/error.js"

const NAME = "<program>"

export default class Terminal {
	static defaultWidth = 80
	static defaultHeight = 24
	static maxProgressBarWidth = 50

	/**
	 * Initialize terminal
	 *
	 * @param {Program} program
	 */
	constructor(program) {
		this.enabled = program._useTerminal
		this.program = program
		this.colors = this.program.colors
		this.logs = []
		this.fullLogs = []
		this.activeTasks = {}
		this.width = process.stdout.columns || Terminal.defaultWidth
		this.height = process.stdout.rows - 1 || Terminal.defaultHeight
		this.progress = 0
		this.progressMax = 100
		this._progressBarVisible = false
		this._animBraille = ["⠈", "⠐", "⠠", "⠄", "⠂", "⠁"]
		this._animBrailleIndex = 0
		this._interval = undefined

		if (this.enabled) {
			this.reserveLines()
			process.on("exit", (code) => {
				this.onFinish(code)
			})
			this.clearLoop()
			process.on("SIGINT", this._abort.bind(this))
		}
	}

	loop() {
		if (this.enabled) {
			this._animBrailleIndex++
			if (this._animBrailleIndex >= this._animBraille.length) {
				this._animBrailleIndex = 0
			}
			const taskNames = Object.keys(this.activeTasks)
			for (let i = 0; i < taskNames.length; i++) {
				if (this.activeTasks[taskNames[i]].status == "processing") {
					this.updateTask(taskNames[i])
				}
			}
			this.renderTasks()
		}
	}

	clearLoop() {
		if (this._interval) clearInterval(this._interval)
	}

	loopBreakCheck(cond) {
		if (cond()) {
			this.clearLoop()
			return true
		}
		return false
	}

	main(cond, then) {
		this._interval ??= setInterval(() => {
			this.loop.bind(this)()
			if (this.loopBreakCheck.bind(this)(cond)) {
				try {
					then()
				} catch (error) {
					this.program.Logger.error(`${error.message}`, { error })
				}
			}
		}, 50)
	}

	_abort() {
		this.program.Logger.error("Aborted", { name: NAME })
		this.program.abort()
		process.exit(0)
	}

	/**
	 * Reserve lines initially for layout
	 */
	reserveLines() {
		if (!this.enabled) return false

		const reservedLines = this.height
		for (let i = 0; i < reservedLines; i++) {
			process.stdout.write(" \n") // Move cursor down to lines
		}
		this.moveTop()
	}

	/**
	 * Adjust terminal layout on resize
	 */
	adjustToResize() {
		if (!this.enabled) return false
		this.width = process.stdout.columns || Terminal.defaultWidth
		this.height = process.stdout.rows - 1 || Terminal.defaultHeight
		this.render() // Re-render the terminal with updated dimensions
	}

	/**
	 * Set the maximum progress bar value
	 *
	 * @param {Number} max - maximum
	 */
	setProgressMax(max) {
		if (!this.enabled) return false
		this.progressMax = Math.max(1, max)
	}

	/**
	 * Format messages with color and append them to the log
	 *
	 * @param {String} message
	 */
	log(message) {
		if (!this.enabled) return false
		this.logs.push(
			this.colors.ansiClean(message).length > this.width
				? this.colors.ansiSlice(message, 0, this.width - 1)
				: message
		)
		this.fullLogs.push(message)

		const maxLogLines = Math.floor(this.getLogHeight())
		if (this.logs.length > maxLogLines) this.logs.shift()

		this.renderLogs()
	}

	/**
	 * Update active task status
	 *
	 * @param {String} taskName - Task name
	 * @param {String} [status] - Task status
	 * @param {Number} [time] - Time taken (optional)
	 */
	updateTask(taskName, status = undefined, time = null) {
		if (!this.enabled) return false
		if (process.aborted) {
			throw new ImGMAbort()
		}

		status ??= this.activeTasks[taskName]?.status
		time ??= this.activeTasks[taskName]?.time

		const statusIcon =
			{
				processing: this.colors.get(
					"yellow",
					/*"⏳"*/ this._animBraille[this._animBrailleIndex] + " "
				),
				idle: this.colors.get("blue", "🔵"),
				success: this.colors.get("green", "✅"),
				error: this.colors.get("red", "❌"),
			}[status] || this.colors.get("gray", "...")

		const timeInfo = time
			? ` - ${this.colors.get("blue", time.toFixed(2) + "s")}`
			: ""

		this.activeTasks[taskName] = Object.assign(
			this.activeTasks[taskName] ?? {},
			{
				fullMessage: `${statusIcon} ${taskName}${timeInfo}`,
				status: status,
				time: time,
			}
		)
		this.renderTasks(taskName)
	}

	/**
	 * Update the progress bar
	 *
	 * @param {Number} progress
	 */
	setProgress(progress) {
		if (!this.enabled) return false

		this.progress = Math.min(Math.max(progress, 0), this.progressMax)
		this.renderProgressBar()
	}

	/**
	 * Get the height available for logs
	 *
	 * @return {Number}
	 */
	getLogHeight() {
		return this.height - Object.keys(this.activeTasks).length - 5 // Progress bar + 2 section titles
	}

	/**
	 * Render all sections
	 */
	render() {
		if (!this.enabled) return false
		this.renderLogs()
		this.renderTasks()
		this.renderProgressBar()
	}

	/**
	 * Clear the current line before writing
	 */
	clearLine() {
		process.stdout.write("\x1b[2K") // Clear the current line
	}

	/**
	 * Move the cursor + write to line, clearing it first
	 *
	 * @param {Number} lineNumber - The target line number (1-based)
	 * @param {String} content - The content
	 */
	moveAndWrite(lineNumber, content) {
		process.stdout.write(`\x1b[${lineNumber}H`) // Move to line
		this.clearLine() // Clear line
		process.stdout.write(content)
	}

	/**
	 * Move the cursor
	 *
	 * @param {Number} lineNumber - The target line number (1-based)
	 */
	move(lineNumber) {
		process.stdout.write(`\x1b[${lineNumber}H`)
	}

	moveTop() {
		process.stdout.write("\x1b[H")
	}

	/**
	 * Render logs only
	 */
	renderLogs() {
		if (!this.enabled) return false

		const logHeight = this.getLogHeight()
		this.moveAndWrite(1, this.separator("Logs") + "\n") // Render "Logs" section title

		this.logs.slice(-logHeight).forEach((log, index) => {
			this.moveAndWrite(index + 2, log) // Render each log line
		})
		this.move(this.height)
	}

	getTaskIndex(task) {
		if (typeof task == "string") {
			let names = Object.keys(this.activeTasks)
			return names.indexOf(task)
		}
		return Object.values(this.activeTasks).indexOf(task)
	}

	/**
	 * Render tasks only and optionally a specific task only
	 */
	renderTasks(taskName) {
		if (!this.enabled) return false
		const taskStartLine = this.getLogHeight() + 2

		if (taskName == undefined) {
			this.moveAndWrite(taskStartLine, this.separator("Tasks") + "\n") // Render "Tasks" section title
			Object.values(this.activeTasks).forEach((task, index) => {
				this.moveAndWrite(taskStartLine + 1 + index, task.fullMessage) // Render each task
			})
		} else {
			let task = this.activeTasks[taskName]
			if (task) {
				let index = this.getTaskIndex(task)
				this.moveAndWrite(taskStartLine + 1 + index, task.fullMessage)
			}
		}
		this.move(this.height)
	}

	showProgressBar(overrideMax = undefined) {
		if (!this.enabled) return false
		this._progressBarVisible = true
		if (overrideMax) {
			this.progressMax = overrideMax
		}
	}

	hideProgressBar() {
		if (!this.enabled) return false
		this._progressBarVisible = false
	}

	setProgressBarVisible(visible = true) {
		if (!this.enabled) return false
		this._progressBarVisible = visible
	}

	/**
	 * Render progress bar only
	 */
	renderProgressBar() {
		if (!this.enabled) return false
		const progressStartLine = this.height - 2

		this.move(progressStartLine + 1) // Render "Progress" section title

		if (this._progressBarVisible && this.progressMax) {
			const progressBarWidth = Math.min(
				this.width - 20,
				Terminal.maxProgressBarWidth
			)

			const progressBarCompleteWidth = Math.floor(
				(this.progress / this.progressMax) * progressBarWidth
			)

			const incompleteWidth = progressBarWidth - progressBarCompleteWidth

			const progressBar = `${this.colors.get(
				"green",
				"█".repeat(progressBarCompleteWidth)
			)}${this.colors.get("gray", "░".repeat(incompleteWidth))}`

			this.moveAndWrite(
				progressStartLine + 1,
				`[${progressBar}] ${(
					(this.progress / this.progressMax) *
					100
				).toFixed(1)}%` +
					(this.progressMax != 100
						? ` (${this.progress}/${this.progressMax})`
						: "")
			)
		} else if (!this._progressBarVisible) {
			this.moveAndWrite(progressStartLine + 1, " ")
		}
		this.move(this.height)
	}

	separator(title, align = 0.8) {
		if (!this.enabled) return false
		const lineWidth = this.width - 2
		const leftWidth = Math.floor((lineWidth - title.length) * align)
		const rightWidth = lineWidth - title.length - leftWidth
		return `${"─".repeat(leftWidth)} ${title} ${"─".repeat(rightWidth)}`
	}

	onFinish(code) {
		if (!this.enabled) return false
		if (code != 0) {
			this.program.Logger.error(`Program exited with code ${code}`, {
				name: NAME,
			})
			return
		}
		for (let i = 0; i < this.height; i++) {
			this.move(i)
			this.clearLine()
		}
		this.moveTop()
		process.stdout.write(`\n` + this.separator("Logs") + `\n`)
		this.fullLogs.forEach((log) => {
			process.stdout.write(log + `\n`)
		})
		process.stdout.write(`\n` + this.separator("Tasks") + `\n`)
		Object.values(this.activeTasks).forEach((task) => {
			process.stdout.write(task.fullMessage + `\n`)
		})
		process.stdout.write(`\n`)
	}
}
