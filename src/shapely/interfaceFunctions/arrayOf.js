// @flow

import ArrayOfValidator from '../validators/ArrayOfValidator';

export default function arrayOf(desc: mixed): ArrayOfValidator {
  return new ArrayOfValidator(desc);
}