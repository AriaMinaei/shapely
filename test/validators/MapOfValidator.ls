require! {
	'../../lib/shapely': {createValidator, mapOf}
}

o = it
describe "MapOfValidator", ->
	o "should be recognized", ->
		(-> createValidator mapOf(Number))
		.should.not.throw!

	describe "::isValid()", ->
		validator = null
		beforeEach ->
			validator := createValidator mapOf(Number)

		o "should validate empty objects", ->
			validator
			.isValid {}
			.should.equal true

		o "should validate correct objects", ->
			validator
			.isValid {a: 1, b: 2}
			.should.equal true

		o "should only validate correct objects", ->
			validator
			.isValid {a: 1, b: 'hello'}
			.should.equal false

		o "should only validate objects", ->
			validator
			.isValid 12
			.should.equal false

	describe "::getValidationResult()", ->
		validator = null
		beforeEach ->
			validator := createValidator mapOf(Number)

		o "should validate empty objects", ->
			validator
			.getValidationResult {}
			.should.be.like {isValid: 'true'}

		o "should validate correct objects", ->
			validator
			.getValidationResult {a: 1, b: 2}
			.should.be.like {isValid: 'true'}

		o "should only validate correct objects", ->
			validator
			.getValidationResult {a: 1, b: 'hello'}
				..isValid.should.equal \false
				..score.should.equal 1

		o "should only validate objects", ->
			validator
			.getValidationResult 12
				..isValid.should.equal \false
				..score.should.equal 0