import fs from "fs"
import * as glob from "glob"
import Path from "path"
import Logger from "./logging.js"

const NAME = "copyFiles"

/**
 *
 * @param {String|Path} path
 * @param {String|Path} parent
 * @return {Boolean}
 */
export function isPathInside(path, parent) {
	return (
		path.startsWith(parent + Path.sep) ||
		fs.existsSync(Path.join(parent, path))
	)
}

// Function to copy files
export function copyFiles(source, destination, patterns = undefined) {
	try {
		const srcPath = Path.resolve(source)
		const destPath = Path.resolve(destination)

		if (!fs.existsSync(srcPath)) {
			Logger.error(`Source path does not exist: ${srcPath}`, {
				name: NAME,
			})
			return
		}

		let filesToCopy = []
		if (patterns) {
			for (const patt of patterns) {
				const glb = glob.globSync(patt, {
					cwd: srcPath,
				})
				for (const i in glb) {
					const srcP = Path.resolve(srcPath, glb[i])
					filesToCopy.push(srcP)
				}
			}
			if (filesToCopy.length === 0) {
				Logger.error(`No files matched patterns: ${patterns}`, {
					name: NAME,
				})
				return
			}
		} else {
			filesToCopy.push(srcPath)
		}

		// Copy files

		const logMsg = `Copying files ${patterns ? " (with patterns)" : ""}: "${source}" --> "${destination}"`

		if (process.env.DRYRUN) {
			Logger.debug(logMsg, {
				name: NAME,
				type: "DRYRUN",
			})
		} else {
			Logger.debug(logMsg, {
				name: NAME,
				type: Logger.types.FILES_COPY_DEBUG_INFO,
			})
		}

		for (const srcFilePath of filesToCopy) {
			const file = Path.relative(srcPath, srcFilePath)
			const destFilePath = Path.join(destPath, file)

			if (fs.lstatSync(srcFilePath).isDirectory()) {
				if (!fs.existsSync(destFilePath)) {
					fs.mkdirSync(destFilePath, { recursive: true })
				}
			} else {
				if (!fs.existsSync(Path.dirname(destFilePath))) {
					fs.mkdirSync(Path.dirname(destFilePath), {
						recursive: true,
					})
				}
			}

			if (process.env.DRYRUN) {
				Logger.debug(` - copyFileSync: ${file}`, {
					name: NAME,
					type: "DRYRUN",
				})
			} else {
				fs.copyFileSync(srcFilePath, destFilePath)
				Logger.debug(
					` - Copied: "${srcFilePath}" -> "${destFilePath}"`,
					{ name: NAME, type: Logger.types.FILES_COPY_DEBUG_INFO }
				)
			}
		}

		Logger.debug(` - Copied files successfully`, {
			name: NAME,
			type: Logger.types.FILES_COPY_DEBUG_INFO,
		})
	} catch (error) {
		Logger.error(`${error.message}`, {
			name: NAME,
			error,
		})
	}
}
