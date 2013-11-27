# Preface

- API gem, that uses Excon, and talks to the PaaS over it's API.
- Client gem, that has a CLI interface

# Error codes

We use HTTP error codes, to semantically explain what happened.

https://devcenter.heroku.com/articles/platform-api-reference
https://dev.twitter.com/docs/error-codes-responses

# Routes

GET /apps             -- get a list of apps
POST /apps            -- create a new app
GET /apps/:id         -- get a specific app
PATCH /apps/:id       -- update app
DELETE /apps/:id      -- delete app

GET /apps/:id/env     -- get app ENV
PUT /apps/:id/env     -- update ENV

GET /apps/:id/gears

DELETE /apps/:id/gears     -- restart all gears
DELETE /apps/:id/gears/:id -- restart single gear

GET /apps/:id/logs     -- get logs (returns a live log stream)

GET /apps/:id/releases -- get logs

POST /login

GET /accout           -- returns account settings
PATCH /account        -- updates account settings
PUT /account/password -- updates password

GET /account/keys
POST /account/keys     -- add key to account
GET /accout/keys/:id
DELETE /account/keys/:id


GET /apps/:id/domains
POST /apps/:id/domains
GET /apps/:id/domains/:id
PUT /apps/:id/domains/:id
DELETE /apps/:id/domains/:id

SSL