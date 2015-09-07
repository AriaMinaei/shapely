require! {
	'./helpers'
}

module.exports = function createTypedClass name, superClass, union-cls
	helpers.validate-type-name$ name

	eval "
		var cls = function #{name}(data){
			if (!(this instanceof superClass)) {
				return new cls(data);
			}
			this.constructor = cls;
			return superClass.apply(this, arguments);
		}
	"
	cls:: = Object.create superClass::
	cls <<< superClass

	cls.name = name
	cls.union = union-cls
	cls.__id = if union-cls?
		union-cls.name + '.' + name
	else
		name

	cls