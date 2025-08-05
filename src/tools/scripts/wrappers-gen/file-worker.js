import fs from "fs"
import { parentPort, workerData } from "worker_threads"
import { getOrCreateModule } from "../../lib/modules.js"
import cpp from "../../lib/parsers/langs/cpp.js"
import { getApi } from "../../lib/parsers/wrappers.js"

import path from "path"
import { Program } from "../../lib/program.js"

Program.setup(true)

const { filePath, moduleHandle, totalStartTime } = workerData

const Logger = Program.Logger
const NAME = "wrapper:gen"

const main = async () => {
	try {
		// Check file exists
		fs.accessSync(filePath, fs.constants.F_OK)
		const module = await getOrCreateModule(moduleHandle)

		const fileContent = fs.readFileSync(filePath, "utf-8")
		const lexer = new cpp.Lexer(fileContent)
		const parser = new cpp.Parser(lexer)
		parser.main()

		// Generate API
		const api = await getApi(parser.tokens, module, filePath)

		const result = {}

		result.time = (Date.now() - totalStartTime) / 1000
		result.moduleHandle = module.handle
		result.file = filePath
		result.tokens = JSON.stringify(api.tokens)
		result.enums = api.enums.filter((e) => {
			return { name: e.name.to() }
		})
		result.functions = JSON.stringify(api.functions)
		result.artifacts =
			api.artifacts.length > 0 ? JSON.stringify(api.artifacts) : undefined

		// Send result back to main thread
		Logger.warn(`Finished: "${path.basename(filePath)}"`, { name: NAME })
		parentPort.postMessage({
			type: "result",
			success: true,
			result,
		})
	} catch (error) {
		parentPort.postMessage({
			type: "result",
			success: false,
			error: error,
		})
	}
}

await main()
