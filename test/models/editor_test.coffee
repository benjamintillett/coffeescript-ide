chai = require 'chai'
expect = chai.expect
Editor = require '../../models/editor'
fs = require 'fs'

describe 'Editor', ->

	before ->
		@editor = new Editor('./code')
		fs.writeFile('./code/_test.txt', 'Original contents of the file')

	# after ->
	# 	fs.unlink('./code/_test.txt')

	it "creates a file", ->
		@editor.createFile 'ben.js', ->
			expect(fs.readdirSync('./code')).to.contain('ben.js')


	it 'can read a file\'s contents', ->
		@editor.readFile '_test.txt', (content) ->
			expect(content).to.eql('Original contents of the file')


	it 'appends to a file', ->
		@editor.appendToFile '_test.txt', ", This is the appended content", (content) ->
			expect(content).to.eql('Original contents of the file, This is the appended content')

	it "deletes a file", -> 
		@editor.deleteFile '_test.txt', ->
			expect(fs.readdirSync('./code')).not.to.contain('_test.txt')

	it 'creates a file with content', ->
		@editor.createFile '_ethel.js', 'content', ->
			expect(@editor.readFile '_ethel.js').to.eql('content')



