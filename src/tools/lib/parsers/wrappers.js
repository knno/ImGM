import * as fs from "fs"
import Path from "path"
import Config from "../../config.js"
import { BaseFunction, BaseFunctionArgument } from "../class/base-functions.js"
import ImGMError from "../class/error.js"
import Name from "../class/name.js"
import { getChildModules, Module } from "../modules.js"
import { CppKeywords, TokenType } from "../parsers/langs/cpp.js"
import { Program } from "../program.js"
import { resolveTemplate } from "../utils/string.js"
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

export class ApiFunction extends BaseFunction {}
export class ApiEnum {
	constructor({ name, entries, sourceToken, source, ...extra } = {}) {
		this.name = name instanceof Name ? name : new Name(name)
		this.entries = entries
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
		if (first.type == TokenType.FUNCTION_DEF) {
			token = nav.advance(-1)
		} else if (first.type != TokenType.IDENTIFIER) {
			return
		}
		if (token.type == TokenType.IDENTIFIER) {
			if (Config.modules[this.opts.module.handle]) {
				let matchApiIdentifier = false
				const patts =
					Config.modules[this.opts.module.handle]
						.apiIdentifierPatterns
				let base_extras = {
					...this.opts.module.name.toExtra("name"),
				}
				const testIdent = (ident, extras, patts) => {
					for (const pat of patts) {
						const regex = new RegExp(resolveTemplate(pat, extras))
						return regex.test(ident)
					}
				}
				if (this.opts.childModules.length > 0) {
					for (const childModule of this.opts.childModules) {
						let extras = Object.assign(
							base_extras,
							childModule.name.toExtra("name")
						)
						if (testIdent(token.value, extras, patts)) {
							matchApiIdentifier = true
							break
						}
					}
				} else {
					if (testIdent(token.value, base_extras, patts)) {
						matchApiIdentifier = true
					}
				}
				if (matchApiIdentifier) {
					let type = nav.advance()
					switch (type.type) {
						case TokenType.KEYWORD:
							if (type.value == CppKeywords.CONST) {
								type = nav.advance()
								type.const = true
							} else if (type.value == CppKeywords.STATIC) {
								type = nav.advance()
								type.static = true
							}
						case TokenType.IDENTIFIER:
						case TokenType.DEREFERENCE:
						case TokenType.POINTER:
							break
						case TokenType.DIRECTIVE:
							return
						default:
							Logger.warn(
								`Could not understand ${type} for ${token.value}`
							)
							return
					}
					const func = nav.advance()
					if (func.type.endsWith("Pair")) {
						return
					}
					let comment
					let i = 1
					let after = nav.peek()
					let args = []
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
					if (after.type == TokenType.SEMI) {
						this.artifacts.push({
							token: type,
						})
					} else if (after.type == TokenType.IDENTIFIER) {
						this.logToken([token, type, after])
					}
					let _func = new ApiFunction({
						name: func.value,
						args: args,
						returnType: type.value,
						sourceToken: func,
						source: this.opts.source ?? func.source,
						namespace: ns,
						comment: comment ? comment.value : "",
					})
					this.functions.push(_func)
					return _func
				}
			}
		}
	}

	p_ns_api_funcs(token, nav, ns) {
		nav ??= this
		if (token.type == TokenType.KEYWORD && token.value == "namespace") {
			let fns = []
			const next = nav.peek(1)
			if (next && next.type == TokenType.IDENTIFIER) {
				nav.advance()
				const after = nav.peek(1)
				if (after.children.length > 0) {
					nav.advance()
					const children = after.navigateChildren()
					ns = ns ? `${ns}.${next.value}` : next.value
					while (!children.isLast()) {
						const child = children.peek()
						let _res
						if (
							token.type == TokenType.KEYWORD &&
							token.value == "namespace"
						) {
							_res = this.p_ns_api_funcs(child, children, ns)
						} else if (child.type == TokenType.IDENTIFIER) {
							_res = this._api_func(child, children, ns)
							if (_res) {
								fns.push(_res)
							}
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
			}
		} else {
			if (token.type == TokenType.KEYWORD) {
				const prev = nav.peek(-1)
				if (prev) {
					let fn = this._api_func(prev, nav, ns)
					if (fn) {
						this.functions.push(fn)
						return fn
					}
				}
			} else if (token.type == TokenType.IDENTIFIER) {
				let fn = this._api_func(token, nav, ns)
				if (fn) {
					this.functions.push(fn)
					return fn
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
					this.opts.module.sourceConfig &&
					!this.opts.module.sourceConfig.ignore?.enums.includes(name)
				) {
					const def = {}
					let inner
					for (let i = nav.index; i < nav.tokens.length; i++) {
						const find = nav.peek(i)
						if (find.type != TokenType.BRACE_PAIR) continue
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
									children.index = i + 1
									break
								}

								if (!found) {
									// TODO: WHAT
									/*const inner = children.tokens
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
										)*/
									prevName = prev.value.replace(
										enumName,
										name
									)
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
								def[prevName] = 0
								break
							}
						}
						children.advance()
					}
					let __enum = new ApiEnum({
						name,
						entries: def,
						sourceToken: next,
						source: this.opts.source,
						namespace: ns,
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
	reserved = reservedArgumentNames
}

export class WrapperFunction extends BaseFunction {
	constructor({ targetFunc = undefined, ...options } = {}) {
		super(options)
		this.targetFunc = targetFunc
		this.isWrapped = true
		this.isUnsupported = false
		this.nameOverride = undefined
		this.argIndex = -1
		this.isForceInline = false
	}

	setNameOverride(name, override = false) {
		if (this.nameOverride != undefined) return
		this.nameOverride = name
	}

	addArg(name, ind, origin) {
		this.arg[ind] = new WrapperArgument({
			name: name,
			type: origin ? WrapperFunction.typefunc(origin) : "Any",
			defaultValue: undefined,
			isHidden: false,
			passthrough: undefined,
		})
		this.argIndex = ind
	}

	modifier(token) {
		switch (token.value) {
			case `${GMMOD}PREPEND`: {
				this._start += token.getFlatString()
				return true
			}
			case `${GMMOD}APPEND`: {
				this._end += token.getFlatString()
				return true
			}
			case `${GMMOD}OVERRIDE`: {
				const name = token.children[0]
				if (!name || name.type != TokenType.IDENTIFIER)
					throw `Could not handle OVERRIDE modifier, expected "name" argument as ${TokenType.IDENTIFIER} at line ${token.line}`
				this.setNameOverride(name.value, true)
				return true
			}

			case `${GMMOD}DEFAULT`: {
				if (this.argIndex === -1)
					throw `Could not handle ${token.value} modifier, target argument is unset at line ${token.line}`
				const arg = this.Arguments[this.ArgumentIndex]
				arg.Default = token.getFlatString()
				return true
			}
			case `${GMMOD}PASSTHROUGH`: {
				if (this.argIndex === -1)
					throw `Could not handle ${token.value} modifier, target argument is unset at line ${token.line}`
				const arg = this.args[this.argIndex]
				arg.passthrough = token.getFlatString()
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
								Logger.info(
									"Overwriting return type for " +
										this.name +
										" as " +
										this.returnType
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
				this.returnType = token.getFlatString()
				Logger.info(
					"Overwriting return type for " +
						this.name +
						" as " +
						this.returnType
				)
				return true
			}

			case `${GMMOD}HINT`: {
				if (this.argIndex === -1)
					throw `Could not handle ${token.value} modifier, target argument is unset at line ${token.line}`

				const arg = this.args[this.argIndex]
				arg.type = token.getFlatString()
				return true
			}

			// Ignore
			case `${GMMOD}COLOR_TO`:
			case `${GMMOD}COLOR_FROM`:
				return true
		}
		Logger.warn(
			`Could not handle unknown modifier "${token.value}" for wrapper "${this.name}" at line ${token.line}`
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
			"%Name": this.name,
			argCount: 0,
			args: [],
			documentation: "",
			externalName: this.name,
			help: "",
			hidden: true,
			kind: 1,
			name: this.name,
			resourceType: "GMExtensionFunction",
			resourceVersion: "2.0",
			returnType: 1,
		}
	}

	toJsdoc(enums, spacing = 1, snake = false) {
		const jsdocConfig = Config.jsdoc
		const indent = Config.style.spacing.repeat(spacing)
		const fnName = !snake ? this.Calls : this.Name.slice(2)
		const visibleArgs = this.Arguments.filter((arg) => !arg.Hidden)
		let lines = []

		// Description block
		if (jsdocConfig.docletCommentType === "multi") {
			lines.push(indent + "/**")
			if (jsdocConfig.setDescriptions && this.comment) {
				lines.push(
					`${indent} * ${jsdocConfig.descriptionTag} ${this.comment}`
				)
			}
			// Function tag
			let fnLine = `${indent} * ${jsdocConfig.functionTag} ${fnName}`
			if (jsdocConfig.functionWriteArgs && visibleArgs.length > 0) {
				const argList = visibleArgs.map((arg) => arg.Name).join(", ")
				fnLine += `(${argList})`
			}
			lines.push(fnLine)

			// Argument tags
			for (const arg of visibleArgs) {
				let type = arg.Type
				if (type === "Real" && arg.Default) {
					if (arg.Default.startsWith("ImGuiReturnMask")) {
						type = "Enum.ImGuiReturnMask"
					} else {
						for (const key in enums) {
							const name = key.endsWith("_")
								? key.slice(0, -1)
								: key
							if (arg.Default.startsWith(name)) {
								type = `Enum.${name}`
								break
							}
						}
					}
				}

				let argLine = `${indent} * ${jsdocConfig.paramTag} {${type}}`
				if (arg.Default !== undefined) {
					argLine += ` [${arg.Name}=${Wrapper._fixArgDefaultValue(arg.Default)}]`
				} else {
					argLine += ` ${arg.Name}`
				}
				lines.push(argLine)
			}

			// Context
			if (!snake) {
				lines.push(`${indent} * ${jsdocConfig.contextTag} ImGui`)
			}

			// Return tag
			lines.push(`${indent} * ${jsdocConfig.returnTag} {${this.Return}}`)
			lines.push(indent + " */")
		} else {
			// Single-line comment style
			if (jsdocConfig.setDescriptions && this.comment) {
				lines.push(
					`${indent}/// ${jsdocConfig.descriptionTag} ${this.comment}`
				)
			}
			let fnLine = `${indent}/// ${jsdocConfig.functionTag} ${fnName}`
			if (jsdocConfig.functionWriteArgs && visibleArgs.length > 0) {
				const argList = visibleArgs.map((arg) => arg.Name).join(", ")
				fnLine += `(${argList})`
			}
			lines.push(fnLine)

			for (const arg of visibleArgs) {
				let type = arg.Type
				if (type === "Real" && arg.Default) {
					if (arg.Default.startsWith("ImGuiReturnMask")) {
						type = "Enum.ImGuiReturnMask"
					} else {
						for (const key in enums) {
							const name = key.endsWith("_")
								? key.slice(0, -1)
								: key
							if (arg.Default.startsWith(name)) {
								type = `Enum.${name}`
								break
							}
						}
					}
				}
				let argLine = `${indent}/// ${jsdocConfig.paramTag} {${type}}`
				if (arg.Default !== undefined) {
					argLine += ` [${arg.Name}=${Wrapper._fixArgDefaultValue(arg.Default)}]`
				} else {
					argLine += ` ${arg.Name}`
				}
				lines.push(argLine)
			}

			if (!snake) {
				lines.push(`${indent}/// ${jsdocConfig.contextTag} ImGui`)
			}
			lines.push(`${indent}/// ${jsdocConfig.returnTag} {${this.Return}}`)
		}

		return lines.join("\n")
	}

	toGML(spacing = 1, snake = false) {
		let str =
			Config.style.spacing.repeat(spacing) +
			(!snake
				? `static ${this.targetFunc} = function(`
				: `function ${this.name.slice(2)}(`) +
			this.args
				.filter((e) => !e.isHidden)
				.map((e) => {
					if (e.defaultValue === undefined) return e.name

					switch (e.type) {
						case "String": {
							return `${e.name}="${e.defaultValue}"`
						}
					}
					return `${e.name}=${e.defaultValue}`
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
		str += `${this.name}(`
		str +=
			this.args
				.map((e) => {
					if (e.passthrough) {
						return e.passthrough
					}
					return e.name
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

	static _fixArgDefaultValue(val) {
		return val.replaceAll("(", "⌊").replaceAll(")", "⌉")
	}
}

export class WrapperAnalyzer extends BaseParser {
	constructor(tokens, opts = {}) {
		opts.recursive = true
		super(tokens, opts)
		this.wrappers = []
	}

	_wrapper_func(token, nav) {
		token.source ??= this.opts.source
		if (!token || token.type !== TokenType.IDENTIFIER) return

		if (token.value !== "GMFUNC" && token.value !== `${GMMOD}FUNC`) return

		const next = nav.advance()
		if (!next || next.type !== TokenType.PAREN_PAIR || !next.children[0])
			return

		const funcNameToken = next.children[0]

		console.log(this.opts.apis.functions)

		const funcName = funcNameToken.value
		const contentToken = nav.advance()

		if (!contentToken || !contentToken.children) return

		const wr = new WrapperFunction({
			name: new Name(funcName, "PascalCase", "").toPascalCase(),
			source: this.opts.source ?? next.source,
			sourceToken: funcNameToken,
			targetFunc: funcName,
			returnType: funcNameToken.returnType,
		})

		const bodyNav = contentToken.navigateChildren()

		while (!bodyNav.isLast()) {
			const modifier = bodyNav.advance()
			if (modifier && modifier.type === TokenType.IDENTIFIER) {
				if (
					modifier.value.startsWith(`${GMMOD}`) ||
					modifier.value.startsWith("GM")
				)
					wr.modifier(modifier)
			}
		}

		this.wrappers.push(wr)
		return wr
	}

	p_wrapper_defs(token, nav) {
		nav ??= this
		const result = this._wrapper_func(token, nav)
		return result ? [result] : []
	}

	steps() {
		return [this.p_wrapper_defs]
	}
}

/**
 *
 * @param {CppToken[]} tokens
 * @param {*} source
 * @param {*} apis
 * @returns {WrapperAnalyzer}
 */
export function getWrappers(tokens, source, apis) {
	const wrapperAnalyzer = new WrapperAnalyzer(tokens, { source, apis })
	wrapperAnalyzer.main()
	return wrapperAnalyzer
}

// #endregion
