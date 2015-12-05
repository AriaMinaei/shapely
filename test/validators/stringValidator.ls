require! {
	'../../lib/shapely': {createValidator}
}

o = it
describe "stringValidator", ->
	o "should be recognized", ->
		(-> createValidator(String))
		.should.not.throw!

	describe "::isValid()", ->
		o "should validate strings", ->
			createValidator String
			.isValid 'hello'
			.should.equal true

		o "should only validate strings", ->
			createValidator String
			.isValid 12
			.should.equal false

	describe "::getValidationResult()", ->
		o "should validate strings", ->
			createValidator String
			.getValidationResult 'hello'
			.should.be.like {isValid: 'true'}

		o "should only validate strings", ->
			createValidator String
			.getValidationResult 12
				..isValid.should.equal \false
				..score.should.equal 0