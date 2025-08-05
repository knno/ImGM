/**
 * @overview
 *
 * A script to find target functions in order to wrap them with GML functions
 *
 * @author knno <github.com/knno>
 */
import path from "path"
import { fileURLToPath } from "url"
import Name from "../../lib/class/name.js"
import { getOrCreateModule } from "../../lib/modules.js"
import { CppToken } from "../../lib/parsers/langs/cpp.js"
import { ApiFunction, getWrappers } from "../../lib/parsers/wrappers.js"
import { Program } from "../../lib/program.js"

const __filename = fileURLToPath(import.meta.url)
const __dirname = path.dirname(__filename)
const NAME = "wrappers:gen"
const Logger = Program.Logger
const Term = Program.terminal
let isReady = false

async function main() {
	const params = Program.getParams()

	if (!params._args || params._args.length < 2) {
		console.error(`Usage: npm run ${NAME} -- <module> <path/to/file.cpp>`)
		return
	}

	const moduleHandle = params._args[0]
	let module

	try {
		module = await getOrCreateModule(moduleHandle)
	} catch (error) {
		Logger.error(`Error creating module from handle "${moduleHandle}"`, {
			name: NAME,
		})
		process.exit(1)
	}

	const filePaths = params._args.slice(1).map((p) => path.resolve(p))
	let apis = []
	const totalStartTime = Date.now()

	Term.setProgressMax(filePaths.length)
	Term.setProgressBarVisible(true)
	Term.render()

	const tasks = filePaths.map((filePath) =>
		Program.worker(
			path.join(__dirname, "file-worker.js"),
			filePath,
			{
				filePath,
				moduleHandle: module.handle,
				totalStartTime,
			},
			{
				resultSuccess: (message, resolve, reject) => {
					apis.push(message.result)
					Term.setProgress(Term.progress + 1)
					Term.render()
					resolve()
				},
				resultError: (message, resolve, reject) => {
					Logger.error(
						`${message.message ?? "Unsuccessful"}: ${message.error ? (message.error.message ?? message.error) : message.result}`,
						{
							name: NAME,
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
	)

	// Process files with worker threads
	Promise.all(tasks).then(() => {
		isReady = true
	})

	Term.main(
		() => isReady || apis.length >= filePaths.length,
		() => {
			Term.setProgressBarVisible(false)
			Term.render()
			const totalEndTime = Date.now()
			const totalTime = (totalEndTime - totalStartTime) / 1000

			// Tokenize result stuffs back
			let createToken = (t) => {
				let newTok = new CppToken({
					type: t.type,
					value: t.value,
					line: t.line,
					col: t.col,
					children: (t.children || []).map(createToken), // recursive
				})
				newTok.source = t.source
				newTok._extra = t._extra
				return newTok
			}
			apis.tokens = apis
				.flatMap((api) => {
					let tokens = JSON.parse(api.tokens) || []
					tokens = tokens.map((t) => {
						t.source ??= api.file
						return t
					})
					api.tokens = tokens
					return tokens
				})
				.map(createToken)

			let funcs = apis.flatMap((api) => JSON.parse(api.functions) || [])
			apis.functions = funcs.map((f) => {
				let func = new ApiFunction({
					name: new Name(f.name._name, f.name._case, f.name._sep),
					args: f.args,
					returnType: f.returnType,
					source: f.source,
					sourceToken:
						apis.tokens.find((t) => {
							t.type == f.sourceToken.type &&
								t.line == f.sourceToken.line &&
								t.pos == f.sourceToken.pos
						}) ?? f.sourceToken,
					namespace: f.namespace,
					comment: f.comment ?? "",
				})
				return func
			})

			// Analyze wrappers
			let wrapperAnalyzer = getWrappers(apis.tokens, apis)

			const fullApi = {
				tokens: apis.tokens,
				enums: apis.flatMap((api) => api.enums || []),
				functions: apis.flatMap((api) => api.functions || []),
				wrappers: wrapperAnalyzer.wrappers,
				artifacts: apis.flatMap((api) => api.artifacts || []),
			}

			console.log(fullApi.wrappers[0])

			// TODO: Here we should update the .gml files directly to the gm/scripts/..... for namespaces (e.g. ImGui, and ImExtExtensionName)
			// from the enums and wrappers above. with jsdocs (from config as a reference)

			Logger.info(`${"─".repeat(10)} Total Stats ${"─".repeat(10)}`)
			Logger.info(
				` - ${Program.colors.get("yellow", fullApi.enums.length)} Enums`,
				{ name: NAME }
			)
			Logger.info(
				` - ${Program.colors.get("yellow", fullApi.functions.length)} Functions`,
				{ name: NAME }
			)
			Logger.info(
				` - ${Program.colors.get("orange", fullApi.wrappers.length)} Wrappers`,
				{ name: NAME }
			)
			Logger.info(
				` - ${Program.colors.get("red", fullApi.artifacts.length)} Artifacts`,
				{ name: NAME }
			)
			if (fullApi.artifacts.length > 0) {
				Logger.info(`${"─".repeat(10)} Artifacts ${"─".repeat(10)}`)
				for (const a of fullApi.artifacts) {
					Logger.info(` - ${Program.colors.get("yellow", a)}`, {
						name: NAME,
					})
				}
			}
			Logger.info(
				`Total Time: ${Program.colors.get("green", totalTime.toFixed(2) + "s")}`,
				{ name: NAME }
			)
		}
	)
}

await main().catch((error) => {
	console.error(error)
	process.exit(1)
})
