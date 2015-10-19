require! {
	'./Field': Field
	'lodash.isplainobject': isPlainObject
	'ramda': {type}
}

module.exports = class ObjectField extends Field
	_getValidationError: (val) ->
		unless isPlainObject val
			"Plain object expected. `#{type val}` given."

	deserialize: (val) ->
		@validate val
		val