# Tasks

1. Get thin server running
2. Test that going to /admin redirects to /sessions/new
3. Make test pass
4. Publish to heroku

***

# Features

* Add article, author, images
* author write articles (admin section)
* homepage features photo articles

***

# Development

* StaticGenerator app: each photo = static page
* get unicorn server running
* publish to heroku

***

Account class: authentication, storage; name, email, password
Articles class: belongs_to writer, has_many Images
Writer class: has_one Account has_many Articles
StaticGenerator: creates static assets (uses main view to yield the current template)
Publisher: publishes static files to AWS?

***

# Phases

* Get working without static
* Create static generator

***

# Plugins

* haml boilerplate: https://raw.githubusercontent.com/jameslutley/haml-html5-boilerplate/master/boilerplate.haml
* heroku:
* bootstrap:

***

# TODO

* When admin deletes image, delete from Amazon