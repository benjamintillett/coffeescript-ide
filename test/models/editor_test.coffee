chai = require 'chai'
expect = chai.expect
Editor = require '../../models/editor'
fs = require 'fs'

describe 'Editor', ->
	editor = null

	beforeEach ->
		editor = new Editor('./code')
		fs.writeFile('./code/_test.txt', 'Original contents of the file')

	# afterEach ->
	# 	fs.unlink('./code/_test.txt', (error)->
	# 		console.log(error))

	it "creates a file", ->
		editor.createFile 'ben.js','', ->
			expect(fs.readdirSync('./code')).to.contain('ben.js')


	it 'can read a file\'s contents', ->
		fs.readFile './code/_test.txt', (content) ->
			expect(content).to.eql('Original contents of the file')


	it 'appends to a file', ->
		content = editor.appendToFile '_test.txt', ", This is the appended content"
		expect(content).to.eql('Original contents of the file, This is the appended content')

	it "deletes a file", -> 
		editor.deleteFile '_test.txt', ->
			expect(fs.readdirSync('./code')).not.to.contain('_test.txt')

	
	it "does it real good", ->
		expect(fs.readdirSync('./code')).not.to.contain('_test.txt')
		editor.createFile '_ethel.js', 'is so funny', ->
			fs.readFile './code/_ethel.js', (err, contents) ->
				expect(contents).to.eql('is so funny')





