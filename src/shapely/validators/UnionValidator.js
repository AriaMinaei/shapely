/* @flow */

import createValidator from '../createValidator';
import type {Validator} from './Validator';
import type {ValidationResult} from './ValidationResult';

export default class UnionValidator {
	validators: Array<Validator>;

	constructor(variants: Array<mixed>) {
		this.validators = [];
		for (let variant of variants) {
			this.validators.push(createValidator(variant));
		}
	}

	isValid(val: mixed): boolean {
		for (let validator of this.validators) {
			if (validator.isValid(val)) return true;
		}
		return false;
	}

	getValidationResult(val: mixed): ValidationResult {
		if (this.isValid(val)) {
			return {
				isValid: 'true'
			}
		} else {
			return {
				isValid: 'false',
				message: 'Value doesn\'t match any of the expected variants.'
			}
		}
	}

	validate(val: mixed): mixed {
		const validationResult = this.getValidationResult(val);
		if (validationResult.isValid === 'false') {
			throw new Error(validationResult.message);
		}
	}
}