fs = require 'fs'

class Editor

	constructor: (@directory) ->

	createFile: (fileName, callback) ->
		fs.writeFile @directory + "/" + fileName, ''
		callback()

	readFile: (fileName) ->
		fs.readFileSync @directory + '/' + fileName, 'utf8'

module.exports = Editor