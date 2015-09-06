require! {
	'./Field': Field
	'ramda': _
	'immutable': {List}
}

module.exports = class ArrayOfTypeField extends Field
	->
		super ...arguments

		@_acceptableClasses = @def
		@_acceptableClassIDs = @_acceptableClasses |> _.map (.__id)

	_isValid: (lst) ->
		if lst.toArray?
			lst = lst.toArray!

		unless _.isArrayLike lst
			return "Expected a an array or list. `#{typeof lst}` given."

		for val in lst
			unless typeof val.isA is \function
				return "Expected typed values in the list. At least one of them was a(n) `#{typeof val}`."

			unless _.any val~isA, @_acceptableClasses
				return "Expected the typed values to be one of [#{@_acceptableClassIDs.join(', ')}]. But at least one of them is from `#{val.union?.__id}`"

		return

	serialize: (val) ->
		val.map (.serialize!) |> (.toArray!)

	deserialize: (val) ->
		unless _.isArrayLike val
			throw Error "Only arrays can be deserialized. `#{typeof val}` given."

		items = []
		:outer for v in val
			for cls in @_acceptableClasses
				try
					items.push cls.deserialize v
					continue outer

			throw Error "Cannot deserialize at least one of the values. It doesn't belong to [#{@_acceptableClassIDs.join(', ')}]."

		items