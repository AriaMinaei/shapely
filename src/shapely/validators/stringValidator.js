// @flow

const typeOf = require('ramda/src/type');

import type {ValidationResult} from "./ValidationResult";
import type {Validator} from "./Validator";

var stringValidator: Validator = {
	isValid: function(val: mixed): boolean {
		if (typeof val === 'string') {
			return true;
		} else {
			return false;
		}
	},

	getValidationResult: function(val: mixed): ValidationResult {
		if (stringValidator.isValid(val)) {
			return {
				isValid: 'true'
			};
		} else {
			return {
				isValid: 'false',
				message: `String expected. '${typeOf(val)}' received.`
			};
		}
	}
};

export default stringValidator;