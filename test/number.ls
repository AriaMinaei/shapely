require! {
	'../lib/shapely': {createValidator}
}

o = it
describe "numberValidator", ->
	o "should be recognized", ->
		(-> createValidator(Number))
		.should.not.throw!

	describe "::isValid()", ->
		o "should validate numbers", ->
			createValidator Number
			.isValid 12
			.should.equal true

		o "should only validate numbers", ->
			createValidator Number
			.isValid 'hello'
			.should.equal false

	describe "::getValidationResult()", ->
		o "should validate numbers", ->
			createValidator Number
			.getValidationResult 12
			.should.be.like {isValid: 'true'}

		o "should only validate numbers", ->
			createValidator Number
			.getValidationResult 'hello'
				..isValid.should.equal \false
				..score.should.equal 0