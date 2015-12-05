// @flow

import type {Validator} from './validators/Validator';

import stringValidator from './validators/stringValidator';
import numberValidator from './validators/numberValidator';
import booleanValidator from './validators/booleanValidator';
import UnionValidator from './validators/UnionValidator';
import ExactValueValidator from './validators/ExactValueValidator';

/**
 * Takes the descriptor of a Validator and returns the Validator.
 * Examples:
 * 	createValidator(String) // returns stringValidator
 * 	createValidator('hello') // returns ExactValueValidator<'hello'>
 * 	createValidator(createValidator(String)) // returns the same stringValidator
 *
 * @throws {Error} If the descriptor is unrecognized.
 */
export default function createValidator(desc: mixed): Validator {
	if (desc == null)
		throw Error('Null cannot be a valid validation descriptor');

	if (desc === String) {
		return stringValidator;
	} else if (desc === Number) {
		return numberValidator;
	} else if (desc === Boolean) {
		return booleanValidator;
	} else if (
		typeof desc === 'object' &&
		desc &&
		typeof desc.isValid === 'function' &&
		typeof desc.getValidationResult === 'function'
		) {
		return desc;
	} else if (typeof desc === 'string' || typeof desc === 'number' || typeof desc === 'boolean') {
		return new ExactValueValidator(desc);
	} else {
		throw new Error(`Can't recognize this descriptor: ${desc}`);
	}
}