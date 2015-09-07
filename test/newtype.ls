require! {
	'../src/newtype'
}

_it = it
they = it

describe \newtype, ->
	_it 'should work', ->
		T = newtype \T,
			a: String

		(T a: 'hi').get('a').should.equal 'hi'

		((T a: 'hi').serialize! |> T.deserialize).get('a').should.equal 'hi'