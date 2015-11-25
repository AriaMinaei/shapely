// @flow

const typeOf = require('ramda/src/type');

import type {ValidationResult} from "./ValidationResult";
import type {Validator} from "./Validator";

var nilValidator: Validator = {
	isValid: function(val: mixed): boolean {
		return val === null || val === undefined;
	},

	getValidationResult: function(val: mixed): ValidationResult {
		if (nilValidator.isValid(val)) {
			return {
				isValid: 'true'
			}
		} else {
			return {
				isValid: 'false',
				message: `Null expected. ${typeOf(val)} given.`,
				score: 0
			}
		}
	}
};

export default nilValidator;