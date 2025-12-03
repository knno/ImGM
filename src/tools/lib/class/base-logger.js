import * as winston from "winston"
import { workerData } from "worker_threads"
import { getObjectProperties, formatDate } from "../utils/data.js"
import ImGMError from "./error.js"

export const defaultLevel = "info"
export const defaultLogLevels = {
	TRACE: "trace",
	DEBUG: "debug",
	INFO: "info",
	WARN: "warn",
	ERROR: "error",
	FATAL: "fatal",
}
export const logLevels = Object.values(getObjectProperties(defaultLogLevels))
export const logLevelsColors = {
	error: "red",
	warn: "yellow",
	info: "green",
	debug: "blue",
}

// (LEVEL)(TYPE)(nn)
export const logTypes = {
	// WRAPPER
	WRAPPER_FILE_READ: "DW01",
	WRAPPER_FILE_PARSE: "DW02",
	WRAPPER_TARGET_CHANGED: "WW01",
	WRAPPER_ARG_CHANGED: "WW02",
	WRAPPER_MODIFIER_UNKNOWN: "WW03",
	WRAPPER_CONTEXT_CHANGED: "WW04",
	WRAPPER_ENUM_COMMA: "WW05",
	WRAPPER_TOKEN_UNKNOWN: "WW06",
	WRAPPER_DISCARDED: "WW07",
	// MODULE
	MODULE_DEBUG_INFO: "DM01",
	MODULE_CONFIG_DISCARDED: "WM01",
	MODULE_NOT_CREATED: "WM02",
	// PARSER
	PARSER_DEBUG_INFO: "DP01",
	PARSER_DEBUG_INFO_CHANGES: "DP02",
	PARSER_DEBUG_INFO_PARSED_TOKENS: "DP03",
	PARSER_DEBUG_INFO_LEXED_TOKENS: "DP04",
	PARSER_DEBUG_INFO_PARSED_TOKENS_RESULT: "DP05",
	// FILES
	FILES_COPY_DEBUG_INFO: "DF01",
	FILES_UPDATE_OPENED: "DF02",
	FILES_UDPATE_SKIPPED: "DF03",
	FILES_UDPATE_WRITTEN: "DF04",

}

/**
 *
 * @export
 * @class Logger
 */
export class Logger {
	/**
	 * Configured colors set from Program
	 *
	 * @static
	 * @type {Program}
	 * @memberof Logger
	 */
	static Program = undefined
	/**
	 * Configured colors set from Program
	 *
	 * @static
	 * @type {ANSIColors}
	 * @memberof Logger
	 */
	static colors = undefined

	/**
	 *
	 * @static
	 * @memberof Logger
	 */
	static types = logTypes

	/**
	 * Configured ignored types set from Program
	 *
	 * @static
	 * @memberof Logger
	 */
	static ignoredTypes = undefined

	/**
	 *
	 * @static
	 * @memberof Logger
	 */
	static level =
		(workerData == null
			? process.env.LOG_LEVEL
			: workerData.env.LOG_LEVEL) ?? defaultLevel

	/**
	 * Timestamp format
	 *
	 * @static
	 * @memberof Logger
	 */
	static timestampFormat = "YYYY-MM-DD HH:mm:ss"

	/**
	 *
	 * @static
	 * @memberof Logger
	 */
	static loggerInstance = this.createWinston()

	static printfFormat = ({ timestamp, level, message }) => {
		const colors = this.colors
		const paddedLevel = level.toUpperCase().padEnd(5, " ")

		timestamp = timestamp
			? timestamp instanceof Date
				? timestamp
				: new Date(timestamp)
			: new Date()

		let msgLevel = paddedLevel
		if (logLevelsColors[level]) {
			msgLevel = colors.get(logLevelsColors[level], paddedLevel)
		}
		const msgTimestamp = colors.get(
			"gray",
			formatDate(timestamp, this.timestampFormat)
		)
		return `${msgTimestamp} [${msgLevel}]: ${message}`
	}

	/**
	 *
	 * @return {winston.Logger}
	 */
	static createWinston() {
		const log = winston.createLogger({
			level: this.level,
			format: winston.format.combine(
				winston.format.printf((...args) => Logger.printfFormat(...args))
			),
			transports: [new winston.transports.Console()],
		})
		this.loggerInstance = log
		return log
	}

	static _resolveTemplate(msg, extra) {
		const deletedKeys = []
		if (extra && typeof extra === "object") {
			Object.entries(extra).forEach(([key, value]) => {
				const placeholder = `%(${key})s`
				let msg2 = msg.replaceAll(placeholder, `${value}`)
				if (msg2 != msg) {
					deletedKeys.push(key)
				}
				msg = msg2
			})
		}
		return { msg, deletedKeys }
	}

	/**
	 * Formats a log message with additional metadata
	 *
	 * @param {String} message
	 * @param {Object} [extra={}]
	 * @return {Array}
	 */
	static formatMessage(message, extra) {
		if (extra._formatted == true) {
			return message
		}
		let { msg, deletedKeys } = this._resolveTemplate(message, extra)
		extra = { ...extra }

		if (typeof extra == "undefined") {
			extra = {}
		}
		const colors = Logger.colors
		let extraColor = ""
		if (typeof extra.color != "undefined") {
			extraColor = extra.color
			delete extra.color
		}
		let type = ""
		if (typeof extra.type != "undefined") {
			type = extra.type
			delete extra.type
		}

		let name = ""
		if (typeof extra.name != "undefined") {
			name = extra.name
			delete extra.name
		}

		let error = undefined
		if (typeof extra.error != "undefined") {
			error = extra.error
			if (typeof error.resolve != "undefined") {
				error = error.resolve()
			}
			if (this.Program.debug) {
				msg = colors.wrap(
					extraColor,
					`(stacktrace)\n${error.stack.replace(/^(.*)/gm, colors.wrap(extraColor, ` - $1`))}`
				)
			} else {
				msg = colors.wrap(
					extraColor,
					`(to see stacktrace, try again with --debug)`
				)
			}
			delete extra.error
		} else {
			msg = colors.wrap(extraColor, msg)
		}

		let pre = ""
		if (name != "") {
			if (type != "") {
				pre = `${colors.get("magenta", type)}|${colors.get("blue", name)}`
			} else {
				pre = `${colors.get("blue", name)}`
			}
		} else {
			if (type != "") {
				pre = `${colors.get("magenta", type)}`
			}
		}
		pre = pre != "" ? colors.get("white", `[${pre}] `) : ``

		for (const key of deletedKeys) {
			delete extra[key]
		}
		const extraData =
			Object.keys(extra).length > 0
				? ` ${colors.get("green", JSON.stringify(extra))}`
				: ""

		const ret = [colors.wrap(extraColor, `${pre}${msg}${extraData}`), extra]
		return ret
	}

	static getCallerName() {
		const reMatchFile = /\((.*?):\d+:\d+\)/

		const stack = new Error().stack
		const stackLines = stack.split("\n")
		let refFileMatch = stackLines[1].match(reMatchFile)
		if (refFileMatch && refFileMatch[1]) {
			refFileMatch = refFileMatch[1]
		}

		let caller = undefined
		let callerFileMatch = undefined
		let i = 0
		for (i = 2; i < stackLines.length; i++) {
			callerFileMatch = stackLines[i].match(reMatchFile)
			if (callerFileMatch && callerFileMatch[1]) {
				callerFileMatch = callerFileMatch[1]
			}
			if (callerFileMatch != refFileMatch) {
				caller = stackLines[i].match(/at ([\w\.]+) /)
				if (caller && caller[1]) {
					caller = caller[1]
				}
				break
			}
		}
		return caller
	}

	/**
	 * Checks if a log type is ignored
	 *
	 * @param {String} type - The log type to check
	 * @return {Boolean}
	 */
	static isIgnoredType(type) {
		if (!type || this.ignoredTypes.length === 0) {
			return false
		}
		const names = Object.keys(this.types)
		const values = Object.values(this.types)

		return this.ignoredTypes.some((ignore) => {
			let pattern = ignore
			pattern =
				pattern === "*"
					? ".*"
					: pattern
							.replace(/(?<=[^\.])\?/g, ".")
							.replace(/(?<=[^\.])\*(?=.)/g, ".*")
			const regex = new RegExp(pattern)

			const matchedKey = names.find((name) => {
				const keyParts = name.split("_")
				let partialKey = keyParts[0]

				for (let i = 0; i < keyParts.length; i++) {
					const patternParts = pattern.split(
						/(?<=.)(?<![._])(?:(?:\.\_)(?=[^.*])|(?:[._]+)(?=[.])|_(?=[.*\w]))/g
					)
					let currentPattern = patternParts[0]
					if (currentPattern == "*") {
						continue
					}

					for (let j = 0; j < patternParts.length; j++) {
						if (regex.test(partialKey)) {
							return true
						}
						if (j === patternParts.length - 1) break
						currentPattern += "_" + patternParts[j + 1]
					}
					if (i === keyParts.length - 1) break
					partialKey += "_" + keyParts[i + 1]
				}
				if (regex.test(name)) {
					return true
				}
				return false
			})
			if (matchedKey) {
				return true
			}

			const matchedValue = values.find(
				(value) =>
					value == type && (ignore == value || regex.test(value))
			)
			if (matchedValue) {
				return true
			}

			return false
		})
	}

	static _logMessage(message, level, extra) {
		if (this.Program.workData) {
			if (extra != undefined) {
				extra.name =
					extra.name +
					" > " +
					(this.Program.workData.workerData.name ?? "worker") +
					"-" +
					String(this.Program.workData.workerData.index).padStart(2, '0')
			} else {
				extra = {
					name:
						(this.Program.workData.workerData.name ?? "worker") +
						"-" +
						String(this.Program.workData.workerData.index).padStart(2, '0'),
				}
			}
			if (extra.name.split(" > ").length > 3) {
				extra.name = extra.name.split(" > ")[0] + " > " +
					(this.Program.workData.workerData.name ?? "worker") +
					"-" +
					String(this.Program.workData.workerData.index).padStart(2, '0') +
					"...."
			}
			this.Program.workData.parentPort.postMessage({
				type: "log",
				message: message,
				level: level,
				extra: extra,
			})
			return
		}
		let msg = Logger.formatMessage(message, extra)
		if (this.Program.terminal.enabled) {
			// Create a log info object for winston formatting
			const info = {
				level,
				message: msg[0],
				extra,
				timestamp: Date.now(),
			}
			const formattedMessage = Logger.printfFormat(info)
			if (formattedMessage) {
				this.Program.terminal.log(
					formattedMessage.message || formattedMessage
				)
			}
		} else {
			Logger.loggerInstance[level](...msg)
		}
	}

	/**
	 * General log method
	 *
	 * @param {String} message
	 * @param {String} level
	 * @param {Object} extra
	 */
	static log(message, level = defaultLevel, extra = undefined) {
		if (Array.isArray(message)) {
			if (message.length == 0) {
				Logger.log("[]", level, extra)
			} else {
				message.forEach((m) => {
					if (m) {
						Logger.log(m, level, extra)
					}
				})
			}
			return
		} else if (typeof message != "string") {
			message = `${message}`
		}
		if (logLevels.indexOf(level) >= logLevels.indexOf(Logger.level)) {
			extra ??= {}
			if (typeof extra.name == "undefined") {
				const caller = this.getCallerName()
				if (caller) {
					extra.name = caller
				}
			}
			const colors = Logger.colors
			if (
				typeof extra.type != "undefined" &&
				Logger.isIgnoredType(extra.type)
			)
				return

			if (
				level == defaultLogLevels.ERROR ||
				(typeof extra.error !== "undefined" &&
					(level == defaultLogLevels.DEBUG ||
						level == defaultLogLevels.ERROR ||
						level == defaultLogLevels.WARN))
			) {
				let error = extra.error
				delete extra.error

				extra.color = colors.get("red")
				if (error) {
					this._logMessage(message, level, extra)
					if (
						!this.Program.terminal.enabled &&
						error.stack != undefined
					) {
						this._logMessage(
							message,
							level,
							Object.assign(extra, {
								error,
								color: colors.get("red"),
							})
						)
					}
				} else {
					this._logMessage(message, level, extra)
				}
			} else {
				this._logMessage(message, level, extra)
			}
		}
	}

	/**
	 * Set the log level
	 *
	 * @param {String} level
	 */
	static setLevel(level) {
		if (!logLevels.includes(level)) {
			throw new ImGMError(
				`Invalid log level: ${level}. Supported levels: ${logLevels.join(", ")}`
			)
		}
		this.level = level
		this.loggerInstance.level = level // Update logger instance level
	}

	/**
	 * Check if a specific log type is ignored
	 *
	 * @param {String} type
	 * @return {Boolean}
	 */
	static isIgnored(type) {
		return this.isIgnoredType(type)
	}

	// Logging methods
	static trace(message, extra) {
		Logger.log(message, "trace", extra)
	}

	static debug(message, extra) {
		Logger.log(message, "debug", extra)
	}

	static info(message, extra) {
		Logger.log(message, "info", extra)
	}

	static warn(message, extra) {
		Logger.log(message, "warn", extra)
	}

	static error(message, extra) {
		Logger.log(message, "error", extra)
	}

	static fatal(message, extra) {
		Logger.log(message, "fatal", extra)
	}
}

export default { Logger, defaultLevel, logLevels }
