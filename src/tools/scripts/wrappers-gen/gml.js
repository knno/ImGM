import Path from "path"
import { Program } from "../../lib/program.js"
import { generateGMLScript } from "./gml-writer.js" // hypothetical module
import File from "../../lib/class/file.js"
import Name from "../../lib/class/name.js"

const Logger = Program.Logger

export async function updateGmlScripts(fullApi, config) {
	Logger.info("Updating GML scripts...")

	const namespaceGroups = {}

	// Group wrappers and enums by namespace
	for (const wrapper of fullApi.wrappers) {
		const ns = wrapper.namespace ?? "ImGui"
		wrapper.namespace = ns;
		if (!namespaceGroups[ns])
			namespaceGroups[ns] = { wrappers: [], enums: [] }
		namespaceGroups[ns].wrappers.push(wrapper)
	}

	for (const en of fullApi.enums) {
		const ns = en.namespace ?? "ImGui"
		en.namespace = ns;
		if (!namespaceGroups[ns])
			namespaceGroups[ns] = { wrappers: [], enums: [] }
		namespaceGroups[ns].enums.push(en)
	}

	// Write each namespace group to its own GML file
	for (const [namespace, group] of Object.entries(namespaceGroups)) {
		const scriptPath = Path.join("src/gm/ImGM", "scripts", `${namespace}/${namespace}.gml`)
		const file = new File(scriptPath)

		// Sort group.wrappers by name._name alphabetically
		const sortedWrappers = [...group.wrappers].sort((a, b) => {
			const nameA = a.name ? ((a.name instanceof Name) ? a.name.get() : a.name).toLowerCase() : '';
			const nameB = b.name ? ((b.name instanceof Name) ? b.name.get() : b.name).toLowerCase() : '';
			return nameA.localeCompare(nameB);
		});

		const contents = generateGMLScript({
			namespace,
			enums: group.enums,
			wrappers: sortedWrappers,
			cfg: config,
		})

		// contents.enums and contents.binds are texts inside their own regions.
		// replace file.content (whatever inside "#region Binds\n... #endregion") with new contents.

		const replaceRegion = (orig, regionName, newText) => {
			const re = new RegExp(
				`(#region\\s+${regionName}\\s*[\\r\\n]*)([ \\t]*[\\s\\S]*?)([ \\t]*#endregion)`,
				"i"
			)
			if (re.test(orig)) {
				return orig.replace(re, (m, p1, _old, p3) => {
					// ensure newText ends with a single newline
					const txt = newText.replace(/\r\n/g, "\n").replace(/\n+$/g, "") + "\n"
					return p1 + txt + p3
				})
			} else {
				// region missing -> append at end
				return orig + `\n#region ${regionName}\n` + newText + `\n#endregion\n`
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
				file.commit()
			}
		}

		Logger.info(`Updated script: ${scriptPath}`)
	}
}
