require! {
	'../Typed': Typed
}

module.exports = class Union extends Typed
	->
		throw Error "A Union's function cannot be called as a constructor."

	@isUnionClass = true

	@deserialize = (data) ->
		constructorId = data.__constructorId

		ctor = this.__constructorsById[constructorId]

		unless ctor?
			throw Error "Invalid constructorId '#{constructorId}' for union '#{this.name}'"

		ctor.deserialize data

