require! {
  '../../lib/shapely': {createValidator, record}
}

o = it
describe "RecordValidator", !->
  o "should be recognized", !->
    (-> createValidator record({a: String}))
    .should.not.throw!

  describe "::constructor()", !->
    o "should only accept objects", !->
      (-> record({a: String})).should.not.throw!
      (-> record([])).should.throw!

  describe "::isValid()", !->
    validator = null
    beforeEach ->
      validator := createValidator record({a: String, b: Number})

    o "should validate matches", !->
      validator
      .isValid {a: 'hello', b: 12}
      .should.equal true

    o "should validate ignore extra properties", !->
      validator
      .isValid {a: 'hello', b: 12, c: 13}
      .should.equal true

    o "should only validate matches", !->
      validator
      .isValid {a: 'hello', b: 'hello'}
      .should.equal false

  describe "::getValidationResult()", !->
    validator = null
    beforeEach ->
      validator := createValidator record({kind: 'leaf', value: Number})

    o "should validate matches", !->
      validator
      .getValidationResult {kind: 'leaf', value: 12}
      .isValid.should.equal 'true'

    o "should ignore extra properties", !->
      validator
      .getValidationResult {kind: 'leaf', value: 12, extra: []}
      .isValid.should.equal 'true'

    o "should only validate objects and return correct score", !->
      validator
      .getValidationResult 'hello'
        ..isValid.should.equal \false
        ..score.should.equal 0

      validator
      .getValidationResult {}
        ..isValid.should.equal 'false'
        ..score.should.equal 1

    o "should only validate matches and return correct score", !->
      validator
      .getValidationResult {kind: 'wrong', value: 12}
        ..isValid.should.equal \false
        ..score.should.equal 1

      validator
      .getValidationResult {kind: 'leaf', value: 'hello'}
        ..isValid.should.equal \false
        ..score.should.equal 2

      validator
      .getValidationResult {kind: 'wrong', value: 12}
        ..isValid.should.equal \false
        ..score.should.equal 1