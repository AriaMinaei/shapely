/* @flow */

import createValidator from '../createValidator';
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
}