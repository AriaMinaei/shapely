require! {
	'./wrapper/Wrapper'
	'lodash.isPlainObject': isPlainObject
	'ramda': _
	'./helpers'
	'./field'
}

module.exports = function wrapper name, def, union-cls
	helpers.validate-type-name$ name

	eval "
		var cls = function #{name}(data){
			if (!(this instanceof Wrapper)) {
				return new cls(data);
			}
			this.constructor = cls;
			return Wrapper.apply(this, arguments);
		}
	"
	cls:: = Object.create Wrapper::
	cls <<< Wrapper
	cls.name = name
	cls.union = union-cls
	cls.__id = if union-cls?
		union-cls.name + '.' + name
	else
		name

	cls.__field = field 'value', def, cls

	cls