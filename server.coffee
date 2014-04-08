express = require 'express'

steps = require './routes/steps'
users = require './routes/users'
users = require './routes/pages'

port = process.env.PORT or 3000

app = express()

app.configure ()->
  app.use express.logger('dev')
  app.use express.bodyParser()

app.get('/steps', steps.findAll)

app.get('/users', users.findAll)

app.get('/pages', users.findAll)


app.listen port
console.log "listening to port #{port}"