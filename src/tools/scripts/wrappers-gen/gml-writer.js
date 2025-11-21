export function generateGMLScript({ namespace, enums, wrappers, cfg }) {
	const ret = {
		enums: "",
		binds: "",
	};

	let lines = []

	for (const en of enums) {
		if (cfg.jsdoc.docletCommentType === "multi") {
			lines.push(cfg.style.spacing + "/**")
			lines.push(`${cfg.style.spacing} * @enum ${en.name.toPascalCase()}`)
			if (en.comment) {
				lines.push(cfg.style.spacing + ` * ${cfg.jsdoc.descriptionTag} ${en.comment.split("\n")[0]}`)
			}
			lines.push(cfg.style.spacing + " *")
			lines.push(cfg.style.spacing + " */")
		} else {
			lines.push(cfg.style.spacing + `/// @enum ${en.name.toPascalCase()}`)
			if (en.comment) {
				lines.push(cfg.style.spacing + `/// ${cfg.jsdoc.descriptionTag} ${en.comment.split("\n")[0]}`)
			}
		}
		lines.push(cfg.style.spacing + `enum ${en.name.toPascalCase()} {`)
		for (const entry of Object.keys(en.entries)) {
			if (en.entries[entry] == null) {
				lines.push(cfg.style.spacing.repeat(2) + `${entry},`)
			} else {
				lines.push(cfg.style.spacing.repeat(2) + `${entry} = ${en.entries[entry]},`)
			}
		}
		lines.push(cfg.style.spacing + "}")
		lines.push("")
	}

	ret.enums = lines.join("\n").trimStart();
	lines = [];

	for (const fn of wrappers) {
		lines.push(fn.toJsdoc(enums, namespace, 1));
		lines.push(fn.toGML(1, false));
	}

	ret.binds = lines.join("\n").trimStart()
	return ret;
}
