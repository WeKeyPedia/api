# mongo = require 'mongodb'

request = require 'request'

exports.findAll = (req, res)->
  options =
    uri: "http://localhost:7474/db/data/cypher"
    port: 7474
    json:
      query: "MATCH (u:User)-[r:visited]->(p:Page) RETURN u, r, p"
#      query: "MATCH (p:Page) RETURN p"

  request.post options,(e,r,b)->
    pages = []

    for p in b.data
      pages.push u =
        user: p[0].data.google_id
        time: p[1].data.time
        page: p[2].data.url
    
    res.send(pages)