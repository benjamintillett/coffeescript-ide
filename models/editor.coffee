fs = require 'fs'

class Editor

	constructor: (@directory) ->

	createFile: (fileName, content = '') ->
		fs.writeFile @directory + "/" + fileName, content


	deleteFile: (fileName, callback) ->
		fs.unlink @directory + "/" + fileName
		callback()


	readFile: (fileName,callback) ->
		fs.readFileSync @directory + '/' + fileName, 'utf8'

	appendToFile: (fileName, addedText) ->
		fs.appendFile @directory + '/' + fileName, addedText


module.exports = Editor