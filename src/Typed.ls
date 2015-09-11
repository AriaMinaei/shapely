module.exports = class Typed
	(val) ->
		if val instanceof @constructor then return val

		@_construct val

	@isTypedClass = yes
	isTypedClass: yes

	isA: (cls) ->
		@constructor.union is cls or this instanceof cls

	@isValueAnInstance = (v) ->
		(v? and v?isA?(this)) is yes

	@ensureInstance = (v) ->
		unless @isValueAnInstance v
			throw Error "Expected a typed class, instance of `#{this.__id}`"

		v

	@deserialize = (data) ->
		constructorId = data.__constructorId
		if constructorId isnt this.__id
			throw Error "Cannot deserialize object. Doesn't belong to `#{this.__id}`"

		@_deserialize data

	serialize: ->
		val = {}
		val.__constructorId = @constructor.__id
		@_serialize val
		val

	cata: (d) ->
		d[@constructor.__name](@get!)