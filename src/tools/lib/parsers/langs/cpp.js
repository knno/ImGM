/**
 * @overview
 *
 * An extended Parser "CppParser" for .cpp or .h files
 *
 * @author knno <github.com/knno>
 */

import Config from "../../../config.js"
import ImGMError from "../../class/error.js"
import {
	BaseParser,
	BaseToken,
	BaseTokenizer,
	BaseTokenType,
	Dict,
} from "../base.js"

// #region Language

/**
 *
 * @export
 * @class
 * @extends {Dict}
 */
export class CppTokenType extends BaseTokenType {
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
	/** ? */
	static QMARK = "Question"
	/** ~ */
	static BNOT = "BinaryInvert"
	/** ; */
	static SEMI = "Semicolon"
	/** , */
	static COMMA = "Comma"
	/** :: */
	static SCOPE = "ScopeResolve"
	/** . */
	static COLON = "Colon"
	/** # */
	static HASH = "Hash"
	/** ... */
	static ELLIPSIS = "Ellipsis"
	/** .* or ->* */
	static PTRMEM = "PointerMember"
	/** . */
	static PERIOD = "Period"
	/** -> */
	static PTRACCESS = "PointerAccess"
	/** -= */
	static ASSIGN_SUB = "AssignSubtract"
	/** -- */
	static DEC = "Decrement"
	/** - */
	static MINUS = "Minus"
	/** += */
	static ASSIGN_ADD = "AssignAdd"
	/** ++ */
	static INC = "Increment"
	/** + */
	static PLUS = "Plus"
	/** *= */
	static ASSIGN_MUL = "AssignMultiply"
	/** * */
	static ASTERISK = "Asterisk"
	/** // ... */
	static COMMENT = "Comment"
	/** /** ... *\/ */
	static COMMENT_MULTILINE = "CommentMultiline"
	/** /= */
	static ASSIGN_DIVIDE = "AssignDivide"
	/** / */
	static DIVIDE = "Divide"
	// static ASSIGN_MOD = "AssignModulo"
	/** % */
	static MODULO = "Modulo"
	/** ^= */
	static ASSIGN_XOR = "AssignBinaryXor"
	/** ^ */
	static XOR = "BinaryXor"
	/** && */
	static LOGICAL_AND = "LogicalAnd"
	/** &= */
	static ASSIGN_AND = "AssignBinaryAnd"
	/** & */
	static AND = "BinaryAnd"
	/** || */
	static LOGICAL_OR = "LogicalOr"
	/** |= */
	static ASSIGN_OR = "AssignBinaryOr"
	/** | */
	static OR = "BinaryOr"
	/** != */
	static CMP_NE = "CompareNot"
	/** ! */
	static NOT = "LogicalNot"
	/** == */
	static CMP_EQ = "CompareEqual"
	/** = */
	static ASSIGN = "Assign"
	/** <<= */
	static ASSIGN_SHIFT_LEFT = "AssignBinaryShiftLeft"
	/** << */
	static SHIFT_LEFT = "BinaryShiftLeft"
	/** <= */
	static CMP_LE = "CompareLessThanEqual"
	/** < */
	static LT = "LessThan"
	/** >>= */
	static ASSIGN_SHIFT_RIGHT = "AssignBinaryShiftRight"
	/** >> */
	static SHIFT_RIGHT = "BinaryShiftRight"
	/** >= */
	static CMP_GE = "CompareGreaterThanEqual"
	/** > */
	static GT = "GreaterThan"
	/** () */
	static PAREN_PAIR = "ParenthesesPair"
	/** {} */
	static BRACE_PAIR = "BracePair"
	/** [] */
	static BRACKET_PAIR = "BracketPair"
	// static CHR = "Character"

	/** '...' */
	static STRING_SQ = "StringSinglequote"
	/** "..." */
	static STRING_DQ = "StringDoublequote"

	// PARSER
	static ARGUMENTS = "Arguments"
	/** [a-zA-Z0-9]+ */
	static IDENTIFIER = "Identifier"
	/** Keyword */
	static KEYWORD = "Keyword"
	/** Directive */
	static DIRECTIVE = "Directive"
	/** 0b0000 */
	static NUMBER_BIN = "NumberBinary"
	/** 0x0000 */
	static NUMBER_HEX = "NumberHex"
	/** #include "..." */
	static INCLUDE_PROGRAM = "IncludeProgram"
	/** #include <...> */
	static INCLUDE_STANDARD = "IncludeStandard"
	static POINTER = "TypePointer"
	static ADDRESS_OF = "AddressOf"
	static DEREFERENCE = "Dereference"
	static TEMPLATE_ARGS = "TemplateArgs"
	static FUNCTION_CALL = "FunctionCall"
	static FUNCTION_DEF = "FunctionDef"
	static CAST = "Cast"

	// OTHER
	/** Any include directive */
	static INCLUDE = "Include"
}

/**
 *
 * @export
 * @class
 * @extends {BaseToken}
 */
export class CppToken extends BaseToken {
	static Types = CppTokenType

	static getTypeOf(value) {
		var c = super.getTypeOf(value)
		if (c) return c

		switch (value) {
			case "(":
				c = this.Types.LPAREN
				break
			case ")":
				c = this.Types.RPAREN
				break
			case "{":
				c = this.Types.LBRACE
				break
			case "}":
				c = this.Types.RBRACE
				break
			case "[":
				c = this.Types.LBRACKET
				break
			case "]":
				c = this.Types.RBRACKET
				break
			case "?":
				c = this.Types.QMARK
				break
			case "~":
				c = this.Types.BNOT
				break
			case ";":
				c = this.Types.SEMI
				break
			case ",":
				c = this.Types.COMMA
				break
			case "::":
				c = this.Types.SCOPE
				break
			case ":":
				c = this.Types.COLON
				break
			case "...":
				c = this.Types.ELLIPSIS
				break
			case ".*":
				c = this.Types.PTRMEM
				break
			case ".":
				c = this.Types.PERIOD
				break
			case "->*":
				c = this.Types.PTRMEM
				break
			case "->":
				c = this.Types.PTRACCESS
				break
			case "-=":
				c = this.Types.ASSIGN_SUB
				break
			case "--":
				c = this.Types.DEC
				break
			case "-":
				c = this.Types.MINUS
				break
			case "+=":
				c = this.Types.ASSIGN_ADD
				break
			case "++":
				c = this.Types.INC
				break
			case "+":
				c = this.Types.PLUS
				break
			case "*=":
				c = this.Types.ASSIGN_MUL
				break
			case "*":
				c = this.Types.ASTERISK
				break
			case "//":
				c = this.Types.COMMENT
				break
			case "/*":
				c = this.Types.COMMENT_MULTILINE
				break
			case "/=":
				c = this.Types.ASSIGN_DIVIDE
				break
			case "/":
				c = this.Types.DIVIDE
				break
			case "%":
				c = this.Types.MODULO
				break
			case "^=":
				c = this.Types.ASSIGN_XOR
				break
			case "^":
				c = this.Types.XOR
				break
			case "&&":
				c = this.Types.LOGICAL_AND
				break
			case "&=":
				c = this.Types.ASSIGN_AND
				break
			case "&":
				c = this.Types.AND
				break
			case "||":
				c = this.Types.LOGICAL_OR
				break
			case "|=":
				c = this.Types.ASSIGN_OR
				break
			case "|":
				c = this.Types.OR
				break
			case "!=":
				c = this.Types.CMP_NE
				break
			case "!":
				c = this.Types.NOT
				break
			case "==":
				c = this.Types.CMP_EQ
				break
			case "=":
				c = this.Types.ASSIGN
				break
			case "<<=":
				c = this.Types.ASSIGN_SHIFT_LEFT
				break
			case "<<":
				c = this.Types.SHIFT_LEFT
				break
			case "<=":
				c = this.Types.CMP_LE
				break
			case "<":
				c = this.Types.LT
				break
			case ">>=":
				c = this.Types.ASSIGN_SHIFT_RIGHT
				break
			case ">>":
				c = this.Types.SHIFT_RIGHT
				break
			case ">=":
				c = this.Types.CMP_GE
				break
			case ">":
				c = this.Types.GT
				break
			case "#":
				c = this.Types.HASH
				break
		}
		return c
	}
}

/**
 *
 * @export
 * @class
 * @extends {Dict}
 */
export class CppDirectives extends Dict {
	static DEFINE = "#define"
	static ELIF = "#elif"
	static ELSE = "#else"
	static ENDIF = "#endif"
	static ERROR = "#error"
	static IF = "#if"
	static IFDEF = "#ifdef"
	static IFNDEF = "#ifndef"
	static INCLUDE = "#include"
	static LINE = "#line"
	static PRAGMA = "#pragma"
	static UNDEF = "#undef"
}

/**
 *
 * @export
 * @class
 * @extends {Dict}
 */
export class CppKeywords extends Dict {
	static ALIGNAS = "alignas"
	static ALIGNOF = "alignof"
	static AND = "and"
	static AND_EQ = "and_eq"
	static ASM = "asm"
	static ATOMIC_CANCEL = "atomic_cancel"
	static ATOMIC_COMMIT = "atomic_commit"
	static ATOMIC_NOEXCEPT = "atomic_noexcept"
	static AUTO = "auto"
	static BITAND = "bitand"
	static BITOR = "bitor"
	static BOOL = "bool"
	static BREAK = "break"
	static CASE = "case"
	static CATCH = "catch"
	static CHAR = "char"
	static CHAR16_T = "char16_t"
	static CHAR32_T = "char32_t"
	static CLASS = "class"
	static COMPL = "compl"
	static CONCEPT = "concept"
	static CONST = "const"
	static CONSTEXPR = "constexpr"
	static CONST_CAST = "const_cast"
	static CONTINUE = "continue"
	static CO_AWAIT = "co_await"
	static CO_RETURN = "co_return"
	static CO_YIELD = "co_yield"
	static DECLTYPE = "decltype"
	static DEFAULT = "default"
	static DELETE = "delete"
	static DO = "do"
	static DOUBLE = "double"
	static DYNAMIC_CAST = "dynamic_cast"
	static ELSE = "else"
	static ENUM = "enum"
	static EXPLICIT = "explicit"
	static EXPORT = "export"
	static EXTERN = "extern"
	static FALSE = "false"
	static FLOAT = "float"
	static FOR = "for"
	static FRIEND = "friend"
	static GOTO = "goto"
	static IF = "if"
	static IMPORT = "import"
	static INLINE = "inline"
	static INT = "int"
	static LONG = "long"
	static MODULE = "module"
	static MUTABLE = "mutable"
	static NAMESPACE = "namespace"
	static NEW = "new"
	static NOEXCEPT = "noexcept"
	static NOT = "not"
	static NOT_EQ = "not_eq"
	static NULLPTR = "nullptr"
	static OPERATOR = "operator"
	static OR = "or"
	static OR_EQ = "or_eq"
	static PRIVATE = "private"
	static PROTECTED = "protected"
	static PUBLIC = "public"
	static REGISTER = "register"
	static REINTERPRET_CAST = "reinterpret_cast"
	static REQUIRES = "requires"
	static RETURN = "return"
	static SHORT = "short"
	static SIGNED = "signed"
	static SIZEOF = "sizeof"
	static STATIC = "static"
	static STATIC_ASSERT = "static_assert"
	static STATIC_CAST = "static_cast"
	static STRUCT = "struct"
	static SWITCH = "switch"
	static SYNCHRONIZED = "synchronized"
	static TEMPLATE = "template"
	static THIS = "this"
	static THREAD_LOCAL = "thread_local"
	static THROW = "throw"
	static TRUE = "true"
	static TRY = "try"
	static TYPEDEF = "typedef"
	static TYPEID = "typeid"
	static TYPENAME = "typename"
	static UNION = "union"
	static UNSIGNED = "unsigned"
	static USING = "using"
	static VIRTUAL = "virtual"
	static VOID = "void"
	static VOLATILE = "volatile"
	static WCHAR_T = "wchar_t"
	static WHILE = "while"
	static XOR = "xor"
	static XOR_EQ = "xor_eq"
}

// #endregion Language

/**
 *
 * @export
 * @class
 * @extends {BaseTokenizer}
 */
export class CppLexer extends BaseTokenizer {
	Token = CppToken
	TokenType = CppTokenType
	Keywords = CppKeywords
	Directives = CppDirectives
	opts = Object.assign({}, Config.parser.cpp.tokenizerOptions)

	t_comments = this.tok_comments

	t_ignore(char) {
		if (char == " " || char == "\t" || char == "\r") {
			this._start += 1
			return false
		}
	}

	t_op(char) {
		let isOp = true
		switch (char) {
			case "!":
				this.consume("=")
				break
			case "=":
				this.consume("=")
				break
			case "%":
				this.consume("=")
				break
			case "^":
				this.consume("=")
				break
			case "*":
				this.consume("=")
				break
			case ":":
				this.consume(":")
				break
			case "&":
				if (!this.consume("&")) {
					this.consume("=")
				}
				break
			case "|":
				if (!this.consume("|")) {
					this.consume("=")
				}
				break
			case "+":
				if (!this.consume("=")) {
					this.consume("+")
				}
				break
			case ".":
				if (!this.consume("..")) {
					this.consume("*")
				}
				break
			case "<":
				if (!this.consume("<=")) {
					if (!this.consume("<")) {
						this.consume("=")
					}
				}
				break
			case ">":
				if (!this.consume(">=")) {
					if (!this.consume(">")) {
						this.consume("=")
					}
				}
				break
			case "-":
				if (!this.consume(">*")) {
					if (!this.consume(">")) {
						if (!this.consume("=")) {
							this.consume("-")
						}
					}
				}
				break

			case "/":
				if (this.check("/")) {
					return this.t_comments(char)
				}
				this.consume("=")
				break

			case ",":
				break

			default:
				isOp = false
		}
		if (isOp) {
			const val = this.text.slice(this._start, this._index)
			let type = this.Token.getTypeOf(val)
			if (type) {
				return this.token(type, val)
			}
		}
	}

	t_stringSQ(char) {
		if (char == "'") {
			const _line = this._line
			while (this.peek() !== "'" && !this.isEnd()) {
				if (this.peek() === "\n") {
					this._line++
					this._lineStart = this._index
				}
				this.advance()
			}

			if (this.isEnd()) {
				throw new ImGMError(
					`Could not find terminating quote for char at line ${_line}`
				)
			}

			this.advance()
			const ret = this.token(
				this.TokenType.STRING_SQ,
				this.text.slice(this._start + 1, this._index - 1)
			)
			this._lineStart = this._index
			return ret
		}
	}

	t_stringDQ(char) {
		if (char == '"') {
			const _line = this._line
			while (
				(this.peek() !== '"' || this.peek(-1) === "\\") &&
				!this.isEnd()
			) {
				if (
					typeof this.opts.lineOnLFstringDQ != "undefined" &&
					this.opts.lineOnLFstringDQ
				) {
					if (this.peek() === "\n") {
						this._line++
					}
				}
				this.advance()
			}

			if (this.isEnd()) {
				throw new ImGMError(
					`Could not find terminating double-quote for string at line ${_line}`
				)
			}

			this.advance()
			const ret = this.token(
				this.TokenType.STRING_DQ,
				this.text.slice(this._start + 1, this._index - 1)
			)
			this._lineStart = this._index
			return ret
		}
	}

	t_directive(char) {
		if (char == "#") {
			return this.readIdent(char)
		}
	}

	t_alphanumeric(char) {
		if (this.isDigit(char)) return this.readNum(char)
		if (this.isAlphabetical(char)) {
			return this.readIdent(char)
		}
	}

	t_pair_chr(char) {
		if (char == "(") return this.token(this.TokenType.LPAREN)
		if (char == ")") return this.token(this.TokenType.RPAREN)
		if (char == "{") return this.token(this.TokenType.LBRACE)
		if (char == "}") return this.token(this.TokenType.RBRACE)
		if (char == "[") return this.token(this.TokenType.LBRACKET)
		if (char == "]") return this.token(this.TokenType.RBRACKET)
	}

	readNum(char) {
		let type = this.TokenType.NUMBER
		if (this.consume("b")) {
			if (char !== "0")
				throw new ImGMError(
					`Binary literal at line ${this._line} must start with 0`
				)
			type = this.TokenType.NUMBER_BIN
		} else if (this.consume("x")) {
			if (char !== "0")
				throw new ImGMError(
					`Hexadecimal literal at line ${this._line} must start with 0`
				)
			while (!this.isEnd()) {
				const next = this.peek(),
					code = next.charCodeAt(0)
				if (
					(!this.isDigit(next) && !(code >= 65 && code <= 70)) ||
					(code >= 97 && code <= 102)
				)
					break
				this.advance()
			}
			return this.token(
				this.TokenType.NUMBER_HEX,
				this.text.slice(this._start, this._index)
			)
		}
		while (this.isDigit(this.peek())) this.advance()
		let val
		if (
			(this.peek() === "." || this.peek() == "_") &&
			this.isDigit(this.peek(1))
		) {
			this.advance()
			while (this.isDigit(this.peek())) this.advance()
			val = parseFloat(this.text.slice(this._start, this._index))
		} else {
			val = this.text.slice(this._start, this._index)
		}
		return this.token(type, val)
	}

	readIdent(char) {
		while (this.isAlphanumeric(this.peek())) this.advance()

		const ident = this.text.slice(this._start, this._index)
		if (this.Keywords.get(ident)) {
			return this.token(this.TokenType.KEYWORD, ident)
		}
		if (this.Directives.get(ident)) {
			return this.token(this.TokenType.DIRECTIVE, ident)
		}
		return this.token(this.TokenType.IDENTIFIER, ident)
	}
}

/**
 *
 * @export
 * @class
 * @extends {BaseParser}
 */
export class CppParser extends BaseParser {
	Token = CppToken
	TokenType = CppTokenType
	Keywords = CppKeywords

	parseGroups(token) {
		switch (token.type) {
			case this.TokenType.LPAREN:
			case this.TokenType.LBRACE:
			case this.TokenType.LBRACKET: {
				const children = []
				while (!this.isEnd()) {
					const next = this.peek(1)
					let changes = {}
					if (next) {
						this.advance()
						switch (next.type) {
							case this.TokenType.RPAREN:
								if (children.length == 1) {
									const chFirst = children[0]
									switch (chFirst.type) {
										case this.TokenType.POINTER:
											changes.type = this.TokenType.CAST
											changes.value = chFirst.value
											token = this.change(token, changes)
											return token
									}
								}
							case this.TokenType.RBRACE:
							case this.TokenType.RBRACKET:
								changes.type = token.getTypeMajor() + "Pair"
								switch (next.type) {
									case this.TokenType.RPAREN:
										changes.value = "()"
										break
									case this.TokenType.RBRACE:
										changes.value = "{}"
										break
									case this.TokenType.RBRACKET:
										changes.value = "[]"
										break
								}
								changes.children = this.from(children)
								this.delete(children)
								token = this.change(token, changes)
								this.delete(next)
								return token

							case this.TokenType.LPAREN:
							case this.TokenType.LBRACE:
							case this.TokenType.LBRACKET:
								const inside = this.parseGroups(next)
								children.push(inside)
								break

							default:
								children.push(next)
								break
						}
					} else {
						return token
					}
				}
				throw new ImGMError(`Non-closed token %(token)s`, { token })
			}

			case this.TokenType.RPAREN:
			case this.TokenType.RBRACE:
			case this.TokenType.RBRACKET:
				throw new ImGMError(`Non-closed orphan token %(token)s`, {
					token,
				})
		}
		return token
	}

	/**
	 * @param {CppToken} token
	 */
	p_directives(token) {
		if (token.type == this.TokenType.DIRECTIVE) {
			switch (token.value) {
				case CppDirectives.INCLUDE:
					const next = this.advance()
					if (next) {
						let changes = {}
						if (next.matchesType(this.TokenType.STRING)) {
							changes.type = this.TokenType.INCLUDE_PROGRAM
						} else {
							changes.type = this.TokenType.INCLUDE_STANDARD
							if (next.type == this.TokenType.IDENTIFIER) {
								changes.children = [next]
								this.replace(next, undefined)
								this.change(token, changes)
								return
							}
							if (next.type == this.TokenType.LT) {
								let afters = []
								while (!this.isEnd()) {
									let after = this.advance()
									afters.push(after)
									this.replace(after, undefined)
									if (after.type == this.TokenType.GT) {
										break
									}
								}
								changes.children = [next, ...afters]
								this.replace(next, undefined)
								this.change(token, changes)
								return
							} else {
								throw new ImGMError(
									`Value not found for pending token change(type) ${changes.type}: %(token)s`,
									{ token }
								)
							}
						}
						changes.children = [next]
						this.replace(next, undefined)
						this.change(token, changes)
						return
					}
					throw new ImGMError(
						`No token after token of type ${token.type} at ${token.pos()}`
					)
			}
		}
	}

	/**
	 * @param {CppToken} token
	 */
	p_pointers(token) {
		switch (token.type) {
			case this.TokenType.IDENTIFIER:
			case this.TokenType.KEYWORD:
				let prev = this.peek(-1)
				if (prev) {
					let prevChanges = {}
					if (prev.type == this.TokenType.AND) {
						prevChanges.type = this.TokenType.ADDRESS_OF
						prevChanges.value = token.value
						this.change(prev, prevChanges)
						this.advance(2)
						return
					}
				}

				const next = this.peek(1)

				if (next) {
					let changes = {}
					const after = this.peek(2)
					if (after && after.matchesType(this.TokenType.NUMBER)) {
						return
					}
					if (next.type == this.TokenType.ASTERISK) {
						changes.value = token.value
						changes.type = this.TokenType.POINTER
						changes.value += next.value
						if (after.type == this.TokenType.ASTERISK) {
							changes.value += after.value
							this.delete(after)
						}
						this.delete(next)
						this.advance()
					} else if (next.type == this.TokenType.AND) {
						changes.type = this.TokenType.DEREFERENCE
						this.delete(next)
						this.advance()
					}
					this.change(token, changes)
					return
				}
				break
		}
	}

	/**
	 * @param {CppToken} token
	 */
	p_numbers(token) {
		switch (token.type) {
			case this.TokenType.MINUS:
			case this.TokenType.PLUS:
				let next = this.peek()
				if (next && next.matchesType(this.TokenType.NUMBER)) {
					let nextChanges = {}
					nextChanges.value = token.value + next.value
					this.change(next, nextChanges)
				}
				break
		}
	}

	/**
	 * @param {CppToken} token
	 */
	p_groups(token) {
		this.parseGroups(token)
	}

	/**
	 * @param {CppToken} token
	 */
	p_templates(token) {
		if (token.type == this.TokenType.LT) {
			const next = this.peek(1)
			if (
				next.type == this.TokenType.KEYWORD ||
				next.type == this.TokenType.IDENTIFIER
			) {
				let args = []
				for (let i = this.nav.index; i < this.nav.tokens.length; i++) {
					const tok = this.nav.tokens[i]
					if (tok && tok.type == this.TokenType.GT) {
						const after = this.nav.tokens[i + 1]
						if (after && after.type == this.TokenType.PAREN_PAIR) {
							this.advance(i + 1 - this.nav.index)
							this.change(token, {
								type: this.TokenType.TEMPLATE_ARGS,
								children: args,
							})
							this.delete(args)
							this.logToken(token)
							return
						}
					}
					args.push(tok)
				}
				this.advance(args.length)
			}
		}
	}

	/**
	 * @param {CppToken} token
	 */
	p_funcs(token) {
		let changes = {}
		switch (token.type) {
			case this.TokenType.IDENTIFIER:
				let tok = this.peek()
				if (tok) {
					if (tok.type == this.TokenType.TEMPLATE_ARGS) {
						changes.value = token.value + "|template=" + tok.value
						this.advance()
						tok = this.peek()
					}
					if (tok.type == this.TokenType.PAREN_PAIR) {
						this.advance()
						const next = this.peek()
						if (next.type == this.TokenType.BRACE_PAIR) {
							changes.type = this.TokenType.FUNCTION_DEF
						} else {
							changes.type = this.TokenType.FUNCTION_CALL
						}
						changes.children = tok.children
						this.change(token, changes)
					}
				}
				break
		}
	}

	/**
	 * @param {CppToken} token
	 */
	p_consts(token) {
		if (
			token.type == this.TokenType.KEYWORD &&
			token.value == this.Keywords.CONST
		) {
			let next = this.peek()
			switch (next.type) {
				case this.TokenType.POINTER:
				case this.TokenType.DEREFERENCE:
					next = this.change(next, {
						value: token.value + " " + next.value,
					})
					break
			}
		}
	}

	steps() {
		return [
			this.p_directives,
			this.p_pointers,
			this.p_numbers,
			this.p_groups,
			this.p_templates,
			this.p_funcs,
			this.p_consts,
		]
	}
}

export {
	CppToken as Token,
	CppTokenType as TokenType,
	CppDirectives as Directives,
	CppKeywords as Keywords,
	CppLexer as Lexer,
	CppParser as Parser,
}

const cpp = {
	Token: CppToken,
	TokenType: CppTokenType,
	Directives: CppDirectives,
	Keywords: CppKeywords,
	Lexer: CppLexer,
	Parser: CppParser,
}
export default cpp
