export function padNumber(number, digits = 1000) {
	digits = digits.toString().length
	return number.toString().padStart(digits, "0")
}

export function rePascalCase(str) {
	// PascalCase to [Pp]ascal[Cc]ase
	return str.replace(/[A-Z]/g, (char) => `[${char}${char.toLowerCase()}]`)
}

function _normName(name) {
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
