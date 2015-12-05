// @flow

import type {Validator} from '../validators/Validator'

export default function validate<T>(validator: Validator, val: T): T {
	const result = validator.getValidationResult(val);
	if (result.isValid === 'false') {
		throw Error(result.message);
	}
	return val;
}