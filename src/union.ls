module.exports = function union name, def
	helpers.validate-type-name$ name

	unless isPlainObject def
		throw Error "Union's definition must be a plain object. #{typeof def} given."

	eval "
		var cls = function #{name}(){
			return Union.apply(this, arguments);
		};
	"
	cls.name = name
	cls.__id = name
	cls.__constructors = {}
	cls.__constructorsById = {}
	cls:: = Object.create Union::
	cls <<< Union

	if Object.keys(def).length is 0
		throw Error "Union definition must have at least one constructor."

	for constructor-name, constructor-def of def
		ct = newtype constructor-name, constructor-def, cls
		cls.__constructorsById[ct.__id] = ct
		cls[constructor-name] = cls.__constructors[constructor-name] = ct


	cls

require! {
	'lodash.isPlainObject': isPlainObject
	'ramda': _
	'./helpers'
	'./union/Union'
	'./newtype'
}