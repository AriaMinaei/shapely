require! {
	'./wrapper/Wrapper'
	'lodash.isplainobject': isPlainObject
	'ramda': _
	'./field'
	'./createTypedClass'
}

module.exports = function wrapper name, def, union-cls
	cls = createTypedClass name, Wrapper, union-cls

	cls.__field = field 'value', def, cls

	cls