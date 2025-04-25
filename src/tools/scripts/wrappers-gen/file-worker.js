import { parentPort, workerData } from "worker_threads"
import fs from "fs"
import { getOrCreateModule } from "../../lib/modules.js"
import cpp from "../../lib/parsers/langs/cpp.js"
import { getApi } from "../../lib/parsers/wrappers.js"

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
		result.file = filePath
		result.tokens = JSON.stringify(api.tokens)
		Logger.warn(
			[
				api.tokens.length,
				api.enums.length,
				api.functions.length,
				api.artifacts.length,
			].join(", "),
			{ name: NAME }
		)
		result.enums = api.enums
		result.functions = api.functions
		result.artifacts = api.artifacts

		// Send result back to main thread
		Logger.warn("Finished", { name: NAME })
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
