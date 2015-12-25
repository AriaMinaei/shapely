// @flow

import typeOf from 'ramda/src/type';
import type {ValidationResult} from "./ValidationResult";
import type {Validator} from "./Validator";

var anyValidator: Validator = {
  isValid: function(val: mixed): boolean {
    return true;
  },

  getValidationResult: function(val: mixed): ValidationResult {
    return {
      isValid: 'true'
    }
  },
};

export default anyValidator;