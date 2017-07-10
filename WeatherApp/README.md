# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...

commands(FYI)

1.  add this line to gem "d3-rails"
    add //= require d3 in application.js
2.  Add the -> gem 'gon' #To pass from the Javascript
    <%= include_gon(:init => true) %> (application.html.erb)
3.   <%= javascript_include_tag "index" %> (application.html.erb)
     assets.rb file-> Rails.application.config.assets.precompile += %w( index.js )

Geocoder::Configuration.always_raise << Geocoder::OverQueryLimitError
