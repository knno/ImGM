import * as converters from "../utils/string.js"
import ImGMError from "./error.js"

/**
 *
 * @export
 * @class Name
 */
export default class Name {
	/**
	 *
	 * @param {String} name
	 * @param {String} toStringCase
	 * @param {String} toStringSep
	 */
	constructor(name, toStringCase = "PascalCase", toStringSep = " ") {
		this._name = name
		this._case = toStringCase
		this._sep = toStringSep
	}

	/**
	 *
	 * @param {String} sep
	 * @return {String}
	 */
	toPascalCase(sep = undefined) {
		sep ??= ""
		return converters.toPascalCase(this._name, sep)
	}

	/**
	 *
	 * @param {String} sep
	 * @return {String}
	 */
	toCamelCase(sep = undefined) {
		sep ??= ""
		return converters.toCamelCase(this._name, sep)
	}

	/**
	 *
	 * @param {String} sep
	 * @return {String}
	 */
	toSnakeCase(sep = undefined) {
		sep ??= "_"
		return converters.toSnakeCase(this._name, sep)
	}

	/**
	 *
	 * @param {String} sep
	 * @return {String}
	 */
	toKebabCase(sep = undefined) {
		sep ??= "-"
		return converters.toKebabCase(this._name, sep)
	}

	/**
	 *
	 * @param {String} sep
	 * @return {String}
	 */
	toCustomSnakeCase(sep = undefined) {
		sep ??= "_"
		return converters.toCustomSnakeCase(this._name, sep)
	}

	/**
	 *
	 * @param {String} sep
	 * @return {String}
	 */
	toScreamingCase(sep = undefined) {
		sep ??= "_"
		return converters.toScreamingCase(this._name, sep)
	}

	/**
	 *
	 * @param {String} sep
	 * @return {Object}
	 */
	getAll(sep = undefined) {
		return {
			pascalCase: this.toPascalCase(sep),
			camelCase: this.toCamelCase(sep),
			snakeCase: this.toSnakeCase(sep),
			kebabCase: this.toKebabCase(sep),
			customSnakeCase: this.toCustomSnakeCase(sep),
			screamingCase: this.toScreamingCase(sep),
		}
	}

	/**
	 *
	 * @param {String} caseName
	 * @param {String} sep
	 * @return {String}
	 */
	get = function (caseName = undefined, sep = undefined) {
		caseName ??= this._case
		const f = `to${caseName}`
		if (typeof this[f] === "function") {
			return this[f](sep)
		}
		throw new ImGMError(`Unknown function: %(f)`, { f })
	}
	to = this.get

	toString() {
		return this.to(this._case, this._sep)
	}

	toExtra(key = "name") {
		return {
			[key]: this,
			[`pascal_case_${key}`]: this.toPascalCase(),
			[`camel_case_${key}`]: this.toCamelCase(),
			[`snake_case_${key}`]: this.toSnakeCase(),
			[`kebab_case_${key}`]: this.toKebabCase(),
			[`custom_snake_case_${key}`]: this.toCustomSnakeCase(),
			[`screaming_case_${key}`]: this.toScreamingCase(),
		}
	}
}
