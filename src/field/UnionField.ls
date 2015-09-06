require! {
	'./Field': Field
}

module.exports = class UnionField extends Field
	_isValid: (val) ->
		unless typeof val.isA is \function
			return "Expected a record. `#{typeof val}` given."

		unless val.isA @def
			return "Expected the record to be from union `#{@def.__id}`. But it's from `#{val.union?.__id}`"

	serialize: (val) ->
		val.serialize!

	deserialize: (val) ->
		@def.deserialize val