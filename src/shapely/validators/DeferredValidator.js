/* @flow */

import createValidator from '../createValidator';
import type {Validator} from './Validator';

export default class DeferredValidator {
	validator: Validator;
	deferredValidator: any;

	constructor(desc: mixed) {
		this.deferredValidator = desc;
	}

	isValid(val: mixed): boolean {
		return this._getValidator().isValid(val);
	}

	_getValidator(): Validator {
		if (!this.validator)
			this.validator = this.deferredValidator();

		return this.validator;
	}
}