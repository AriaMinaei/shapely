require! {
  '../lib/shapely': {isValid, record}
}

o = it
describe "isValid()", !->
  o "should create validator on the fly if needed", !->
    (-> isValid String, "hello").should.not.throw!
    (-> isValid record({a: String}), {a: 'hello'}).should.not.throw!

  o "should return value if value matches", !->
    isValid String, "hello"
    .should.equal true

  o "should throw if value doesn't match", !->
    isValid String, 10
    .should.equal false