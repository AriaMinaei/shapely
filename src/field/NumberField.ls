require! {
	'./Field': Field
}

module.exports = class NumberField extends Field
	_isValid: (val) ->
		unless typeof val is \number
			"Number expected. `#{typeof val}` given."