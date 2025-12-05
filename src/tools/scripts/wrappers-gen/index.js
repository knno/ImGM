/**
 * @overview
 *
 * A script to find target functions in order to wrap them with GML functions
 *
 * @author knno <github.com/knno>
 */
import { sync as globSync } from "glob"
import Path from "path"
import { fileURLToPath } from "url"
import Config from "../../config.js"
import File from "../../lib/class/file.js"
import Name from "../../lib/class/name.js"
import { getOrCreateModule, loadModules, toHandle, Module, getChildModules } from "../../lib/modules.js"
import { CppToken } from "../../lib/parsers/langs/cpp.js"
import {
	ApiEnum,
	ApiFunction,
	getWrappers,
	updateGMExtensionWrappers,

} from "../../lib/parsers/wrappers.js"
import { Program } from "../../lib/program.js"
import * as str from "../../lib/utils/string.js"
import { generateCoverage } from "./coverage.js"
import { updateGmlScripts } from "./gml.js"
import ImGMError, { ImGMAbort } from "../../lib/class/error.js"

const __filename = fileURLToPath(import.meta.url)
const __dirname = Path.dirname(__filename)
const NAME = "wrappers:gen"
const Logger = Program.Logger

const Term = Program.terminal
let isReady = false

const getModuleFileName = (module) => {
	const _pre = module.parentHandle ? (Config.modules[module.parentHandle].name) : "";
	const moduleFileName = `${_pre}${str.toPascalCase(module.name, "")}`;
	return moduleFileName;
}

async function main() {
	const params = Program.getParams()

	if (!params._args || (params._args.length < 1 || Program.hasHelpFlag())) {
		console.error(`Usage: npm run ${NAME} -- <module> <path/to/file.cpp>`)
		return
	}

	const modules = await loadModules(true); // Preload modules

	const requestedModuleHandle = toHandle(params._args[0]);
	let module = undefined;
	let moduleChilds = undefined;
	let allChilds = undefined;

	try {
		module = await getOrCreateModule(requestedModuleHandle)
		allChilds = Object.values(Module._loadedModules).filter(m => m.parent != undefined);
		moduleChilds = allChilds.filter(m => m.parent.handle == module.handle).filter(mc => Program._config.enabledImExts.has(mc.handle))
	} catch (error) {
		Logger.error(`Error creating module from handle "${requestedModuleHandle}"`, {
			name: NAME,
			error
		})
		process.exit(1)
	}

	if (module.parent != undefined && !Program._config.enabledImExts.has(module.handle)) {
		if (Program.hasForceFlag()) {
			Program._config.enabledImExts.add(requestedModuleHandle);
		} else {
			Logger.error(`Use --force to execute with disabled extension in ${Program.colors.get("orange", "config.h", "red")}: ${Program.colors.get("white", "IMEXT_" + str.toScreamingCase(requestedModuleHandle), "red")}`, {
				name: NAME,
			})
			process.exit(1)
		}
	}

	let genFiles = undefined;
	if (moduleChilds && moduleChilds.length > 0) {
		genFiles = moduleChilds.map(mc => {
			var subFiles = mc.parent.config.wrappersGenFilesPatterns?.map(fp => str.resolveTemplate(fp, mc.name.toExtra("name"))).flatMap(p => globSync(p))
			return { module: mc, files: subFiles };
		});
	} else {
		if (module.parent != undefined) {
			genFiles = [{
				module: module,
				files: module.parent.config.wrappersGenFilesPatterns?.map(fp => str.resolveTemplate(fp, module.name.toExtra("name"))).flatMap(p => globSync(p))
			}]
		} else {
			genFiles = [{
				module: module,
				files: module.config.wrappersGenFilesPatterns?.map(fp => str.resolveTemplate(fp, module.name.toExtra("name"))).flatMap(p => globSync(p))
			}]
		}
	}

	const dataByHandle = {};
	genFiles.forEach(gf => {
		if (!Object.keys(dataByHandle).includes(gf.module.handle)) {
			dataByHandle[gf.module.handle] = {
				files: new Set(),
				module: gf.module,
			}
		}
		var paths = gf.files.map(p => Path.resolve(p));
		paths.forEach(p => { if (p != undefined) dataByHandle[gf.module.handle].files.add(p) })
	});

	const allFilePaths = new Set()
	Object.values(dataByHandle).forEach((d) => {
		for (const v of d.files.values()) {
			allFilePaths.add(v);
		}
	});

	let apis = {}
	const totalStartTime = Date.now()

	Term.setProgressMax(allFilePaths.size)
	Term.setProgressBarVisible(true)
	Term.render();

	const tasks = Array.from(allFilePaths).map(filePath => {
		var data = Object.values(dataByHandle).find(d => d.files.has(filePath));
		var module = data.module;
		return Program.worker(
			Path.join(__dirname, "file-worker.js"),
			filePath,
			{
				filePath,
				moduleHandle: module.handle,
				parentModule: module.parentHandle,
				totalStartTime,
			},
			{
				resultSuccess: (message, resolve, reject) => {
					const api = message.result;
					api.isFromWorker = true;
					if (typeof apis[api.moduleHandle] == "undefined") {
						apis[api.moduleHandle] = [];
					}
					apis[api.moduleHandle].push(api);
					Term.setProgress(Term.progress + 1)
					Term.render()
					resolve()
				},
				resultError: (message, resolve, reject) => {
					Logger.error(
						`${message.message ?? "Unsuccessful"}: ${message.error ? (message.error.message ?? message.error) : message.result}`,
						{
							name: NAME + ` > worker-${message._worker.index}`,
							error: message.error,
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
				},
				error: (error, resolve, reject) => {
					Logger.error(`Worker error: ${error.message}`)
					reject(error)
				},
				exit: (code, resolve, reject) => {
					if (code !== 0) {
						Logger.error(`Worker stopped with exit code ${code}`)
						reject(
							new Error(`Worker stopped with exit code ${code}`)
						)
					}
				},
			}
		)
	})

	Logger.debug(
		`Working on ${Program.colors.get("green", allFilePaths.size)} files:`,
		{ name: NAME, type: Logger.types.WRAPPER_FILE_READ }
	)

	allFilePaths.forEach(f => Logger.debug(
		` - ${Program.colors.get("darkorange", f)}`,
		{ name: NAME, type: Logger.types.WRAPPER_FILE_READ }
	))

	Logger.info(
		`Started ${Program.colors.get("green", tasks.length)} workers`,
		{ name: NAME, type: Logger.types.WRAPPER_FILE_PARSE }
	)

	// Process files with worker threads
	Promise.all(tasks).then(() => {
		isReady = true
	}).catch((err) => {
		Logger.error("Aborted due to errors.", { name: NAME })
		process.exit(1)
	})

	const apisCompleted = () => {
		if (apis == undefined || Object.keys(apis).length == 0) { return false; }
		for (const a of Object.keys(apis)) {
			var data = dataByHandle[a];
			if (!data) return false;
			if (!apis[a]) return false;
			if (apis[a].length < data.files.size) {
				return false;
			}
		}
		return true;
	}

	Term.main(
		() => isReady || apisCompleted(),
		() => {
			Term.setProgressBarVisible(false)
			Term.render()
			const totalEndTime = Date.now()
			const totalTime = (totalEndTime - totalStartTime) / 1000
			Logger.info(
				`Finished all ${Program.colors.get("green", tasks.length)} workers`,
				{ name: NAME, type: Logger.types.WRAPPER_FILE_PARSE }
			)

			// Tokenize result stuffs back
			let createToken = (t, parentSource = undefined) => {
				const source = t.source ?? parentSource

				const children = (t.children || []).map((ct) =>
					createToken(ct, source)
				)

				const newTok = new CppToken({
					type: t.type,
					value: t.value,
					line: t.line,
					col: t.col,
					children,
				})
				newTok.source ??= source
				newTok._extra ??= t._extra
				return newTok
			}

			let extFile = new File(
				Path.join(Config.gm.projectDir, "extensions/ImGM/ImGM.yy")
			)

			const allApis = [];

			for (const h of Object.keys(apis)) {
				const mApis = apis[h];
				const mWrappers = [];
				let apisTokens = mApis
					.flatMap((api) => {
						let tokens = JSON.parse(api.tokens) || []
						tokens = tokens.map((t) => {
							t.source ??= api.file
							return t
						})
						api.tokens = tokens
						return tokens
					})
					.map((t) => createToken(t))

				for (const api of mApis) {
					const rawEnums = JSON.parse(api.enums) || []
					api.enums = rawEnums.map((e) => {
						const sourceToken =
							apisTokens.find(
								(t) =>
									t.type === e.sourceToken.type &&
									t.line === e.sourceToken.line &&
									t.pos === e.sourceToken.pos
							) ?? e.sourceToken

						let en = new ApiEnum({
							name: new Name(e.name._name, e.name._case, e.name._sep),
							entries: e.entries,
							sourceToken,
							source: e.source,
							namespace: e.namespace,
							comment: e.comment,
							entriesComments: e.entriesComments,
						})
						return en
					})
					const rawFuncs = JSON.parse(api.functions) || []
					api.functions = rawFuncs.map((f) => {
						const sourceToken =
							apisTokens.find(
								(t) =>
									t.type === f.sourceToken.type &&
									t.line === f.sourceToken.line &&
									t.pos === f.sourceToken.pos
							) ?? f.sourceToken

						return new ApiFunction({
							name: new Name(f.name._name, f.name._case, f.name._sep),
							args: JSON.parse(f.args),
							returnType: f.returnType,
							source: f.source,
							sourceToken,
							namespace: f.namespace,
							comment: f.comment,
						})
					})
				}

				// Analyze wrappers
				let wrapperAnalyzer = getWrappers(apisTokens, undefined, mApis, {
				})
				mWrappers.push(...wrapperAnalyzer.wrappers);

				// Log tokens sources recusrively
				apisTokens = apisTokens.flatMap((t) => {
					let logSources = (token) => {
						let tokens;
						if (!token.children || token.children.length === 0) {
							tokens = [token]
						} else {
							tokens = token.children.flatMap(logSources)
						}
					}
					return logSources(t)
				})

				const moduleFileName = getModuleFileName(module);
				const moduleSnakeName = module.name.toSnakeCase("_")

				var foundErrors = false;
				for (const wr of mWrappers) {
					if (wr.targetFunc.startsWith(module.parentHandle) || wr.targetFunc.startsWith(`__${module.parentHandle}`)) {
						if (!(wr.targetFunc.startsWith(`${module.parentHandle}_${moduleSnakeName}`) || wr.targetFunc.startsWith(`__${module.parentHandle}_${moduleSnakeName}`))) {
							// Specified __imext_<funcname> without any mention of the extension error.
							Logger.error(`Error in ${wr.source}:${wr.sourceToken.pos()}`, { name: NAME });
							Logger.error(`  - Incorrect function name for ${module.name}: "${wr.targetFunc}"`, { name: NAME });
							Logger.error(`  - Perhaps you meant ${wr.targetFunc.replace(/(_*imext)_(.*)/i, `$1_${moduleSnakeName}_$2`)}?`, { name: NAME });
							foundErrors = true;
						}
					}
				}

				if (foundErrors == true) {
					throw new ImGMAbort("Aborted due to errors.");
				}

				const fullApi = {
					tokens: apisTokens,
					enums: mApis.flatMap((api) => api.enums || []),
					functions: mApis.flatMap((api) => api.functions || []),
					wrappers: mWrappers,
					artifacts: mApis.flatMap((api) => api.artifacts || []),
					modulesConfigs: Object.assign({
						requestedModuleHandle,
						requestedModuleChildrenHandles: new Set((moduleChilds ? moduleChilds.map(mc => mc.handle) : [])),
					},
						...allChilds.map(childModule => ({
							[childModule.handle]: {
								config: Module.getConfig(childModule.handle),
								moduleName: childModule.name.toPascalCase(),
								moduleFileName: getModuleFileName(childModule),
							}
						})),
					)
				}

				updateGMExtensionWrappers(fullApi, extFile)
				updateGmlScripts(fullApi)
				const covInfo = generateCoverage(fullApi)
				fullApi.coverageInfo = covInfo;
				allApis.push(fullApi);

				if (moduleChilds.length > 0) {
					Logger.info(`${"─".repeat(10)} ${str.toPascalCase(h)} Stats ${"─".repeat(10)}`)
					Logger.info(
						` - ${Program.colors.get("yellow", fullApi.enums.length)} Enums`,
						{ name: NAME }
					)
					// Functions found during the whole build.
					Logger.info(
						` - ${Program.colors.get("yellow", fullApi.functions.length)} Functions`,
						{ name: NAME }
					)
					// Wrappers found during the whole build.
					Logger.info(
						` - ${Program.colors.get("orange", fullApi.wrappers.length)} Wrappers`,
						{ name: NAME }
					)
				}
			}

			const fullApis = {
				tokens: allApis.flatMap(fa => fa.tokens || []),
				enums: allApis.flatMap(fa => fa.enums || []),
				functions: allApis.flatMap(fa => fa.functions || []),
				wrappers: allApis.flatMap(fa => fa.wrappers || []),
				artifacts: allApis.flatMap(fa => fa.artifacts || []),
				coverageInfo: allApis.flatMap(fa => fa.coverageInfo || []),
				modulesConfigs: Object.assign(
					{},
					...allApis.map(fa => fa.modulesConfigs || {})
				),
			}
			const covInfo = fullApis.coverageInfo.reduce(
				(acc, ci) => {
					acc.coverageCount += ci.coverageCount || 0;
					acc.totalCount += ci.totalCount || 0;
					return acc;
				},
				{ coverageCount: 0, totalCount: 0 }
			);
			covInfo.percent = covInfo.totalCount === 0 ? 0 : Math.round((covInfo.coverageCount / covInfo.totalCount) * 100);
			fullApis.coverageInfo = covInfo;

			Logger.info(`${"─".repeat(10)} Total Process Stats ${"─".repeat(10)}`)
			Logger.info(
				` - ${Program.colors.get("yellow", fullApis.enums.length)} Enums`,
				{ name: NAME }
			)
			// Functions found during the whole build.
			Logger.info(
				` - ${Program.colors.get("yellow", fullApis.functions.length)} Functions`,
				{ name: NAME }
			)
			// Wrappers found during the whole build.
			Logger.info(
				` - ${Program.colors.get("orange", fullApis.wrappers.length)} Wrappers`,
				{ name: NAME }
			)
			Logger.info(
				` - ${Program.colors.get("red", fullApis.artifacts.length)} Artifacts`,
				{ name: NAME }
			)
			if (fullApis.artifacts.length > 0) {
				Logger.info(`${"─".repeat(10)} Artifacts ${"─".repeat(10)}`)
				for (const a of fullApis.artifacts) {
					Logger.info(` - ${Program.colors.get("yellow", a)}`, {
						name: NAME,
					})
				}
			}
			Logger.info(
				`Total Time: ${Program.colors.get("green", totalTime.toFixed(2) + "s")}`,
				{ name: NAME }
			)
			if (fullApis.coverageInfo) {
				Logger.info(
					`Coverage: ${Program.colors.get("green", `${fullApis.coverageInfo.percent}%`)}`,
					{ name: NAME }
				)
			}
			Logger.info(
				`Result: ${Program.colors.get("green", "Success")}`,
				{ name: NAME }
			)
		}
	)
}

await main().catch((error) => {
	Logger.error(`${error.message}`, { name: NAME, error })
	process.exit(1)
})
