module.exports = function union name, def
	unless isPlainObject def
		throw Error "Union's definition must be a plain object. #{typeof def} given."

	cls = createTypedClass name, Union

	cls.__constructors = {}
	cls.__constructorsById = {}

	if Object.keys(def).length is 0
		throw Error "Union definition must have at least one constructor."

	for constructor-name, constructor-def of def
		ct = newtype constructor-name, constructor-def, cls
		cls.__constructorsById[ct.__id] = ct
		cls[constructor-name] = cls.__constructors[constructor-name] = ct


	cls

require! {
	'lodash.isplainobject': isPlainObject
	'ramda': _
	'./helpers'
	'./union/Union'
	'./newtype'
	'./createTypedClass'
}