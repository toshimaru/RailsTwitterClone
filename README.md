[![Build Status](https://travis-ci.org/toshimaru/Rails-4-Twitter-Clone.svg?branch=master)](https://travis-ci.org/toshimaru/Rails-4-Twitter-Clone)
[![Coverage Status](https://img.shields.io/coveralls/toshimaru/Rails-4-Twitter-Clone.svg)](https://coveralls.io/r/toshimaru/Rails-4-Twitter-Clone?branch=master)


## Imprementation

This imprementatin is based on [Ruby on Rails Tutorial](http://ruby.railstutorial.org/ruby-on-rails-tutorial-book).

## Features

This application doesn't provide many features in order to keep it simple. Here is the features:

* See timeline
* Post new tweet
* Follow/Unfollow user

## Used gem

### For template
* slim

### Style
* bootstrap-sass

### For testing
* rspec
* factory_girl
* capybara
* simplecov
* guard
* faker

### For debugging
* quiet_assets
* bullet
* better_errors & binding_of_caller

See more details on [Gemfile](https://github.com/toshimaru/Rails-4-Twitter-Clone/blob/master/Gemfile).

## Test

    $ bundle exec rspec

## Data reset and creation

    $ bundle exec rake db:reset
    $ bundle exec rake db:populate
    $ bundle exec rake test:prepare

## TODO
* Cool design
* Add profile description to User
  * and Favorites feature
* User Slug
  * Edit user
  * Add spec
* Spec of pagination
