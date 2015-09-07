require! {
	'../Typed': Typed
}

module.exports = class Wrapper extends Typed
	_construct: ->

	get: -> void

	_serialize: ->

	@_deserialize = (val) ->
		new this val