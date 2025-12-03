import * as fs from "fs"
import Path from "path"
import { Program } from "../../lib/program.js"
import { Module } from "../modules.js"
import { Jsdoc } from "./jsdoc.js"
import Name from "./name.js"

// reserved <name> would be changed to <_name>
export const baseReservedArgumentNames = [
	"continue",
	"return",
	"argument",
	"arguments",
]

export class BaseFunctionArgument {
	/**
	 *
	 * @abstract
	 * @static
	 * @memberof BaseFunctionArgument
	 */
	static reserved = baseReservedArgumentNames

	/**
	 *
	 * @param {Object} options
	 * @param {*} options.name
	 * @param {*} [options.defaultValue=undefined]
	 * @param {*} [options.type=undefined]
	 * @param {Boolean} [options.isHidden=false]
	 * @param {*} [options.passthrough=undefined]
	 * @param {*} [options.extra=undefined]
	 * @memberof BaseFunctionArgument
	 */
	constructor({
		name,
		defaultValue = undefined,
		type = undefined,
		isHidden = false,
		passthrough = undefined,
		...extra
	} = {}) {
		this.oldName = name instanceof Name ? name._name : name
		this.name = this.constructor.getName(
			new Name(this.oldName, "snake_case", "_")
		)
		if (this.name._name == this.oldName) {
			this.oldName = undefined
		}
		this.type = type
		this.isHidden = isHidden
		this.passthrough = passthrough
		this.defaultValue = defaultValue
		this.description = undefined
		if (extra) {
			for (const k in extra) {
				this[k] = extra[k]
			}
		}
	}

	/**
	 *
	 * @param {Name} name
	 * @return {Name}
	 */
	static getName(name) {
		if (this.reserved.includes(name._name)) {
			name._name = "_" + name._name
		}
		return name
	}
}

export class BaseFunction {
	/**
	 *
	 * @param {Object} options
	 * @param {String|Name} options.name
	 * @param {BaseFunctionArgument[]} options.args
	 * @param {*} options.returnType
	 * @param {BaseToken} options.sourceToken
	 * @param {*} options.source
	 * @param {*} [options.extra]
	 */
	constructor({
		name,
		args = undefined,
		returnType = undefined,
		sourceToken = undefined,
		source = undefined,
		...extra
	} = {}) {
		this.name = name instanceof Name ? name : new Name(name, undefined, "")
		this.args = args
		this.returnType = returnType
		this.sourceToken = sourceToken
		this.source = source
		if (extra) {
			for (const k in extra) {
				switch (k) {
					case "jsdoc":
						extra[k] =
							extra[k] instanceof Jsdoc ?? new Jsdoc(extra[k])
						break
				}
				this[k] = extra[k]
			}
		}
	}

	addArgument(arg) {
		this.args[this.args.length] = arg
	}

	/**
	 * @abstract
	 * @param {*} returnType
	 */
	setReturnType(returnType) {
		this.returnType = returnType
	}

	isNameMatching(name) {
		let thisName = this.name instanceof Name ? this.name.get() : this.name;
		let thisNameOrig = this.name instanceof Name ? this.name._name : this.name;
		let providedName = name instanceof Name ? name.get() : name;
		let providedNameOrig = name instanceof Name ? name._name : name;

		return ((thisName === providedName) || (thisNameOrig === providedNameOrig))
	}

	isNameMatchingAny(name) {
		let thisName = this.name instanceof Name ? this.name.get() : this.name;
		let thisNameOrig = this.name instanceof Name ? this.name._name : this.name;
		let providedName = name instanceof Name ? name.get() : name;
		let providedNameOrig = name instanceof Name ? name._name : name;

		return (
			((thisName === providedName) || (thisNameOrig === providedNameOrig)) ||
			((thisName === providedNameOrig) || (thisNameOrig === providedName))
		)
	}

	toString() {
		const colors = Program.colors
		let nameColor = colors.get("red")
		let typeColorName = "orange"
		let post = colors.get("darkorange", "()")
		let typ =
			this.returnType != undefined
				? `${colors.get("darkgreen", this.returnType)}`
				: ""
		let pos = ""
		if (Program.debug) {
			let argstr =
				this.args && this.args.length > 0
					? this.args.map((arg) => arg.name.get()).join(", ")
					: ""
			post = `${colors.get(
				"darkorange",
				`(${argstr})`.replace(/([\n\r])/gm, (m) =>
					m == "\n" ? "\\n" : "\\r"
				)
			)}`
			let source = this.source
			if (source instanceof Module) {
				source = source.name.get()
			} else if (source instanceof Name) {
				source = source.get()
			} else if (typeof source == "string") {
				if (fs.existsSync(source)) {
					source = Path.basename(source)
				}
			}
			pos = colors.italic(
				colors.get(
					"gray",
					` at ` +
					(source ? `${source}:` : "") +
					`${this.sourceToken.line}${source ? "" : `:${this.sourceToken.col}`}`
				)
			)
		}

		const instStr =
			colors.get(typeColorName, this.constructor.name) +
			" " +
			colors.wrap(nameColor, this.name.get()) +
			post +
			(typ ? ` : ${typ}` : "") +
			pos

		return colors.get("gray", `<`) + instStr + colors.get("gray", `>`)
	}
}
