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
	editor.createFile request.query.file, request.body.content.trim(), ->
		response.render "edit", { Dilename: request.query.file, text: editor.readFile request.query.file }

app.delete '/files', (request,response) ->
	editor.deleteFile request.query.file, ->
		response.send "hello"

app.get '/edit', (request,response) ->
	response.render "edit", { Dilename: request.query.file, text: editor.readFile request.query.file }
	

module.exports = server

