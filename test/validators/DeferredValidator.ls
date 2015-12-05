require! {
	'../../lib/shapely': {createValidator, deferred}
}

o = it
describe "DeferredValidator", ->
	o "should be recognized", ->
		(-> createValidator(deferred -> Number))
		.should.not.throw!

	describe "::isValid()", ->
		validator = null
		beforeEach ->
			validator := createValidator deferred -> originalValidator
			originalValidator = createValidator Number

		o "should validate matches", ->
			validator
			.isValid 12
			.should.equal true

		o "should only validate matches", ->
			validator
			.isValid 'hello'
			.should.equal false

	describe "::getValidationResult()", ->
		validator = null
		beforeEach ->
			validator := createValidator deferred -> originalValidator
			originalValidator = createValidator Number

		o "should validate matches", ->
			validator
			.getValidationResult 12
			.should.be.like {isValid: 'true'}

		o "should only validate matches", ->
			validator
			.getValidationResult 'hello'
				..isValid.should.equal \false
				..score.should.equal 0