/**
 * @overview
 *
 * A script to find target functions in order to wrap them with GML functions
 *
 * @author knno <github.com/knno>
 */
import path from "path"
import { fileURLToPath } from "url"
import { getOrCreateModule } from "../../lib/modules.js"
import { Program } from "../../lib/program.js"

const __filename = fileURLToPath(import.meta.url)
const __dirname = path.dirname(__filename)
const NAME = "wrappers:gen"
const Logger = Program.Logger
const Term = Program.terminal

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
	const apis = []
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
					// const tokens = JSON.parse(message.result)
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
	Promise.all(tasks)
	Term.main(
		() => apis.length == filePaths.length,
		() => {
			Term.setProgressBarVisible(false)
			Term.render()
			const totalEndTime = Date.now()
			const totalTime = (totalEndTime - totalStartTime) / 1000

			const fullApi = {
				enums: apis.flatMap((api) => api.enums || []),
				functions: apis.flatMap((api) => api.functions || []),
				artifacts: apis.flatMap((api) => api.artifacts || []),
			}

			// TODO: Here we should update the .gml files directly to the gm/scripts/..... for namespaces (e.g. ImGui, and ImExtExtensionName)
			// from the enums and functions parsed above. with jsdocs (from config as a reference)

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
				` - ${Program.colors.get("orange", fullApi.artifacts.length)} Artifacts`,
				{ name: NAME }
			)
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
