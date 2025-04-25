import { parentPort, Worker, workerData } from "worker_threads"
import Config from "../config.js"
import { defaultLogLevels } from "./class/base-logger.js"
import ImGMError, { ImGMAbort } from "./class/error.js"
import Logger, { defaultLevel } from "./logging.js"
import Terminal from "./terminal.js"
import { ansiClean, ansiSlice, toCamelCase } from "./utils/string.js"

const abortController = new AbortController()
const { signal } = abortController

function envIsTrue(name) {
	return (
		typeof process.env[name] != "undefined" &&
		((typeof process.env[name] == "string" &&
			["true", "1"].includes(process.env[name].toLowerCase())) ||
			(typeof process.env[name] == "bool" && process.env[name] == true))
	)
}

function _getParams() {
	const args = process.argv.slice(2)
	const values = new Set()

	const params = args.reduce((acc, arg, i, array) => {
		if (arg.startsWith("--") && arg !== "--") {
			const key = toCamelCase(arg.slice(2)) // Convert --some-param to someParam
			const value =
				array[i + 1] && !array[i + 1].startsWith("--")
					? array[i + 1].indexOf(",") > -1
						? array[i + 1].split(",").map((val) => val.trim())
						: array[i + 1]
					: true

			if (value !== true) {
				values.add(i + 1)
			}

			if (!acc[key]) {
				acc[key] = value
			} else if (!Array.isArray(acc[key][0])) {
				acc[key] = [
					Array.isArray(acc[key]) ? acc[key] : [acc[key]],
					value,
				]
			} else {
				acc[key].push(value)
			}
		} else {
			if (arg !== "--") {
				if (typeof acc._args === "undefined") {
					acc._args = []
				}
				if (!values.has(i)) {
					acc._args.push(arg)
				}
			}
		}
		return acc
	}, {})

	return params
}

export class ANSIColors {
	constructor(enabled = false, useNamesRGB = true) {
		if (enabled) {
			this.enabled = true
			this._esc = `\x1b`
			this._rgb = `${this._esc}[38;2;(r);(g);(b)m`
			this._c = `${this._esc}[(c)m`
			this._reset = `${this._esc}[0;m`
			this._names = {
				bold: this._c.replace(`(c)`, 1),
				dim: this._c.replace(`(c)`, 2),
				italic: this._c.replace(`(c)`, 3),
				underline: this._c.replace(`(c)`, 4),
				white: this.getRGB(255, 255, 255),
				gray: this.getRGB(128, 128, 128),
				red: useNamesRGB ? this.getRGB(195, 45, 45) : this.get256(31),
				darkred: useNamesRGB
					? this.getRGB(125, 25, 0)
					: this.get256(31), // red
				orange: useNamesRGB
					? this.getRGB(195, 125, 45)
					: this.get256(31), // red
				darkorange: useNamesRGB
					? this.getRGB(125, 75, 25)
					: this.get256(31), // red
				green: useNamesRGB
					? this.getRGB(125, 225, 125)
					: this.get256(32),
				darkgreen: useNamesRGB
					? this.getRGB(0, 75, 25)
					: this.get256(32), // green
				yellow: useNamesRGB
					? this.getRGB(225, 225, 125)
					: this.get256(33),
				darkyellow: useNamesRGB
					? this.getRGB(125, 125, 25)
					: this.get256(33), // yellow
				blue: useNamesRGB ? this.getRGB(0, 125, 225) : this.get256(34),
				magenta: useNamesRGB
					? this.getRGB(195, 125, 195)
					: this.get256(35),
				cyan: useNamesRGB ? this.getRGB(25, 125, 125) : this.get256(36),
			}
		} else {
			this.enabled = false
		}
	}

	wrap(color, wrapped = undefined, reset = undefined) {
		if (this.enabled) {
			return wrapped != undefined
				? color + wrapped + this.reset(reset)
				: color
		}
		return wrapped ?? ""
	}

	ansiClean(string) {
		return ansiClean(string)
	}

	ansiSlice(string, start, end) {
		return ansiSlice(string, start, end)
	}

	getRGB(r = 0, g = 0, b = 0, wrapped = undefined, reset = undefined) {
		if (this.enabled) {
			let color = this._rgb
				.replace("(r)", r)
				.replace("(g)", g)
				.replace("(b)", b)
			return wrapped != undefined
				? color + wrapped + this.reset(reset)
				: color
		}
		return wrapped ?? ""
	}

	get256(c, wrapped = undefined, reset = undefined) {
		if (this.enabled) {
			let color = this._c.replace(`(c)`, c)
			return wrapped != undefined
				? color + wrapped + this.reset(reset)
				: color
		}
		return wrapped ?? ""
	}

	get(name, wrapped = undefined, reset = undefined) {
		if (this.enabled) {
			if (typeof this._names[name] != "undefined") {
				let color = this._names[name]
				return wrapped != undefined
					? color + wrapped + this.reset(reset)
					: color
			} else {
				throw `Color not defined: ${name}`
			}
		}
		return wrapped ?? ""
	}

	reset(reset = undefined) {
		return this.enabled ? (reset ?? this._reset) : ""
	}

	bold(wrapped = undefined, reset = undefined) {
		return this.get("bold", wrapped, reset)
	}
	dim(wrapped = undefined, reset = undefined) {
		return this.get("dim", wrapped, reset)
	}
	italic(wrapped = undefined, reset = undefined) {
		return this.get("italic", wrapped, reset)
	}
	underline(wrapped = undefined, reset = undefined) {
		return this.get("underline", wrapped, reset)
	}
}

class ProcessProgram {
	static _pNoColor = undefined
	static _pRainbow = undefined

	static env = {}
	/**
	 *
	 * @type {Terminal}
	 * @memberof ProcessProgram
	 */
	static terminal = undefined
	/**
	 *
	 * @type {Logger}
	 * @memberof ProcessProgram
	 */
	static Logger = Logger
	/**
	 *
	 * @type {ImGMError}
	 * @memberof ProcessProgram
	 */
	static Error = ImGMError
	/**
	 *
	 * @static
	 * @memberof ProcessProgram
	 */
	static params = _getParams()
	/**
	 *
	 * @type {ANSIColors}
	 * @memberof ProcessProgram
	 */
	static colors = undefined
	/**
	 *
	 * @type {Boolean}
	 * @memberof ProcessProgram
	 */
	static debug = process.env.DEBUG
	/**
	 *
	 * @type {Object|Undefined}
	 * @memberof ProcessProgram
	 */
	static workData = undefined
	/**
	 *
	 * @type {AbortController}
	 * @memberof ProcessProgram
	 */
	static abortController = abortController
	/**
	 *
	 *
	 * @static
	 * @type {Worker[]}
	 * @memberof ProcessProgram
	 */
	static _workers = []

	static async task(promiseFunc, name) {
		const terminal = this.terminal
		const startTime = Date.now()

		terminal.updateTask(name, "processing")
		terminal.render()
		const ret = promiseFunc()
			.then((result) => {
				const timeTaken = (Date.now() - startTime) / 1000
				terminal.updateTask(name, "success", timeTaken)
				terminal.render()
				return result
			})
			.catch((error) => {
				if (error instanceof ImGMAbort) {
					throw error
				}
				terminal.updateTask(name, "error")
				this.Logger.error(`${error.message}`, { error })
				terminal.render()
			})
		return ret
	}

	static async worker(
		workerFilePath,
		name,
		_workerData,
		callbacks = {
			message: undefined,
			resultSuccess: undefined,
			resultError: undefined,
			error: undefined,
			exit: undefined,
		},
		onFinish,
		onError
	) {
		const terminal = this.terminal
		const startTime = Date.now()

		const cbResultError = callbacks.resultError
		const cbResultSuccess = callbacks.resultSuccess
		const cbResult = callbacks.result
		const cbMessage = callbacks.message
		const cbError = callbacks.error
		const cbExit = callbacks.exit

		terminal.updateTask(name, "processing")
		terminal.render()

		return new Promise((resolve, reject) => {
			let wIndex = Program._workers.length
			_workerData.index = wIndex
			_workerData.env = {
				// LOG_LEVEL: ProcessProgram._logLevel,
				// DEBUG: ProcessProgram.debug,
				// NO_COLOR: ProcessProgram._pNoColor,
				// RAINBOW: ProcessProgram._pRainbow,
			}
			_workerData.params = ProcessProgram.params

			const worker = new Worker(workerFilePath, {
				workerData: _workerData,
			})
			Program._workers.push(worker)
			worker.index = wIndex

			worker.on("message", (message) => {
				switch (message.type) {
					case "log":
						let extra = message.extra
						if (extra) {
							extra = {
								name: `${extra.name}|${worker.name ?? "worker"}-${worker.index}`,
								_formatted: true,
							}
						} else {
							extra = {
								name: `|${worker.name ?? "worker"}-${worker.index}`,
								_formatted: true,
							}
						}
						if (message.message) {
							this.Logger._logMessage(
								message.message,
								message.level,
								message.extra
							)
						}
						break

					case "result":
						if (cbResult) {
							cbResult(message, resolve, reject)
						} else {
							if (message.success) {
								const timeTaken =
									(Date.now() - startTime) / 1000
								terminal.updateTask(name, "success", timeTaken)
								terminal.render()
								if (cbResultSuccess) {
									cbResultSuccess(message, resolve, reject)
								} else {
									resolve(message.result)
								}
							} else {
								terminal.updateTask(name, "error")
								terminal.render()
								if (cbResultError) {
									cbResultError(message, resolve, reject)
								} else {
									ProcessProgram.Logger.error(
										`${message.message ?? "Unsuccessful"}: ${message.error ? (message.error.message ?? message.error) : message.result}`,
										{
											name: worker.name,
										}
									)
									if (
										message.error != undefined ||
										message.result instanceof Error
									) {
										reject(message.result)
									} else {
										resolve(message.result)
									}
								}
							}
						}
						ProcessProgram._workers.splice(worker.index, 1)
						worker.index = -1
						break

					default:
						if (cbMessage) {
							cbMessage(message, resolve, reject)
						}
						break
				}
			})

			worker.on("error", (error) => {
				terminal.updateTask(name, "error")
				ProcessProgram.Logger.error(error.message, { error })
				terminal.render()
				if (cbError) {
					cbError(error, resolve, reject)
				} else {
					reject(error)
				}
			})

			worker.on("exit", (code) => {
				if (cbExit) {
					cbExit(code, resolve, reject)
				} else {
					if (code !== 0) {
						reject(
							new ImGMError(
								`Worker stopped with exit code ${code}`
							)
						)
					}
				}
			})
		})
			.then(onFinish)
			.catch(onError)
	}

	static setup(argIsWorker = false) {
		let wParams = undefined
		let wEnv = undefined
		if (argIsWorker == true) {
			ProcessProgram.workData = { parentPort, workerData }
			wParams = ProcessProgram.workData.workerData.params
			wEnv = ProcessProgram.workData.workerData.env
		}
		if (typeof wParams != "undefined") {
			ProcessProgram.params = wParams
		}
		ProcessProgram._processParams()

		if (typeof wEnv != "undefined") {
			ProcessProgram.env = wEnv
		}

		ProcessProgram.evals()
		ProcessProgram.postSetup()
	}

	static evals() {
		Object.assign(process.env, ProcessProgram.env)

		ProcessProgram._pNoColor =
			(workerData == null && !process.stdout.isTTY) ||
			envIsTrue("NO_COLOR") ||
			Config.logging.color == false
		ProcessProgram._pRainbow =
			envIsTrue("RAINBOW") || Config.logging.colorUseRGB == true
	}

	static postSetup() {
		// Setup Colors
		if (ProcessProgram._pNoColor) {
			ProcessProgram.colors = new ANSIColors(false)
		} else {
			if (ProcessProgram._pRainbow) {
				ProcessProgram.colors = new ANSIColors(true, true)
			} else {
				ProcessProgram.colors = new ANSIColors(true, false)
			}
		}
		ProcessProgram.Logger.Program = ProcessProgram
		ProcessProgram.Logger.colors = ProcessProgram.colors

		ProcessProgram.debug =
			process.env.DEBUG ?? ProcessProgram.params?.debug == true

		// Setup Terminal
		ProcessProgram.terminal = new Terminal(this)

		// Setup Logger
		ProcessProgram.Logger.ignoredTypes = ProcessProgram._logIgnoredTypes
		ProcessProgram.Logger.setLevel(ProcessProgram._logLevel)

		if (process.env.DRYRUN) {
			Logger.warn("--dry-run %(status)s", {
				status: ProcessProgram.colors.get("green", "On"),
			})
		}
	}

	static abort() {
		ProcessProgram.abortController.abort()
	}

	static getParams() {
		if (ProcessProgram.params == undefined) {
			if (workerData != null) {
				ProcessProgram.params = workerData.params
			} else {
				ProcessProgram.params = _getParams()
			}
		}
		return ProcessProgram.params
	}

	static _processParams() {
		let logIgnoredTypes = undefined
		let wantedLogLevels = []
		if (process.env.LOG_LEVEL) {
			wantedLogLevels.push(
				...process.env.LOG_LEVEL.split(",").map((l) => l.toLowerCase())
			)
		}
		for (const key in ProcessProgram.params) {
			if (key.toLowerCase() == "logignore") {
				if (!Array.isArray(ProcessProgram.params[key])) {
					ProcessProgram.params[key] = [ProcessProgram.params[key]]
				}
				if (
					!(
						ProcessProgram.params[key].length == 1 &&
						typeof ProcessProgram.params[key][0] !== "string"
					)
				) {
					logIgnoredTypes = []
					for (const p of ProcessProgram.params[key]) {
						if (p.toLowerCase() == "all") {
							logIgnoredTypes.push("*")
						} else if (p.toLowerCase() == "none") {
							logIgnoredTypes = []
							break
						} else {
							logIgnoredTypes.push(p)
						}
					}
				}
			}
			if (key.toLowerCase() == "loglevel") {
				if (!Array.isArray(ProcessProgram.params[key])) {
					ProcessProgram.params[key] = [ProcessProgram.params[key]]
				}
				wantedLogLevels.push(
					...ProcessProgram.params[key].map((v) => v.toLowerCase())
				)
			}
			if (process.env.DRYRUN || key.toLowerCase() == "dryrun") {
				process.env.DRYRUN = 1
			}
		}
		if (logIgnoredTypes == undefined) {
			logIgnoredTypes = Array.isArray(Config.logging.ignore)
				? Config.logging.ignore
				: [Config.logging.ignore]
		}
		let wantedLogLevel = undefined
		const orderedLevels = Object.values(defaultLogLevels)
		if (wantedLogLevels.length > 1) {
			wantedLogLevels = orderedLevels.find((level) =>
				wantedLogLevels.includes(level)
			)
		} else if (wantedLogLevels.length == 1) {
			wantedLogLevel = wantedLogLevels[0].toLowerCase()
		}
		if (wantedLogLevel == undefined) wantedLogLevel = defaultLevel
		if (!orderedLevels.includes(wantedLogLevel)) {
			throw "Could not configure LOG_LEVEL"
		}
		ProcessProgram._logLevel = wantedLogLevel
		ProcessProgram._logIgnoredTypes = logIgnoredTypes
		ProcessProgram._useTerminal =
			(workerData == null || workerData == undefined) &&
			(Config.logging.useTerminal == true ||
				(typeof ProcessProgram.params?.useTerminal != "undefined" &&
					ProcessProgram.params.useTerminal == true))
	}
}

ProcessProgram.setup()

export const Program = ProcessProgram
