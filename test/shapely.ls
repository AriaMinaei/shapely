require! '../lib/shapely':{union, optional, record, any}

o = it

describe "shapely", ->
	describe "union", ->
		o "should work", ->
			u = union do
				record do
					type: \success
					result: any
				record do
					type: \failure
					message: String
					code: optional Number
					extraInfo: any

			u.isValid(type: \success, result: \whatever ).should.equal yes
			u.isValid(type: \invalid ).should.equal no
			u.isValid(type: \failure, message: \msg ).should.equal yes

			console.log u.getValidationResult(type: \failure, message: null).message