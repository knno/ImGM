import { resolveTemplate } from "../utils/string.js"

export class ImGMError extends Error {
	constructor(message, extra, options) {
		super(message, options)
		this.extra = extra
	}

	resolve() {
		this.message = this.resolveTemplate(this.message)
		this.stack = this.resolveTemplate(this.stack)
		return this
	}

	resolveTemplate(msg) {
		return resolveTemplate(msg, this.extra)
	}
}

export class ImGMAbort extends Error {
	constructor(message, extra, options) {
		super(message, options)
		this.extra = extra
	}
}

export default ImGMError
