express = require 'express'

steps = require './routes/steps'
users = require './routes/users'
pages = require './routes/pages'

port = process.env.PORT or 3000

app = express()

allowCrossDomain = (req, res, next)->
  res.header('Access-Control-Allow-Origin', '*')
  res.header('Access-Control-Allow-Methods', 'GET')
  res.header('Access-Control-Allow-Headers', 'Content-Type')

  next()

app.configure ()->
  app.use express.logger('dev')
  app.use allowCrossDomain
  app.use express.bodyParser()

app.get('/visits', steps.findAll)

app.get('/users', users.findAll)

app.get('/pages', pages.findAll)


app.listen port
console.log "listening to port #{port}"