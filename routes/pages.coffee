request = require 'request'

exports.findAll = (req, res)->
  options =
    uri: "http://localhost:7474/db/data/cypher"
    port: 7474
    json:
      query: "MATCH (p:Page) RETURN DISTINCT p"

  request.post options,(e,r,b)->
    pages = []

    for x in b.data
      pages.push x[0].data
    
    res.send(pages)