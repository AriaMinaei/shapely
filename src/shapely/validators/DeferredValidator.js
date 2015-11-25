/* @flow */

const typeOf = require('ramda/src/type');

import createValidator from '../createValidator';
import type {ValidationResult} from './ValidationResult'
import type {Validator} from './Validator';

export default class DeferredValidator {
	validator: Validator;
	deferredValidator: any;

	constructor(desc: mixed) {
		if (typeof desc !== 'function') {
			throw Error(`Deferred validator only accepts a function. ${typeOf(desc)} given`);
		}
		this.deferredValidator = desc;
	}

	isValid(val: mixed): boolean {
		return this._getValidator().isValid(val);
	}

	getValidationResult(val: mixed): ValidationResult {
		return this._getValidator().getValidationResult(val);
	}

	_getValidator(): Validator {
		if (!this.validator)
			this.validator = this.deferredValidator();

		return this.validator;
	}
}