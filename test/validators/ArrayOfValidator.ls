require! {
	'../../lib/shapely': {createValidator, arrayOf}
}

o = it
describe "ArrayOfValidator", !->
	o "should be recognized", !->
		(-> createValidator arrayOf(Number))
		.should.not.throw!

	describe "::isValid()", !->
		validator = null
		beforeEach ->
			validator := createValidator arrayOf(Number)

		o "should validate empty arrays", !->
			validator
			.isValid []
			.should.equal true

		o "should validate correct arrays", !->
			validator
			.isValid [1, 2, 3]
			.should.equal true

		o "should only validate correct arrays", !->
			validator
			.isValid [1, 2, 'hello']
			.should.equal false

		o "should only validate arrays", !->
			validator
			.isValid 12
			.should.equal false

	describe "::getValidationResult()", !->
		validator = null
		beforeEach ->
			validator := createValidator arrayOf(Number)

		o "should validate empty arrays", !->
			validator
			.getValidationResult []
			.should.be.like {isValid: 'true'}

		o "should validate correct arrays", !->
			validator
			.getValidationResult [1, 2, 3]
			.should.be.like {isValid: 'true'}

		o "should only validate correct arrays", !->
			validator
			.getValidationResult [1, 2, 'hello']
				..isValid.should.equal \false
				..score.should.equal 1

		o "should only validate arrays", !->
			validator
			.getValidationResult 12
				..isValid.should.equal \false
				..score.should.equal 0