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

	after ->
		fs.unlink('./code/example.js')

	before (done) ->
		browser.visit('/', done)

	it 'displays a welcome message', ->
		expect(browser.text('h1')).to.eql('Welcome to Makers IDE')

	it 'has an input form', ->
		expect(browser.query('form')).to.be.ok

	it 'has a list of files', -> 
		expect(browser.text('.files')).to.contain('example.js')

	it 'entering a file name and pressing the button creates a new file', ->
		browser.fill("file-name", "ben.js").pressButton('+ New File').then ->
			expect(browser.text('.files')).to.contain('ben.js')
