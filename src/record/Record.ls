require! {
	'../Typed': Typed
	'immutable': {fromJS: imm}
}

module.exports = class Record extends Typed
	(val) ->
		val = imm val

		container = imm({}).asMutable()

		for key, field of @constructor.__fields
			container.set key, field.create val.get(key)

		@_container = container.asImmutable()

	get: (key) -> @_container.get key

	isA: (cls) ->
		@constructor.union is cls or this instanceof cls

	serialize: ->
		val = {}

		for key, field of @constructor.__fields
			val[key] = field.serialize @_container.get(key)

		val.__constructorId = @constructor.__id

		val

	@deserialize = (val) ->
		container = imm({}).asMutable()

		for key, field of @__fields
			container.set key, field.deserialize val[key]

		new this container.asImmutable!