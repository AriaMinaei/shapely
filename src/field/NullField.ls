require! {
	'./Field': Field
}
{type} = require \ramda


module.exports = class NullField extends Field
	_getValidationError: (val) ->
		if val?
			"Null expected. #{type val} given."

	deserialize: (val) ->
		@validate val
		val