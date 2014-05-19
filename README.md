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

### GET /page/:wikipedia_page_url_encoded

Give a some meta information about available data about this page:

- number of revisions stored as datasets
- last revision

### GET /page/:wikipedia_page_url_encoded/timeline

Give a list of all revisions ordered by timestamps.

- info:
  - revision id
  - timestamp

### GET /page/:wikipedia_page_url_encoded/revision/:revision_id

Proxy the datasets database and give back the json result from the corresponding wikipediage page#revision from the wikipedia API.

- info
  - author (IP or official id)
  - timestamp
  - comment
  - content
  - size


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
