require! {
  '../lib/shapely': {createValidator, record}
}

o = it
describe "createValidator", !->
  o "should turn String into stringValidator", !->
    createValidator String
      ..isValid('hello').should.equal true
      ..isValid(12).should.equal false

  o "should turn Number into numberValidator", !->
    createValidator Number
      ..isValid(10).should.equal true
      ..isValid('hello').should.equal false

  o "should turn Boolean into booleanValidator", !->
    createValidator Boolean
      ..isValid(false).should.equal true
      ..isValid('hello').should.equal false

  o "should turn strings into ExactValueValidator", !->
    createValidator 'hello'
      ..isValid('hello').should.equal true
      ..isValid('a').should.equal false

  o "should turn numbers into ExactValueValidator", !->
    createValidator 10
      ..isValid(10).should.equal true
      ..isValid(11).should.equal false

  o "should turn booleans into ExactValueValidator", !->
    createValidator false
      ..isValid(false).should.equal true
      ..isValid(11).should.equal false

  o "should act like identity() if supplied with a Validator", !->
    validator = record a: String

    createValidator validator
    .should.equal validator