import fs from "fs";
import Path from "path";
import { fileURLToPath } from "url";
import Config from "../../config.js";
import File from "../../lib/class/file.js";
import Name from "../../lib/class/name.js";
import { Module, toHandle } from "../../lib/modules.js";
import { Program } from "../../lib/program.js";
import * as str from "../../lib/utils/string.js";
import Logger from "../../lib/logging.js"

const __filename = fileURLToPath(import.meta.url)
const __dirname = Path.dirname(__filename)


function getSrcLine(wrapper) {
    let srcLineFile = Path.relative(Path.join(__dirname, '../../../../'), wrapper.source);
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
        var coverageApiCount = 0; // all api funcs regardless of hidden
        var coverageSupportedApiCount = 0; // all api funcs with wrappers regardless of hidden
        var totalApiCount = group.functions.length; // regardless of hidden

        const functions = [];
        const wrappers = [];
        const extraWrappers = [];

        // Sort group.wrappers by name._name alphabetically
        const sortedGroupWrappers = [...group.wrappers].sort((a, b) => {
            const nameA = a.name ? ((a.name instanceof Name) ? a.name.get() : a.name).toLowerCase() : '';
            const nameB = b.name ? ((b.name instanceof Name) ? b.name.get() : b.name).toLowerCase() : '';
            return nameA.localeCompare(nameB);
        });

        const getWNote = function (wrapper, def = "-") {
            const wname = (wrapper.name instanceof Name ? wrapper.name.get() : wrapper.name);
            const wns = toHandle(wrapper.namespace)
            const ws = Module._loadedModules[wns]?.config?.docs?.wrappers
            if (ws) {
                let found = ws[wname];
                if (found) {
                    return found.note ?? def;
                }
            }
            return def;
        }

        const getWLocation = function (wrapper, def = "-") {
            const wname = (wrapper.name instanceof Name ? wrapper.name.get() : wrapper.name);
            const wns = toHandle(wrapper.namespace)
            const ws = Module._loadedModules[wns]?.config?.docs?.wrappers
            if (ws) {
                let found = ws[wname];
                if (found) {
                    return found.link ?? def;
                }
            }
            return def;
        }

        const getWSupported = function (wrapper, def = "-") {
            const wname = (wrapper.name instanceof Name ? wrapper.name.get() : wrapper.name);
            const wns = toHandle(wrapper.namespace)
            const ws = Module._loadedModules[wns]?.config?.docs?.wrappers
            if (ws) {
                let found = ws[wname];
                if (found) {
                    return found.supported ? "✅" : "❌";
                }
            }
            return def;
        }

        group.functions.map(f => {
            const w = sortedGroupWrappers.find(wrapper => (wrapper.name instanceof Name ? wrapper.name.get() : wrapper.name) == f.name._name || wrapper.name?._name == f.name._name || wrapper.targetFunc == f.name._name);
            var covered = w != undefined;
            if (covered) {
                if (!w.isHidden) {
                    wrappers.push(w);
                }
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
                if (!w.isHidden) {
                    extraWrappers.push(w);
                }
            }
        });

        const _wraps = functions.map(f => {
            coverageApiCount++;
            coverageSupportedApiCount++;
            if (f._wrapper) {
                return `| \`${f._wrapper.namespace}.${f._wrapper.name}\` | ✅ | ${getWLocation(f._wrapper, getSrcLine(f._wrapper))} | ${getWNote(f._wrapper, "-")} |`;
            } else {
                let supportText = getWSupported(f, "❌")
                let note = getWNote(f, "-")
                let loc = getWLocation(f, "-")
                if (supportText != "✅") {
                    coverageSupportedApiCount--;
                    if (note == "-" && loc == "-") {
                        coverageApiCount--;
                    }
                }
                return `| \`${f.namespace}.${f.name}\` | ${supportText} | ${loc} | ${note} |`;
            }
        })

        const _extras = extraWrappers.map(w => {
            return `| \`${w.namespace}.${w.name}\` | ${getWLocation(w, getSrcLine(w))} | ${getWNote(w, "-")} |`
        });

        const percent = totalApiCount === 0 ? 0 : Math.round((coverageApiCount / totalApiCount) * 100);

        const coveragePath = Path.join("docs/coverage", `${namespace}.md`);
        if (!fs.existsSync(coveragePath)) {
            fs.writeFileSync(coveragePath, "");
        }
        const coverageBadgePath = Path.join(`extras/badges/coverage.${namespace}.badge.json`);
        if (!fs.existsSync(coverageBadgePath)) {
            fs.writeFileSync(coverageBadgePath, "");
        }
        const file = new File(coveragePath)
        const badgeFile = new File(coverageBadgePath)

        const newCov = [
            `# ${namespace} Coverage`,
            (totalApiCount > 0) ? `\n**Coverage:** ${percent}% (${coverageApiCount}/${totalApiCount})\n` : ``,
            '', '## Wrappers', '',
            ...((totalApiCount > 0) ? [
                `These are the wrappers of functions generated for ${namespace}.`, '',
                '| Wrapper | Covered | Wrapper Location | Note |',
                '|---------|---------|------------------|------|',
                ..._wraps,
            ] : [
                `There were no functions detected for ${namespace}.`,
            ]),
            '', '', '## Custom Wrappers', '', `These are non-standard functions made specifically for ${namespace}.`, '',
            '| Wrapper | Wrapper Location | Note |',
            '|---------|------------------|------|',
            ..._extras,
        ].join('\n');

        const newBadge = `{"subject":"coverage","status":"${(totalApiCount > 0) ? percent : "100"}%","color":"green"}`;

        if (!process.env.DRYRUN) {
            if (file.update(newCov)) {
                if (file.commit()) {
                    Logger.info(`Updated coverage: ${coveragePath}`, {
                        type: Logger.types.FILES_UDPATE_WRITTEN
                    })
                }
            }
            if (badgeFile.update(newBadge)) {
                badgeFile.commit()
            }
        }

        return {
            percent,
            coverageCount: coverageApiCount,
            totalCount: totalApiCount,
        }
    }
}