api
===

node.js api for the wekeypedia project


## API endpoints

### GET /users

```
[
  {
    "google_id": google id [OPTIONAL]
    "christos_id": id [OPTIONAL]    
  },
]
```

### GET /pages

```
[
  {
    "url": url,
    "title": title    
  },
]
```

### GET /visits

```
[
  {
    "page": page url, 
    "time": timestamp, 
    "user": user id
  },
]
```