require! {
	'./Field': Field
}

module.exports = class TypeField extends Field
	_isValid: (val) ->
		unless typeof val.isA is \function
			return "Expected a typed value. `#{typeof val}` given."

		unless val.isA @def
			return "Expected the value to be from type `#{@def.__id}`. But it's from `#{val.__id}`"

	serialize: (val) ->
		val.serialize!

	deserialize: (val) ->
		@def.deserialize val