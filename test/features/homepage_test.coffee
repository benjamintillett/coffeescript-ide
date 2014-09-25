Browser = require 'zombie'
fs = require 'fs'
chai = require 'chai'
expect = chai.expect
server = require '../../app'

describe 'home page', ->
	browser = null

	before ->
		@server = server.listen(3000)
		browser = new Browser({ site: 'http://localhost:3000' })
		fs.writeFile('./code/example.js', '')

	before (done) ->
		browser.visit('/', done)

	# after ->
	# 	fs.unlink('./code/example.js')

	it 'displays a welcome message', ->
		expect(browser.text('h1')).to.eql('Welcome to Makers IDE')

	it 'has an input form', ->
		expect(browser.query('form')).to.be.ok

	it 'has a list of files', -> 
		expect(browser.text('.files')).to.contain('example.js')

	it 'each file in the list should have delete button', ->
		expect(browser.query('button.delete')).to.be.ok

	it 'each file in the list should have an edit button', ->
		expect(browser.query('button.edit')).to.be.ok

	it 'pressing the delete button deletes the file', ->
		browser.pressButton('ul li:last-child button.delete').then ->
			expect(browser.text('ul')).not.to.contain('example.js')
	
	describe 'creating a file', ->

		before (done) ->
			browser.fill("file-name", "ben.js").pressButton('+ New File', done)

		after ->
			fs.unlink('./code/ben.js')

		it 'entering a file name and pressing the button creates a new file', ->
			expect(browser.text('.files')).to.contain('ben.js')