require! {
	'./field/StringField'
	'./field/NumberField'
	'./field/BooleanField'
	'./field/ObjectField'
	'./field/AnyField'
	'./field/TypeField'
	'./field/VirtualUnionField'
	'./field/ArrayOfTypeField'
	'./helpers'
	'lodash.isplainobject': isPlainObject
	'ramda': _
	'./union'
}

module.exports = function field name, def, wrapper-cls
	helpers.validate-field-name$ name

	switch
	| def is String =>
		new StringField name, def, wrapper-cls

	| def is Number =>
		new NumberField name, def, wrapper-cls

	| def is Boolean =>
		new BooleanField name, def, wrapper-cls

	| def is Object =>
		new ObjectField name, def, wrapper-cls

	| def is \any =>
		new AnyField name, def, wrapper-cls

	# | def instanceof

	| def.isTypedClass is true =>
		new TypeField name, def, wrapper-cls

	| isPlainObject(def) and _.all (.0.match(/^[A-Z]{1}$/)?), Object.keys(def) =>
		new VirtualUnionField name, def, wrapper-cls

	| _.isArrayLike def
		switch
		| def.length is 1 =>
			new ArrayOfTypeField name, def, wrapper-cls

		| otherwise =>
			throw Error "Invalid "

	| otherwise =>
		throw Error "Unkown field type `#{def}`"