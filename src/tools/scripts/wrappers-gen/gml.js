import fs from "fs";
import Path from "path";
import Config from "../../config.js";
import File from "../../lib/class/file.js";
import Name from "../../lib/class/name.js";
import { Program } from "../../lib/program.js";
import * as str from "../../lib/utils/string.js";
import { generateGMLScript } from "./gml-writer.js";
import ImGMError, { ImGMAbort } from "../../lib/class/error.js";

const Logger = Program.Logger

export function updateGmlScripts(fullApi) {
	const namespaceApis = {}
	let par = undefined;

	// Group wrappers and enums by namespace
	for (const wrapper of fullApi.wrappers) {
		const ns = wrapper.namespace ?? "ImGui"
		wrapper.namespace = ns;
		if (!namespaceApis[ns]) {
			namespaceApis[ns] = { wrappers: [], enums: [] }
		}
		namespaceApis[ns].wrappers.push(wrapper)
	}

	for (const en of fullApi.enums) {
		const ns = en.namespace ?? "ImGui"
		en.namespace = ns;
		if (!namespaceApis[ns]) {
			namespaceApis[ns] = { wrappers: [], enums: [] }
		}
		namespaceApis[ns].enums.push(en)
	}

	var modconf;
	var mods;

	// Write each namespace api to its own GML file
	if (fullApi.modulesConfigs.requestedModuleChildrenHandles.size > 0) {
		mods = fullApi.modulesConfigs.requestedModuleChildrenHandles;
	} else {
		mods = [fullApi.modulesConfigs.requestedModuleHandle];
	}
	for (const mH of mods) {
		for (const [namespace, api] of Object.entries(namespaceApis)) {
			modconf = fullApi.modulesConfigs[mH] ?? {
				moduleFileName: "ImGui",
			};
			const scriptPath = Path.join("src/gm/ImGM", "scripts", `${modconf.moduleFileName}/${modconf.moduleFileName}.gml`)
			if (!fs.existsSync(scriptPath)) {
				Logger.error(`Please create a GML asset or file as "${scriptPath}".`);
				break;
			}
			const file = new File(scriptPath)

			// Sort api.wrappers by name._name alphabetically
			const sortedWrappers = [...api.wrappers].sort((a, b) => {
				const nameA = a.name ? ((a.name instanceof Name) ? a.name.get() : a.name).toLowerCase() : '';
				const nameB = b.name ? ((b.name instanceof Name) ? b.name.get() : b.name).toLowerCase() : '';
				return nameA.localeCompare(nameB);
			});

			const sortedGmlWrappers = sortedWrappers.filter(w => w.isPrivate == false);

			const contents = generateGMLScript({
				namespace,
				enums: api.enums,
				wrappers: sortedGmlWrappers,
			})

			// contents.enums and contents.binds are texts inside their own regions.
			// replace file.content (whatever inside "#region Binds\n... #endregion") with new contents.

			const replaceRegion = (orig, regionName, newText) => {
				const re = new RegExp(
					`([\t ]*)(#region\\s+${regionName}\\s*[\\r\\n]*)([ \\t]*[\\s\\S]*?)([ \\t]*#endregion)`,
					"i"
				)
				if (re.test(orig)) {
					return orig.replace(re, (m, p1, p2, _old, p3) => {
						// ensure newText ends with a single newline
						let txt = newText.replace(/\r\n/g, "\n").replace(/\n+$/g, "")
						return `${p1}#region ${regionName}\n` + (txt ? `\n${p1}${txt}\n` : ``) + `\n${p1}#endregion`;
					})
				} else {
					// region missing
					throw new ImGMAbort(`Please add \"${Program.colors.get("green", `#region ${regionName}`)}${Program.colors.get("red")}\" and \"${Program.colors.get("green", `#endregion`)}${Program.colors.get("red")}\" in the file "${Program.colors.get("orange")}${file.name}${Program.colors.get("red")}" correctly and try again.`)
				}
			}

			let updated = file.content
			if (contents.enums !== undefined) {
				updated = replaceRegion(updated, "Enums", contents.enums)
			}
			if (contents.binds !== undefined) {
				updated = replaceRegion(updated, "Binds", contents.binds)
			}

			if (!process.env.DRYRUN) {
				if (file.update(updated)) {
					if (file.commit()) {
						Logger.info(`Updated GML: ${scriptPath}`, {
							type: Logger.types.FILES_UDPATE_WRITTEN
						})
					}
				}
			}
		}
	}
}
