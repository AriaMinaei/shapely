require! {
  '../../lib/shapely': {createValidator}
}

o = it
describe "ExactValueValidator", !->
  o "should be recognized", !->
    (-> createValidator('hello'))
    .should.not.throw!

  describe "::isValid()", !->
    o "should validate exact value", !->
      createValidator 'hello'
      .isValid 'hello'
      .should.equal true

    o "should only validate exact value", !->
      createValidator 12
      .isValid 13
      .should.equal false

  describe "::getValidationResult()", !->
    o "should validate exact value", !->
      createValidator true
      .getValidationResult true
      .should.be.like {isValid: 'true'}

    o "should only validate exact value", !->
      createValidator 'hello'
      .getValidationResult 12
        ..isValid.should.equal \false
        ..score.should.equal 0