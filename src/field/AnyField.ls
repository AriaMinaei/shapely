require! {
	'./Field': Field
}

module.exports = class AnyField extends Field
	serialize: (val) ->
		unless val?
			val
		else
			if val.toJS?
				val.toJS!
			else
				val