require! './Field'
{type} = require \ramda

module.exports = class ArrayOfTypeField extends Field
	->
		super ...arguments

		@_field = field \value, @def, @id, @unionCls

	_getValidationError: (lst) ->
		unless _.isArrayLike lst
			return "Expected a an array or list. `#{type lst}` given."

		for val, i in lst
			err = @_field._getValidationError(val)
			if typeof err is \string
				return err + " (In item[#i])"

		return

	serialize: (val) ->
		val.map (v) ~>
			@_field.serialize v

	deserialize: (val) ->
		unless _.isArrayLike val
			throw Error "Only arrays can be deserialized. `#{type val}` given."

		items = []
		for v, i in val
			try
				items.push @_field.deserialize v
				continue
			catch e

			throw Error "Cannot deserialize item[#i] in `#{@id}`: #{e.message}"

		items

require! {
	'ramda': _
	'../field'
}