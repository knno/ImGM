import * as fs from "fs"
import Path from "path"
import Config from "../../config.js"
import { BaseFunction, BaseFunctionArgument } from "../class/base-functions.js"
import ImGMError from "../class/error.js"
import Name from "../class/name.js"
import { getChildModules, Module, nameFromHandle, toHandle } from "../modules.js"
import { CppKeywords, TokenType } from "../parsers/langs/cpp.js"
import { Program } from "../program.js"
import * as str from "../utils/string.js"
import { BaseParser } from "./base.js"

const Logger = Program.Logger

// #region API
export const GMMOD = Config.dll.modifierDirective

export const reservedArgumentNames = [
	"x",
	"y",
	"continue",
	"return",
	"id",
	"repeat",
	"frac",
	"visible",
	"ptr",
	"argument",
	"arguments",
]

export const reservedModifierNames = [
	"PASSTHROUGH",
	"PREPEND",
	"APPEND",
	"OVERRIDE",
	"DEFAULT",
	"RETURNS",
	"RETURN",
	"COLOR_TO",
	"COLOR_FROM",
	"HIDDEN",
	"HINT",
]

export class ApiFunction extends BaseFunction { }
export class ApiEnum {
	constructor({ name, entries, sourceToken, source, ...extra } = {}) {
		this.name = name instanceof Name ? name : new Name(name)
		this.entries = entries
		this.entriesComments = []
		this.sourceToken = sourceToken
		this.source = source
		this.comment = undefined
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

	toString() {
		const colors = Program.colors
		let nameColor = colors.get("red")
		let typeColorName = "orange"
		let pos = ""
		if (Program.debug) {
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
			pos

		return colors.get("gray", `<`) + instStr + colors.get("gray", `>`)
	}
}

export class ApiAnalyzer extends BaseParser {
	constructor(tokens, opts) {
		opts.recursive = true
		super(tokens, opts)

		this.functions = []
		this.enums = []
		this.artifacts = []
	}

	_api_func(first, nav, ns) {
		let token = first

		if (first.type === TokenType.FUNCTION_DEF) {
			token = nav.advance(-1)
		} else if (
			first.type !== TokenType.IDENTIFIER &&
			first.type !== TokenType.FUNCTION_CALL
		) {
			return
		}

		if (
			token.type === TokenType.IDENTIFIER ||
			token.type === TokenType.FUNCTION_CALL
		) {
			const moduleConfig = Config.modules[this.opts.module.handle]
			if (!moduleConfig) return

			const patts = moduleConfig.apiIdentifierPatterns
			const base_extras = {
				...this.opts.module.name.toExtra("name"),
			}

			const testIdent = (ident, extras, patts) => {
				for (const pat of patts) {
					const regex = new RegExp(str.resolveTemplate(pat, extras))
					if (regex.test(ident)) return true
				}
				return false
			}

			let matchApiIdentifier = false
			if (this.opts.childModules.length > 0) {
				for (const childModule of this.opts.childModules) {
					const extras = Object.assign(
						base_extras,
						childModule.name.toExtra("name")
					)
					if (testIdent(token.value, extras, patts)) {
						matchApiIdentifier = true
						break
					}
				}
			} else {
				matchApiIdentifier = testIdent(token.value, base_extras, patts)
			}

			if (!matchApiIdentifier) return

			let type = nav.advance()
			switch (type.type) {
				case TokenType.KEYWORD:
					if (type.value === CppKeywords.CONST) {
						type = nav.advance()
						type.const = true
					} else if (type.value === CppKeywords.STATIC) {
						type = nav.advance()
						type.static = true
					}
				// fallthrough
				case TokenType.IDENTIFIER:
				case TokenType.DEREFERENCE:
				case TokenType.POINTER:
					break
				case TokenType.DIRECTIVE:
				case TokenType.NEWLINE:
					return
				default:
					Logger.warn(
						`Could not understand ${type} for ${token.value}`,
						{
							type: Logger.types.WRAPPER_TOKEN_UNKNOWN,
						}
					)
					return
			}

			const func = nav.advance()
			if (func.type.endsWith("Pair")) {
				return
			}

			// Extract arguments from function pair
			const args = []
			const argNav = func.navigateChildren()
			while (!argNav.isLast()) {
				let argType = argNav.peek()
				argNav.advance()
				if (!argType || argType.type === TokenType.COMMA) continue

				let argName = argNav.peek()
				if (
					argName &&
					[argType.type, argName.type].includes(TokenType.IDENTIFIER)
				) {
					argNav.advance() // consume name
					args.push({
						name: argName.value,
						type: argType.value,
					})
				}
			}

			// Optional comment detection
			let comment
			let i = 1
			let after = nav.peek(3)
			while (
				after &&
				!after.matchesType(TokenType.COMMENT) &&
				![
					TokenType.KEYWORD,
					TokenType.IDENTIFIER,
					TokenType.DEREFERENCE,
					TokenType.POINTER,
				].includes(after.type)
			) {
				after = nav.peek(i)
				i++
			}
			if (after && after.matchesType(TokenType.COMMENT)) {
				comment = after
			}

			after = nav.advance()
			if (after.type === TokenType.SEMI) {
				this.artifacts.push({ token: type })
			} else if (after.type === TokenType.IDENTIFIER) {
				this.logToken([token, type, after])
			}

			const _func = new ApiFunction({
				name: func.value,
				args,
				returnType: type.value,
				sourceToken: func,
				source: this.opts.source ?? func.source,
				namespace: ns,
				comment: comment ? comment.value : "",
			})

			this.functions.push(_func)
			return // _func
		}
	}

	p_ns_api_funcs(token, nav, ns) {
		nav ??= this
		if (token.type == TokenType.KEYWORD && token.value == "namespace") {
			let fns = []
			const next = nav.peek(1)
			if (next && next.type == TokenType.IDENTIFIER) {
				nav.advance()
				let i = 1;
				let after = nav.peek(i);
				while (
					after &&
					[
						TokenType.NEWLINE,
					].includes(after.type)
				) {
					after = nav.peek(i)
					i++
				}
				if (after.children.length > 0) {
					nav.advance()
					const children = after.navigateChildren()
					if (ns && next.value && ns != next.value) {
						ns = ns ? `${ns}.${next.value}` : next.value
					}
					let _res;
					while (!children.isLast()) {
						const child = children.peek()
						_res = undefined
						if (child.type == TokenType.IDENTIFIER) {
							_res = this._api_func(child, children, ns)
							if (_res) {
								fns.push(_res)
							}
							children.advance();
							continue
						}
						if (_res) {
							if (Array.isArray(_res)) {
								fns.push(..._res)
							} else {
								fns.push(_res)
							}
						} else {
							children.advance()
						}
					}
					this.functions.push(...fns)
					return fns
				}
			} else if (next && next.type == TokenType.KEYWORD) {
				const prev = nav.peek(-1)
				if (prev) {
					let fn = this._api_func(prev, nav, ns)
					if (fn) {
						this.functions.push(fn)
						return fn
					}
				}
			}
		}
	}

	p_api_enum(token, nav, ns) {
		nav ??= this
		if (token.type == TokenType.KEYWORD && token.value == "enum") {
			const next = nav.peek(1)
			if (next && next.type == TokenType.IDENTIFIER) {
				nav.advance()
				let name = next.value
				if (
					this.opts.module.config == undefined ||
					(this.opts.module.config &&
						!this.opts.module.config.apiIgnore?.enums?.includes(
							name
						))
				) {
					let eCmts = []
					let cmt =
						this.opts.addNewline == true
							? nav.peek(-2)
							: nav.peek(-3)
					let comment = undefined
					if (
						cmt.type == TokenType.COMMENT ||
						cmt.type == TokenType.COMMENT_MULTILINE
					) {
						if (
							!(
								cmt.value.startsWith("// [SECTION]") ||
								cmt.value.startsWith("//---")
							)
						) {
							comment = cmt.value
							let _f = 0
							for (
								let i = -4;
								nav.peek(i).type == TokenType.COMMENT ||
								nav.peek(i).type ==
								TokenType.COMMENT_MULTILINE ||
								nav.peek(i).type == TokenType.NEWLINE;
								i--
							) {
								if (nav.peek(i).type == TokenType.NEWLINE) {
									if (_f >= 2) {
										break
									}
									_f++
									continue
								}
								_f--
								if (
									nav
										.peek(i)
										.value.startsWith("// [SECTION]") ||
									nav.peek(i).value.startsWith("//---")
								) {
									continue
								}
								comment = nav.peek(i).value + "\n" + comment
							}
						}
					}
					if (comment) {
						comment = str.stripSingleJsdoc(comment);
						comment = comment.replace(/^@(?:desc|description)\s+(.+)$/im, `$1`).trim(); // Remove description tag if found
					}
					const def = {}
					let inner
					for (let i = nav.index; i < nav.tokens.length; i++) {
						const find = nav.peek(i)
						if (find.value == ":") {
							let testAfter = nav.peek(i + 1);
							if (testAfter.type == TokenType.KEYWORD || testAfter.type == TokenType.IDENTIFIER) {
								if (nav.peek(i + 2).type == TokenType.SEMI) {
									nav.advance(2);
									return undefined;
								}
							}
						}
						if (find.type != TokenType.BRACE_PAIR) continue;
						if (!find.children || find.children.length == 0) {
							throw new ImGMError(`Empty enum %(token)s`, {
								token: next,
							})
						}
						inner = find
						break
					}
					if (!inner) {
						throw new ImGMError(`Empty enum %(token)s`, {
							token: next,
						})
					}
					let enumName = name
					if (!name.toLowerCase().startsWith("im")) {
						const mN = this.opts.module.name.get()
						if (!name.toLowerCase().startsWith(mN.toLowerCase())) {
							enumName = `${mN}${name}`
						}
					}
					const children = inner.navigateChildren()
					while (!children.isLast()) {
						const child = children.peek()
						const prev = children.peek(-1)
						let prevName

						switch (child.type) {
							case TokenType.ASSIGN: {
								if (prev.type != TokenType.IDENTIFIER) {
									throw new ImGMError(
										`Could not recognize enum member "${prev.value}" of enum: %(token)s`,
										{ token: prev }
									)
								}
								let found = false
								let i = 0
								for (
									i = children.index;
									i < children.tokens.length;
									i++
								) {
									const find = children.tokens[i]
									if (!find) break
									if (find.type != TokenType.COMMA) {
										continue
									}
									const inner = children.tokens
										.slice(children.index, i)
										.filter(
											(t) =>
												(t.matchesType(
													TokenType.COMMENT
												) ||
													t.type == TokenType.HASH) ==
												false
										)
									found = true
									prevName = prev.value.replace(
										enumName,
										name
									)
									def[prevName.replace(name + "_", "").replace(name, "")] = inner.filter(t => !([TokenType.ASSIGN, TokenType.NEWLINE].includes(t.type))).map(t => t.value).join(" ");
									children.index = i + 1
									break
								}

								if (!found) {
									const inner = children.tokens
										.slice(
											children.index,
											children.tokens.length
										)
										.filter(
											(t) =>
												(t.matchesType(
													TokenType.COMMENT
												) ||
													t.type == TokenType.HASH) ==
												false
										)
									prevName = prev.value.replace(
										enumName,
										name
									)
									def[prevName.replace(name + "_", "").replace(name, "")] = inner.filter(t => !([TokenType.ASSIGN, TokenType.NEWLINE].includes(t.type))).map(t => t.value).join(" ");
									children.index = children.tokens.length
									Logger.warn(
										`Reached end of enum member "${prevName}" without trailing comma`,
										{
											type: Logger.types
												.WRAPPER_ENUM_COMMA,
										}
									)
								}
								break
							}
							case TokenType.COMMA: {
								prevName = prev.value.replace(enumName, name)
								def[prevName.replace(name + "_", "").replace(name, "")] = null;
								break
							}
						}
						children.advance()
					}
					for (const k in def) {
						let v = def[k]
						if (typeof v !== "string" || v === null) continue
						def[k] = v
							.replaceAll(name, name.slice(0, -1) + ".")
							.trim()
					}
					let __enum = new ApiEnum({
						name,
						entries: def,
						sourceToken: next,
						source: this.opts.source,
						namespace: ns,
						entriesComments: eCmts,
						comment: comment,
					})
					this.enums.push(__enum)
					return __enum
				}
			}
		}
	}

	steps() {
		return [this.p_ns_api_funcs, this.p_api_enum]
	}
}

export async function getApi(tokens, module, source) {
	const childModules = await getChildModules(module)
	const api = new ApiAnalyzer(tokens, {
		module,
		childModules: childModules,
		source,
	})
	api.main()
	return api
}

// #endregion

// #region Wrappers

export class WrapperArgument extends BaseFunctionArgument {
	static reserved = reservedArgumentNames
}

/**
 * @function WrapperFunction
 * @extends BaseFunction
 * @description Represents a GML wrapper.
 *
 */
export class WrapperFunction extends BaseFunction {
	constructor({ targetFunc = undefined, ...options } = {}) {
		super(options)
		/**
		 * @type {Array<WrapperArgument>}
		 */
		this.args = options.args ?? []
		/**
		 * @type {String}
		 */
		this.targetFunc = targetFunc
		this.isHidden = false
		this.isPrivate = false
		this.isUnsupported = false
		/**
		 * @type {String|Undefined}
		 */
		this.oldName = undefined
		this.argIndex = -1
		this.isForceInline = false
		this._start = ""
		this._end = ""
	}

	setName(name) {
		if (this.oldName != undefined) return
		this.oldName = name
		this.name = name
	}

	addArg(name, ind, origin) {
		this.args[ind] = new WrapperArgument({
			name: name,
			type: origin ? WrapperFunction.typefunc(origin) : "Any",
			defaultValue: undefined,
			isHidden: false,
			passthrough: undefined,
		})
		if (this.args[ind].oldName != undefined) {
			Logger.warn(
				Program.colors.get("gray", `Changing arg${ind + 1} name of ${Program.colors.get("white", this.name, "gray")}: \"${this.args[ind].oldName}\" -> \"${this.args[ind].name._name}\"`),
				{
					type: Logger.types.WRAPPER_ARG_CHANGED,
				}
			)
		}
		this.argIndex = ind
	}

	_resolveModVal(val) {
		let def = val.replace(/^\((.*)\)$/g, `$1`)
		// Replace placeholders such as #arg0 or #arg11 with the corresponding argument Name.
		// Replace longer indices first to avoid partial matches (#arg1 matching inside #arg11).
		const indices = this.args.map((_, i) => i).sort((a, b) => b - a)
		for (const i of indices) {
			const a = this.args[i]
			if (!a) continue
			def = def.replaceAll(`#arg${i}`, a.name._name)
		}

		return def;
	}

	modifier(token, bodyNavigator) {
		switch (token.value) {
			case `${GMMOD}PREPEND`: {
				const next = bodyNavigator.peek(1)
				const tokVal = next.children[0]
				this._start += this._resolveModVal(tokVal.getFlatString());
				return true
			}
			case `${GMMOD}APPEND`: {
				const next = bodyNavigator.peek(1)
				const tokVal = next.children[0]
				this._end += this._resolveModVal(tokVal.getFlatString());
				return true
			}
			case `${GMMOD}OVERRIDE`: {
				const next = bodyNavigator.peek(1)
				const name = next.children[0]
				if (!name)
					throw `Could not handle ${token.value} modifier, expected "name" argument as ${TokenType.IDENTIFIER} or String at line ${token.line}`
				if (
					name?.type == TokenType.IDENTIFIER ||
					name?.type == TokenType.STRING_DQ ||
					name?.type == TokenType.STRING_SQ
				) {
					if (name.value != "_") {
						this.setName(name.value)
					} else {
						this.isHidden = true;
					}
					return true
				}
			}

			case `${GMMOD}DEFAULT`: {
				if (this.argIndex === -1)
					throw `Could not handle ${token.value} modifier, target argument is unset at line ${token.line}`
				const arg = this.args[this.argIndex]
				const next = bodyNavigator.peek(1)
				arg.defaultValue = this._resolveModVal(next.getFlatString())
				return true
			}
			case `${GMMOD}PASSTHROUGH`: {
				if (this.argIndex === -1)
					throw `Could not handle ${token.value} modifier, target argument is unset at line ${token.line}`
				const arg = this.args[this.argIndex]
				const next = bodyNavigator.peek(1)
				arg.passthrough = this._resolveModVal(next.getFlatString())
				return true
			}
			case `${GMMOD}HIDDEN`: {
				if (this.argIndex === -1)
					throw `Could not handle ${token.value} modifier, target argument is unset at line ${token.line}`
				const arg = this.args[this.argIndex]
				arg.isHidden = true
				return true
			}

			case `${GMMOD}RETURN`: {
				let index = this.argIndex

				const inner = token.children
				if (inner) {
					const ind = inner[0]
					if (ind) {
						switch (ind.type) {
							case "Number": {
								index = ind.value
								if (index > this.argIndex) {
									throw `Could not handle ${token.value} modifier, target argument index ${index} is out of range (${this.argIndex}) at line ${token.line}`
								}
								break
							}

							default: {
								this.returnType = token.getFlatString()
								Logger.warn(
									Program.colors.get("gray", "Overwriting return type for ") +
									Program.colors.get("white", this.name) +
									Program.colors.get("gray", ": ") +
									this.returnType,
									{
										type: Logger.types
											.WRAPPER_CONTEXT_CHANGED,
									}
								)
								return true
							}
						}
					}
				}
				if (index === -1)
					throw `Could not handle ${token.value} modifier, target argument is unset at line ${token.line}`

				this.setToReturnArg(index)
				return true
			}

			case `${GMMOD}RETURNS`: {
				const next = bodyNavigator.peek(1)
				this.returnType = this._resolveModVal(next.getFlatString())
				Logger.warn(
					Program.colors.get("gray", "Overwriting return type for ") +
					Program.colors.get("white", this.name) +
					Program.colors.get("gray", ": ") +
					this.returnType,
					{
						type: Logger.types.WRAPPER_CONTEXT_CHANGED,
					}
				)
				return true
			}

			case `${GMMOD}HINT`: {
				if (this.argIndex === -1)
					throw `Could not handle ${token.value} modifier, target argument is unset at line ${token.line}`

				const arg = this.args[this.argIndex]
				const next = bodyNavigator.peek(1)
				arg.type = this._resolveModVal(next.getFlatString())
				return true
			}

			case `${GMMOD}DESCRIPTION`:
			case `${GMMOD}DESC`: {
				if (this.argIndex === -1)
					throw `Could not handle ${token.value} modifier, target argument is unset at line ${token.line}`

				const arg = this.args[this.argIndex]
				const next = bodyNavigator.peek(1)
				arg.description = this._resolveModVal(next.getFlatString())
				return true
			}

			// Ignore
			case `${GMMOD}COLOR_TO`:
			case `${GMMOD}COLOR_FROM`:
				return true
		}
		Logger.warn(
			`Could not handle unknown modifier "${token.value}" for wrapper "${this.name}" at line ${token.line}`,
			{
				type: Logger.types.WRAPPER_MODIFIER_UNKNOWN,
			}
		)
		return false
	}

	setReturns(kind) {
		this.returnType = WrapperFunction.typename(kind)
	}

	setToReturnArg(ind) {
		this.returnType = this.args[ind].type
	}

	static typename(kind) {
		switch (kind) {
			case "VALUE_INT32":
			case "VALUE_INT64":
			case "VALUE_REAL":
				return "Real"
			case "VALUE_STRING":
				return "String"
			case "VALUE_ARRAY":
				return "Array"
			case "VALUE_OBJECT":
				return "Asset.GMObject"
			case "VALUE_UNDEFINED":
				return "Undefined"
			case "VALUE_PTR":
				return "Pointer"
			case "VALUE_BOOL":
				return "Bool"
		}
		return `Unknown<${kind}>`
	}

	static typefunc(func) {
		let ret = ""
		let base = func.slice("YYGet".length)
		const template = base.indexOf("|template=")
		if (template > -1) {
			const arr = base.slice(template + "|template=".length)
			switch (arr) {
				case "double":
				case "float":
				case "int": {
					ret = "<Real>"
					break
				}

				default: {
					ret = "<Unknown>"
					break
				}
			}
			base = base.slice(0, template)
		}

		switch (base) {
			case "String":
			case "Array":
			case "Real":
			case "Bool":
				return base + ret
			case "PtrOrInt":
			case "Ptr":
				return ret + "Pointer"
			case "Int32":
			case "Uint32":
			case "Int64":
			case "Float":
				return ret + "Real"
			case "Struct":
				return ret + "Struct"
		}
		return ret
	}

	toGMExtensionFunction() {
		return {
			$GMExtensionFunction: "",
			"%Name": this.targetFunc,
			argCount: 0,
			args: [],
			documentation: "",
			externalName: this.targetFunc,
			help: "",
			hidden: true,
			kind: 1,
			name: this.targetFunc,
			resourceType: "GMExtensionFunction",
			resourceVersion: "2.0",
			returnType: 1,
		}
	}

	toJsdoc(enums, context, spacing = 1, extras = []) {
		const jsdocConfig = Config.jsdoc
		const indent = Config.style.spacing.repeat(spacing)
		const fnName = this.name
		const visibleArgs = this.args.filter((arg) => !arg.isHidden)
		let lines = []

		// Description block
		if (jsdocConfig.docletCommentType === "multi") {
			lines.push(indent + "/**")
			// Function tag
			let fnLine = `${indent} * ${jsdocConfig.functionTag} ${fnName}`
			if (jsdocConfig.functionWriteArgs && visibleArgs.length > 0) {
				const argList = visibleArgs.map((arg) => arg.name._name).join(", ")
				fnLine += `(${argList})`
			}
			lines.push(fnLine)

			// Context
			lines.push(`${indent} * ${jsdocConfig.contextTag} ${context}`)

			if (jsdocConfig.setDescriptions && this.comment) {
				lines.push(
					`${indent} * ${jsdocConfig.descriptionTag} ` +
					this.comment
						.split("\n")
						.map((line, l) => {
							if (line.trim().length === 0) {
								return `${indent} *`;
							}
							return (l == 0 ? `` : `${indent} * `) + `${line}`;
						})
						.join("\n")
				);
			}

			// Argument tags
			for (const arg of visibleArgs) {
				let type = arg.type
				let description = arg.description;
				if (type === "Real" && arg.defaultValue) {
					if (arg.defaultValue.startsWith("ImGuiReturnMask")) {
						type = "Enum.ImGuiReturnMask"
					} else {
						for (const item of enums) {
							const name = item.name._name.endsWith("_")
								? item.name._name.slice(0, -1)
								: item.name._name
							if (arg.defaultValue.startsWith(name)) {
								type = `Enum.${name}`
								break
							}
						}
					}
				}

				let argLine = `${indent} * ${jsdocConfig.paramTag} {${type}}`
				if (arg.defaultValue !== undefined) {
					argLine += ` [${arg.name._name}=${WrapperFunction._fixArgDefaultValue(arg.defaultValue)}]`
				} else {
					argLine += ` ${arg.name._name}`
				}
				if (description) {
					if (description.includes("\n")) {
						let descriptionLines = description.trim().split("\n");
						argLine += ` ${descriptionLines[0]}`;
						descriptionLines.shift();
						lines.push(argLine);
						lines.push(...descriptionLines.map(line => `${indent} * ${line}`))
						lines.push(`${indent} *`);
					} else {
						argLine += ` ${description}`;
						lines.push(argLine)
					}
				} else {
					lines.push(argLine)
				}
			}

			// Return tag
			lines.push(`${indent} * ${jsdocConfig.returnTag} {${this.returnType}}`)
			lines.push(indent + " */")
		} else {
			// Single-line comment style
			let fnLine = `${indent}/// ${jsdocConfig.functionTag} ${fnName}`
			if (jsdocConfig.functionWriteArgs && visibleArgs.length > 0) {
				const argList = visibleArgs.map((arg) => arg.name._name).join(", ")
				fnLine += `(${argList})`
			}
			lines.push(fnLine)

			lines.push(`${indent}/// ${jsdocConfig.contextTag} ${context}`)

			if (jsdocConfig.setDescriptions && this.comment) {
				lines.push(
					this.comment
						.split("\n")
						.map((line, l) => {
							const trimmed = line.trim();
							if (trimmed.length === 0) {
								return `${indent}///`;
							}
							return `${indent}/// ${(l == 0 ? `${jsdocConfig.descriptionTag} ` : ``)}${line}`;
						})
						.join("\n")
				);

			}

			for (const arg of visibleArgs) {
				let type = arg.type
				let description = arg.description;
				if (type === "Real" && arg.defaultValue) {
					if (arg.defaultValue.startsWith("ImGuiReturnMask")) {
						type = "Enum.ImGuiReturnMask"
					} else {
						for (const item of enums) {
							const name = item.name._name.endsWith("_")
								? item.name._name.slice(0, -1)
								: item.name._name
							if (arg.defaultValue.startsWith(name)) {
								type = `Enum.${name}`
								break
							}
						}
					}
				}
				let argLine = `${indent}/// ${jsdocConfig.paramTag} {${type}}`
				if (arg.defaultValue !== undefined) {
					argLine += ` [${arg.name._name}=${WrapperFunction._fixArgDefaultValue(arg.defaultValue)}]`
				} else {
					argLine += ` ${arg.name._name}`
				}
				if (description) {
					if (description.includes("\n")) {
						let descriptionLines = description.trim().split("\n");
						argLine += ` ${descriptionLines[0]}`;
						descriptionLines.shift();
						lines.push(argLine);
						lines.push(...descriptionLines.map(line => `${indent}/// ${line}`))
						lines.push(`${indent}///`);
					} else {
						argLine += ` ${description}`;
						lines.push(argLine)
					}
				} else {
					lines.push(argLine)
				}
			}

			lines.push(`${indent}/// ${jsdocConfig.returnTag} {${this.Return}}`)
		}

		return lines.join("\n")
	}

	toGML(spacing = 1) {
		let str =
			Config.style.spacing.repeat(spacing) +
			`static ${this.name} = function(` +
			this.args
				.filter((e) => !e.isHidden)
				.map((e) => {
					if (e.defaultValue === undefined) return e.name._name

					switch (e.type) {
						case "String": {
							if (e.defaultValue == undefined) {
								return `${e.name._name}=${e.defaultValue}`
							} else {
								return `${e.name._name}="${e.defaultValue}"`
							}
						}
					}
					return `${e.name._name}=${e.defaultValue}`
				})
				.join(", ") +
			") {\n"
		if (this.isForceInline)
			str +=
				Config.style.spacing.repeat(spacing + 1) +
				`gml_pragma("forceinline");\n`
		if (this._start.length > 0)
			str += Config.style.spacing.repeat(spacing + 1) + this._start + "\n"

		const has_end = this._end.length > 0
		str +=
			Config.style.spacing.repeat(spacing + 1) +
			(has_end ? "var ___ret = " : "return") +
			" "
		str += `${this.targetFunc}(`
		str +=
			this.args
				.map((e) => {
					if (e.passthrough) {
						return e.passthrough
					}
					return e.name._name
				})
				.join(", ") + ");\n"
		if (has_end)
			str +=
				Config.style.spacing.repeat(spacing + 1) +
				this._end +
				"\n" +
				Config.style.spacing.repeat(spacing + 1) +
				"return ___ret;\n"
		str += Config.style.spacing.repeat(spacing) + "}\n"
		return str
	}

	finalize() {
		if (typeof this.name == "string") {
			this.name = new Name(this.name, "PascalCase", "");
		}

		if (!this.targetFunc) {
			const calls = this.name.slice("__imgui_".length).split("_")
			this.targetFunc = calls
				.map((e) => e[0].toUpperCase() + e.slice(1))
				.join("")
			Logger.warn(
				`Calling function is unset for wrapper "${this.name}", infering call as "${this.targetFunc}" from name`, {
				type: Logger.types.WRAPPER_TARGET_CHANGED
			}
			)
		}

		if (this._start.length > 0) {
			let start = this._start
			this.args.forEach((e, ind) => {
				start = start.replaceAll("#arg" + ind, e.Name)
			})
			this._start = start
		}

		if (this._end.length > 0) {
			let end = this._end
			this.args.forEach((e, ind) => {
				end = end.replaceAll("#arg" + ind, e.Name)
			})
			this._end = end
		}

		for (let i = 0; i < this.args.length; i++) {
			const arg = this.args[i]
			if (!arg) {
				throw `Could not read undefined argument at index ${i} in wrapper name "${this.name}" at line ${this.sourceToken.line}`
			}

			if (WrapperArgument.reserved.includes(arg.name._name)) {
				Logger.warn(
					`Reserved keyword "${arg.name._name}" found in arguments for wrapper "${this.name}", renaming to "_${arg.name._name}"`, {
					type: Logger.types.WRAPPER_ARG_CHANGED
				}
				)
				arg.name._name = "_" + arg.name._name
			}

			if (arg.passthrough !== undefined) {
				let passthrough = arg.passthrough
				this.args.forEach((e, ind) => {
					passthrough = passthrough.replaceAll("#arg" + ind, e.Name)
				})
				arg.passthrough = passthrough
			}

			if (arg.defaultValue !== undefined) {
				let def = arg.defaultValue
				this.args.forEach((e, ind) => {
					def = def.replaceAll("#arg" + ind, e.Name)
				})
				arg.defaultValue = def
			}
		}

		let _targetFuncNamespace = this.namespace;
		let wrapperDescription = undefined;

		// Based on jsdocInfo, update wrapper argument attrs (type and description). etc.
		let jsdocInfoFunc = this._targetFuncComment ? str.parseJsDoc(this._targetFuncComment) : undefined;
		let jsdocInfoWrap = this._wrapperComment ? str.parseJsDoc(this._wrapperComment) : undefined;

		let jsdocInfo = Object.assign(jsdocInfoFunc ?? {}, jsdocInfoWrap ?? {});

		if (jsdocInfo) {
			if (jsdocInfo.private) {
				this.isPrivate = true;
			}
			wrapperDescription = jsdocInfo.description || "";
			if (jsdocInfo._) {
				wrapperDescription = str.stripSingleJsdoc(jsdocInfo._) + (wrapperDescription ? `\n\n${wrapperDescription}` : ``);
			}

			if (typeof jsdocInfo.params != "undefined" && Object.keys(jsdocInfo.params).length > 0) {
				for (const arg of this.args) {
					// Find the argument based on name._name or oldName
					let argJsdocKey = Object.keys(jsdocInfo.params).filter(item => item === arg.name._name || item === arg.oldName);
					if (argJsdocKey == -1) continue;
					let argJsdoc = jsdocInfo.params[argJsdocKey[0]];
					if (argJsdoc) {
						if (typeof argJsdoc === "string") {
							// If it is a string, convert it to { type, desc }
							let typeMatch = argJsdoc.match(/^\{(.+)\}\s*(.+)?$/);
							if (typeMatch) {
								argJsdoc = {
									type: typeMatch[1],
									description: typeMatch[2] || "",
								};
							} else {
								argJsdoc = {
									type: undefined,
									description: argJsdoc,
								};
							}
						}
						if (argJsdoc.type) {
							let _type = WrapperFunction.typefunc(argJsdoc.type);
							if (_type != "") {
								arg.type = _type;
							}
						}
						if (argJsdoc.description) {
							arg.description = argJsdoc.description;
						}
					}
				}
			}
		}
		let comment = undefined;
		if (_targetFuncNamespace == undefined) {
			// This is a custom wrapper.
			comment = `ImGM custom wrapper.` + (wrapperDescription ? `\n\n${wrapperDescription}` : ``);
		} else {
			if (this._isCustom) {
				comment = `ImGM custom wrapper for \`${_targetFuncNamespace}\`.`
			} else {
				comment = `ImGM wrapper for \`${_targetFuncNamespace}\`.`
			}
			comment += (wrapperDescription ? `\n${wrapperDescription}` : ``) + "\n";
		}
		this.comment = comment;

		return this;
	}

	static _fixArgDefaultValue(val) {
		return val.replaceAll("(", "⌊").replaceAll(")", "⌉")
	}
}

export class WrapperAnalyzer extends BaseParser {
	constructor(tokens, opts = {}) {
		opts.recursive = true
		super(tokens, opts)
		this.wrappers = []
		this._allFuncs = this.opts.apis.map(a => a.functions).flat();
	}

	_wrapper_func(token, nav, ns) {
		token.source ??= this.opts.source
		if (
			!token ||
			(token.type !== TokenType.IDENTIFIER &&
				token.type !== TokenType.FUNCTION_CALL)
		)
			return

		if (token.value !== "GMFUNC" && token.value !== `${GMMOD}FUNC`) return

		let cmt =
			this.opts.addNewline == true
				? nav.peek(-1)
				: nav.peek(-2)
		let comment = undefined
		if (
			cmt.type == TokenType.COMMENT ||
			cmt.type == TokenType.COMMENT_MULTILINE
		) {
			comment = cmt.value
			let _f = 0
			for (
				let i = (this.opts.addNewline ? -2 : -3);
				nav.peek(i).type == TokenType.COMMENT ||
				nav.peek(i).type ==
				TokenType.COMMENT_MULTILINE ||
				nav.peek(i).type == TokenType.NEWLINE;
				i--
			) {
				if (nav.peek(i).type == TokenType.NEWLINE) {
					if (_f >= 2) {
						break
					}
					_f++
					continue
				}
				if (_f > 0) { _f--; }
				comment = nav.peek(i).value + "\n" + comment
			}
		}

		const next = nav.advance()
		if (!next || next.type !== TokenType.PAREN_PAIR || !next.children[0])
			return

		const funcNameToken = next.children[0]
		const funcName = funcNameToken.value
		const contentToken = nav.advance()

		if (!contentToken || !contentToken.children) return

		// Remove prefix e.g. "__imgui_add_font" to become "add_font", then create a name from it.
		// Prefix is: "__imgui_", "__imext_", or e.g. "__node_editor_" etc.
		let wrapperName = new Name(funcName.slice(8/*"__imgui_".length*/), "PascalCase", "");
		let wrapname = wrapperName.toSnakeCase();

		var wr = new WrapperFunction({
			name: wrapname,
			source: this.opts.source ?? next.source,
			sourceToken: funcNameToken,
			targetFunc: funcName,
			returnType: funcNameToken.returnType,
		})

		const bodyNav = contentToken.navigateChildren()

		while (!bodyNav.isLast()) {
			const token = bodyNav.advance()
			if (!token) break
			const left = bodyNav.peek(-1)

			switch (token.type) {
				case TokenType.ASSIGN: {
					const offset =
						bodyNav.peek()?.type === TokenType.CAST ? 1 : 0
					let right = bodyNav.peek(offset + 1)
					if (!right || left.type !== TokenType.IDENTIFIER) break

					let isCast = false
					let rightArgs
					if (
						right.type == TokenType.CAST ||
						(right.type == TokenType.KEYWORD &&
							right.value == "static_cast")
					) {
						if (right.value == "static_cast") {
							if (bodyNav.peek(offset + 2).type == TokenType.LT) {
								bodyNav.advance(3)
								right = bodyNav.peek(offset + 2).children
								if (right.children?.length == 0) {
									rightArgs = bodyNav.peek(offset + 3)
								}
							}
						}
						isCast = true
					}
					if (isCast) {
						bodyNav.advance(1)
						right = bodyNav.peek(offset + 1)
						if (right.children.length == 0) {
							rightArgs = bodyNav.peek(offset + 2)
						}
					}


					// Handle (type)YYGet<type>(arg, index)
					if (right.type === TokenType.PAREN_PAIR && right.children.length > 0 &&
						right.children[0].type === TokenType.KEYWORD
					) {
						let right2 = bodyNav.peek(offset + 2);
						if (right2.value.startsWith("YYGet")) {
							right = right2;
							bodyNav.advance()
						}
					}
					// Handle YYGet<type>(arg, index)
					if (
						(right.type === TokenType.FUNCTION_CALL ||
							right.type === TokenType.IDENTIFIER) &&
						right.value.startsWith("YYGet")
					) {
						rightArgs = bodyNav.peek(offset + 2);
						if (rightArgs?.type == TokenType.LT) {
							rightArgs = bodyNav.peek(offset + 5);
						}
						const inner = rightArgs.children.filter(
							(e) => e.type !== TokenType.COMMA
						)
						if (inner.length < 2)
							throw `Expected at least 2 arguments for ${right.value} at line ${right.line}`

						const [ident, ind] = inner
						if (
							ident.type !== TokenType.IDENTIFIER ||
							ident.value !== "arg"
						)
							throw `Expected "arg" as first argument for ${right.value} at line ${right.line}`
						if (ind.type !== TokenType.NUMBER)
							throw `Expected Number as second argument for ${right.value} at line ${right.line}`

						wr.addArg(left.value, parseInt(ind.value), right.value)
						bodyNav.advance()
						break
					}

					// Handle &arg[index]
					if (
						(right.type === TokenType.ADDRESS_OF ||
							right.type === TokenType.IDENTIFIER) &&
						right.value === "arg"
					) {
						let more = bodyNav.peek(offset + 1)
						if (right.type === TokenType.ADDRESS_OF) {
							more = bodyNav.peek(offset + 3);
						}
						if (more?.type === TokenType.BRACKET_PAIR) {
							const inner = more.children[0]
							if (inner.type !== TokenType.NUMBER)
								throw `Expected Number as index for argument array at line ${right.line}`

							if (left.value === "Result")
								wr.setToReturnArg(inner.value)
							else {
								wr.addArg(left.value, inner.value)
							}
							bodyNav.advance()
						}
						break
					}

					// Handle static_cast<type>(YYGet<type>(arg, index))
					if (
						right.type == TokenType.PAREN_PAIR &&
						right.children.length > 0 &&
						(right.children[0].type === TokenType.FUNCTION_CALL ||
							right.children[0].type === TokenType.IDENTIFIER) &&
						right.children[0].value.startsWith("YYGet")
					) {
						let subRight = right.children[0];
						if (
							(subRight.type === TokenType.FUNCTION_CALL ||
								subRight.type === TokenType.IDENTIFIER) &&
							subRight.value.startsWith("YYGet")
						) {
							let subRightArgs = right.children[1];
							const inner = subRightArgs.children.filter(
								(e) => e.type !== TokenType.COMMA
							)
							if (inner.length < 2)
								throw `Expected at least 2 arguments for ${subRight.value} at line ${subRight.line}`

							const [ident, ind] = inner
							if (
								ident.type !== TokenType.IDENTIFIER ||
								ident.value !== "arg"
							)
								throw `Expected "arg" as first argument for ${subRight.value} at line ${subRight.line}`
							if (ind.type !== TokenType.NUMBER)
								throw `Expected Number as second argument for ${subRight.value} at line ${subRight.line}`

							wr.addArg(left.value, parseInt(ind.value), subRight.value)
							bodyNav.advance()
							break
						}
					}

					// Handle Result.kind = VALUE_BOOL
					if (
						left.value === "kind" &&
						bodyNav.match(
							[
								[TokenType.IDENTIFIER, "Result"],
								TokenType.PERIOD,
								[TokenType.IDENTIFIER, "kind"],
							],
							-3
						)
					) {
						const more = bodyNav.peek(offset + 1)
						wr.setReturns(more.value)
						bodyNav.advance()
						break
					}
					break
				}

				case TokenType.SCOPE: {
					if (
						left.type === TokenType.IDENTIFIER &&
						left.value === "ImGui"
					) {
						const right = bodyNav.peek(1)
						const after = bodyNav.peek(2)
						if (
							right?.type !== TokenType.FUNCTION_CALL &&
							right?.type !== TokenType.IDENTIFIER &&
							after?.type !== TokenType.PAREN_PAIR
						) {
							throw `Expected FunctionCall after scope resolution at line ${token.line} in file ${next.source}`
						}
						if (!wr.targetFunc) {
							wr.targetFunc = right.value
						}
						bodyNav.advance(2)
					}
					break
				}

				case TokenType.FUNCTION_CALL:
				case TokenType.IDENTIFIER: {
					if (
						token.value.startsWith(`${GMMOD}`) ||
						token.value.startsWith("GM")
					) {
						try {
							wr.modifier(token, bodyNav)
						} catch (e) {
							Logger.error(e + " in file " + next.source)
						}
					}
					break
				}
			}
		}

		let _targetFunc = this._allFuncs.filter(f => {
			const fname = (f.name instanceof Name ? f.name.get() : f.name);
			const wname = (wrapperName instanceof Name ? wrapperName.get() : wrapperName);
			if (fname == wname) { return f };
		})[0];

		// Custom wrapper, placeholder apifunction
		if (_targetFunc == undefined) {
			wr._isCustom = true;
			var defaultNs = this.opts.moduleName ?? ns ?? this.opts.source;
			if (defaultNs == undefined) {
				var s = this.opts.apis.filter(a => a.file == wr.source)[0]
				if (s) {
					defaultNs = s.moduleName;
				}
			}
			wr.namespace = defaultNs;
			wr._targetFuncComment = "";
		} else { // native wrapper, pre-detected apifunction
			wr._isCustom = false;
			wr.namespace = _targetFunc?.namespace;
			wr._targetFuncComment = _targetFunc?.comment;
		}
		wr._wrapperComment = comment;
		wr = wr.finalize();
		if (this.wrappers.findIndex(w => (w.name instanceof Name ? w.name.get() : w.name) == (wr.name instanceof Name ? wr.name.get() : wr.name) && w.namespace == wr.namespace) == -1) {
			this.wrappers.push(wr)
			return wr;
		}
	}

	p_wrapper_defs(token, nav, ns) {
		nav ??= this
		const result = this._wrapper_func(token, nav, ns)
		return result ? [result] : []
	}

	steps() {
		return [this.p_wrapper_defs]
	}
}


export function getNameOfGMExtensionFunction(gmfn) {
	if (!gmfn) return ""
	if (gmfn["%Name"]) return String(gmfn["%Name"])
	if (gmfn.externalName) return String(gmfn.externalName)
	if (gmfn.name) return String(gmfn.name)
	return ""
}

function _getNamespacesOfGMExtensionFunction(gmfn, fullApi) {
	// Normalize gmfnName
	const gmfnName = typeof gmfn === "string" ? gmfn : getNameOfGMExtensionFunction(gmfn);
	if (!gmfnName) return undefined;

	const fnFullName = gmfnName.toLowerCase();

	// Parent handles: ensure "imgui" is evaluated last (pattern priority)
	const parentHandles = new Set([...Object.keys(Config.modules).filter(k => k !== "imgui"), "imgui"]);
	const childHandles = new Set([...Object.keys(Module._loadedModules).filter(k => !parentHandles.has(k))]);

	// Pattern templates
	const chPatterns = [
		"%(name)s_",               // child-only (e.g., "node_editor_")
		"%(parent)s_%(name)s_",    // parent + child (e.g., "imgui_node_editor_")
	];

	// Try to resolve against all patterns constructed for the requested child handle
	const result = { parent: undefined, name: undefined };

	const allPatts = new Set();
	for (const chHandle of childHandles) {
		const normName = nameFromHandle(chHandle);
		const nsHandle = toHandle(normName);
		const fnNsName = nsHandle.replace(/[-_]/g, "_"); // normalized child handle
		if (!fnNsName) continue;

		// Build all concrete patterns for this child across all parents
		for (const par of parentHandles) {
			chPatterns
				.map(p => str.resolveTemplate(p, { name: fnNsName, parent: par }))
				.forEach(s => allPatts.add(s));
		}
	}
	parentHandles.forEach(p => allPatts.add(p)); // "%(parent)s_" (parent-only like "imgui_")

	for (const pat of allPatts) {
		const matchesPlain = fnFullName.startsWith(pat);
		const matchesUnderscored = fnFullName.startsWith(`__${pat}`);
		if (!matchesPlain && !matchesUnderscored) continue;
		let { parent: patParent, name: patName } = str.parseGMFunctionName(pat, parentHandles, childHandles);

		// Case A: child-only pattern (e.g., "node_editor") with no parent
		if (!patParent && patName) {
			if (childHandles.has(patName)) {
				patParent = Module._loadedModules[patName].parentHandle;
			}
			result.parent = patParent;
			result.name = patName;
			break;
		}

		// Case B: parent-only match without recognized child after it
		if (patParent == "imgui") {
			result.parent = undefined;
			result.name = patParent;
		} else {
			result.parent = patParent;
			result.name = patName;
		}
		break;
	}

	if (result.parent == undefined || result.name == undefined) {
		if (!parentHandles.has(result.name))
			return undefined
	};

	return result;
}


export function getNamespaceOfGMExtensionFunction(gmfn, fullApi) {
	var gmfnName;
	if (typeof gmfn != "string") {
		gmfnName = getNameOfGMExtensionFunction(gmfn);
	} else {
		gmfnName = gmfn;
	}

	if (!gmfnName) return undefined

	const gmfnInfo = _getNamespacesOfGMExtensionFunction(gmfn, fullApi)
	return gmfnInfo
}

/**
 *
 * @param {CppToken[]} tokens
 * @param {*} source
 * @param {*} apis
 * @returns {WrapperAnalyzer}
 */
export function getWrappers(tokens, source, apis, extras) {
	const wrapperAnalyzer = new WrapperAnalyzer(tokens, Object.assign({
		source: source,
		apis: apis,
	}, extras));
	wrapperAnalyzer.main()
	return wrapperAnalyzer
}

function _yyFix(output) {
	output = output.replace(/(\s*".+?":\s*[^,\n\[{\}]+)(?=\n)/g, "$1,");
	output = output.replace(/([}\]])(\s*\n)/g, "$1,$2");
	output = output.replace(
		/\{\s*"\$GMExtensionFile"([\s\S]*?)\}/g,
		(m) => m.replace(/\s+/g, "")
	);

	output = output
		.split("\n")
		.map((line) => {
			// Preserve leading indentation
			const m = line.match(/^([ \t]*)/);
			const indent = m ? m[1] : "";
			let body = line.slice(indent.length).replace(/[ \t]+/g, " ");
			body = body
				.replace(/"[ \t]*:[ \t]*/g, '":')     // after colon
				.replace(/,[ \t]*/g, ",")             // after comma
				.replace(/[ \t]*([}\]])/g, "$1")      // before closing } or ]
				.replace(/([\[{])[ \t,]*/g, "$1");    // after opening { or [

			return indent + body;
		})
		.join("\n");

	output = output
		.replace(/,,+/g, ",")
		.replace(/(\[|\{), +/g, "$1");

	return output;
}

/**
 * Injects wrapper functions into a GMExtension file if they don't already exist.
 *
 * @param {Array<WrapperFunction>} wrappers
 * @param {File} extensionFile
 */
export function updateGMExtensionWrappers(fullApi, extensionFile) {
	const wrappers = fullApi.wrappers;
	const extension = JSON.parse(str.removeTrailingCommas(extensionFile.content))
	if (extension.resourceType !== "GMExtension") {
		throw new ImGMError(
			`Invalid extension file "${extensionFile.name}": expected resourceType "GMExtension"`
		)
	}

	const dllName = "imgm.dll"
	const index = extension.files.findIndex((f) => f.filename === dllName)
	if (index === -1) {
		throw new ImGMError(
			`Missing DLL entry "${dllName}" in "${extensionFile.name}"`
		)
	}

	const resource = extension.files[index]
	const obsoleted = getUnusedWrappers(fullApi, extensionFile);
	const obsoletedNames = obsoleted.map(o => o.externalName);

	if (obsoleted.length > 0) {
		Logger.warn(`Found ${obsoleted.length} obsolete wrapper(s) in ${extensionFile.name}`)
		obsoleted.forEach(o => Logger.warn(` - ${o.externalName || o.name}`))
	}

	resource.functions = resource.functions.filter(gmfn => !obsoletedNames.includes(gmfn.externalName));
	const existing = resource.functions || []

	// Identify new Wrapper functions (not present by externalName)
	const newFunctions = wrappers
		.filter((w) => existing.some((fn) => fn?.externalName == w.targetFunc) === false)
		.filter((w) => !obsoleted.includes(w.targetFunc))
		.map((w) => w.toGMExtensionFunction())

	// Sort [...keptExisting, ...newFunctions] by the "%Name" attribute in each object, alphabetically.
	const allFunctions = [...existing, ...newFunctions].slice().sort((a, b) => {
		const na = getNameOfGMExtensionFunction(a).toLowerCase()
		const nb = getNameOfGMExtensionFunction(b).toLowerCase()
		return na.localeCompare(nb, "en", { sensitivity: "base" })
	})

	// remove functions for pretty serialization (temporary)
	const extensionClone = structuredClone(extension)

	let output = JSON.stringify(extensionClone, null, 2)

	const pat = `\\{(?<sf>[\\n\\s]*)\\"\\$GMExtensionFile\\"[\\n\\s]*:[\\s\\S]*?\\"filename\\"[\\n\\s]*:[\\n\\s]*\\"${dllName}\\"[\\s\\S]*?\\"functions\\"[\\n\\s]*:[\\n\\s]*\\[(?<sw>\\s*)(?<functions>([^\\[\\]]|\\][^}]|\\"[^\\"\\\\\\\\]*(?:\\\\\\\\.[^\\"\\\\]*)*\\"|\\\\{[^}]*\\\\})*?)\\][\\s\\S]*?\\}`;
	const outputRegex = new RegExp(pat, 'g')
	let fileTextMatch = outputRegex.exec(output);

	if (fileTextMatch) {
		const gmfnIndent = fileTextMatch.groups.sw.slice(1);
		const gmfnWrappersIndent = fileTextMatch.groups.sf.slice(1);
		const gmfnsPosStart = output.indexOf(fileTextMatch[3]);
		const gmfnsPosEnd = gmfnsPosStart + fileTextMatch.groups.functions.length - gmfnWrappersIndent.length;
		// Count newlines starting for GMExtFns
		const preContent = output.slice(0, gmfnsPosStart)//.split("\n").length + 1;
		const postContent = output.slice(gmfnsPosEnd)//.split("\n").length + 1;
		let newOutput = allFunctions
			.map((fn, i) => {
				fn = JSON.stringify(fn);
				fn = fn.slice(0, fn.length - 1) + ",}"
				if (i == 0) return gmfnIndent + fn;
				if (i == allFunctions.length-1) return gmfnIndent + fn + ",";
				return gmfnIndent + fn;
			})
			.join(",\n")
		output = preContent + "\"<NEW_OUTPUT_HOLDER>\"" + postContent;
		output = _yyFix(output)
		output = output.replace("\"<NEW_OUTPUT_HOLDER>\"", `\n${newOutput}\n` + gmfnWrappersIndent);
		if (!process.env.DRYRUN) {
			if (extensionFile.update(output)) {
				extensionFile.commit()
			}
		}
		return true;
	}
	Logger.error("Error parsing ImGM.yy extension file.", { error: true });
}

/**
 * Retrieves array of wrapper functions from a GMExtension file.
 *
 * @param {File} extensionFile
 * @return {Array<WrapperFunction>}
 */
export function getInjectedWrappers(extensionFile) {
	const extension = JSON.parse(str.removeTrailingCommas(extensionFile.content))
	if (extension.resourceType !== "GMExtension") {
		throw new ImGMError(
			`Invalid extension file "${extensionFile.name}": expected resourceType "GMExtension"`
		)
	}

	const dllName = "imgm.dll"
	const index = extension.files.findIndex((f) => f.filename === dllName)
	if (index === -1) {
		throw new ImGMError(`Missing DLL entry "${dllName}" in "${extensionFile.name}"`)
	}

	const resource = extension.files[index]
	return resource.functions || []
}

export function getUnusedWrappers(fullApi, extensionFile) {
	const extension = JSON.parse(str.removeTrailingCommas(extensionFile.content))
	if (extension.resourceType !== "GMExtension") {
		throw new ImGMError(
			`Invalid extension file "${extensionFile.name}": expected resourceType "GMExtension"`
		)
	}

	const dllName = "imgm.dll"
	const index = extension.files.findIndex((f) => f.filename === dllName)
	if (index === -1) {
		throw new ImGMError(`Missing DLL entry "${dllName}" in "${extensionFile.name}"`)
	}

	const resource = extension.files[index]
	const existing = resource.functions || []
	var newWrappers = fullApi.wrappers;

	const requestedHandle = fullApi.modulesConfigs.requestedModuleHandle;
	const requestedHandleChildren = fullApi.modulesConfigs.requestedModuleChildrenHandles;

	const others = existing.filter(gmfn => {
		var { name: handle, parent: parentHandle } = getNamespaceOfGMExtensionFunction(gmfn, fullApi);
		return handle != str.toKebabCase(requestedHandle, "-") && !requestedHandleChildren.has(handle)
	})
	const othersNames = others.map(gmfn => gmfn.externalName);
	const ours = existing.filter(gmfn => !othersNames.includes(gmfn.externalName));
	const obsoletes = ours.filter(gmfn => !newWrappers.some(w => w.targetFunc == gmfn.externalName));

	// Remove existing functions from any extension(s) that are disabled currently in the config header
	const loadedChilds = Object.keys(Module._loadedModules).filter(k => Module._loadedModules[k].parent != undefined);
	const otherObsoletes = new Set()
	const disabledExtensions = loadedChilds.filter(k => !Program._config.enabledImExts.has(k));
	for (const disabledExt of disabledExtensions) {
		let disabledModule = Module._loadedModules[disabledExt];
		if (disabledModule) {
			const moduleGmfns = existing.filter(gmfn => {
				var { name: handle, parent: parentHandle } = getNamespaceOfGMExtensionFunction(gmfn, fullApi);
				if (handle == disabledModule.handle) {
					if (parentHandle == disabledModule.parentHandle) {
						return true;
					}
				}
			});
			const moduleGmfnsNames = moduleGmfns.map(gmfn => gmfn.externalName);
			moduleGmfnsNames.forEach(mgmfn => otherObsoletes.add(mgmfn))
		}
	}

	obsoletes.push(...existing.filter(gmfn => otherObsoletes.has(gmfn.externalName)));

	return obsoletes
}

// #endregion
