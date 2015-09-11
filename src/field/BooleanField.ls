require! {
	'./Field': Field
}

module.exports = class BooleanField extends Field
	_isValid: (val) ->
		unless typeof val is \boolean
			"Boolean expected. `#{typeof val}` given."