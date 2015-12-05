// @flow

import createValidator from '../createValidator';
import type {ValidationResult} from "./ValidationResult";
import type {Validator} from './Validator';

export default class OptionalValidator {
	validator: Validator;

	constructor(desc: mixed) {
		this.validator = createValidator(desc);
	}

	isValid(val: mixed): boolean {
		if (!(val))
			return true;

		return this.validator.isValid(val);
	}

	getValidationResult(val: mixed): ValidationResult {
		if (!(val))
			return {
				isValid: 'true'
			}

		return this.validator.getValidationResult(val);
	}
}