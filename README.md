[![Build Status](https://travis-ci.org/toshimaru/Rails-4-Twitter-Clone.svg?branch=master)](https://travis-ci.org/toshimaru/Rails-4-Twitter-Clone)
[![Test Coverage](https://codeclimate.com/github/toshimaru/Rails-4-Twitter-Clone/badges/coverage.svg)](https://codeclimate.com/github/toshimaru/Rails-4-Twitter-Clone)
[![Code Climate](https://codeclimate.com/github/toshimaru/Rails-4-Twitter-Clone/badges/gpa.svg)](https://codeclimate.com/github/toshimaru/Rails-4-Twitter-Clone)
[![Dependency Status](https://gemnasium.com/toshimaru/Rails-4-Twitter-Clone.svg)](https://gemnasium.com/toshimaru/Rails-4-Twitter-Clone)
[![Circle CI](https://circleci.com/gh/toshimaru/Rails-4-Twitter-Clone.svg?style=svg)](https://circleci.com/gh/toshimaru/Rails-4-Twitter-Clone)

![Github Clone Screen Capture](https://cloud.githubusercontent.com/assets/803398/5903211/acdfe32c-a5c3-11e4-8171-b5ab2c3ef806.png)

## Implementation

This implementation is based on [Ruby on Rails Tutorial](https://www.railstutorial.org/book).

## Features

This application doesn't provide many features in order to keep it simple. Here are the features that it does include:

* See timeline
* Post new tweet
* Follow/Unfollow user

## Used gem

### For template
* slim

### For CSS Style
* bootstrap-sass

### For testing
* capybara
* factory_girl
* faker
* guard
* rspec
* simplecov

### For debugging
* better_errors & binding_of_caller
* bullet
* quiet_assets

See more details on [Gemfile](https://github.com/toshimaru/Rails-4-Twitter-Clone/blob/master/Gemfile).

## Test

    $ bundle exec rspec

## Data reset and creation

    $ bundle exec rake db:reset
    $ bundle exec rake db:populate
    $ bundle exec rake test:prepare
