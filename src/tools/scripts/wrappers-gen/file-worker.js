import fs from "fs"
import path from "path"
import { parentPort, workerData } from "worker_threads"
import Name from "../../lib/class/name.js"
import { getOrCreateModule } from "../../lib/modules.js"
import cpp from "../../lib/parsers/langs/cpp.js"
import { getApi } from "../../lib/parsers/wrappers.js"
import { Program } from "../../lib/program.js"

Program.setup(true)

const { filePath, moduleHandle, parentModule, totalStartTime } = workerData

const Logger = Program.Logger
const NAME = "wrapper:gen"

const main = async () => {
	try {
		// Check file exists
		fs.accessSync(filePath, fs.constants.F_OK)
		var module;
		if (parentModule) {
			const parentModuleObj = await getOrCreateModule(parentModule);
			module = await getOrCreateModule(moduleHandle, undefined, parentModuleObj)
		} else {
			module = await getOrCreateModule(moduleHandle);
		}

		const fileContent = fs.readFileSync(filePath, "utf-8")
		const lexer = new cpp.Lexer(fileContent)
		const parser = new cpp.Parser(lexer)
		parser.main()

		// Generate API
		const api = await getApi(parser.tokens, module, filePath)
		const result = {}

		result.time = (Date.now() - totalStartTime) / 1000
		result.moduleHandle = module.handle
		result.moduleName = module.name.get()
		result.file = filePath
		result.tokens = JSON.stringify(api.tokens)
		result.enums = JSON.stringify(api.enums)
		result.functions = JSON.stringify(
			api.functions.map((f) => {
				f.args = JSON.stringify(f.args)
				return f
			})
		)
		result.artifacts =
			api.artifacts.length > 0 ? JSON.stringify(api.artifacts) : undefined

		// Send result back to main thread
		Logger.debug(`Finished`, { name: NAME, type: Logger.types.WRAPPER_FILE_PARSE })
		parentPort.postMessage({
			type: "result",
			success: true,
			result: result,
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
