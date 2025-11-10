/**
 * @overview
 *
 * A customizable base Parser classes
 *
 * @author knno <github.com/knno>
 */

import util from "util"
import Config from "../../config.js"
import { ImGMAbort } from "../class/error.js"
import { Program } from "../program.js"
import { getObjectFunctions, getObjectProperties } from "../utils/data.js"
import * as str from "../utils/string.js"

// #region Base

const Logger = Program.Logger

/**
 *
 * @export
 * @class
 */
export class Dict {
	/**
	 * @param {String} value
	 * @return {String|Undefined}
	 */
	static of(value) {
		return Object.keys(this).find((key) => this[key] === value)
	}
	static get = Dict.of
}

/**
 *
 * @export
 * @class
 * @extends {Dict}
 */
export class BaseTokenType extends Dict {
	/** EOF */
	static EOF = "EOF"
	/** \n or \r\n */
	static NEWLINE = "Newline"
	/** Any String token */
	static STRING = "String"
	/** Any Number token */
	static NUMBER = "Number"

	/** ( */
	static LPAREN = "ParenthesesLeft"
	/** ) */
	static RPAREN = "ParenthesesRight"
	/** { */
	static LBRACE = "BraceLeft"
	/** } */
	static RBRACE = "BraceRight"
	/** [ */
	static LBRACKET = "BracketLeft"
	/** ] */
	static RBRACKET = "BracketRight"

	/** () */
	static PAREN_PAIR = "ParenthesesPair"
	/** {} */
	static BRACE_PAIR = "BracePair"
	/** [] */
	static BRACKET_PAIR = "BracketPair"

	static [util.inspect.custom]() {
		return `TT`
	}
}

/**
 *
 * @export
 * @class
 */
export class BaseToken {
	/**
	 *
	 * @abstract
	 * @static
	 * @memberof BaseToken
	 * @type {BaseTokenType}
	 */
	static Types = BaseTokenType

	/**
	 *
	 * @param {Object} options
	 * @param {String} options.type
	 * @param {Any} options.value
	 * @param {Number} options.line
	 * @param {Number} options.col
	 * @param {BaseToken[]} [options.children]
	 * @param {object} [options.extra]
	 */
	constructor({ type, value, line, col, children, ...extra } = {}) {
		this.types = this.constructor.Types
		this.type = type
		this.value = value
		this.line = line
		this.col = col
		this.children = children ?? []
		this._extra = extra
		if (extra) {
			for (const k in extra) {
				this[k] = extra[k]
			}
		}
	}

	getFlatString(begin = undefined) {
		const TT = this.constructor.Types

		let before = undefined,
			after = undefined,
			end = undefined,
			value = this.value,
			inner = ""

		switch (this.type) {
			case TT.PAREN_PAIR: {
				after = "("
				end = ")"
				value = ""
				break
			}
			case TT.BRACE_PAIR: {
				after = "{"
				end = "}"
				value = ""
				break
			}
			case TT.BRACKET_PAIR: {
				after = "["
				end = "]"
				value = ""
				break
			}
			case TT.IDENTIFIER: {
				switch (this.value) {
					case "var": {
						after = " "
						break
					}
				}
				break
			}
			case TT.ASSIGN: {
				before = " "
				after = " "
				break
			}
			case TT.COMMA:
			case TT.SEMI: {
				end = " "
				break
			}
		}

		if (this.children.length > 0) {
			for (let i = 0; i < this.children.length; i++) {
				inner += this.children[i].getFlatString(begin)
			}
		}
		return (
			(begin ?? "") +
			(before ?? "") +
			value +
			(after ?? "") +
			(inner ?? "") +
			(end ?? "")
		)
	}

	/**
	 *
	 * @abstract
	 * @param {String} value
	 * @return {BaseTokenType}
	 */
	static getTypeOf(value) {
		const TT = this.Types
		switch (value) {
			case "(":
				return TT.LPAREN
			case ")":
				return TT.RPAREN
			case "{":
				return TT.LBRACE
			case "}":
				return TT.RBRACE
			case "[":
				return TT.LBRACKET
			case "]":
				return TT.RBRACKET
			case "()":
				return TT.PAREN_PAIR
			case "[]":
				return TT.BRACKET_PAIR
			case "{}":
				return TT.BRACE_PAIR
		}
		return undefined
	}
	/**
	 *
	 * @return {String}
	 */
	static getTypeMajor(type) {
		type = str.toPascalCase(type, "_")
		type = type.split("_")[0]
		return type
	}

	static matchesType(wanted, type) {
		let ret = false

		let types = Object.fromEntries(
			Object.entries(getObjectProperties(this.Types)).filter(
				([key, val]) => {
					return (
						/^[A-Z]/.test(key) &&
						typeof val == "string" &&
						(val.startsWith(type) || val == type)
					)
				}
			)
		)
		for (const tn in types) {
			const tt = this.getTypeMajor(types[tn])
			if (wanted.startsWith(tt)) {
				ret = tt
				break
			}
		}
		return ret
	}

	/**
	 *
	 * @return {BaseTokenType}
	 */
	getTypeOf(value = undefined) {
		return this.constructor.getTypeOf(value ?? this.value)
	}
	/**
	 *
	 * @return {String}
	 */
	getTypeMajor(type = undefined) {
		return this.constructor.getTypeMajor(type ?? this.type)
	}
	/**
	 *
	 * @return {BaseTokenType}
	 */
	matchesType(wanted) {
		return this.constructor.matchesType(wanted, this.type) == wanted
	}

	/**
	 *
	 * @return {Object}
	 */
	pos() {
		let line = this.line
		let col = this.col
		return {
			line,
			col,
			toString: function () {
				return `${line}:${col}`
			},
		}
	}

	toTreeStrings(
		opts = {
			includeSelf: true,
			indentStart: 0,
			indentChar: "  ",
			indentStep: 1,
		}
	) {
		opts = Object.assign(
			{
				indentStart: 0,
				indentChar: "  ",
				indentStep: 1,
			},
			opts
		)
		const _processOne = function (token, indent = 0) {
			let indentText = `${opts.indentChar.repeat(indent)}`
			if (token.children && token.children.length > 0) {
				const childText = token.children
					.map((child) =>
						_processOne(child, indent + opts.indentStep)
					)
					.join("\n")
				let tokenText = opts.includeSelf ? `${token}\n` : ``
				return `${tokenText}${childText}`
			} else {
				return `${indentText}${token}`
			}
		}
		return _processOne(this).replace(
			/^/gm,
			opts.indentChar.repeat(opts.indentStart)
		)
	}

	navigateChildren() {
		return new Navigator(this.children)
	}

	toString() {
		const colors = Program.colors
		let extra = ""
		let extraColorName = "yellow"
		let typeColor = colors.get("red")
		if (this.type && ["newline", "eof"].includes(this.type.toLowerCase())) {
			typeColor = colors.get("gray")
			extraColorName = "gray"
		}
		if (Program.debug && this.value) {
			if (
				typeof this.constructor.Types.COMMENT !== "undefined" &&
				this.matchesType(this.constructor.Types.COMMENT)
			) {
				extraColorName = "green"
			}
			extra = ` ${colors.get(
				extraColorName,
				`"${this.value}"`.replace(/([\n\r])/gm, (m) =>
					m == "\n" ? "\\n" : "\\r"
				)
			)}`
		}

		const instStr =
			colors.get("darkred", this.constructor.name) +
			" " +
			colors.wrap(typeColor, this.type + extra) +
			colors.italic(colors.get("gray", ` at ${this.line}:${this.col}`))

		return colors.get("gray", `<`) + instStr + colors.get("gray", `>`)
	}
}

// #endregion

// #region Internal

/**
 *
 * @export
 * @class
 */
export class BaseTokenizer {
	Token = BaseToken
	TokenType = BaseTokenType

	constructor(
		text,
		opts = {
			Token: BaseToken,
			TokenType: BaseTokenType,
			keepSemi: this.opts?.keepSemi ?? Config.parser.keepSemi ?? false,
			addEOF: this.opts?.addEOF ?? Config.parser.addEOF ?? false,
			addNewline:
				this.opts?.addNewline ?? Config.parser.addNewline ?? false,
		}
	) {
		this.text = text
		this.tokens = []
		this._index = 0
		this._line = 1
		this._start = 0
		this._lineStart = 0
		this.opts = this.opts ? Object.assign(this.opts, opts) : opts
		this.Token ??= this.opts.Token ?? BaseToken
		this.TokenType ??= this.opts.TokenType ?? BaseTokenType
	}

	prepare() {
		this.fns = Object.keys(getObjectFunctions(this))
	}

	/**
	 *
	 * @return {Object}
	 */
	pos() {
		let line = this._line
		let col = this._start - this._lineStart + 1
		return {
			line,
			col,
			toString: function () {
				return `${line}:${col}`
			},
		}
	}

	/**
	 *
	 * @param {String} value
	 * @return {String|Boolean|Undefined}
	 */
	consume(value) {
		if (this.check(value)) {
			return this.advance(value.length)
		} else {
			return false
		}
	}

	/**
	 *
	 * @return {BaseToken[]}
	 * @memberof BaseTokenizer
	 */
	main() {
		this.prepare()
		Logger.debug(`Tokenizing text with a length of ${this.text.length}:`, {
			name: this.constructor.name,
			type: Logger.types.PARSER_DEBUG_INFO,
		})
		while (!this.isEnd()) {
			this._start = this._index
			const token = this.tokenize()
			if (token) {
				this.tokens.push(token)
			}
		}
		if (this.opts.addEOF) {
			const eofToken = this.token(this.Token.Types.EOF, undefined)
			this.tokens.push(eofToken)
		}

		if (
			!Logger.isIgnoredType(Logger.types.PARSER_DEBUG_INFO_LEXED_TOKENS)
		) {
			this.tokens.forEach((t, i) =>
				Logger.debug(` - ${str.padNumber(i, 1000)} - ${t}`, {
					name: this.constructor.name,
					type: Logger.types.PARSER_DEBUG_INFO_LEXED_TOKENS,
				})
			)
		}

		Logger.debug(
			`Read ${this.tokens.length} tokens in ${this._line - 1} lines`,
			{
				name: this.constructor.name,
				type: Logger.types.PARSER_DEBUG_INFO,
			}
		)
		return this.tokens
	}

	/**
	 *
	 * @return {BaseToken|Undefined}
	 */
	tokenize() {
		let char = this.advance()
		const tFns = this.fns.filter((fn) => fn.startsWith("t_"))
		for (const t_Fn of tFns) {
			const tok = this[t_Fn].apply(this, [char])
			if (tok == undefined) {
				continue
			}
			if (tok instanceof this.Token) {
				return tok
			}
			if (tok == false) {
				char = this.advance()
				continue
			}
		}
	}

	/**
	 *
	 * @return {BaseToken|Undefined}
	 */
	lastToken() {
		return this.tokens.length > 0
			? this.tokens[this.tokens.length - 1]
			: undefined
	}

	/**
	 *
	 * @return {BaseToken}
	 */
	token(type, value, children = undefined, extra = undefined) {
		const pos = this.pos()
		if (type != this.TokenType.EOF) {
			value ??= this.text.slice(this._start, this._index)
		}
		return new this.Token({
			type,
			value,
			line: pos.line,
			col: pos.col,
			children,
			...extra,
		})
	}

	/**
	 *
	 * @return {Boolean}
	 */
	isEnd(offset = 0) {
		return this._index + offset >= this.text.length
	}

	/**
	 *
	 * @return {String|Undefined}
	 */
	advance(count = 1) {
		this._index += count
		return this.text.slice(this._index - count, this._index)
	}

	/**
	 *
	 * @return {String|Undefined}
	 */
	peek(offset = 0) {
		if (this.isEnd(offset)) return ""
		return this.text.charAt(this._index + offset)
	}

	/**
	 *
	 * @return {Boolean}
	 */
	check(value) {
		if (this.isEnd()) return false
		if (this.text.slice(this._index, this._index + value.length) !== value)
			return false
		return true
	}

	// Helpers

	isDigit(char) {
		const code = char.charCodeAt(0)
		return code >= 48 && code <= 57
	}

	isAlphabetical(char) {
		const code = char.charCodeAt(0)
		return (
			(code >= 65 && code <= 90) ||
			(code >= 97 && code <= 122) ||
			code === 95
		)
	}

	isAlphanumeric(char) {
		return this.isAlphabetical(char) || this.isDigit(char)
	}

	// TOK Functions (T templates)

	tok_comments(char) {
		if (char == "/") {
			if (this.check("/")) {
				while (!this.isEnd()) {
					if (this.peek() === "\n") {
						break
					}
					this.advance()
				}
				const val = this.text.slice(this._start, this._index).trim()
				const tok = this.token(this.TokenType.COMMENT, val)
				return tok
			} else if (this.consume("*")) {
				while (!this.isEnd()) {
					if (this.peek() === "\n") {
						this._line++
					}
					if (this.advance() === "*" && this.consume("/")) break
				}
				const val = this.text.slice(this._start, this._index).trim()
				const tok = this.token(this.TokenType.COMMENT_MULTILINE, val)
				this._lineStart = this._index
				return tok
			}
		}
	}

	// T Functions

	t__semi(char) {
		if (char == ";") {
			if (typeof this.opts.keepSemi == "undefined" || !this.opts.keepSemi)
				return undefined
			return this.token(this.TokenType.SEMI, char)
		}
	}

	t__line(char) {
		if (char == "\n" || (char == "\r" && this.peek() == "\n")) {
			let val = "\n"
			let tok = undefined

			if (char == "\r" && this.peek() == "\n") {
				val = "\r\n"
				this.advance()
			}
			if (this.opts.addNewline) {
				if (typeof this.TokenType.NEWLINE != "undefined") {
					tok = this.token(this.TokenType.NEWLINE, val)
				}
			}
			this._line++
			this._lineStart = this._index
			return tok
		}
	}
}

/**
 *
 * @export
 * @class
 */
export class BaseParser {
	/**
	 *
	 * @abstract
	 * @type {BaseToken}
	 * @memberof BaseParser
	 */
	Token = BaseToken
	/**
	 *
	 * @abstract
	 * @type {BaseTokenType}
	 * @memberof BaseParser
	 */
	TokenType = BaseTokenType

	/**
	 *
	 * @type {BaseTokenizer}
	 * @memberof BaseParser
	 */
	tokenizer = undefined

	opts = {
		recursive: true,
	}

	constructor(tokens, opts = {}) {
		this.tokens = undefined
		if (tokens instanceof BaseTokenizer) {
			this.tokenizer = tokens
			this.Token ??= this.tokenizer.Token ?? BaseToken
			this.TokenType ??= this.tokenizer.TokenType ?? BaseTokenType
			this._tokens = this.tokenizer.tokens
		} else {
			this.tokenizer = undefined
			this.Token = this.constructor.Token ?? BaseToken
			this.TokenType = this.constructor.TokenType ?? BaseTokenType
			this._tokens = tokens
		}
		this._index = 0
		/**
		 * @type {BaseToken[]}
		 */
		this.tokens = undefined
		this.index = 0
		this.nav = undefined
		this._latestChanges = []
		this.opts = BaseParser.opts
			? Object.assign(BaseParser.opts, opts)
			: opts
	}

	prepare() {
		this.fns = Object.keys(getObjectFunctions(this))
	}

	lex() {
		if (this.tokenizer?.tokens.length == 0) {
			this._tokens = this.tokenizer.main()
			this._index = 0
		}
	}

	/**
	 *
	 * @return {BaseToken[]}
	 */
	main() {
		try {
			if (this._tokens == undefined || this._tokens.length == 0) {
				this.lex()
			}
			this._tokens = this.parse()
			return this._tokens
		} catch (error) {
			if (error instanceof ImGMAbort) {
				throw error
			}
			Logger.error(`Error while parsing`, { error })
			Logger.error(`${error}`)
		}
	}

	/**
	 *
	 * @abstract
	 * @return {Function[]}
	 * @memberof BaseParser
	 */
	steps() {
		return []
	}

	/**
	 *
	 * @return {BaseToken[]}
	 * @memberof BaseParser
	 */
	parse() {
		this.tokens = this._tokens
		const colors = Program.colors
		const steps = this.steps() ?? this.fns.filter((f) => f.startsWith("p_"))
		Logger.debug(
			`Parsing ${this.tokens.length} tokens with ${steps.length} steps:`,
			{
				name: this.constructor.name,
				type: Logger.types.PARSER_DEBUG_INFO,
			}
		)
		for (let i = 0; i < steps.length; i++) {
			Logger.debug(` - step ${colors.get("green", steps[i].name)}:`, {
				name: this.constructor.name,
				type: Logger.types.PARSER_DEBUG_INFO,
			})
			Logger.debug(`       - changes:`, {
				name: this.constructor.name,
				type: Logger.types.PARSER_DEBUG_INFO_PARSED_TOKENS,
			})
			this.step(steps[i], new Navigator(this.tokens))
			if (
				Program.debug &&
				!Logger.isIgnoredType(
					Logger.types.PARSER_DEBUG_INFO_PARSED_TOKENS
				)
			) {
				Logger.debug(`       - tokens:`, {
					name: this.constructor.name,
					type: Logger.types.PARSER_DEBUG_INFO_PARSED_TOKENS,
				})
				for (const token of this.tokens) {
					Logger.debug(
						`             - T(${str.padNumber(this.indexOf(token), 1000)}) ${token}`,
						{
							name: this.constructor.name,
							type: Logger.types.PARSER_DEBUG_INFO_PARSED_TOKENS,
						}
					)
				}
			}
		}
		if (
			!Logger.isIgnoredType(
				Logger.types.PARSER_DEBUG_INFO_PARSED_TOKENS_RESULT
			)
		) {
			Logger.debug(`Parse result:`, {
				name: this.constructor.name,
				type: Logger.types.PARSER_DEBUG_INFO_PARSED_TOKENS_RESULT,
			})
			this.logToken(this.tokens, "debug", {
				name: this.constructor.name,
				type: Logger.types.PARSER_DEBUG_INFO_PARSED_TOKENS_RESULT,
			})
		}
		Logger.debug(
			`Parsed ${this.tokens.length} tokens in ${steps.length} steps.`,
			{
				name: this.constructor.name,
				type: Logger.types.PARSER_DEBUG_INFO,
			}
		)
		return this.tokens
	}

	/**
	 *
	 * @return {Boolean}
	 * @memberof BaseParser
	 */
	isEnd(offset = 0) {
		return this.index + offset >= this.tokens.length
	}

	/**
	 *
	 * @return {BaseToken|Undefined}
	 * @memberof BaseParser
	 */
	advance(amount = 1) {
		this.index += amount
		if (this.index > this.tokens.length) {
			this.index = this.tokens.length
			return undefined
		}
		return this.tokens[this.index]
	}

	/**
	 *
	 * @return {BaseToken|Undefined}
	 * @memberof BaseParser
	 */
	peek(offset = 0) {
		if (
			this.index + offset < 0 ||
			this.index + offset >= this.tokens.length
		)
			return undefined
		return this.tokens[this.index + offset]
	}

	/**
	 *
	 *
	 * @param {Function} fn
	 * @param {Navigator} nav
	 * @return {Navigator}
	 * @memberof BaseParser
	 */
	step(fn, nav) {
		while (!nav.isLast()) {
			const token = nav.peek()
			if (token == undefined || token.type == undefined) {
				if (token) {
					nav.forceDelete(token)
				} else {
					nav.deleteIndex(nav.index)
					nav.advance()
				}
				continue
			}
			const parser = this
			const self = Object.assign(
				{
					...this,
					...getObjectFunctions(this),
				},
				{
					nav: nav,
					parser: parser,
					TokenType: parser.TokenType,
					Token: parser.Token,
					...nav.toStepContext(),
				},
				{
					forceDelete: (t) => {
						if (nav.forceDelete.bind(nav)(t)) {
							if (parser.tokens != nav.tokens) {
								parser.forceDelete.bind(parser)(t)
							}
							return true
						}
						return false
					},
					delete: parser.delete.bind(parser),
					change: parser.change.bind(parser),
				}
			)
			fn.apply(self, [token])
			if (
				this.opts.recursive &&
				token.children &&
				token.children.length > 0
			) {
				token.children = this.step(
					fn,
					new Navigator(token.children)
				).tokens
			}
			if (token.type == undefined) {
				this._logChange({ status: "deleted", token })
			}
			while (this._latestChanges.length > 0) {
				const change = this._latestChanges.pop()
				this._logChange(change)
			}
			nav.advance()
		}
		return nav
	}

	logToken(token, level, extra, ind = -1, st_ind = 0) {
		const colors = Program.colors
		let nav = this
		if (token instanceof Navigator) {
			nav = token
			token = token.tokens
		}
		if (Array.isArray(token)) {
			let i = 0
			for (const t of token) {
				this.logToken(t, level, extra, i, st_ind)
				i++
			}
			return
		}
		let index = nav.indexOf(token)
		if (index == -1) {
			index = ind
		}
		let indText =
			index > -1 ? colors.get("gray", str.padNumber(index, 1000)) : "++++"
		if (token == undefined) {
			Logger.log(
				`${"   ".repeat(st_ind)}${st_ind == 0 ? ` + ${indText} - ` : `   ${indText} - `}undefined`,
				level,
				extra
			)
		} else {
			Logger.log(
				`${"   ".repeat(st_ind)}${st_ind == 0 ? ` + ${indText} - ` : `   ${indText} - `}${token.toString()}` +
					(token.children && token.children.length > 0
						? ` [${token.children.length}]`
						: ""),
				level,
				extra
			)
			if (token.children && token.children.length > 0) {
				const tokenTree = token.children
				let i = 0
				for (const t of tokenTree) {
					this.logToken(t, level, extra, i, st_ind + 1)
					i++
				}
			}
		}
	}

	_logChange(change) {
		const colors = Program.colors
		let msg
		if (
			(change.token && typeof change.token.type != "undefined") ||
			typeof change.token == "undefined"
		) {
			if (change.token) {
				if (change.token.type.endsWith("Pair")) {
					return
				}
			}
			if (typeof change.status != "undefined") {
				if (change.status == "deleted") {
					msg = colors.get("red", change.status)
				} else {
					msg = colors.get("white", change.status)
				}
			} else if (change.props && change.props.type == undefined) {
				msg = colors.get("red", "deleted")
			} else if (change.props) {
				msg = colors.get(
					"green",
					`changed(${Object.keys(change.props).join(",")})` +
						(change.token ? `: ${change.token}` : ``)
				)
			}
			Logger.debug(
				`             - T(${str.padNumber(change.index ?? this.indexOf(change.token), 1000)}) ${msg}`,
				{
					name: this.constructor.name,
					type: Logger.types.PARSER_DEBUG_INFO_CHANGES,
				}
			)
		}
	}

	indexOf(token) {
		return this.tokens.indexOf(token)
	}

	/**
	 * Mark a token as deleted
	 * @param {BaseToken|BaseToken[]} token
	 */
	delete(token) {
		if (Array.isArray(token)) {
			token = token.map((t) => {
				return this.change(t, { type: undefined })
			})
		} else {
			token = this.change(token, { type: undefined })
		}
		return token
	}

	/**
	 * Delete a token
	 * @param {BaseToken|BaseToken[]} token
	 */
	forceDelete(token) {
		let toDelete = token
		if (!Array.isArray(token)) {
			toDelete = [token]
		}
		let success = false
		let index2 = this.index
		for (let t = 0; t < this.tokens.length; t++) {
			if (toDelete.includes(this.tokens[t])) {
				this.tokens.splice(t, 1) // lol
				success = true
				if (t < index2) {
					index2--
				}
				t--
			}
		}
		this.index = index2
		return success
	}

	/**
	 * Delete a single token based on index
	 * @param {Number} index
	 */
	deleteIndex(index) {
		this.tokens.splice(index, 1) // lol
		this.index = index--
		return true
	}

	/**
	 * Insert a token at index
	 * @param {BaseToken|BaseToken[]} token
	 * @param {Number} index
	 */
	insert(token, index) {
		if (Array.isArray(token)) {
			this.tokens.splice(index, 0, ...token)
		} else {
			this.tokens.splice(index, 0, token)
		}
		return token
	}

	/**
	 * Replace a token with a new token or value
	 * @param {BaseToken|BaseToken[]} token
	 * @param {*} newToken
	 */
	replace(token, newToken) {
		if (Array.isArray(token)) {
			for (let i = 0; i < token.length; i++) {
				this.tokens[this.indexOf(token[i])] = newToken
			}
		} else {
			this.tokens[this.indexOf(token)] = newToken
		}
	}

	/**
	 * Clear a token place (set to undefined)
	 * @param {BaseToken|BaseToken[]} token
	 */
	clear(token) {
		this.replace(token, undefined)
	}

	/**
	 * Change a token props
	 * @param {BaseToken|BaseToken[]} token
	 * @param {Object} props
	 * @return {BaseToken}
	 */
	change(token, props) {
		if (Array.isArray(token)) {
			return token.map((t) => this.change(t))
		}
		let pos = this.indexOf(token)
		if (props && Object.keys(props).length > 0) {
			for (const k in props) {
				token[k] = props[k]
			}
			this._latestChanges.push({ token, props })
		}
		this.tokens[pos] = token
		return this.tokens[pos]
	}

	/**
	 * Create a token from a token
	 * @param {BaseToken|BaseToken[]} token
	 * @param {Object} [extra]
	 * @return {BaseToken|BaseToken[]}
	 */
	from(token, ...extra) {
		let token2 = Array.isArray(token) ? token : [token]
		token2 = token2.map(
			(t) =>
				new this.Token({
					type: t.type,
					value: t.value,
					line: t.line,
					col: t.col,
					children: t.children,
					...Object.assign(t._extra ?? {}, extra ?? {}),
				})
		)
		return Array.isArray(token) ? token2 : token2[0]
	}

	[util.inspect.custom]() {
		return `{${Program.colors.get("blue", `'${this.constructor.name}'`)}}`
	}
}

/**
 * Token navigator class
 */
export class Navigator {
	constructor(tokens) {
		this.tokens = tokens
		this.index = 0
	}

	/**
	 *
	 *
	 * @param {BaseToken} token
	 * @return {Number}
	 * @memberof Navigator
	 */
	indexOf(token) {
		return this.tokens.indexOf(token)
	}

	/**
	 *
	 * @return {Boolean}
	 * @memberof Navigator
	 */
	isEnd(offset = 0) {
		return this.index + offset >= this.tokens.length
	}

	/**
	 *
	 * @return {Boolean}
	 * @memberof Navigator
	 */
	isLast() {
		return this.isEnd(0)
	}

	/**
	 *
	 * @return {BaseToken|Undefined}
	 * @memberof Navigator
	 */
	advance(amount = 1) {
		this.index += amount
		if (this.index > this.tokens.length) {
			this.index = this.tokens.length
			return undefined
		}
		return this.tokens[this.index]
	}
	/**
	 *
	 * @return {BaseToken|Undefined}
	 * @memberof Navigator
	 */
	peek(offset = 0) {
		if (
			this.index + offset < 0 ||
			this.index + offset >= this.tokens.length
		)
			return undefined
		return this.tokens[this.index + offset]
	}

	/**
	 * Mark a token as deleted
	 * @param {BaseToken|BaseToken[]} token
	 * @memberof Navigator
	 */
	delete(token) {
		if (Array.isArray(token)) {
			token = token.map((t) => {
				return this.change(t, { type: undefined })
			})
		} else {
			token = this.change(token, { type: undefined })
		}
		return token
	}

	/**
	 * Delete a token
	 * @param {BaseToken|BaseToken[]} token
	 * @memberof Navigator
	 */
	forceDelete(token) {
		let toDelete = token
		if (!Array.isArray(token)) {
			toDelete = [token]
		}
		let success = false
		let index2 = this.index
		for (let t = 0; t < this.tokens.length; t++) {
			if (toDelete.includes(this.tokens[t])) {
				this.tokens.splice(t, 1) // lol
				success = true
				if (t < index2) {
					index2--
				}
				t--
			}
		}
		this.index = index2
		return success
	}

	/**
	 * Deletes a single token based on index
	 * @param {Number} index
	 * @memberof Navigator
	 */
	deleteIndex(index) {
		this.tokens.splice(index, 1) // lol
		this.index = index--
		return true
	}

	/**
	 * Changes a token with new values
	 * @param {BaseToken|BaseToken[]} token
	 * @param {Object} props
	 * @memberof Navigator
	 */
	change(token, props) {
		if (Array.isArray(token)) {
			return token.map((t) => this.change(t))
		}
		let pos = this.indexOf(token)
		if (props && Object.keys(props).length > 0) {
			for (const k in props) {
				token[k] = props[k]
			}
		}
		this.tokens[pos] = token
		return this.tokens[pos]
	}

	/**
	 * Insert a token at index
	 * @param {BaseToken|BaseToken[]} token
	 * @param {Number} index
	 * @memberof Navigator
	 */
	insert(token, index) {
		if (Array.isArray(token)) {
			this.tokens.splice(index, 0, ...token)
		} else {
			this.tokens.splice(index, 0, token)
		}
		return token
	}

	/**
	 * Replace a token with a new token
	 * @param {BaseToken|BaseToken[]} token
	 * @param {*} newToken
	 * @memberof Navigator
	 */
	replace(token, newToken) {
		if (Array.isArray(token)) {
			for (let i = 0; i < token.length; i++) {
				this.tokens[this.indexOf(token[i])] = newToken
			}
		} else {
			this.tokens[this.indexOf(token)] = newToken
		}
	}

	/**
	 * Clear a token place (set to undefined)
	 * @param {BaseToken|BaseToken[]} token
	 * @memberof Navigator
	 */
	clear(token) {
		this.replace(token, undefined)
	}

	toStepContext() {
		return {
			indexOf: this.indexOf.bind(this),
			isEnd: this.isEnd.bind(this),
			isLast: this.isLast.bind(this),
			advance: this.advance.bind(this),
			peek: this.peek.bind(this),
			insert: this.insert.bind(this),
			replace: this.replace.bind(this),
			clear: this.clear.bind(this),
		}
	}

	/**
	 * Match a sequence of tokens by type and/or value
	 * @param {Array<string|[string, string]>} pattern - e.g. ["Identifier", ["Operator", "="]]
	 * @param {number} offset
	 * @returns {boolean}
	 */
	match(pattern, offset = 0) {
		for (let i = 0; i < pattern.length; i++) {
			const token = this.peek(offset + i)
			if (!token) return false

			const expected = pattern[i]

			if (typeof expected === "string") {
				if (token.type !== expected) return false
			} else if (Array.isArray(expected)) {
				const [expectedType, expectedValue] = expected
				if (
					token.type !== expectedType ||
					token.value !== expectedValue
				)
					return false
			}
		}
		return true
	}
}

// #endregion
