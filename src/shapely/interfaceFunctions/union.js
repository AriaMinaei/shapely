// @flow

import UnionValidator from '../validators/UnionValidator';

export default function union(...variants:Array<mixed>): UnionValidator {
  return new UnionValidator(variants);
}