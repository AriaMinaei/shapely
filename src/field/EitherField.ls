require! './Field'
{type} = require \ramda


module.exports = class EitherField extends Field
	->
		super ...arguments

		@_possibleFields = @def.map (def) ~>
			field \value, def, @id, @unionCls

	_getValidationError: (val) ->
		errors = []
		for field in @_possibleFields
			err = field._getValidationError val
			if typeof err is \string
				errors.push err
			else
				return void

		return "Value didn't match any of the possible fields. Errors: [" +
			errors.map((err) -> '"' + err + '"').join(', ') +
			"]"

	serialize: (val) ->
		for field in @_possibleFields
			if field.isValid val
				return field.serialize val

		throw Error "Cannot serialize value. None of the possible fields deem it valid."

	deserialize: (val) ->
		for field in @_possibleFields
			try
				r = field.deserialize val
				return r

		throw "Value cannot be deserialized by any of the possible fields"

require! {
	'ramda': _
	'../field'
}