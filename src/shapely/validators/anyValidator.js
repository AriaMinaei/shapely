// @flow

const typeOf = require('ramda/src/type');

import type {ValidationResult} from "./ValidationResult";
import type {Validator} from "./Validator";

var anyValidator: Validator = {
	isValid: function(val: mixed): boolean {
		return true;
	},

	getValidationResult: function(val: mixed): ValidationResult {
		return {
			isValid: 'true'
		}
	},

	validate: function(val: mixed): any {}
};

export default anyValidator;