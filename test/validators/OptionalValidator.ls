require! {
	'../../lib/shapely': {createValidator, optional}
}

o = it
describe "OptionalValidator", !->
	o "should be recognized", !->
		(-> createValidator optional(Number))
		.should.not.throw!

	describe "::isValid()", !->
		o "should validate matches", !->
			createValidator optional(Number)
			.isValid 12
			.should.equal true

		o "should validate nils", !->
			createValidator optional(Number)
			.isValid null
			.should.equal true

		o "should not validate non-matches", !->
			createValidator optional(Number)
			.isValid 'hello'
			.should.equal false

	describe "::getValidationResult()", !->
		o "should validate matches", !->
			createValidator optional(Number)
			.getValidationResult 12
			.should.be.like {isValid: 'true'}

		o "should validate nils", !->
			createValidator optional(Number)
			.getValidationResult undefined
			.should.be.like {isValid: 'true'}

		o "should only not validate non-matches", !->
			createValidator optional(Number)
			.getValidationResult 'hello'
				..isValid.should.equal \false
				..score.should.equal 0