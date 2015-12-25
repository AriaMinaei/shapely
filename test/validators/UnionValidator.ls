require! {
  '../../lib/shapely': {createValidator, record, union}
}

o = it
describe "UnionValidator", !->
  o "should be recognized", !->
    (-> createValidator union(record({a: String}), String))
    .should.not.throw!

  describe "::constructor()", !->
    o "should only accept validators", !->
      (-> union String, Number ).should.not.throw!
      (-> union String, null).should.throw!

  describe "::isValid()", !->
    validator = null
    beforeEach ->
      validator := createValidator union String, record(kind: 'leaf')

    o "should validate all variants", !->
      validator
      .isValid 'hello'
      .should.equal true

      validator
      .isValid {kind: 'leaf'}
      .should.equal true

    o "should only validate variants", !->
      validator
      .isValid 0
      .should.equal false

  describe "::getValidationResult()", !->
    validator = null
    beforeEach ->
      validator := createValidator union String, record(kind: 'leaf', value: Number)

    o "should validate all variants", !->
      validator
      .getValidationResult 'hello'
        ..isValid.should.equal 'true'

      validator
      .getValidationResult {kind: 'leaf', value: 12}
        ..isValid.should.equal 'true'

    o "should only validate variants", !->
      validator
      .getValidationResult 0
        ..isValid.should.equal 'false'

    o "should return the best matched score", !->
      validator
      .getValidationResult 0
        ..score.should.equal 0

      validator
      .getValidationResult {}
        ..score.should.equal 1

      validator
      .getValidationResult {kind: 'leaf'}
        ..score.should.equal 2