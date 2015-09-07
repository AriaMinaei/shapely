require! {
	'../Typed': Typed
	'immutable': {fromJS: imm}
}

module.exports = class Wrapper extends Typed
	_construct: (val) ->
		@_container = imm @constructor.__field.create val

	get: -> @_container

	isA: (cls) ->
		@constructor.union is cls or this instanceof cls

	_serialize: (val) ->
		val.field = @constructor.__field.serialize @_container
		val

	@_deserialize = (data) ->
		new this data.field