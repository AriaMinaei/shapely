// @flow

const typeOf = require('ramda/src/type');

import type {ValidationResult} from "./ValidationResult";
import type {Validator} from "./Validator";

var booleanValidator: Validator = {
	isValid: function(val: mixed): boolean {
		if (typeof val === 'boolean') {
			return true;
		} else {
			return false;
		}
	},

	getValidationResult: function(val: mixed): ValidationResult {
		if (booleanValidator.isValid(val)) {
			return {
				isValid: true
			};
		} else {
			return {
				isValid: false,
				expected: 'boolean',
				actual: typeOf(val)
			};
		}
	}
};

export default booleanValidator;