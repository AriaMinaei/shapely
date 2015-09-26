require! './Typed'

module.exports =
	union: require './union'
	newtype: require './newtype'
	mapOf: require './mapOf'
	isTyped: -> &0 instanceof Typed