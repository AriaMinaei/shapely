require! {
	'./Field': Field
	'lodash.isplainobject': isPlainObject
}

module.exports = class ObjectField extends Field
	_isValid: (val) ->
		unless isPlainObject val
			"Plain object expected. `#{typeof val}` given."