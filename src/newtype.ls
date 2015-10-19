module.exports = function newtype name, def, union-cls
	switch
	| not def?
		nullType name, def, union-cls

	| isPlainObject def =>
		if _.all (.0.match(/^[A-Z]{1}$/)?), Object.keys(def)
			throw Error "Unimplemented"
		else if _.all (.0.match(/^[a-z]{1}$/)?), Object.keys(def)
			record name, def, union-cls

	# | Array.isArray def =>
	# 	console.log name, def, union-cls
	# 	array name, def, union-cls

	| otherwise =>
		wrapper name, def, union-cls

require! {
	'./record' './wrapper' './nullType'
	'lodash.isplainobject': isPlainObject
	'ramda': _
}