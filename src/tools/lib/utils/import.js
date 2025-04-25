import * as fs from "fs"
import { pathToFileURL } from "url"

export default async function Import(file) {
	const path = pathToFileURL(file)
	if (fs.existsSync(path)) {
		const content = await import(path)
		return content
	}
}
