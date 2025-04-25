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
					let arg = undefined
					let _func = new ApiFunction({
						name: func.value,
						args: undefined,
						returnType: type.value,
						sourceToken: func,
						source: this.opts.source,
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
					return fns
				}
			}
		} else {
			if (token.type == TokenType.KEYWORD) {
				const prev = nav.peek(-1)
				if (prev) {
					let fn = this._api_func(prev, nav, ns)
					if (fn) {
						return fn
					}
				}
			} else if (token.type == TokenType.IDENTIFIER) {
				let fn = this._api_func(token, nav, ns)
				if (fn) {
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
					this.enums.push(
						new ApiEnum({
							name,
							entries: def,
							sourceToken: next,
							source: this.opts.source,
							namespace: ns,
						})
					)
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
	constructor({ targetFunc: undefined, ...options } = {}) {
		super(options)
		this.targetFunc = targetFunc
	}
}

export function getWrappers(tokens) {
	for (const token of tokens) {
		if (token.type == TokenType.DIRECTIVE) {
			console.log(token)
		}
	}
}

// #endregion
