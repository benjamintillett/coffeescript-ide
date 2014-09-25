app = require('express')()
server = require('http').Server app 
path = require 'path'
fs = require 'fs'
Editor = require './models/editor'

app.use(require('express-ejs-layouts'))
app.use(require('express').static('public'))
app.set 'views', path.join(__dirname,"./views")
app.set 'view engine', 'ejs'

editor = new Editor './code'

app.get '/', (request, response) ->
  response.render 'index', { files: fs.readdirSync('./code') }

app.post "/files", (request, response) ->
	editor.createFile request.query.file, ->
		response.send "hello"

app.delete '/files', (request,response) ->
	editor.deleteFile request.query.file, ->
		response.send "hello"
		
module.exports = server

