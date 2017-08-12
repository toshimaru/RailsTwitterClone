# Rails Twitter Clone

[![Build Status](https://travis-ci.org/toshimaru/RailsTwitterClone.svg?branch=bundle-update-20170116)](https://travis-ci.org/toshimaru/RailsTwitterClone)
[![Code Climate](https://codeclimate.com/github/toshimaru/RailsTwitterClone/badges/gpa.svg)](https://codeclimate.com/github/toshimaru/RailsTwitterClone)
[![Test Coverage](https://codeclimate.com/github/toshimaru/RailsTwitterClone/badges/coverage.svg)](https://codeclimate.com/github/toshimaru/RailsTwitterClone/coverage)
[![Dependency Status](https://gemnasium.com/badges/github.com/toshimaru/RailsTwitterClone.svg)](https://gemnasium.com/github.com/toshimaru/RailsTwitterClone)
[![CircleCI](https://circleci.com/gh/toshimaru/RailsTwitterClone.svg?style=svg)](https://circleci.com/gh/toshimaru/RailsTwitterClone)

![Github Clone Screen Capture](https://cloud.githubusercontent.com/assets/803398/5903211/acdfe32c-a5c3-11e4-8171-b5ab2c3ef806.png)

## Implementation

This implementation is based on [Ruby on Rails Tutorial](https://www.railstutorial.org/book).

## Setup

Check out this repository and then,

```console
$ bundle install
$ bundle exec rails db:migrate
$ bundle exec rails server
```

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
* font-awesome-sass

### For testing

* capybara
* factory_girl
* faker
* rspec
* simplecov

### For debugging

* bullet
* pry-byebug
* pry-rails
* web-console

See more details on [Gemfile](https://github.com/toshimaru/RailsTwitterClone/blob/master/Gemfile).

## Test

```console
$ bundle exec rspec
```

## Data reset and sample data creation

```console
$ bundle exec rails db:reset    # Data reset
$ bundle exec rails db:populate # Create sample data
```
