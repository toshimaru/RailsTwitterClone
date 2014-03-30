[![Build Status](https://drone.io/github.com/toshimaru/Rails-4-Twitter-Clone/status.png)](https://drone.io/github.com/toshimaru/Rails-4-Twitter-Clone/latest)

##TODO

* Add profile description to User
  * and Favorites feature
* Design
* Test of pagination
* DRY!

##Imprementation

Imprementatin is based on [Ruby on Rails Tutorial](http://ruby.railstutorial.org/ruby-on-rails-tutorial-book).

##Features

This application doesn't provide many features in order to keep it simple. Here is the features:

* See timeline
* Post new tweet
* Follow/Unfollow user

##Used gem

* slim
* rspec
* factory_girl
* capybara
* simplecov
* guard
* bootstrap-sass
* faker

See more details on [Gemfile](https://github.com/toshimaru/Rails-4-Twitter-Clone/blob/master/Gemfile).

##Test

    $ bundle exec rspec

##Data reset and creation

    $ bundle exec rake db:reset
    $ bundle exec rake db:populate
    $ bundle exec rake test:prepare

## README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version
* Configuration
* Database creation
* Database initialization
* Services (job queues, cache servers, search engines, etc.)
* ...
