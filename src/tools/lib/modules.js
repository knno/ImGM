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
	let nameObj = undefined;
	let nameSnake = name;

	if (typeof name == Name) {
		nameObj = name;
		nameSnake = name.toSnakeCase("_").replace(/im[-_](gui|ext)[-_]/, `im$1_`);
	} else {
		let nameObj = new Name(name, "PascalCase", "");
		if (name == nameObj.get()) {
			nameSnake = nameObj.toSnakeCase("_").replace(/im[-_](gui|ext)[-_]/, `im$1_`);
		} else {
			nameSnake = nameObj.toSnakeCase("_").replace(/im[-_](gui|ext)[-_]/, `im$1_`);
		}
	}
	if (nameSnake.startsWith('im')) {
		// Get name without im(gui/ext) prefixes (excluding imgui and imext themselves.)
		if (!Config.modules.hasOwnProperty(nameSnake)) {
			nameSnake = nameSnake.replace(/(?:imgui(?:[-_])?|imext(?:[-_])?|im(?:[-_])?|imgui(?=[a-z])|imext(?=[a-z])|im(?=[a-z]))/g, "")
		}
	}
	nameSnake = nameSnake.replace(/[-_]/, "-");

	if (Object.keys(Config.modules).indexOf(nameSnake) > -1) {
		return nameSnake;
	}
	if (Object.keys(Module._loadedModules).indexOf(nameSnake) > -1) {
		return nameSnake;
	}
	for (const mh in Config.modules) {
		if (Config.modules[mh].name == name) {
			return mh
		}
	}
	return undefined
}

/**
 * Loads module definitions from Config.modules into Module._loadedModules.
 *
 * @param {Boolean} [recursive=false] whether to load child modules recursively.
 *
 */
export async function loadModules(recursive = false) {
	const _loadedModules = Module._loadedModules;
	for (const mh in Config.modules) {
		try {
			let parentModule = await getOrCreateModule(mh);
			if (parentModule) {
				_loadedModules[parentModule.handle] = parentModule;
				if (recursive) {
					const childModules = await getChildModules(parentModule);
					if (childModules) {
						for (const chM of childModules) {
							let childModule = await getOrCreateModule(chM.handle, undefined, parentModule);
							if (childModule) {
								_loadedModules[childModule.handle] = childModule;
							}
						}
					}
				}
			}
		} catch (error) {
			Logger.error(`Error loading module from handle "${mh}"`, {
				name: NAME,
				error
			});
		}
	}
	// Update Module._loadedModules with new information.
	Module._loadedModules = {
		...Module._loadedModules,
		..._loadedModules
	};
	return _loadedModules;
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
 * Get PascalName of a module provided a directory name if found in Config.modules and loaded modules.
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
	const rePatSep = `[-_\.]`
	const rePatExtra = `(?:${rePatSep})?(?<name>.*)` // capture name
	const reDefaultParPat = `(?:[Gg]ui)|(?:[Ee]xt)`
	const reModule = `(?:(?:[Ii]m(?:(?:${reDefaultParPat})(?![a-z]))?)?)${rePatExtra}`

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

export function nameFromHandle(handle) {
	if (!handle) return undefined;
	const preconfiguredModules = Object.keys(Config.modules);
	var keys = [...preconfiguredModules, ...Object.keys(Module._loadedModules)] // kebab-case
	var found = false;
	var result = undefined;
	var _handle = str.toKebabCase(handle, "-");

	var key = keys.find((v, i) => v.toLowerCase() == _handle.toLowerCase());
	if (key != undefined) {
		found = true;
	}

	if (!found) {
		key = str.toPascalCase(handle, "");
		result = key;
	} else {
		if (preconfiguredModules.indexOf(key) != -1) {
			result = Config.modules[key]?.name;
		} else {
			result = str.toPascalCase(key, "");
		}
	}
	return new Name(result, "PascalCase", "")
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
	let dirs = dir.split(/\/|\\/).reverse();
	if (dirs[1] == "modules") {
		return true;
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
				.filter((dir) => dir.isDirectory() && isPathInside(dir.name, modulePath))
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

	constructor(key = undefined, parent = undefined, config = undefined) {
		this.parent = parent
		let dllDir = path.join(Config.projectRoot, Config.dll.baseDir)

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
				this.name = new Name(key, "PascalCase", "")
				this.handle = toHandle(this.name)
				if (this.parent) {
					this.handle = this.name.toKebabCase("-")
					let parentHandle = toHandle(this.parent.handle);
					this.submoduleDir = (Config.modules[
						this.handle
					] ?? Config.modules[parentHandle]).submoduleDir.replace(/\\/g, "/");

					// Remove prefixes from base folder name: im-, im glued, imgui-, imext-, etc. Keeping bare "imgui" / "imext" unchanged.
					let baseName = key.replace(/^(?:imgui(?:[-_]|(?=[a-z]))|imext(?:[-_]|(?=[a-z]))|im(?:[-_]|(?=[a-z])))/i, "");
					// Now reconstruct possible folder names based on baseName.
					let moduleKeys = Object.keys(Config.modules);
					let folderNames = [
						str.toSnakeCase(baseName),
						str.toKebabCase(baseName),
						str.toPascalCase(baseName),
						`im_${str.toSnakeCase(baseName)}`,
						`im-${str.toKebabCase(baseName)}`,
						`Im${str.toPascalCase(baseName)}`,
					];
					for (const mk of moduleKeys) {
						// Iterate through keys as additional prefixes other than im-, im_, Im.
						// Mostly for extensions like imext-, imext_, Imext. Including imgui- variants as well.
						let modName = Config.modules[mk].name;
						folderNames.push(`${modName.toLowerCase()}_${str.toSnakeCase(baseName)}`);
						folderNames.push(`${modName.toLowerCase()}-${str.toKebabCase(baseName)}`);
						folderNames.push(`${modName}${str.toPascalCase(baseName)}`);
					}

					var found = false;
					for (const fname of folderNames) {
						const testPath = path.join(this.parent.submoduleDir, fname);
						if (
							fs.existsSync(testPath)
						) {
							this.name = new Name(
								nameFromSubmoduleDir(key),
								"PascalCase",
								""
							)
							this.handle = this.name.toKebabCase("-")
							found = true;
							this.submoduleDir = path
								.join(this.parent.submoduleDir, key)
								.replace(/\\/g, "/")
							break;
						}
					}
					if (!found) {
						throw new ImGMError(
							`Cannot create non-existent module: ${key} from parent: ${this.parent.name.get()}`
						)
					}
				} else {
					if (fs.existsSync(path.join(dllDir, key))) {
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
					} else {
						if (Object.keys(Module._loadedModules).length > 0) {
							for (const lm in Module._loadedModules) {
								let moduleDir = Module._loadedModules[lm].submoduleDir;
								let submoduleDir = path.join(moduleDir, key);
								if (fs.existsSync(submoduleDir)) {
									this.name = new Name(
										nameFromSubmoduleDir(key),
										"PascalCase",
										""
									)
									this.handle = toHandle(this.name)
									this.submoduleDir = key.replace(/\\/g, "/")
								}
							}
						} else {
							throw new ImGMError(
								`Cannot create non-existent module: \`${key}\` from \`${key},${parent}\``
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
		this.config = this.config ?? Module.getConfig(key);
		if (this.handle != undefined) {
			Module._loadedModules[this.handle] = this
		} else {
			throw new ImGMError(`Could not create module with key: ${key}`)
		}
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

	static getConfig(handle) {
		return Module._loadedModules[handle]?.config ?? {}
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
	if (!parent) {
		module.parentHandle = undefined;
		module.config = Object.assign({}, (
			await Import(path.join(module.getSourceDir(), "config.js"))
		)?.default, Config.modules[module.handle])
	} else {
		module.parentHandle = parent.handle;
		module.config = Object.assign(module.config, (
			await Import(path.join(module.getSourceDir(), "config.js"))
		)?.default, {
			hasParent: true,
			parentHandle: parent.handle,
		})
	}
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
