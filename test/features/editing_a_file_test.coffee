Browser = require 'zombie'
fs = require 'fs'
chai = require 'chai'
expect = chai.expect
server = require '../../app'

describe 'editor page', ->
	browser = null

	before ->
		@server = server.listen(3000)
		browser = new Browser({ site: 'http://localhost:3000' })
		fs.writeFile('./code/ethel.js', 'function()')

	before (done) ->
		browser.visit('/').then ->
			browser.clickLink('.edit', done)

	after ->
		fs.unlink('./code/ethel.js')

	it 'clicking the edit button on the file shows the file contents', ->
		expect(browser.text('textarea')).to.eql('function()')