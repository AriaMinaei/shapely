require! {
	'./Field': Field
	'ramda': {type}
}

module.exports = class BooleanField extends Field
	_getValidationError: (val) ->
		unless typeof val is \boolean
			"Boolean expected. `#{type val}` given."

	deserialize: (val) ->
		@validate val
		val