import Path from "path"

import Config from "../config.js"
import Name from "../lib/class/name.js"
import { copyFiles } from "../lib/filesystem.js"
import * as gmk from "../lib/gm.js"
import Logger from "../lib/logging.js"
import { getChildModules, getOrCreateModule, loadModules } from "../lib/modules.js"
import { Program } from "../lib/program.js"

const NAME = "modules:info"
const ImGMError = Program.Error

async function main() {
    const params = Program.getParams()

    let countChilds = 0
    let countMain = 0;
    let allChilds = [];

    const modules = await loadModules(); // Preload modules
    let moduleKeys = Object.keys(Config.modules);

    for (const cfgModuleHandle in Config.modules) {
        const cfgModule = await getOrCreateModule(cfgModuleHandle)
        if (cfgModule) {
            const cfgModuleChilds = await getChildModules(cfgModule)
            allChilds.push(...cfgModuleChilds);
        }
    }
    let gm = gmk.getInfo();
    Logger.info(`You have selected ${Program.colors.get("white", gm.programName)} with ${Program.colors.get("white", gm.runtimeName)} for ImGM`, {name: NAME});

    countChilds = allChilds.length;
    countMain = Object.keys(Config.modules).length;
    Logger.info(`You have ${countMain} main modules (${countChilds + countMain} total):`, { name: NAME });
    for (const mK of moduleKeys) {
        Logger.info(` * ${mK} (${Program.colors.get("white", modules[mK].name)}) - ${Program.colors.get("gray", modules[mK].submoduleDir)}`, { name: NAME });
        for (const ch of allChilds.filter(c => c.parent.handle == modules[mK].handle)) {
            Logger.info(`   - ${ch.handle} (${Program.colors.get("white", ch.name)}) - ${Program._config.enabledImExts.has(ch.handle) ? Program.colors.get("green","✔") : Program.colors.get("lightgray","✗")} - ${Program.colors.get("gray", ch.submoduleDir)}`, { name: NAME });
        }
    }


    try {
        if (true) {
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
