/* @flow */

import createValidator from '../createValidator';
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
}