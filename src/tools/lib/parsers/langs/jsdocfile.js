/**
 * @overview
 *
 * A lightweight version of a parser for text files to parse jsdoc comments
 * @deprecated Use strings.js parseJsdoc instead for parsing strings.
 *
 * @author knno <github.com/knno>
 */

import Config from "../../../config.js"
import { BaseToken, BaseTokenizer, BaseTokenType, Dict } from "../base.js"

// #region Language

/**
 *
 * @export
 * @class
 * @extends {Dict}
 */
export class JsdocFileTokenType extends BaseTokenType {
	/** @ */
	static AT = "At"
	/** # */
	static HASH = "Hash"
	/** * */
	static ASTERISK = "Asterisk"
	/** // ... */
	static COMMENT = "Comment"
	/** /** ... *\/ */
	static COMMENT_MULTILINE = "CommentMultiline"

	// PARSER
	/** [a-zA-Z0-9]+ */
	static IDENTIFIER = "Identifier"
	/** Directive */
	static DIRECTIVE = "Directive"
}

/**
 *
 * @export
 * @class
 * @extends {BaseToken}
 */
export class JsdocFileToken extends BaseToken {
	static Types = JsdocFileTokenType

	static getTypeOf(value) {
		var c = super.getTypeOf(value)
		if (c) return c
		const TT = this.Types

		switch (value) {
			case "*":
				c = TT.ASTERISK
				break
			case "//":
				c = TT.COMMENT
				break
			case "/*":
				c = TT.COMMENT_MULTILINE
				break
			case "#":
				c = TT.HASH
				break
			case "@":
				c = TT.AT
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
export class JsdocFileDirectives extends Dict {
	static REGION = "#region"
	static ENDREGION = "#endregion"
}

/**
 *
 * @export
 * @class
 * @extends {Dict}
 */
export class JsdocFileKeywords extends Dict { }

// #endregion Language

/**
 *
 * @export
 * @class
 * @extends {BaseTokenizer}
 */
export class JsdocFileLexer extends BaseTokenizer {
	Token = JsdocFileToken
	TokenType = JsdocFileTokenType
	Keywords = JsdocFileKeywords
	Directives = JsdocFileDirectives
	opts = Object.assign({}, Config.parser.jsdocfile.tokenizerOptions)

	t_comments = this.tok_comments

	t_ignore(char) {
		if (char == " " || char == "\t" || char == "\r") {
			this._start += 1
			return false
		}
	}
}
