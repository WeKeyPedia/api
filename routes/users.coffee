request = require 'request'

exports.findAll = (req, res)->
  options =
    uri: "http://localhost:7474/db/data/cypher"
    port: 7474
    json:
      query: "MATCH (u:User) RETURN DISTINCT u"

  request.post options,(e,r,b)->
    users = []

    for u in b.data
      users.push u[0].data
    
    res.send(users)