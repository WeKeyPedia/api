api
===

node.js api for the wekeypedia project


## API endpoints

### GET /users

CYPHER query:

```
MATCH (u:User) RETURN DISTINCT u
```

JSON response:

```
[
  {
    "google_id": google id [OPTIONAL]
    "christos_id": id [OPTIONAL]    
  },...
]
```

### GET /pages

CYPHER query:

```
MATCH (p:Page) RETURN DISTINCT p
```

JSON response:

```
[
  {
    "url": url,
    "title": title    
  },...
]
```

### GET /visits

CYPHER query:

```
MATCH (u:User)-[r:visited]->(p:Page) RETURN u, r, p
```

JSON response:

```
[
  {
    "page": page url, 
    "time": timestamp, 
    "user": user id
  },...
]
```