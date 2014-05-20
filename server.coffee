express = require 'express'

bodyParser = require 'body-parser'

steps = require './routes/steps'
users = require './routes/users'

page = require './routes/page'
pages = require './routes/pages'

port = process.env.PORT or 3000

app = express()

allowCrossDomain = (req, res, next)->
  res.header('Access-Control-Allow-Origin', '*')
  res.header('Access-Control-Allow-Methods', 'GET')
  res.header('Access-Control-Allow-Headers', 'Content-Type')

  next()

# app.use express.logger('dev')
app.use allowCrossDomain
app.use bodyParser()

# app.param("pageurl", /^\d+$/)

app.param "page", (req, res, next, id)->
  re = new RegExp("_", 'g')
  req.page = id.replace(re, " ")
  next()

app.route('/visits').get(steps.findAll)
app.route('/users').get(users.findAll)
app.route('/pages').get(pages.findAll)
app.route('/page/:wiki_origin/wiki/:page').get(page.findLatestInfo)
app.route('/page/:wiki_origin/wiki/:page/revision/:revision_id').get(page.findRevision)
app.route('/page/:wiki_origin/wiki/:page/timeline').get(page.timeline)
app.route('/page/:wiki_origin/wiki/:page/revision/:revision_id/blocks').get(page.revisionBlocks)


app.listen port
console.log "listening to port #{port}"