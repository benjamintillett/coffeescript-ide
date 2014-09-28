app = require('express')()
server = require('http').Server app 
path = require 'path'
fs = require 'fs'
Editor = require './models/editor'

bodyParser = require 'body-parser'
app.use bodyParser.urlencoded({extended: false})
app.use(require('express-ejs-layouts'))
app.use(require('express').static('public'))
app.set 'views', path.join(__dirname,"./views")
app.set 'view engine', 'ejs'

editor = new Editor './code'

app.get '/', (request, response) ->
  response.render 'index', { files: fs.readdirSync('./code') }

app.post "/files", (request, response) ->
	fileName = request.query.file
	editor.createFile fileName, request.body.content.trim(), ->
		response.send "ben"
		# response.redirect('/edit?file=' + fileName);


app.delete '/files', (request,response) ->
	editor.deleteFile request.query.file, ->
		console.log("hello")
		response.send "hello"

app.get '/edit', (request,response) ->
	fileName = request.query.file
	console.log(fileName)
	fs.readFile 'code/' + fileName, (err,data)->
		response.render 'edit', { Dilename: fileName, text: data }






	# response.render "edit", { Dilename: request.query.file, text: editor.readFile request.query.file }
	

module.exports = server

