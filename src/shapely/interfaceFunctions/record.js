// @flow

import RecordValidator from '../validators/RecordValidator';

export default function record(desc: mixed): RecordValidator {
  return new RecordValidator(desc);
}