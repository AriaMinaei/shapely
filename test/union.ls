require! '../src/shapely': {union, newtype, mapOf}
o = it

describe 'union', ->
	describe \definition, ->
		o "should require a name", ->
			(-> union null, {Constructor: String})
			.should.throw!

		o 'should require at least one variant', ->
			(-> union \U, null).should.throw!
			(-> union \U, A: a: String).should.not.throw!

		o 'should not allow non-typed variants', ->
			(-> union \U, a: String).should.throw!

	describe \validation, ->
		o 'should work for any', ->
			U = union \U,
				A:
					a: 'any'

			(-> U.A a: 'hello').should.not.throw()
			(-> U.A a: null).should.not.throw()

		o 'should work for strings', ->
			U = union \U,
				A:
					a: String

			U.A a: 'hello'

			(-> U.A a: 'hello').should.not.throw()
			(-> U.A a: 10).should.throw()

		o 'should work for eithers', ->
			A = newtype \A,
				a: [\either, [String, Number]]

			(-> A a: 'hi').should.not.throw!
			(-> A a: 10).should.not.throw!
			(-> A a: true).should.throw!


		o 'should consider default values', ->
			U = union \U,
				A:
					a: [\only, String, "something"]

			U.A a: 'hello'

			(-> U.A a: 'hello').should.not.throw()
			(-> U.A a: 10).should.throw()
			(-> U.A a: null).should.not.throw()

		o 'should not allow wrong default values', ->
			(-> newtype \A, a: [\only, String, 10]).should.throw!
			(-> newtype \A, a: [\only, String, "10"]).should.not.throw!

		o 'should work for arrays of typed objects', ->
			U2 = union \U2,
				A: a: String

			U3 = union \U2,
				A: a: String

			U = union \U,
				A:
					a: [\arrayOf, U2]

			(-> U.A a: [U2.A a: 'hello']).should.not.throw()
			(-> U.A a: 10).should.throw()

		o 'should work for other unions', ->
			U2 = union \U2,
				A:
					a: String

			U = union \U, A: a: U2

			# U.A a: 10

			(-> U.A a: U2.A({a: 'hi'})).should.not.throw()
			(-> U.A a: 10).should.throw()

		o 'should work for deferred unions', ->
			U = union \U, A: a: -> U2

			U2 = union \U2, A: a: String

			(-> U.A a: U2.A({a: 'hi'})).should.not.throw()
			(-> U.A a: 10).should.throw()

		o.skip 'should work for other unions created on the fly', ->
			U2 = union \U2,
				A:
					a: String
			U3 = union \U3,
				A:
					a: String

			V = union \V,
				A:
					a: {U2, U3}

			v = V.A a: U2.A a: 'hi'
			v.get('a').get('a').should.equal 'hi'

			(-> V.A a: U2.A({a: 'hi'})).should.not.throw()
			(-> V.A a: U3.A({a: 'hi'})).should.not.throw()
			(-> V.A a: 10).should.throw()

		o 'should work for other types being wrappers', ->
			R = newtype \R,
				a: String

			U = union \U,
				A: R

			(-> U.A 'hi').should.throw!
			(-> U.A R a: 'hi').should.not.throw!

		o 'should work for unions with types being wrappers', ->
			U2 = union \U2,
				A:
					a: String

			U = union \U,
				A: String
				B: U2

			(-> U.A 'hi').should.not.throw!
			(-> U.A 10).should.throw!
			(-> U.B U2.A a: 'hi').should.not.throw!
			(-> U.B 'hello').should.throw!

		o 'should work for recursive types', ->
			U = union \U,
				A:
					a: \U
				B:
					a: String

			U2 = union \U,
				A: a: String

			(-> U.A a: U.B a: 'hi').should.not.throw!
			(-> U.A a: U2.A a: 'hi').should.throw!


		o 'should work for maps', ->
			U = union \U, A: a: String

			A = newtype \A, a: [\mapOf String]
			B = newtype \B, a: [\mapOf U]

			(-> A a: {one: \hi }).should.not.throw!
			(-> A a: {one: 10 }).should.throw!
			(-> B a: {one: U.A(a: 'hi') }).should.not.throw!
			(-> B a: {one: 10 }).should.throw!

		o 'should work for arrays', ->
			A = newtype \A, a: [\arrayOf, String]

			U = union \U, A: a: String

			B = newtype \B, a: [\arrayOf, U]

			(-> A a: [\hi ]).should.not.throw!
			(-> A a: [10]).should.throw!
			(-> B a: [U.A(a: 'hi')]).should.not.throw!
			(-> B a: [10]).should.throw!


	describe 'Retrieving properties', ->
		o 'should work for strings', ->
			U = union \U,
				A:
					a: String

			u = U.A a: 'hello'

			u.get('a').should.equal 'hello'

		o 'should work for all', ->
			U2 = union \U2,
				A:
					a: String

			U = union \U,
				A:
					a: String
					b: U2

			u2 = U2.A a: 'u2'
			u = U.A a: 'hello', b: u2

			u.get('a').should.equal 'hello'
			u.get('b').should.equal u2

		o 'should work for wrappers', ->
			U2 = union \U2,
				A:
					a: String

			U = union \U,
				U2: U2

			(U.U2 U2.A a: 'hi').get!.get('a').should.equal 'hi'

	describe '::serialize()/deserialize()', ->
		o 'should work', ->
			U2 = union \U2,
				A:
					a: String
					b: Number
					c: \any
					d: [\either, [String, Number]]

			U3 = union \U3,
				A: a: String

			U = union \U,
				A:
					a: String
					b: U2
					# c: {U2, U3}
					d: [\arrayOf, U3]
					e: [\mapOf, U3]
					# f: mapOf String
			# return

			u3 = U3.A a: 'u3'
			u2 = U2.A a: 'a', b: 10, c: 's', d: \10
			u = U.A do
				a: 'hi'
				b: u2
				d: [u3]
				e:
					one: U3.A a: 'hi'
					two: U3.A a: 'bye'

			s = U.deserialize u.serialize!
			s.get('a').should.equal 'hi'
			s.get('b').get('a').should.equal 'a'
			s.get('b').get('b').should.equal 10
			s.get('b').get('c').should.equal 's'
			s.get('b').get('d').should.equal \10
			s.get('d')[0].get('a').should.equal 'u3'
			s.get('e').one.get('a').should.equal \hi
			s.get('e').two.get('a').should.equal \bye

	describe \::deserialize, ->
		o 'should work', ->
			A = union \A, A: a: String
			B = union \B, A: a: String

			a = A.A a: 'hi'
			(-> B.deserialize a.serialize!).should.throw!

		o 'should work for wrappers', ->
			A = newtype \A, String
			B = newtype \B, String
			a = A 'hello'
			a.serialize!

			A.deserialize(a.serialize!).get!.should.equal 'hello'