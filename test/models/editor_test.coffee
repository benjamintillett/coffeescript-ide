chai = require 'chai'
expect = chai.expect
Editor = require '../../models/editor'
fs = require 'fs'

describe 'Editor', ->

	before ->
		@editor = new Editor('./code')
		fs.writeFile('./code/_test.txt', 'Lorem ipsum')

	# after ->
	# 	fs.unlink('./code/_test.txt')

	it "creates a file", ->
		@editor.createFile 'ben.js', (file) ->
			expect(fs.readdirSync('./code')).to.contain('ben.js')


	it 'can read a file\'s contents', ->
		@editor.readFile '_test.txt', (content) ->
			expect(content).to.eql('Lorem ipsum')


	it "deletes a file", -> 
		@editor.deleteFile '_test.txt', ->
			expect(fs.readdirSync('./code')).not.to.contain('_test.txt')