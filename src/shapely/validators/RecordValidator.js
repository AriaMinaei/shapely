/* @flow */

import createValidator from '../createValidator';
import type {Validator} from './Validator';

export default class RecordValidator {
	shape: {[key: mixed]: Validator};

	constructor(desc: mixed) {
		if (!(typeof desc === 'object' && desc))
			throw Error(`A record must be defined by an object.`);

		this.shape = {};
		for (let propName of Object.getOwnPropertyNames(desc)) {
			this.shape[propName] = createValidator(desc[propName]);
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
}