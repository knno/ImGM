export function isPlainObject(value) {
	return (
		value != null &&
		typeof value === "object" &&
		value.constructor === Object
	)
}

const reserved = ["caller", "callee", "arguments"]

export function getObjectPropertiesKeys(obj) {
	const keys = new Set()
	let current = obj
	while (current) {
		const propertyNames = Object.getOwnPropertyNames(current)
		propertyNames.forEach((name) => {
			keys.add(name)
		})
		current = Object.getPrototypeOf(current)
	}
	return [...keys]
}

export function getObjectProperties(obj) {
	const attrs = {}
	const keys = getObjectPropertiesKeys(obj)
	keys.forEach((key) => {
		if (!reserved.includes(key)) {
			attrs[key] =
				Object.getOwnPropertyDescriptor(obj, key)?.value ?? obj[key]
		}
	})
	return attrs
}

export function getObjectFunctionsKeys(obj) {
	const functions = new Set()
	const properties = getObjectProperties(obj)
	Object.entries(properties).forEach(([name, value]) => {
		if (typeof value === "function" && name !== "constructor") {
			functions.add(name)
		}
	})
	return [...functions]
}

export function getObjectFunctions(obj) {
	const functions = {}
	const properties = getObjectProperties(obj)
	Object.entries(properties).forEach(([name, value]) => {
		if (typeof value === "function" && name !== "constructor") {
			functions[name] = value
		}
	})
	return functions
}

export function assignObjectRecursive(target, source) {
	for (const key in source) {
		if (source.hasOwnProperty(key)) {
			if (Array.isArray(source[key])) {
				target[key] = [...source[key]]
			} else if (
				typeof source[key] === "object" &&
				source[key] !== null
			) {
				if (
					typeof target[key] !== "object" ||
					target[key] === null ||
					Array.isArray(target[key])
				) {
					target[key] = {}
				}
				assignObjectRecursive(target[key], source[key])
			} else {
				target[key] = source[key]
			}
		}
	}
	return target
}

/**
 *
 * @param {Date} date
 * @param {String} format
 * @returns {String}
 */
export function formatDate(date, format) {
	const replacements = {
		YYYY: date.getFullYear(),
		MM: String(date.getMonth() + 1).padStart(2, "0"), // Months are zero-indexed
		DD: String(date.getDate()).padStart(2, "0"),
		HH: String(date.getHours()).padStart(2, "0"),
		mm: String(date.getMinutes()).padStart(2, "0"),
		ss: String(date.getSeconds()).padStart(2, "0"),
	}

	return format.replace(
		/YYYY|MM|DD|HH|mm|ss/g,
		(match) => replacements[match]
	)
}
