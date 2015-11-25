/* @flow */
const typeOf = require('ramda/src/type');

import createValidator from '../createValidator';
import type {ValidationResult} from './ValidationResult';
import type {Validator} from './Validator';

export default class MapOfValidator {
	validator: Validator;

	constructor(desc: mixed) {
		this.validator = createValidator(desc);
	}

	isValid(val: mixed): boolean {
		if (!(typeof val === 'object' && val))
			return false;

		const keys = Object.keys(val);
		for (let key of keys) {
			let keyVal = val[key];
			if (this.validator.isValid(keyVal) === false)
				return false;
		}

		return true;
	}

	getValidationResult(val: mixed): ValidationResult {
		if (!(typeof val === 'object' && val))
			return {
				isValid: 'false',
				message: `Object expected. ${typeOf(val)} given.`,
				score: 0
			}

		const keys = Object.keys(val);
		for (let key of keys) {
			let keyVal = val[key];
			let result = this.validator.getValidationResult(keyVal);
			if (result.isValid === 'false') {
				return {
					isValid: 'false',
					message: `Validation failed for key '${key}': ${result.message}`,
					score: 1
				}
			}
		}

		return {isValid: 'true'}
	}
}