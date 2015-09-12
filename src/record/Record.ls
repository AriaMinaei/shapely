require! {
	'../Typed': Typed
	'lodash.isplainobject': isPlainObject
}

module.exports = class Record extends Typed
	_construct: (val) ->
		unless isPlainObject val
			throw Error "Cannot construct a record `#{@constructor.__id}` from a non-object '#{val}'"

		container = {}

		for key, field of @constructor.__fields
			container[key] = field.create val[key]

		@_container = container

	get: (key) ->
		unless key?
			@_container
		else
			@_container[key]

	_serialize: (val) ->
		for key, field of @constructor.__fields
			val[key] = field.serialize @_container[key]

		val

	@_deserialize = (val) ->
		data = {}

		for key, field of @__fields
			data[key] = field.deserialize val[key]

		new this data