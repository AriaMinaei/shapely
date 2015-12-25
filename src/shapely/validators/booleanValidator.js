// @flow

import typeOf from 'ramda/src/type';
import type {ValidationResult} from "./ValidationResult";
import type {Validator} from "./Validator";

var booleanValidator: Validator = {
  isValid: function(val: mixed): boolean {
    if (typeof val === 'boolean') {
      return true;
    } else {
      return false;
    }
  },

  getValidationResult: function(val: mixed): ValidationResult {
    if (booleanValidator.isValid(val)) {
      return {
        isValid: 'true'
      };
    } else {
      return {
        isValid: 'false',
        message: `Boolean expected. ${typeOf(val)} given.`,
        score: 0
      };
    }
  }
};

export default booleanValidator;