require! {
	'./Field': Field
}

module.exports = class TypeField extends Field
	->
		super ...arguments

		unless @def.__id?
			fn = @def
			getDef = -> fn!
			Object.defineProperty this, \def, get: getDef

	_isValid: (val) ->
		unless typeof val?.isA is \function
			return "Expected a value from `#{@def.__id}`. `#{typeof val}` given."

		unless val.isA @def
			return "Expected the value to be from type `#{@def.__id}`. But it's from `#{val.constructor.__id}`"

	serialize: (val) ->
		val.serialize!

	deserialize: (val) ->
		@def.deserialize val