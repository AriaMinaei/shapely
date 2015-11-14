/* @flow */

export type ValidationResult =
	{isValid: true} |
	{isValid: false, expected: string, actual: string}