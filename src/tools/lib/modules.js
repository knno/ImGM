import fs from "fs"
import path from "path"
import Config from "../config.js"
import Name from "./class/name.js"
import { isPathInside } from "./filesystem.js"
import { Program } from "./program.js"
import * as str from "./utils/string.js"
import Import from "./utils/import.js"

const Logger = Program.Logger
const ImGMError = Program.Error
const NAME = "modules"
const colors = Program.colors

/**
 *
 * @param {Name|String} name
 * @return {String} handle
 */
export function toHandle(name) {
	if (typeof name == Name) {
		name = name.toSnakeCase("-")
	}
	for (const mh in Config.modules) {
		if (Config.modules[mh].name == name) {
			return mh
		}
	}
	if (Object.keys(Config.modules).indexOf(name) > -1) {
		return name
	}
	return undefined
}

/**
 *
 * @param {String} dirname
 * @return {String}
 */
export function submoduleDirToHandle(dirname) {
	let dir = dirname
	if (fs.existsSync(path.join(Config.projectRoot, dirname))) {
		dir = path.join(Config.projectRoot, dirname)
	}
	for (const key in Config.modules) {
		if (
			Config.modules[key].submoduleDir == dirname ||
			Config.modules[key].submoduleDir == dir
		) {
			return key
		}
	}
	return undefined
}

/**
 * get PascalName of a module provided a directory name if found in Config.modules and loaded modules.
 * Otherwise infers it from the directory name
 *
 * @param {String} dirname Directory name
 * @return {String} module name as string
 */
export function nameFromSubmoduleDir(dirname) {
	const handle = submoduleDirToHandle(dirname)
	if (handle && Object.keys(Config.modules).includes(handle)) {
		return Config.modules[handle].name
	}
	for (const k in Module._loadedModules) {
		if (Module._loadedModules[k].submoduleDir == dirname) {
			return Module._loadedModules[k].name.toPascalCase("")
		}
	}
	/* const rePatName = (name) => `(${str.rePascalCase(name)})`*/
	const rePatSep = `[-_\.]`
	const rePatExtra = `(?:${rePatSep})?(?<name>.*)` // capture name
	const reDefaultParPat = `(?:[Gg]ui)|(?:[Ee]xt)`
	const reModule = `(?:(?:[Ii]m(?:(?:${reDefaultParPat})(?![a-z]))?))${rePatExtra}`

	const regexes = [reModule]
	let name = undefined
	for (const rexp of regexes) {
		const regex = new RegExp(rexp)
		const match = regex.exec(dirname)
		if (match) {
			name = match.groups.name
			break
		}
	}
	if (name != undefined) {
		return str.toPascalCase(name, "")
	}

	throw new ImGMError(`Could not convert ${dirname} to a module name`)
}

/**
 *
 * @param {String} dirname
 * @return {Boolean}
 */
export function isSubmoduleDir(dirname) {
	let dir = dirname
	if (fs.existsSync(path.join(Config.projectRoot, dirname))) {
		dir = path.join(Config.projectRoot, dirname)
	} else {
		if (fs.existsSync(dirname)) {
			throw new ImGMError(`Directory does not exist: ${dirname}`)
		}
	}
	if (fs.existsSync(path.join(dir, ".git"))) {
		return true
	} else {
		for (const key in Config.modules) {
			if (
				Config.modules[key].submoduleDir == dirname ||
				Config.modules[key].submoduleDir == dir
			) {
				return true
			}
		}
	}
	return false
}

/**
 *
 * @param {Module} module
 * @return {Module[]}
 */
async function _getFSChildModules(module) {
	let modulePath
	if (module instanceof Module) {
		modulePath = module.submoduleDir
	} else {
		throw new ImGMError(`Could not recognize module: ${module}`)
	}

	let children = []
	if (isSubmoduleDir(modulePath)) {
		if (!fs.existsSync(path.join(modulePath, ".git"))) {
			const directories = fs
				.readdirSync(modulePath, { withFileTypes: true })
				.filter((entry) => entry.isDirectory())
				.filter(
					(dir) =>
						isPathInside(dir.name, modulePath) &&
						fs.existsSync(path.join(modulePath, dir.name, ".git"))
				)
				.map((dir) => dir.name)

			children = await Promise.all(
				directories.map((dirName) =>
					getOrCreateModule(dirName, undefined, module)
				)
			)
		}
	}
	return children
}

/**
 *
 * @param {Module} module
 * @return {Module[]}
 */
function _getLoadedChildModules(module) {
	let modulePath
	if (module instanceof Module) {
		modulePath = module.submoduleDir
	} else {
		throw new ImGMError(`Could not recognize module: ${module}`)
	}

	const loaded = []
	for (const lm in Module._loadedModules) {
		if (lm.parent == module) {
			loaded.push(lm)
		}
	}
	return loaded
}

/**
 *
 * @param {Module} module
 * @return {Module[]}
 */
export async function getChildModules(module) {
	const rModules = []
	const loadedChModules = _getLoadedChildModules(module)
	if (loadedChModules !== undefined) {
		rModules.push(...loadedChModules)
	}
	const fsChModules = await _getFSChildModules(module)
	const filteredFsModules = await Promise.all(
		fsChModules.map(async (fsM) => {
			const isDuplicate = rModules.some(
				(rM) =>
					rM.handle === fsM.handle ||
					rM.name === fsM.name ||
					rM.submoduleDir === fsM.submoduleDir
			)
			return isDuplicate ? null : fsM
		})
	)
	const finalFsModules = filteredFsModules.filter((fsM) => fsM !== null)
	rModules.push(...finalFsModules)
	return rModules
}

/**
 *
 * @export
 * @class Module
 */
export class Module {
	static _loadedModules = {}

	handle = undefined
	name = undefined
	submoduleDir = undefined
	sourceConfig = undefined

	constructor(key = undefined, parent = undefined) {
		this.parent = parent

		if (typeof key !== "undefined") {
			if (key instanceof Name) {
				this.handle = toHandle(key)
				this.name = key
				this.submoduleDir = Config.modules[
					this.handle
				].submoduleDir.replace(/\\/g, "/")
			} else if (typeof key == "object") {
				// config
				this.handle = toHandle(key.name)
				this.name = new Name(key.name, "PascalCase", "")
				this.submoduleDir =
					key.submoduleDir ?? Config.modules[this.handle].submoduleDir
			} else if (typeof key == "string") {
				if (this.parent) {
					if (
						fs.existsSync(path.join(this.parent.submoduleDir, key))
					) {
						this.name = new Name(
							nameFromSubmoduleDir(key),
							"PascalCase",
							""
						)
						this.handle = this.name.toSnakeCase("-")
						this.submoduleDir = path
							.join(this.parent.submoduleDir, key)
							.replace(/\\/g, "/")
					} else {
						throw new ImGMError(
							`Cannot create non-existent module: ${this.parent.name.get()}/${key}`
						)
					}
				} else {
					if (fs.existsSync(path.join(Config.projectRoot, key))) {
						this.name = new Name(
							nameFromSubmoduleDir(key),
							"PascalCase",
							""
						)
						this.handle = toHandle(this.name)
						this.submoduleDir = key.replace(/\\/g, "/")
					} else {
						this.handle = toHandle(key)
						if (Config.modules[this.handle]) {
							this.submoduleDir =
								Config.modules[this.handle].submoduleDir
							this.name =
								Config.modules[this.handle].name ?? this.handle
							this.name = new Name(this.name, "PascalCase", "")
						} else {
							throw new ImGMError(
								`Cannot create module with key: ${key}`
							)
						}
					}
				}
				Logger.debug(
					"Module " +
						`${colors.get("green", this.handle)} (${this.name}) in ${this.submoduleDir}`,
					{
						name: NAME,
						type: Logger.types.MODULE_DEBUG_INFO,
					}
				)
			}
		}
		Module._loadedModules[this.handle] = this
	}

	getSourceDir() {
		let base, dir
		if (this.parent != undefined) {
			base = this.parent.getSourceDir()
			dir = this.handle
		} else {
			base = path.join(Config.projectRoot, Config.dll.baseDir)
			dir = this.handle
		}
		return path.join(base, dir)
	}

	getInfo() {
		return {
			handle: this.handle,
			name: this.name.get(),
			submoduleDir: this.submoduleDir,
			parent: this.parent,
			sourceDir: this.getSourceDir(),
		}
	}
}

/**
 *
 * @param {Name|String} key  name, handle, or submoduleDir
 * @param {Object} [config]
 * @param {Module|Name|String} [parent]
 * @return {Module}
 */
export async function getOrCreateModule(
	key,
	config = undefined,
	parent = undefined
) {
	let module
	let testKey = key
	if (testKey != undefined) {
		if (testKey instanceof Module) {
			return testKey
		}
		if (testKey instanceof Name) {
			testKey = testKey.toSnakeCase("_")
		} else if (typeof testKey == "string") {
			var _foundCfg = false
			for (const mh in Config.modules) {
				if (Config.modules[mh].submoduleDir == testKey) {
					if (typeof config != "undefined") {
						Logger.warn(
							`Provided key "${testKey}" found as submoduleDir in Config. Do not provide a separate config.`,
							{
								name: NAME,
								type: Logger.types.MODULE_CONFIG_DISCARDED,
							}
						)
						config = undefined
					}
					testKey = mh
					_foundCfg = true
					break
				}
			}
			if (!_foundCfg) {
				testKey = str.toSnakeCase(testKey, "_")
			}
			if (Module._loadedModules[testKey]) {
				return Module._loadedModules[testKey]
			}
		}
		if (Module._loadedModules[key]) {
			return Module._loadedModules[key]
		}
		module = new Module(key, parent)
	} else {
		if (config != undefined) {
			for (const handle in Config.modules) {
				if (Config.modules[handle] == config) {
					key = handle
					break
				}
			}
			if (key == undefined) {
				throw new ImGMError(
					"Cannot create module without key or config"
				)
			}
		} else {
			for (const handle in Config.modules) {
				if (Config.modules[handle].submoduleDir == config) {
					key = handle
					break
				}
			}
		}
		module = new Module(key, parent)
	}
	module.sourceConfig = (
		await Import(path.join(module.getSourceDir(), "config.js"))
	)?.default
	return module
}

/**
 *
 * @param {Name|String} module name, handle, or submoduleDir
 * @return {Object}
 */
export function getModuleInfo(module) {
	return getOrCreateModule(module).getInfo()
}
