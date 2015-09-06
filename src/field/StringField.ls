require! {
	'./Field': Field
}

module.exports = class StringField extends Field
	_isValid: (val) ->
		unless typeof val is \string
			"String expected. `#{typeof val}` given."