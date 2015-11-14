/* @flow */

import createValidator from '../createValidator';
import type {Validator} from './Validator';

export default class UnionValidator {
	validators: Array<Validator>;

	constructor(variants: Array<mixed>) {
		this.validators = [];
		for (let variant of variants) {
			this.validators.push(createValidator(variant));
		}
	}

	isValid(val: mixed): boolean {
		for (let validator of this.validators) {
			if (validator.isValid(val)) return true;
		}
		return false;
	}
}