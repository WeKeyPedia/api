client = require('mongodb').MongoClient

mongo_address = process.env.MONGODB_PORT_27017_TCP_ADDR

exports.findLatestInfo = (req, res)->
  info =
    lang: (req.param("wiki_origin")).split(".")[0]
    page: req.param("page")
    datasets:
      revisions: 0
      latest_rev: 0

  client.connect "mongodb://#{mongo_address}/datasets", (err,db)->
    # console.log err
    # console.log db

    datasets = db.collection("datasets")
    datasets.count { url: /en\/Crimea\/revision\/.*/ }, (err, count)->
      info.datasets.revisions = count

      # { "url":1, "dataset.revid":1, "dataset.timestamp": 1 }
      datasets.find({ url: /en\/Crimea\/revision\/.*/ },  { "url":1, "dataset.revid":1, "dataset.timestamp": 1 }).sort({ "dataset.timestamp": -1}).toArray (err,dataset)->
        info.datasets.latest_rev = dataset[0]
        res.json(info)

exports.findRevision = (req, res)->
  client.connect "mongodb://#{mongo_address}/datasets", (err,db)->
    lang = (req.param("wiki_origin")).split(".")[0]
    page = req.param("page")
    revision_id = req.param("revision_id")

    datasets = db.collection("datasets")
    datasets.findOne { url: "#{lang}/#{page}/revision/#{revision_id}" }, (err, dataset)->
      res.json dataset.dataset[0]


exports.timeline = (req, res)->
  result = []

  lang = (req.param("wiki_origin")).split(".")[0]
  page = req.param("page")
  url = req.param("url")

  client.connect "mongodb://#{mongo_address}/datasets", (err,db)->
    datasets = db.collection("datasets")
    
#    datasets.findOne({ url: "#{lang}/#{page}/timeline" },  { "url":1, "dataset.revid":1, "dataset.timestamp": 1 }).sort({ "dataset.timestamp": 1}).toArray (err,dataset)->
    datasets.findOne { url: "#{url}/timeline" }, (err,dataset)->
      if error
        res.send(500, "Cannot find timeline for page: #{url}")
      else
        res.json dataset.dataset