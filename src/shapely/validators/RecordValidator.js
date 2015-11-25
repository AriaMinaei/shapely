/* @flow */

import createValidator from '../createValidator';
import type {Validator} from './Validator';
import type {ValidationResult} from './ValidationResult';
const typeOf = require('ramda/src/type');


export default class RecordValidator {
	shape: {[key: mixed]: Validator};

	constructor(desc: mixed) {
		if (!(typeof desc === 'object' && desc))
			throw Error(`A record must be defined by an object.`);

		this.shape = {};
		for (let propName of Object.getOwnPropertyNames(desc)) {
			try {
				this.shape[propName] = createValidator(desc[propName]);
			} catch (e) {
				let propertyName = propName;
				let stack = e.stack;
				if (e.originalStack) {
					stack = e.originalStack;
					propertyName += '.' + e.propertyName;
					e.propertyName = propertyName;
				} else {
					e.originalStack = e.stack;
				}
				e.stack = `Error defining prop \'${propertyName}': ${e.originalStack}`
				throw e;
			}
		}
	}

	isValid(val: mixed): boolean {
		if (!(typeof val === 'object' && val))
			return false;

		for (let key of Object.keys(this.shape)) {
			let validator = this.shape[key];
			if (validator.isValid(val[key]) === false)
				return false;
		}

		return true;
	}

	getValidationResult(val: mixed): ValidationResult {
		if (!(typeof val === 'object' && val))
			return {
				isValid: 'false',
				message: `Object expected. ${typeOf(val)}`,
				score: 0
			}

		var numberOfPropsCounted = 0
		for (let key of Object.keys(this.shape)) {
			let validator = this.shape[key];
			let result = validator.getValidationResult(val[key]);
			if (result.isValid == 'false') {
				return {
					isValid: 'false',
					message: `Error validating prop ${key}:\n ${result.message}`,
					score: 1 + numberOfPropsCounted
				}
			}
			numberOfPropsCounted++;
		}

		return {
			isValid: 'true'
		}
	}
}