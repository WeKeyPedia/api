client = require('mongodb').MongoClient

mongo_address = process.env.MONGODB_PORT_27017_TCP_ADDR

exports.findLatestInfo = (req, res)->
  lang = (req.param("wiki_origin")).split(".")[0]
  page = req.page

  console.log page

  info =
    lang: lang
    page: page
    datasets:
      revisions: 0
      latest_rev: 0

  client.connect "mongodb://#{mongo_address}/datasets", (err,db)->
    # console.log err
    # console.log db

    datasets = db.collection("datasets")
    datasets.count { url: { "$regex" : "#{lang}\/#{page}\/revision\/.*" } }, (err, count)->
      info.datasets.revisions = count
      console.log count

      # { "url":1, "dataset.revid":1, "dataset.timestamp": 1 }
      datasets.findOne { url: { "$regex" : "#{lang}\/#{page}\/timeline" } },  { "url":1, "dataset.revid":1, "dataset.timestamp": 1 }, (err,timeline)->
        console.log err

        if (err || not timeline)
          res.send(500, "no information for: #{page}")
        else        
          console.log timeline.dataset[timeline.dataset.length-1]

          info.datasets.latest_rev = timeline.dataset[timeline.dataset.length-1].revid
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
  # url = encodeURIComponent("http://#{lang}.wikipedia.org/wiki/#{page}")
  url = "#{lang}/#{page}"

  client.connect "mongodb://#{mongo_address}/datasets", (err,db)->
    # console.log err
    datasets = db.collection("datasets")
    
    # datasets.findOne({ url: "#{lang}/#{page}/timeline" },  { "url":1, "dataset.revid":1, "dataset.timestamp": 1 }).sort({ "dataset.timestamp": 1}).toArray (err,dataset)->
    datasets.findOne { url: "#{url}/timeline" }, (error,dataset)->
      if error || not dataset
        res.send(500, "Cannot find timeline for page: #{url}")
      else
        res.json dataset.dataset