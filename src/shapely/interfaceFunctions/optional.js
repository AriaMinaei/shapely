// @flow

import OptionalValidator from '../validators/OptionalValidator';

export default function optional(desc: mixed): OptionalValidator {
	return new OptionalValidator(desc);
}