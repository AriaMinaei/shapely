// @flow
import type {ValidationResult} from "./ValidationResult";

export type Validator = {
	isValid (val: mixed): boolean;
	getValidationResult (val: mixed): ValidationResult;
}