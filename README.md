api
===

node.js api for the wekeypedia project


## API endpoints

### GET /users

CYPHER query:

```cypher
MATCH (u:User) RETURN DISTINCT u
```

JSON response:

```json
[
  {
    "google_id": google id [OPTIONAL],
    "christos_id": id [OPTIONAL]    
  },...
]
```

### GET /pages

CYPHER query:

```cypher
MATCH (p:Page) RETURN DISTINCT p
```

JSON response:

```json
[
  {
    "url": url,
    "title": title    
  },...
]
```

### GET /visits

CYPHER query:

```cypher
MATCH (u:User)-[r:visited]->(p:Page) RETURN u, r, p
```

JSON response:

```json
[
  {
    "page": page url, 
    "time": timestamp, 
    "user": user id
  },...
]
```

### installation

Easy peasy!

```
# git clone https://github.com/WeKeyPedia/api
# cd api
# npm install
# forever -c coffee server.coffee
```
