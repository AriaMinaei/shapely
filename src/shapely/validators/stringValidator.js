// @flow

import typeOf from 'ramda/src/type';
import type {ValidationResult} from "./ValidationResult";
import type {Validator} from "./Validator";

var stringValidator: Validator = {
  isValid: function(val: mixed): boolean {
    if (typeof val === 'string') {
      return true;
    } else {
      return false;
    }
  },

  getValidationResult: function(val: mixed): ValidationResult {
    if (stringValidator.isValid(val)) {
      return {
        isValid: 'true'
      };
    } else {
      return {
        isValid: 'false',
        message: `String expected, ${typeOf(val)} given.`,
        score: 0
      };
    }
  }
};

export default stringValidator;