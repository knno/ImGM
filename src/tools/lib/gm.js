import fs from "fs"
import Path from "path"

import Config from "../config.js"
import ImGMError from "./class/error.js"
import Logger from "./logging.js"

/**
 * Resolves the GameMaker data directory.
 * Priority: env.GM_DATA → Config.gm.gmDataPath
 *
 * @param {String} [gmName] GameMaker program name
 * @param {Object} [env] Environment object (defaults to process.env)
 * @returns {String} Absolute path to GameMaker data directory
 * @throws {ImGMError} If no valid directory is found
 */
export function getGmDataDir(gmName = Config.gm.defaultProgram, env = process.env) {
	const candidates = []

	if (env.GM_DATA) {
		candidates.push(Path.join(env.GM_DATA, gmName))
		candidates.push(Path.join(env.GM_DATA, "..", gmName))
	}

	if (Config.gm.gmDataPath) {
		candidates.push(Path.join(Config.gm.gmDataPath, gmName))
		candidates.push(Path.join(Config.gm.gmDataPath, "..", gmName))
	}

	for (const dir of candidates) {
		if (fs.existsSync(dir)) return dir
	}

	throw new ImGMError(`No valid GameMaker data directory found. Checked: ${candidates.join(", ")}`)
}

/**
 * Resolves the runtime directory for a GameMaker program.
 * Tries standard Cache/runtimes path, then fallback to scanning for runtime-* folders.
 *
 * @param {String} [gmName] GameMaker program name
 * @param {Object} [env] Environment object
 * @returns {String} Absolute path to runtimes directory
 */
export function getRuntimesDir(gmName = Config.gm.defaultProgram, env = process.env) {
	const dataDir = getGmDataDir(gmName, env)
	const cachePath = Path.join(dataDir, "Cache", "runtimes")

	if (fs.existsSync(cachePath)) return cachePath

	// Fallback: scan for runtime-* folders directly under dataDir
	const fallback = fs.readdirSync(dataDir, { withFileTypes: true })
		.filter(d => d.isDirectory() && d.name.startsWith("runtime-"))
		.map(d => Path.join(dataDir, d.name))

	if (fallback.length > 0) return dataDir

	throw new ImGMError(`No runtimes found under ${dataDir}`)
}

/**
 * Lists available runtimes for a GameMaker program.
 *
 * @param {String} [gmName]
 * @param {String} [prefix=""]
 * @param {Object} [env]
 * @returns {Array<{name: string, path: string}>}
 */
export function getAvailableRuntimes(gmName = Config.gm.defaultProgram, prefix = "", env = process.env) {
	const runtimeDir = getRuntimesDir(gmName, env)
	if (!fs.existsSync(runtimeDir)) {
		Logger.warn(`Runtime directory "${runtimeDir}" does not exist for "${gmName}"`)
		return []
	}

	return fs.readdirSync(runtimeDir, { withFileTypes: true })
		.filter(entry => entry.isDirectory() && entry.name.startsWith(`runtime-${prefix}`))
		.map(dir => ({
			name: dir.name,
			path: Path.join(runtimeDir, dir.name),
		}))
}

/**
 * Returns the latest runtime from a list.
 *
 * @param {Array<{name: string, path: string}>} runtimes
 * @returns {{name: string, path: string}}
 */
export function getLatestRuntimeOf(runtimes = []) {
	if (runtimes.length === 0) throw new ImGMError("No runtimes found")
	return runtimes.sort((a, b) => b.name.localeCompare(a.name))[0]
}

/**
 * Retrieves GameMaker runtime info from config/env/params.
 *
 * @param {Object} [params]
 * @param {Object} [env]
 * @returns {{programName: string, runtimes: Array, runtimeName: string, runtimeDir: string}}
 */
export function getInfo(params = {}, env = process.env) {
	const gmProgram = params.gmProgram || env.GM_PROGRAM || Config.gm.defaultProgram
	const allRuntimes = getAvailableRuntimes(gmProgram, "", env)

	let runtimeName, runtimeDir

	if (typeof params.gmRuntime === "string") {
		if (Path.isAbsolute(params.gmRuntime) && fs.existsSync(params.gmRuntime)) {
			runtimeDir = params.gmRuntime
			runtimeName = Path.basename(runtimeDir)
		} else {
			const filtered = getAvailableRuntimes(gmProgram, params.gmRuntime === "latest" ? "" : params.gmRuntime, env)
			const latest = getLatestRuntimeOf(filtered)
			runtimeName = latest.name
			runtimeDir = latest.path
		}
	} else {
		const fallback = env.GM_RUNTIME || Config.gm.defaultRuntime
		if (!fallback) throw new ImGMError("No runtime specified and no default available")
		runtimeName = fallback
		runtimeDir = Path.join(getRuntimesDir(gmProgram, env), runtimeName)
		if (!fs.existsSync(runtimeDir)) {
			throw new ImGMError(`Runtime "${runtimeName}" not found. Path does not exist: "${runtimeDir}"`)
		}
	}

	return { programName: gmProgram, runtimes: allRuntimes, runtimeName, runtimeDir }
}

/**
 * Converts RValue kind to a high-level data type.
 *
 * @param {String} kind
 * @returns {String}
 */
export function convertRValueTypeToDataType(kind) {
	const map = {
		VALUE_INT32: "Real",
		VALUE_INT64: "Real",
		VALUE_REAL: "Real",
		VALUE_STRING: "String",
		VALUE_ARRAY: "Array",
		VALUE_OBJECT: "Asset.GMObject",
		VALUE_UNDEFINED: "Undefined",
		VALUE_PTR: "Pointer",
		VALUE_BOOL: "Bool",
	}
	return map[kind] || `Unknown<${kind}>`
}

/**
 * Converts a YYGet* function name to a high-level data type.
 *
 * @param {String} func
 * @returns {String}
 */
export function convertYYGetTypeToDataType(func) {
	let ret = ""
	let base = func.slice("YYGet".length)

	const templateIndex = base.indexOf("|template=")
	if (templateIndex > -1) {
		const template = base.slice(templateIndex + "|template=".length)
		ret = ["double", "float", "int"].includes(template) ? "<Real>" : "<Unknown>"
		base = base.slice(0, templateIndex)
	}

	const map = {
		String: "String",
		Array: "Array",
		Real: "Real",
		Bool: "Bool",
		PtrOrInt: "Pointer",
		Ptr: "Pointer",
		Int32: "Real",
		Uint32: "Real",
		Int64: "Real",
		Float: "Real",
		Struct: "Struct",
	}

	return map[base] ? `${ret}${map[base]}` : ret
}
