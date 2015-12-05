require! {
	'../lib/shapely': {createValidator, nil}
}

o = it
describe "nilValidator", ->
	o "should be recognized", ->
		(-> createValidator(nil))
		.should.not.throw!

	describe "::isValid()", ->
		o "should validate null", ->
			createValidator nil
			.isValid null
			.should.equal true

		o "should validate undefined", ->
			createValidator nil
			.isValid undefined
			.should.equal true

		o "should only validate nil values", ->
			createValidator nil
			.isValid 'hello'
			.should.equal false

	describe "::getValidationResult()", ->
		o "should validate null", ->
			createValidator nil
			.getValidationResult null
			.should.be.like {isValid: 'true'}

		o "should validate undefined", ->
			createValidator nil
			.getValidationResult undefined
			.should.be.like {isValid: 'true'}

		o "should only validate nil values", ->
			createValidator nil
			.getValidationResult 'hello'
				..isValid.should.equal \false
				..score.should.equal 0