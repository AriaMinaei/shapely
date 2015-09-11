require! {
	'../Typed': Typed
	'lodash.isplainobject': isPlainObject
}

module.exports = class Union extends Typed
	->
		throw Error "A Union's function cannot be called as a constructor."

	@isUnionClass = true

	@deserialize = (data) ->
		unless isPlainObject data
			throw Error "Cannot deserialize a non-plain-object. `#{typeof data}` given."

		constructorId = data.__constructorId
		ctor = this.__constructorsById[constructorId]
		unless ctor?
			throw Error "Invalid constructorId '#{constructorId}' for union '#{this.__name}'"

		ctor.deserialize data

	@cata = (v, pattern) ->
		unless v?.isA? this
			throw Error "Value is not a constructor of this union"

		if pattern[v.constructor.__name]?
			that v
		else
			throw Error "Pattern is not exhaustive. No case for `#{v.constructor.__name}`"