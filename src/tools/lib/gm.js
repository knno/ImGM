import fs from "fs"
import Path from "path"

import Config from "../config.js"
import ImGMError from "./class/error.js"
import Logger from "./logging.js"

/**
 * Retrieves data directory of a GameMaker program
 *
 * Optional env GM_DATA: The absolute path to
 *
 * @param {String} gmName GameMaker program name (Defaults to Config.gm.defaultProgram)
 * @param {Object} [env]
 * @return {Path}
 */
export function getGmDataDir(gmName = undefined, env = undefined) {
	gmName ??= Config.gm.defaultProgram
	env ??= process.env

	if (typeof env.GM_DATA != "undefined") {
		if (fs.existsSync(Path.join(env.GM_DATA, gmName))) {
			return Path.join(env.GM_DATA, gmName)
		} else if (fs.existsSync(Path.join(env.GM_DATA, "Cache"))) {
			if (fs.existsSync(Path.join(env.GM_DATA, "..", gmName))) {
				return Path.join(env.GM_DATA, "..", gmName)
			}
		}
		throw new ImGMError(
			`env GM_DATA directory does not exist or not a GameMaker data directory: ${env.GM_DATA}`
		)
	} else {
		if (typeof Config.gm.gmDataPath != "undefined") {
			if (fs.existsSync(Path.join(Config.gm.gmDataPath, gmName))) {
				return Path.join(Config.gm.gmDataPath, gmName)
			} else if (
				fs.existsSync(Path.join(Config.gm.gmDataPath, "Cache"))
			) {
				if (
					fs.existsSync(Path.join(Config.gm.gmDataPath, "..", gmName))
				) {
					return Path.join(Config.gm.gmDataPath, "..", gmName)
				}
			}
			throw new ImGMError(
				`Config.gm.gmDataPath directory does not exist or not a GameMaker data directory: ${Config.gm.gmDataPath}`
			)
		} else {
			throw new ImGMError(
				`env GM_DATA (and Config.gm.gmDataPath) are not set or detected. Set either to GameMaker program data folder.`
			)
		}
	}
}

/**
 * Returns the directory of all runtimes for a GameMaker program
 *
 * @param {String} gmName GameMaker program name
 * @param {Object} [env]
 * @return {Path}
 */
export function getRuntimesDir(gmName = undefined, env = undefined) {
	gmName ??= Config.gm.defaultProgram

	const dataDir = getGmDataDir(gmName, env)
	return Path.join(dataDir, "Cache", "runtimes")
}

/**
 * Returns the available runtimes for a GameMaker program
 *
 * @param {String} gmName GameMaker program name (Defaults to Config.gm.defaultProgram)
 * @param {String} [prefix=""] A prefix to match only specific runtimes, (Defaults to empty string, which means all)
 * @param {Object} [env]
 * @return {Object[]} An array of objects of { name, path }
 */
export function getAvailableRuntimes(
	gmName = undefined,
	prefix = "",
	env = undefined
) {
	gmName ??= Config.gm.defaultProgram

	const runtimeDir = getRuntimesDir(gmName, env)
	if (!fs.existsSync(runtimeDir)) {
		Logger.warn(
			`Runtime directory "${runtimeDir}" does not exist for "${gmName}"`
		)
		return []
	}

	const runtimes = fs
		.readdirSync(runtimeDir, { withFileTypes: true })
		.filter((entry) => entry.isDirectory())
		.filter((dir) => dir.name.startsWith(`runtime-${prefix}`)) // Filter by prefix
		.map((dir) => ({
			name: dir.name,
			path: Path.join(runtimeDir, dir.name),
		}))

	Logger.debug(`Found ${runtimes.length} runtimes for "${gmName}"`, {
		runtimeDir: runtimeDir,
		runtimes: runtimes.map((r) => r.name),
	})

	return runtimes
}

/**
 * Selects the latest runtime from a set of runtimes
 *
 * @param {Object[]} runtimes An array of objects of { name, path }
 * @return {Object}
 */
export function getLatestRuntimeOf(runtimes = undefined) {
	runtimes ??= []
	if (runtimes.length === 0) {
		throw new ImGMError(`No runtimes found`)
	}

	runtimes.sort((a, b) => b.name.localeCompare(a.name)) // Must be "runtime-{version}" format..
	return runtimes[0]
}

/**
 * Retrieves various GameMaker info (such as runtime, program)
 *
 * @param {Object} [params] parameters that were passed to the process
 * @param {Object} [env] env (Defaults to process.env) (GM_PROGRAM, GM_RUNTIME, GM_DATA)
 * @return {Object} An object of {
 *   programName,
 *   runtimes,
 *   runtimeName,
 *   runtimeDir,
 * }
 */
export function getInfo(params = undefined, env = undefined) {
	params ??= {}
	env ??= process.env

	const gmProgram =
		params.gmProgram || env.GM_PROGRAM || Config.gm.defaultProgram
	const allRuntimes = getAvailableRuntimes(gmProgram, "", env)

	let runtimeName, runtimeDir

	if (typeof params.gmRuntime === "string") {
		if (
			Path.isAbsolute(params.gmRuntime) &&
			fs.existsSync(params.gmRuntime)
		) {
			runtimeDir = params.gmRuntime // Absolute path provided
			runtimeName = Path.basename(runtimeDir)
		} else {
			const availRuntimes = getAvailableRuntimes(
				gmProgram,
				params.gmRuntime === "latest" ? "" : params.gmRuntime,
				env
			)
			const latestRuntime = getLatestRuntimeOf(availRuntimes)
			runtimeName = latestRuntime.name
			runtimeDir = latestRuntime.path
		}
	} else if (typeof params.gmRuntime === "undefined") {
		if (!env.GM_RUNTIME) {
			if (!Config.gm.defaultRuntime) {
				throw new ImGMError(
					`Runtime is not set, and no default runtime found. Either provide one or set Config.gm.defaultRuntime`
				)
			} else {
				runtimeName = Config.gm.defaultRuntime
				runtimeDir = Path.join(getRuntimesDir(gmProgram), runtimeName)
				if (!fs.existsSync(runtimeDir)) {
					throw new ImGMError(
						`Default runtime "${runtimeName}" does not exist at path ${runtimeDir}`
					)
				}
			}
		} else {
			runtimeName = env.GM_RUNTIME
			runtimeDir = Path.join(getRuntimesDir(gmProgram), runtimeName)
			if (!fs.existsSync(runtimeDir)) {
				throw new ImGMError(
					`Runtime "${runtimeName}" does not exist at path "${runtimeDir}" (inferred from env)`
				)
			}
		}
	} else {
		throw new ImGMError(
			`Unrecognized Runtime name or format: ${params.gmRuntime}`
		)
	}

	return {
		programName: gmProgram,
		runtimes: allRuntimes,
		runtimeName: runtimeName,
		runtimeDir: runtimeDir,
	}
}

/**
 * Converts RValue kind to DataType such as "VALUE_REAL" to "Real"
 *
 * @param {String} kind RValue kind
 * @return {String} DataType
 */
export function convertRValueTypeToDataType(kind) {
	switch (kind) {
		case "VALUE_INT32":
		case "VALUE_INT64":
		case "VALUE_REAL":
			return "Real"
		case "VALUE_STRING":
			return "String"
		case "VALUE_ARRAY":
			return "Array"
		case "VALUE_OBJECT":
			return "Asset.GMObject"
		case "VALUE_UNDEFINED":
			return "Undefined"
		case "VALUE_PTR":
			return "Pointer"
		case "VALUE_BOOL":
			return "Bool"
	}
	return `Unknown<${kind}>`
}

/**
 * Returns DataType of a YYGet* function
 * such as "Real" from YYGetReal
 *
 * @param {String} func Function name
 * @return {String} DataType
 */
export function convertYYGetTypeToDataType(func) {
	// TODO: Test
	let ret = ""
	let base = func.slice("YYGet".length)

	const template = base.indexOf("|template=")
	if (template > -1) {
		const arr = base.slice(template + "|template=".length)
		switch (arr) {
			case "double":
			case "float":
			case "int": {
				ret = "<Real>"
				break
			}

			default: {
				ret = "<Unknown>"
				break
			}
		}
		base = base.slice(0, template)
	}

	switch (base) {
		case "String":
		case "Array":
		case "Real":
		case "Bool":
			return base + ret
		case "PtrOrInt":
		case "Ptr":
			return ret + "Pointer"
		case "Int32":
		case "Uint32":
		case "Int64":
		case "Float":
			return ret + "Real"
		case "Struct":
			return ret + "Struct"
	}
	return ret
}
