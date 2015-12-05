// @flow

import typeOf from 'ramda/src/type';
import createValidator from '../createValidator';
import type {ValidationResult} from './ValidationResult'
import type {Validator} from './Validator';

export default class DeferredValidator {
	validator: Validator;
	deferredValidator: any;

	/**
	 * DeferredValidator is useful for defining recursive types. It also
	 * works in cases where you want to define a dependency on a type
	 * that's not yet defined.
	 *
	 * Example:
	 * 	import {union, record, deferred, nil} from 'shapely';
	 * 	const Tree = union(
	 * 		nil,
	 * 		record({
	 * 			kind: 'leaf', value: Number
	 * 		}),
	 * 		record({
	 * 			kind: 'node', left: deferred(=> Tree), right: deferred(=> Tree)
	 * 		})
	 * 	);
	 */
	constructor(desc: mixed) {
		if (typeof desc !== 'function') {
			throw Error(`Deferred validator only accepts a function. ${typeOf(desc)} given`);
		}
		this.deferredValidator = desc;
	}

	isValid(val: mixed): boolean {
		return this._getValidator().isValid(val);
	}

	getValidationResult(val: mixed): ValidationResult {
		return this._getValidator().getValidationResult(val);
	}

	_getValidator(): Validator {
		if (!this.validator)
			this.validator = this.deferredValidator();

		return this.validator;
	}
}