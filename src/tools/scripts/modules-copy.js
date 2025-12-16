import Path from "path"

import Config from "../config.js"
import Name from "../lib/class/name.js"
import { copyFiles } from "../lib/filesystem.js"
import * as gmk from "../lib/gm.js"
import Logger from "../lib/logging.js"
import { getChildModules, getOrCreateModule, loadModules } from "../lib/modules.js"
import { Program } from "../lib/program.js"

const NAME = "modules:copy"
const ImGMError = Program.Error

// Task 1. [optional]    copy submoduleDirs to sourceDirs        (--imgui) and/or (--ext <names>,...)
async function copyModulesFiles(params) {
	const cpChildNamesPerModule = {}
	const cpFromToPerModule = {}
	let count = 0
	let countChilds = 0

	const modules = await loadModules(); // Preload modules
	let moduleKeys = Object.keys(Config.modules);

	for (const cfgModuleHandle in Config.modules) {
		const cfgModule = await getOrCreateModule(cfgModuleHandle)
		if (cfgModule) {
			const cfgModuleChilds = await getChildModules(cfgModule)
			let modulesToCopy = []

			let paramNames = [
				Config.modules[cfgModuleHandle].paramName,
				cfgModuleHandle,
			]

			for (const paramName of paramNames) {
				if (Object.keys(params).includes(paramName)) {
					let param = params[paramName]
					if (typeof params[paramName] == "string") {
						param = [params[paramName]]
					}
					if (
						(typeof params[paramName] == "bool" &&
							params[paramName] == true &&
							paramName == cfgModuleHandle) ||
						cfgModuleChilds.length > 0
					) {
						if (
							param == true ||
							param == "*" ||
							param == "all"
						) {
							modulesToCopy = cfgModuleChilds
						} else if (Array.isArray(param)) {
							// Match provided param entries against child modules using several name variants.
							const wanted = new Set(
								param
									.flatMap((p) => (Array.isArray(p) ? p : [p]))
									.filter((p) => typeof p === "string")
							)

							const matchModule = (mod) => {
								const variants = new Set()
								const name = new Name(String(mod.name?.get?.() ?? mod.name ?? ""))

								variants.add(name.toSnakeCase())
								variants.add(name.toKebabCase())
								variants.add(name.toPascalCase())
								variants.add(`im_${name.toSnakeCase()}`)
								variants.add(`im-${name.toKebabCase()}`)
								variants.add(`Im${name.toPascalCase()}`)

								for (const mk of moduleKeys) {
									// Iterate through keys as additional prefixes other than im-, im_, Im.
									// Mostly for extensions like imext-, imext_, Imext. Including imgui- variants as well.
									let modName = Config.modules[mk].name;
									variants.add(`${modName.toLowerCase()}_${name.toSnakeCase()}`)
									variants.add(`${modName.toLowerCase()}-${name.toKebabCase()}`)
									variants.add(`${modName.toLowerCase()}${name.toPascalCase()}`)
								}

								for (const v of variants) {
									if (wanted.has(v)) return true
								}

								// also allow partial matches
								for (const w of wanted) {
									for (const v of variants) {
										if (v.includes(w) || w.includes(v)) return true
									}
								}
								return false
							}

							modulesToCopy = cfgModuleChilds.filter((c) => matchModule(c))
						}
						break
					} else {
						modulesToCopy = [cfgModule]
						break
					}
				}
			}

			if (modulesToCopy.length > 0) {
				if (
					modulesToCopy.includes(cfgModule) &&
					cfgModuleChilds.length == 0
				) {
					let fromTo = []
					count++
					fromTo.push({
						from: cfgModule.submoduleDir,
						to: Path.join(cfgModule.getSourceDir(), "internal"),
						patterns: Config.modules[cfgModuleHandle].copyPatterns,
					})
					cpFromToPerModule[cfgModule.name] = fromTo
				} else {
					for (const cpModule of modulesToCopy) {
						let fromTo = []
						if (cpModule) {
							countChilds++
							fromTo.push({
								from: cpModule.submoduleDir,
								to: Path.join(
									cpModule.getSourceDir(),
									"internal"
								),
								patterns:
									Config.modules[cpModule.parent.handle]
										.copyPatterns,
							})
						}
						cpFromToPerModule[cpModule.name] = fromTo
						count++
					}
				}
			}

			cpChildNamesPerModule[cfgModule.name] = modulesToCopy
				.filter((m) => m.handle != cfgModuleHandle)
				.map((m) => m.name.get())
		} else {
			Logger.warn(
				`Could not get or create module from handle: ${cfgModuleHandle}`,
				{
					name: NAME,
					type: Logger.types.MODULE_NOT_CREATED,
				}
			)
		}
	}

	for (const moduleName in cpFromToPerModule) {
		let logMsg = `Copying ${moduleName} module...`
		for (const pName of Object.keys(cpChildNamesPerModule)) {
			if (cpChildNamesPerModule[pName].includes(moduleName)) {
				logMsg = `Copying ${pName}'s ${moduleName} module...`
				break
			}
		}
		Logger.info(logMsg, { name: NAME })

		for (const op of cpFromToPerModule[moduleName]) {
			copyFiles(op.from, op.to, op.patterns)
		}
	}
	if (count > 0) {
		Logger.info(
			` - Copied ${count} modules to source${countChilds > 0 ? ` including ${countChilds} child modules` : ""}`,
			{ name: NAME }
		)
	}
	return count
}

// Task 2. [optional]    copy GameMaker runtime files            (--gm) (--gm-program GameMakerStudio2, --gm-runtime ... --gm-data C:/ProgramData/GameMakerStudio2)
function copyRuntimeFiles(params) {
	const gmInfo = gmk.getInfo(params, process.env)
	Logger.info(`Copying GM files...`, { name: NAME })
	Logger.info(`  - ${gmInfo.programName} `, { name: NAME })
	Logger.info(`  - ${gmInfo.runtimeName} `, { name: NAME })
	const rtBase = Path.join(gmInfo.runtimeDir, "yyc", "include")

	const toDir = Path.join(Config.dll.baseDir, "internal")
	copyFiles(
		`${rtBase}/extension/YYRunnerInterface.h`,
		`${toDir}/YYRunnerInterface.h`
	)
	copyFiles(`${rtBase}/Ref.h`, `${toDir}/Ref.h`)
	copyFiles(`${rtBase}/YYStd.h`, `${toDir}/YYStd.h`)
	copyFiles(`${rtBase}/YYRValue.h`, `${toDir}/YYRValue.h`)

	Logger.debug(
		` - Modified 4 files from ${gmInfo.programName} (${gmInfo.runtimeName})`,
		{ name: NAME }
	)
}

async function main() {
	const params = Program.getParams()

	if ((
		Object.keys(params).length == 0 &&
		(typeof params._args == "undefined" || params._args.length == 0)
	) || Program.hasHelpFlag()) {
		console.error(
			`Usage: npm run ${NAME} -- [--gm [--gm-*]] [--imgui] [--ext [all|<name>[,<name>]] ...]`
		)
		return
	}

	try {
		let c = (await copyModulesFiles(params)) > 0

		// Copy GameMaker files on '--gm'
		if (params.gm) {
			copyRuntimeFiles(params)
			c = true
		}

		if (c) {
			Logger.info("Task(s) completed successfully.", { name: NAME })
		} else {
			Logger.error("No Task(s).", { name: NAME })
		}
	} catch (error) {
		Logger.error(`${error.message}`, {
			name: NAME,
			error,
		})
	}
}

await main()
