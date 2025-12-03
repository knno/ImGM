import Config from "../../config.js";

export function generateGMLScript({ namespace, enums, wrappers, cfg }) {
	const ret = {
		enums: "",
		binds: "",
	};

	let lines = []

	for (const en of enums) {
		if (Config.jsdoc.docletCommentType === "multi") {
			lines.push(Config.style.spacing + "/**")
			lines.push(`${Config.style.spacing} * @enum ${en.name.toPascalCase()}`)
			if (en.comment) {
				lines.push(Config.style.spacing + ` * ${Config.jsdoc.descriptionTag} ${en.comment.split("\n")[0]}`)
			}
			lines.push(Config.style.spacing + " *")
			lines.push(Config.style.spacing + " */")
		} else {
			lines.push(Config.style.spacing + `/// @enum ${en.name.toPascalCase()}`)
			if (en.comment) {
				lines.push(Config.style.spacing + `/// ${Config.jsdoc.descriptionTag} ${en.comment.split("\n")[0]}`)
			}
		}
		lines.push(Config.style.spacing + `enum ${en.name.toPascalCase()} {`)
		for (const entry of Object.keys(en.entries)) {
			if (en.entries[entry] == null) {
				lines.push(Config.style.spacing.repeat(2) + `${entry},`)
			} else {
				lines.push(Config.style.spacing.repeat(2) + `${entry} = ${en.entries[entry]},`)
			}
		}
		lines.push(Config.style.spacing + "}")
		lines.push("")
	}

	ret.enums = lines.join("\n").trim()
	lines = [];

	for (const wr of wrappers) {
		lines.push(wr.toJsdoc(enums, namespace, 1));
		lines.push(wr.toGML(1, false));
	}

	ret.binds = lines.join("\n").trim()

	return ret;
}
