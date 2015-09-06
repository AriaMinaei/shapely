require! {
	'../Typed': Typed
	'immutable': {fromJS: imm}
}

module.exports = class Wrapper extends Typed
	(val) ->
		@_container = imm @constructor.__field.create val

	get: -> @_container

	isA: (cls) ->
		@constructor.union is cls or this instanceof cls

	serialize: ->
		val = {}

		val.field = @constructor.__fields.serialize @_container

		val.__constructorId = @constructor.__id

		val

	@deserialize = (val) ->
		container = imm({}).asMutable()

		for key, field of @__fields
			container.set key, field.deserialize val[key]

		new this container