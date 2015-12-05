// @flow

import createValidator from '../createValidator'

export default function validate(validationDescriptor: mixed, val: mixed): boolean {
	const validator = createValidator(validationDescriptor);
	return validator.isValid(val);
}