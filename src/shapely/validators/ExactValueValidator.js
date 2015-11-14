/* @flow */

import createValidator from '../createValidator';
import type {Validator} from './Validator';
import type {ValidationResult} from './ValidationResult';

export default class ExactValueValidator {
	expectedValue: mixed;

	constructor(desc: mixed) {
		this.expectedValue = desc;
	}

	isValid(val: mixed): boolean {
		return val === this.expectedValue;
	}

	getValidationResult(val: mixed): ValidationResult {
		if (this.isValid(val)) {
			return {
				isValid: 'true'
			}
		} else {
			return {
				isValid: 'false',
				message: `Expected: ${JSON.stringify(this.expectedValue)}. Received: ${JSON.stringify(val)}`
			}
		}
	}
}