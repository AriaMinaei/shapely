require! {
	'./Field': Field
	'ramda': {type}
}

module.exports = class StringField extends Field
	_getValidationError: (val) ->
		unless typeof val is \string
			"String expected. `#{type val}` given."

	deserialize: (val) ->
		@validate val
		val