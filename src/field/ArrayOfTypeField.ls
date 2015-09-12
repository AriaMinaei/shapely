require! {
	'./Field': Field
	'ramda': _
}

module.exports = class ArrayOfTypeField extends Field
	->
		super ...arguments

		@_acceptableClass = @def.0
		@_acceptableClassID = @_acceptableClass.__id

	_isValid: (lst) ->
		unless _.isArrayLike lst
			return "Expected a an array or list. `#{typeof lst}` given."

		for val, i in lst
			unless val? and typeof val.isA is \function
				return "Expected typed values in the list. Item[#i] is a(n) `#{typeof val}`."

			unless val.isA @_acceptableClass
				return "Expected the typed values to be one an `#@_acceptableClassID`. But item[#i] is from `#{val.union?.__id}`"

		return

	serialize: (val) ->
		val.map (.serialize!)

	deserialize: (val) ->
		unless _.isArrayLike val
			throw Error "Only arrays can be deserialized. `#{typeof val}` given."

		items = []
		for v, i in val
			try
				items.push @_acceptableClass.deserialize v
				continue

			throw Error "Cannot deserialize item[#i]. It doesn't belong to `#@_acceptableClassID`."

		items