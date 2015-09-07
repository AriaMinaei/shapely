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
	# cls <<< superClass
	for own key, prop of superClass
		if prop? and typeof prop.bind is \function
			cls[key] = prop.bind cls
		else
			cls[key] = prop

	cls.__name = name
	cls.union = union-cls
	cls.__id = if union-cls?
		union-cls.__name + '.' + name
	else
		name

	cls