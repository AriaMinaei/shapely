require! {
	'../Typed': Typed
	'immutable': {fromJS: imm}
}

module.exports = class Record extends Typed
	_construct: (val) ->
		val = imm val

		container = imm({}).asMutable()

		for key, field of @constructor.__fields
			container.set key, field.create val.get(key)

		@_container = container.asImmutable()

	get: (key) -> @_container.get key

	_serialize: (val) ->
		for key, field of @constructor.__fields
			val[key] = field.serialize @_container.get(key)

		val

	@_deserialize = (val) ->
		data = {}

		for key, field of @__fields
			data[key] = field.deserialize val[key]

		new this data