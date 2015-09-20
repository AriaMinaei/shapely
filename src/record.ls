require! {
	'./record/Record'
	'lodash.isplainobject': isPlainObject
	'ramda': _
	'./helpers'
	'./field'
	'./createTypedClass'
}

module.exports = function record name, def, union-cls
	unless isPlainObject def
		throw Error "A record's definition must either be null or a plain object. `#{typeof def}` given."

	cls = createTypedClass name, Record, union-cls

	cls.__fields = {}
	for let key, val of def
		cls.__fields[key] = field key, val, cls.__id

	keys = Object.keys cls.__fields

	cls