JanusReviews
=======

Generic reviews website designed as a re-modeling of the final project for my "Intro to Software Engineering" course at "the Flatiron School" in NYC

Layout
========

Product:
* Has name
* Has uniqueness
* Has description
* Has ratings (see <tt>db/migrate/AddRatingsToProduct</tt> for details)

Rating
* Belongs to Product
* An array-type variable in the products table

System Details:
=========

* Ruby version: 2.4.3

* System dependencies: Rails 4.2.5

* Database creation: PostgreSQL 

* Database initialization: see migrations

* Services (job queues, cache servers, search engines, etc.)

* Webhost: Heroku

* To test, run <tt>rails server</tt>