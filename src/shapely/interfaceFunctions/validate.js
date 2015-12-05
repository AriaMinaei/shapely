// @flow

import type {Validator} from '../validators/Validator'
import createValidator from '../createValidator'

export default function validate<T>(validationDescriptor: mixed, val: T): T {
	const validator = createValidator(validationDescriptor);
	const result = validator.getValidationResult(val);
	if (result.isValid === 'false') {
		throw Error(result.message);
	}
	return val;
}