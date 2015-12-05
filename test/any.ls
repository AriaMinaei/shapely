require! {
	'../lib/shapely': {createValidator, any}
}

o = it
describe "anyValidator", ->
	o "should be recognized", ->
		(-> createValidator(any))
		.should.not.throw!

	describe "::isValid()", ->
		o "should validate any value", !->
			validator = createValidator any
			for value in [null, 1, \s, {}, [], new Date!, (->)]
				validator.isValid value
				.should.equal true

	describe "::getValidationResult()", ->
		o "should validate any value", ->
			validator = createValidator any
			for value in [null, 1, \s, {}, [], new Date!, (->)]
				validator.getValidationResult value
				.should.be.like {isValid: 'true'}