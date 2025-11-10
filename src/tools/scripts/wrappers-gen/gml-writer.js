export function generateGMLScript({ namespace, enums, wrappers, cfg }) {
	const ret = {
		enums: "",
		binds: "",
	};

	let lines = []

	for (const en of enums) {
		lines.push(cfg.style.spacing + `/// @enum ${en.name.toPascalCase()}`)
		if (en.comment) {
			lines.push(cfg.style.spacing + `/// @desc ${en.comment.split("\n")[0]}`)
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
		lines.push(fn.toJsdoc(enums));
		lines.push(fn.toGML(1, false));
	}

	ret.binds = lines.join("\n").trimStart()
	return ret;
}
