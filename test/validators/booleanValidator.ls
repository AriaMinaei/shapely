require! {
  '../../lib/shapely': {createValidator}
}

o = it
describe "booleanValidator", !->
  o "should be recognized", !->
    (-> createValidator(Boolean))
    .should.not.throw!

  describe "::isValid()", !->
    o "should validate booleans", !->
      createValidator Boolean
      .isValid true
      .should.equal true

    o "should only validate booleans", !->
      createValidator Boolean
      .isValid 'hello'
      .should.equal false

  describe "::getValidationResult()", !->
    o "should validate booleans", !->
      createValidator Boolean
      .getValidationResult false
      .should.be.like {isValid: 'true'}

    o "should only validate booleans", !->
      createValidator Boolean
      .getValidationResult 'hello'
        ..isValid.should.equal \false
        ..score.should.equal 0