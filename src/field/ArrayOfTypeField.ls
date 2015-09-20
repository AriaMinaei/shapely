require! './Field'

module.exports = class ArrayOfTypeField extends Field
	->
		super ...arguments

		@_field = field \value, @def.0, @id

	_isValid: (lst) ->
		unless _.isArrayLike lst
			return "Expected a an array or list. `#{typeof lst}` given."

		for val, i in lst
			if @_field._isValid(val)?
				return that + " (In itemm['#i'])"

		return

	serialize: (val) ->
		val.map (v) ~>
			@_field.serialize v

	deserialize: (val) ->
		unless _.isArrayLike val
			throw Error "Only arrays can be deserialized. `#{typeof val}` given."

		items = []
		for v, i in val
			try
				items.push @_field.deserialize v
				continue
			catch e

			throw Error "Cannot deserialize item[#i] in @id: #{e.message}"

		items

require! {
	'ramda': _
	'../field'
}