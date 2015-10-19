require! {
	'./Field': Field
	'ramda': {type}
}

module.exports = class NumberField extends Field
	_getValidationError: (val) ->
		unless typeof val is \number
			"Number expected. `#{type val}` given."

	deserialize: (val) ->
		@validate val
		val