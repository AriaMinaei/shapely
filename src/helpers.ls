module.exports.validate-type-name$ = (name) !->
	unless typeof name is \string
		throw Error "A type needs a string name. `#{typeof name}` given."

	unless name.match /^[A-Z]{1}[a-zA-Z0-9\_]*$/
		throw Error "A type's name must be a string starting with a capital letter. '#{name}' given."

module.exports.validate-field-name$ = (name) !->
	unless typeof name is \string
		throw Error "A field needs a string name. `#{typeof name}` given."

	unless name.match /^[a-z]{1}[a-zA-Z0-9\_]*$/
		throw Error "A field's name must be a string starting with a small letter. '#{name}' given."