import Path from "path"
import { fileURLToPath } from "url"
import { Program } from "../../lib/program.js"
import File from "../../lib/class/file.js"
import Config from "../../config.js"
import Name from "../../lib/class/name.js"

const __filename = fileURLToPath(import.meta.url)
const __dirname = Path.dirname(__filename)

const Logger = Program.Logger


function getSrcLine(wrapper) {
    let srcLineFile = Path.relative(Path.join(__dirname,'../../../../'), wrapper.source);
    let srcLineLink = `${Config.projectLink}/blob/main/${srcLineFile.replace(/\\/g, `/`)}#L${wrapper.sourceToken.line}`;
    return `[${Path.basename(srcLineFile)}](${srcLineLink})`;
}

export function generateCoverage(fullApi) {
    const namespaceGroups = {}

    // Group functions and wrappers by namespace
    for (const wrapper of fullApi.wrappers) {
        const ns = wrapper.namespace ?? "ImGui"
        wrapper.namespace = ns;
        if (!namespaceGroups[ns])
            namespaceGroups[ns] = { wrappers: [], functions: [] }
        namespaceGroups[ns].wrappers.push(wrapper)
    }

    for (const func of fullApi.functions) {
        const ns = func.namespace ?? "ImGui"
        func.namespace = ns;
        if (!namespaceGroups[ns])
            namespaceGroups[ns] = { wrappers: [], functions: [] }
        namespaceGroups[ns].functions.push(func)
    }

    // Write each namespace group to its own coverage
    for (const [namespace, group] of Object.entries(namespaceGroups)) {
        var coverageCount = 0;
        var totalCount = group.functions.length;

        const functions = [];
        const wrappers = [];
        const extraWrappers = [];

        // Sort group.wrappers by name._name alphabetically
        const sortedGroupWrappers = [...group.wrappers].sort((a, b) => {
            const nameA = a.name ? ((a.name instanceof Name) ? a.name.get() : a.name).toLowerCase() : '';
            const nameB = b.name ? ((b.name instanceof Name) ? b.name.get() : b.name).toLowerCase() : '';
            return nameA.localeCompare(nameB);
        });

        const getWNote = function(wrapper, def="-") {
            const wname = (wrapper.name instanceof Name ? wrapper.name.get() : wrapper.name);
            const ws = fullApi.modulesConfigs[wrapper.namespace].wrappers
            let found = ws[wname];
            if (found) {
                return found.note ?? def;
            }
            return def;
        }

        const getWLocation = function(wrapper, def="-") {
            const wname = (wrapper.name instanceof Name ? wrapper.name.get() : wrapper.name);
            const ws = fullApi.modulesConfigs[wrapper.namespace].wrappers
            let found = ws[wname];
            if (found) {
                return found.link ?? def;
            }
            return def;
        }

        const getWSupported = function(wrapper, def="-") {
            const wname = (wrapper.name instanceof Name ? wrapper.name.get() : wrapper.name);
            const ws = fullApi.modulesConfigs[wrapper.namespace].wrappers
            let found = ws[wname];
            if (found) {
                return found.supported ? "✅" : "❌";
            }
            return def;
        }

        group.functions.map(f => {
            const w = sortedGroupWrappers.find(wrapper => (wrapper.name instanceof Name ? wrapper.name.get() : wrapper.name) == f.name._name || wrapper.name?._name == f.name._name || wrapper.targetFunc == f.name._name);
            var covered = w != undefined;
            if (covered) {
                coverageCount++;
                wrappers.push(w);
                f._wrapper = w;
            } else {
                f._wrapper = undefined;
            }
            if (functions.findIndex(f2 => f2.name._name == f.name._name) == -1) {
                functions.push(f);
            }
        });

        sortedGroupWrappers.map(w => {
            var isExtra = (!wrappers.includes(w));
            if (isExtra) {
                extraWrappers.push(w);
            }
        });

        const _wraps = functions.map(f => {
            if (f._wrapper) {
                return `| \`${f._wrapper.namespace}.${f._wrapper.name}\` | ✅ | ${getWLocation(f._wrapper, getSrcLine(f._wrapper))} | ${getWNote(f._wrapper, "-")} |`;
            } else {
                let supportText = getWSupported(f, "❌");
                if (supportText == "✅") {
                    coverageCount++;
                }
                return `| \`${f.namespace}.${f.name}\` | ${supportText} | ${getWLocation(f, "-")} | ${getWNote(f, "-")} |`;
            }
        })
        const _extras = extraWrappers.map(w => `| \`${w.namespace}.${w.name}\` | ${getWLocation(w, getSrcLine(w))} | ${getWNote(w, "-")} |`);

        const percent = totalCount === 0 ? 0 : Math.round((coverageCount / totalCount) * 100);

        const coveragePath = Path.join("docs/coverage", `${namespace}.md`);
        const file = new File(coveragePath)

        const newCov = [
            `# ${namespace} Coverage`,
            '',
            `**Coverage:** ${percent}% (${coverageCount}/${totalCount})`,
            '','','## Wrappers','',`These are the wrappers of functions generated for ${namespace}.`,'',
            '| Wrapper | Covered | Wrapper Location | Note |',
            '|---------|---------|------------------|------|',
            ..._wraps,
            '','','## Custom Wrappers','',`These are non-standard functions made specifically for ${namespace}.`,'',
            '| Wrapper | Wrapper Location | Note |',
            '|---------|------------------|------|',
            ..._extras,
        ].join('\n');

        if (!process.env.DRYRUN) {
            if (file.update(newCov)) {
                file.commit()
            }
        }

        Logger.info(`Updated coverage: ${coveragePath}`)
    }
}