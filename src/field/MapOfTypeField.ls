require! './Field'

module.exports = class MapOfTypeField extends Field
	->
		super ...arguments

		@_field = field \value, @def.1, @id

		# @_acceptableClass = @def.1
		# @_acceptableClassID = @_acceptableClass.__id

	_isValid: (obj) ->
		unless isPlainObject obj
			return "Expected a plain object. `#{typeof obj}` given."

		for key, val of obj
			err = @_field._isValid(val)
			if typeof err is \string
				return that + " (In itemm['#key'])"

		return

	serialize: (obj) ->
		s = {}
		for key, v of obj
			s[key] = @_field.serialize v
		s

	deserialize: (obj) ->
		unless isPlainObject obj
			throw Error "Only objects can be deserialized. `#{typeof obj}` given."

		items = {}
		for k, v of obj
			try
				items[k] = @_field.deserialize v
				continue
			catch e

			throw Error "Cannot deserialize item['#k'] in `#{@id}`: #{e.message}"

		items

require! {
	'ramda': _
	'lodash.isplainobject': isPlainObject
	'../field'
}