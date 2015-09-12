require! {
	'../Typed': Typed
}

module.exports = class Wrapper extends Typed
	_construct: (val) ->
		@_container = @constructor.__field.create val

	get: -> @_container

	_serialize: (val) ->
		val.field = @constructor.__field.serialize @_container
		val

	@_deserialize = (data) ->
		new this @__field.deserialize data.field