chai = require('chai')

chai
.use(require 'chai-fuzzy')
.use(require 'chai-changes')
.use(require 'sinon-chai')
.should()

global.expect = chai.expect
global.sinon = require 'sinon'

# pretty-error = require \pretty-error
# 	.start!
# 	.skipNodeFiles!
# 	.skipPackage \socket.io, \coffee-script, \LiveScript, \data.task, \mocha