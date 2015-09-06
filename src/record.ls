require! {
	'./record/Record'
	'lodash.isPlainObject': isPlainObject
	'ramda': _
	'./helpers'
	'./field'
}

module.exports = function record name, def, union-cls
	helpers.validate-type-name$ name

	unless isPlainObject def
		throw Error "A record's definition must either be null or a plain object. `#{typeof def}` given."

	eval "
		var cls = function #{name}(data){
			if (!(this instanceof Record)) {
				return new cls(data);
			}
			this.constructor = cls;
			return Record.apply(this, arguments);
		}
	"
	cls:: = Object.create Record::
	cls <<< Record
	cls.name = name
	cls.union = union-cls
	cls.__id = if union-cls?
		union-cls.name + '.' + name
	else
		name

	cls.__fields = {}
	for let key, val of def
		cls.__fields[key] = field key, val, cls
		# Object.defineProperty cls::, key, get: -> @_container.get key

	keys = Object.keys cls.__fields

	cls