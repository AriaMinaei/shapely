require! {
	'./nullType/NullType'
	'lodash.isplainobject': isPlainObject
	'ramda': _
	'./helpers'
}

module.exports = function wrapper name, def, union-cls
	helpers.validate-type-name$ name

	eval "
		var cls = function #{name}(data){
			if (!(this instanceof NullType)) {
				return new cls(data);
			}
			this.constructor = cls;
			return NullType.apply(this, arguments);
		}
	"
	cls:: = Object.create NullType::
	cls <<< NullType
	cls.__name = name
	cls.union = union-cls
	cls.__id = if union-cls?
		union-cls.__name + '.' + name
	else
		name

	cls