// @flow

import MapOfValidator from '../validators/MapOfValidator';

export default function mapOf(desc: mixed): MapOfValidator {
	return new MapOfValidator(desc);
}