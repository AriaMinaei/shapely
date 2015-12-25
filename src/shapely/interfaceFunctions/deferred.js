// @flow

import DeferredValidator from '../validators/DeferredValidator';

export default function deferred(desc: mixed): DeferredValidator {
  return new DeferredValidator(desc);
}