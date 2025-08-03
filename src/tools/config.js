import * as fs from "fs"
import path from "path"
import { pathToFileURL } from "url"
import defaultConfig from "./defaults.js"
import { projectRoot } from "./defaults.js"
import { assignObjectRecursive } from "./lib/utils/data.js"
import Import from "./lib/utils/import.js"

const gmConfig = {
	defaultRuntime: "runtime-2024.11.0.227",
	defaultProgram: "GameMakerStudio2",
}

let Config = {
	gm: gmConfig,
	logging: {
		ignore: ["DM01", "DP03", "DP02"],
	},
	dll: {
		modifierDirective: "GM",
	}
}

Config = assignObjectRecursive(defaultConfig, Config)
const UserConfig = await Import(path.join(projectRoot, "imgm.config.js"))
if (UserConfig) {
	Config = assignObjectRecursive(Config, UserConfig.default)
}

export default Config
