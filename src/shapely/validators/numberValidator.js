// @flow

const typeOf = require('ramda/src/type');

import type {ValidationResult} from "./ValidationResult";
import type {Validator} from "./Validator";

var numberValidator: Validator = {
	isValid: function(val: mixed): boolean {
		if (typeof val === 'number') {
			return true;
		} else {
			return false;
		}
	},

	getValidationResult: function(val: mixed): ValidationResult {
		if (numberValidator.isValid(val)) {
			return {
				isValid: 'true'
			};
		} else {
			return {
				isValid: 'false',
				message: `Number expected. '${typeOf(val)}' received.`
			};
		}
	}
};

export default numberValidator;