/* @flow */
const typeOf = require('ramda/src/type');

import createValidator from '../createValidator';
import type {ValidationResult} from './ValidationResult'
import type {Validator} from './Validator';

export default class ArrayOfValidator {
	validator: Validator;

	constructor(desc: mixed) {
		this.validator = createValidator(desc);
	}

	isValid(val: mixed): boolean {
		if (!(Array.isArray(val)))
			return false;

		for (let keyVal of val) {
			if (this.validator.isValid(keyVal) === false)
				return false;
		}

		return true;
	}

	getValidationResult(val: mixed): ValidationResult {
		if (!(Array.isArray(val)))
			return {
				isValid: 'false',
				message: `Array expected. ${typeOf(val)} given.`,
				score: 0
			}

		for (let i = 0; i < val.length; i++) {
			let keyVal = val[i];
			let result = this.validator.getValidationResult(keyVal);
			if (result.isValid === 'false') {
				return {
					isValid: 'false',
					message: `Validation failed on item #${i}: ${result.message}`,
					score: 1
				}
			}
		}

		return {isValid: 'true'}
	}
}