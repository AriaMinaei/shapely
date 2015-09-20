module.exports = function field name, def, wrapper-id
	helpers.validate-field-name$ name
	id = wrapper-id + \. + name

	switch
	| def is String =>
		new StringField id, def

	| def is Number =>
		new NumberField id, def

	| def is Boolean =>
		new BooleanField id, def

	| def is Object =>
		new ObjectField id, def

	| def is \any =>
		new AnyField id, def

	# | def instanceof

	| def.isTypedClass is true =>
		new TypeField id, def

	| isPlainObject(def) and _.all (.0.match(/^[A-Z]{1}$/)?), Object.keys(def) =>
		new VirtualUnionField id, def

	| _.isArrayLike def
		switch
		| def.length is 1 =>
			new ArrayOfTypeField id, def

		| def.length is 2 =>
			switch def[0]
			| \mapOf =>
				new MapOfTypeField id, def

			| otherwise =>
				throw Error "Invalid type modifier '#that'"

		| otherwise =>
			throw Error "Invalid array definition. Must have"

	| otherwise =>
		throw Error "Unkown field type `#{def}`"

require! {
	'./field/StringField'
	'./field/NumberField'
	'./field/BooleanField'
	'./field/ObjectField'
	'./field/AnyField'
	'./field/TypeField'
	'./field/VirtualUnionField'
	'./field/ArrayOfTypeField'
	'./field/MapOfTypeField'
	'./helpers'
	'lodash.isplainobject': isPlainObject
	'ramda': _
	'./union'
}