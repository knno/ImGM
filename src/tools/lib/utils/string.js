import Name from "../class/name.js"

export function padNumber(number, digits = 1000) {
	digits = digits.toString().length
	return number.toString().padStart(digits, "0")
}

export function rePascalCase(str) {
	// PascalCase to [Pp]ascal[Cc]ase
	return str.replace(/[A-Z]/g, (char) => `[${char}${char.toLowerCase()}]`)
}

function _normName(name) {
	if (name instanceof Name) { name = name._name; }
	return name
		.replace(/([a-z])([A-Z])/g, `$1 $2`) // camels (aA => a A)
		.replace(/[^a-zA-Z0-9]+/g, " ") // Remove non-alphanumeric characters
		.trim()
}

// PascalCase
export function toPascalCase(name, resultSep = "") {
	// normalize -> spaces -> map replace
	return _normName(name)
		.split(" ")
		.map(
			(word) => word.charAt(0).toUpperCase() + word.slice(1) // Capitalize each word
		)
		.join(resultSep) // Join with specified separator
}

// camelCase
export function toCamelCase(name, resultSep = "") {
	const zwSep = "\u200B" // space of zero-width
	const pascalCase = toPascalCase(name, zwSep)
	return (
		pascalCase.charAt(0).toLowerCase() +
		pascalCase.slice(1).split(zwSep).join(resultSep)
	)
}

// snake_case
export function toSnakeCase(name, resultSep = "_") {
	return _normName(name)
		.split(" ")
		.map((word) => word.toLowerCase())
		.join(resultSep)
}

// kebab-case
export function toKebabCase(name, resultSep = "-") {
	return toSnakeCase(name, resultSep)
}

// custom_Snake_Case
export function toCustomSnakeCase(name, resultSep = "_") {
	return _normName(name)
		.split(" ")
		.map((word, index) =>
			index === 0
				? word.toLowerCase()
				: word.charAt(0).toUpperCase() + word.slice(1).toLowerCase()
		)
		.join(resultSep)
}

// SCREAMING_CASE   AAAAAA
export function toScreamingCase(name, resultSep = "_") {
	return _normName(name)
		.split(" ")
		.map((word) => word.toUpperCase())
		.join(resultSep)
}

/**
 *
 * @param {String} msg
 * @param {Object} extra
 * @return {String}
 */
export function resolveTemplate(msg, extra) {
	// Just replaces any `%(key)s` with corresponding value from `extra`
	if (extra && typeof extra === "object") {
		Object.entries(extra).forEach(([key, value]) => {
			const placeholder = `%(${key})s`
			msg = msg.replaceAll(placeholder, `${value}`)
		})
	}
	return msg
}

/**
 *
 * @param {String} string
 * @return {String}
 */
export function ansiClean(string) {
	const ansiRegex = /\x1b\[[0-9;]*m/g
	return string.replace(ansiRegex, "")
}

/**
 *
 * @param {String} string
 * @param {Number} start
 * @param {Number} end
 * @returns {String}
 */
export function ansiSlice(string, start, end) {
	const ansiRegex = /\x1b\[[0-9;]*m/g
	const strippedString = string.replace(ansiRegex, "")
	const part = strippedString.slice(start, end)
	let visIndex = 0
	let result = ""
	let inAnsi = false
	for (const char of string) {
		if (char === "\x1b") inAnsi = true
		if (!inAnsi && visIndex >= start && visIndex < end) {
			result += char
		}
		if (!inAnsi) visIndex += 1
		if (char.match(/m/) && inAnsi) inAnsi = false
		if (visIndex >= end && !inAnsi) break
		if (inAnsi) result += char
	}
	return result
}

/**
 * Strip all prefixes from each line in the input string.
 *
 * @param {String} input
 * @returns {String}
 */
export function stripLinesPrefix(input) {
	let x = input
		.split("\n")
		.map((line) =>
			line.trimStart().startsWith("//")
				? line.replace(/^\/\/\/?\s*/, "")
				: line
		)
		.filter(line => line.length > 0)
		.join("\n")
	return x
}

/**
 * Strip from single-line jsdoc comments to the contents only.
 *
 * @param {String} input
 * @returns {String}
 */
export function stripSingleJsdoc(input) {
	let x = stripLinesPrefix(input);
	return x;
}

/**
 * Strip from multiline jsdoc to contents only.
 *
 * @param {String} input
 * @returns {String}
 */
export function stripMultiJsdoc(input) {
	let x = input
		.split("\n")
		.map((line) => {
			let trimmed = line.trimStart();
			if (trimmed.startsWith("/**") || trimmed.startsWith("/*") || trimmed.startsWith("*/")) {
				return "";
			}
			if (trimmed.startsWith("*")) {
				trimmed = trimmed.replace(/^\*\s?/, "");
			}
			return trimmed;
		})
		.filter(line => line.length > 0)
		.join("\n")
	return x
}

/**
 * Return docstring information in an object keyed by tag and the rest of line.
 * - Param tags are grouped in a params object.
 * - Other multiple tags are grouped in arrays.
 * - Description text before any tags is stored in the "_" key if there was no description tag.
 * - When there's no description tag, the text before any tags is considered the description.
 * - Single tags are stored as strings.
 * - desc and description tags are considered the same. Using description attr.
 *
 * @example
 * "/**
 * * Text before anything.
 * *
 * * \@desc This is a sample function.
 * * \@param arg1 The first argument.
 * * \@param arg2 The second argument.
 * * \@customtag Some custom tag info.
 * * \@customtag2 Additional info one.
 * * \@customtag2 Additional info two.
 * *
 * * \@return The result.
 * *\/"
 *
 * parseJsDoc(comment) == {
 *   _: "Text before anything."
 *   description: "This is a sample function.",
 *   params: {
 *      arg1: "The first argument.",
 *      arg2: "The second argument."
 *   },
 *   customtag: "Some custom tag info.",
 *   customtag2: [
 * 		"Additional info one."
 * 		"Additional info two."
 *   ],
 *   return: "The result."
 * }
 *
 * @param {String} input
 * @returns {String}
 */
export function parseJsDoc(input) {
	const docInfo = {}
	let currentTag = null
	let currentTagContent = []
	const lines = stripMultiJsdoc(input).split("\n");
	for (const line of lines) {
		const tagMatch = line.match(/^@(\w+)(\s+(.+))?/);
		if (tagMatch) {
			// Save previous tag content
			if (currentTag) {
				const content = currentTagContent.join("\n").trim();
				if (currentTag === "param") {
					//					const paramMatch = content.match(/^(\w+)\s+(.+)$/);
					const paramMatch = content.match(/^(\w+)\s+([\s\S]+)$/);
					if (paramMatch) {
						const paramName = paramMatch[1];
						const paramDesc = paramMatch[2];
						if (!docInfo.params) docInfo.params = {};
						docInfo.params[paramName] = paramDesc;
					}
				} else if (currentTag === "desc" || currentTag === "description") {
					docInfo["description"] = content;
				} else {
					if (docInfo[currentTag]) {
						// If tag already exists, convert to array or push to existing array
						if (Array.isArray(docInfo[currentTag])) {
							docInfo[currentTag].push(content);
						} else {
							docInfo[currentTag] = [docInfo[currentTag], content];
						}
					} else {
						docInfo[currentTag] = content != "" ? content : true;
					}
				}
			}
			// Start new tag
			currentTag = tagMatch[1];
			currentTagContent = [];
			if (tagMatch[3]) {
				currentTagContent.push(tagMatch[3]);
			}
		} else {
			// Continuation of current tag content or description
			if (currentTag) {
				currentTagContent.push(line);
			} else {
				// Description before any tags
				if (!docInfo._) {
					docInfo._ = line;
				} else {
					docInfo._ += " " + line;
				}
			}
		}
	}
	// Save last tag content
	if (currentTag) {
		const content = currentTagContent.join("\n").trim();
		if (currentTag === "param") {
			//			const paramMatch = content.match(/^(\w+)\s+(.+)$/);
			const paramMatch = content.match(/^(\w+)\s+([\s\S]+)$/);
			if (paramMatch) {
				const paramName = paramMatch[1];
				const paramDesc = paramMatch[2];
				if (!docInfo.params) docInfo.params = {};
				docInfo.params[paramName] = paramDesc;
			}
		} else if (currentTag === "desc" || currentTag === "description") {
			docInfo["description"] = content;
		} else {
			if (docInfo[currentTag]) {
				// If tag already exists, convert to array or push to existing array
				if (Array.isArray(docInfo[currentTag])) {
					docInfo[currentTag].push(content);
				} else {
					docInfo[currentTag] = [docInfo[currentTag], content];
				}
			} else {
				docInfo[currentTag] = content != "" ? content : true;
			}
		}
	}
	return docInfo;
}

/**
 *
 * @param {String} input
 * @returns {String}
 */
export function removeTrailingCommas(input) {
	const commaIndicesToRemove = []

	for (let i = 0; i < input.length; i++) {
		if (input[i] !== ",") continue

		// find non-whitespace character next..
		let lookahead = i + 1
		while (lookahead < input.length && input.charCodeAt(lookahead) <= 32) {
			lookahead++
		}
		const nextChar = input[lookahead] // If the comma is followed by a closing bracket or brace, mark it for removal
		if (nextChar === "]" || nextChar === "}") {
			commaIndicesToRemove.push(i)
		}
	}

	let cleaned = input // Remove commas from original, adjusting for shifting indices
	for (let i = 0; i < commaIndicesToRemove.length; i++) {
		const index = commaIndicesToRemove[i] - i
		cleaned = cleaned.slice(0, index) + cleaned.slice(index + 1)
	}

	return cleaned
}


/**
 * Parse a pattern into { parent, name } without breaking compound names, from function name.
 * parent will be undefined if it does not include two components in the provided function name.
 *
 * @param {String} gmfnName A GMExtensionFunction externalName
 * @param {Set<String>} parentSet An array of all parent handles
 * @param {Set<String>} childSet An array of all child handles
 * @returns {Object}
 */
export function parseGMFunctionName(gmfnName, parentSet, childSet = undefined) {
	// Drop leading "__" and trailing "_" and convert to hyphen
	const trimmed = gmfnName.replace(/^__/, "").replace(/_$/, "").replaceAll("_","-");

	// Try to match against known parents
	for (const parent of parentSet) {
		const prefix = parent + "-";
		if (trimmed === parent) {
			// Exact parent-only match
			return { parent: undefined, name: parent };
		}
		if (trimmed.startsWith(prefix)) {
			const rest = trimmed.slice(prefix.length);
			// If rest is in childSet, treat as child; otherwise undefined
			if (!childSet || childSet.has(rest)) {
				return { parent, name: rest || undefined };
			}
			return { parent: undefined, name: parent };
		}
	}

	// No known parent matched
	if (trimmed.includes("-")) {
		// Treat whole trimmed token as child if it's in childSet
		if (childSet && childSet.has(trimmed)) {
			return { parent: undefined, name: trimmed };
		}
		// Otherwise: parent-only literal
		return { parent: undefined, name: trimmed };
	}

	// Single token, no underscores
	return { parent: undefined, name: trimmed };
}