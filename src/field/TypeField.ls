require! {
	'./Field': Field
	'ramda': {type}
}

module.exports = class TypeField extends Field
	->
		super ...arguments

		unless @def.__id?
			fn = @def
			getDef = -> fn!
			Object.defineProperty this, \def, get: getDef

	_getValidationError: (val) ->
		unless typeof val?.isA is \function
			return "Expected a value from `#{@def.__id}`. `#{type val}` given."

		unless val.isA @def
			return "Expected the value to be from type `#{@def.__id}`. But it's from `#{val.constructor.__id}`"

	serialize: (val) ->
		val.serialize!

	deserialize: (val) ->
		@def.deserialize val