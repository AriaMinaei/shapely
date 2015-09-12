module.exports = class Field
	(@name, @def, @wrapper-cls) ->
		@__id = @wrapper-cls.__id + '.' + @name

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