/* @flow */

import createValidator from '../createValidator';
import type {Validator} from './Validator';

export default class ExactValueValidator {
	expectedValue: mixed;

	constructor(desc: mixed) {
		this.expectedValue = desc;
	}

	isValid(val: mixed): boolean {
		return val === this.expectedValue;
	}
}