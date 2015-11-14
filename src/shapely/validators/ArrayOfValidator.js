/* @flow */

import createValidator from '../createValidator';
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
}