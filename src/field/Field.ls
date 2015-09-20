module.exports = class Field
	(@id, @def) ->
		@__id = @id

	create: (val) ->
		@validate val
		val

	_isValid: -> true

	validate: (val) ->
		err = @_isValid val

		if typeof err is 'string'
			throw Error "Error validating `#{@__id}`: #{err}"

	deserialize: (v) ->
		v

	serialize: (v) ->
		v