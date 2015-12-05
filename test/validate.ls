require! {
	'../lib/shapely': {validate, record}
}

o = it
describe "validate()", ->
	o "should create validator on the fly if needed", ->
		(-> validate String, "hello").should.not.throw!
		(-> validate record({a: String}), {a: 'hello'}).should.not.throw!

	o "should return value if value matches", ->
		validate String, "hello"
		.should.equal "hello"

	o "should throw if value doesn't match", ->
		(-> validate String, 10)
		.should.throw!