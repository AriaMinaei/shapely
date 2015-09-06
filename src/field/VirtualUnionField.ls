require! {
	'./Field': Field
	'ramda': _
}

module.exports = class VirtualUnionField extends Field
	->
		super ...arguments
		# union-name = (wrapper-cls.__id + "." + name + "").replace(/\./g, '_') + "_VirtualUnion"
		@_acceptableClasses = []
		for key, cls of @def
			@_acceptableClasses.push cls

		@_acceptableClassIDs = @_acceptableClasses
		|> _.map (.__id)

	_isValid: (val) ->
		unless typeof val.isA is \function
			return "Expected a typed value. `#{typeof val}` given."

		unless _.any val~isA, @_acceptableClasses
			return "Expected the typed value to be one of [#{@_acceptableClassIDs.join(', ')}]. But it's from `#{val.union?.__id}`"

	serialize: (val) ->
		val.serialize!

	deserialize: (val) ->
		for cls in @_acceptableClasses
			try
				return cls.deserialize val

		throw Error "Cannot deserialize value. It doesn't belong to [#{@_acceptableClassIDs.join(', ')}]."