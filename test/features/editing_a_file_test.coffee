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
		fs.writeFile './code/ethel.js','function()'		
	
	before (done) ->
		browser.visit '/edit?file=ethel.js', done

	after ->
		fs.unlink('./code/ethel.js')

	it 'clicking the edit button on the file shows the file contents', ->		
		expect(browser.text('textarea')).to.eql('function()')

	describe 'saving changes', ->
	
      	before (done) ->
        	browser.fill("textarea", 'Hello').
        	pressButton 'Save', done 
        it "writes the changes to the file", ->
        	fs.readFileSync 'code/ethel.js','utf8', (content)-> 
        		expect(content).to.eql('Hello')







		
