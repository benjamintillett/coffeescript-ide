fs = require 'fs'

class Editor

	constructor: (@directory) ->

	createFile: (fileName, content = '', callback) ->
		fs.writeFile @directory + "/" + fileName, content
		# callback()

	deleteFile: (fileName, callback) ->
		# console.log(fileName)
		# console.log(callback)
		# callback()
		fs.unlink @directory + "/" + fileName, ->
			callback()

		


	readFile: (fileName, callback) ->
		fs.readFile @directory + '/' + fileName, 'utf8', ->
			callback()

	appendToFile: (fileName, addedText) =>
		fs.appendFileSync @directory + '/' + fileName, addedText

module.exports = Editor