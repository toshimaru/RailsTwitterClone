# Rails Twitter Clone

[![Actions Status](https://github.com/toshimaru/RailsTwitterClone/workflows/Docker%20Compose%20Build/badge.svg)](https://github.com/toshimaru/RailsTwitterClone/actions)
[![Code Climate](https://codeclimate.com/github/toshimaru/RailsTwitterClone/badges/gpa.svg)](https://codeclimate.com/github/toshimaru/RailsTwitterClone)
[![Test Coverage](https://codeclimate.com/github/toshimaru/RailsTwitterClone/badges/coverage.svg)](https://codeclimate.com/github/toshimaru/RailsTwitterClone/coverage)
[![CircleCI](https://circleci.com/gh/toshimaru/RailsTwitterClone.svg?style=svg)](https://circleci.com/gh/toshimaru/RailsTwitterClone)

![Twitter Clone Screen Capture](https://cloud.githubusercontent.com/assets/803398/5903211/acdfe32c-a5c3-11e4-8171-b5ab2c3ef806.png)

## Implementation

This implementation is based on [Ruby on Rails Tutorial](https://www.railstutorial.org/book).

## Setup

Check out this repository and then,

```console
$ bundle install
$ bin/rails webpacker:install
$ bin/rails db:migrate
$ bin/rails server
```

## Features

This application doesn't provide many features in order to keep it simple. Here are the features that it does include:

* See TimeLine
* Post new Tweet
* Follow/Unfollow User

## Used gem

### JavaScript

- webpacker

### Database

- sqlite3

### For testing

* capybara
* factory_bot
* faker
* rspec
* simplecov

### For debugging

* bullet
* pry-byebug
* pry-rails
* web-console

See more details on [Gemfile](./Gemfile).

## Testing

```console
$ bundle exec rspec
```

## Data reset and sample data creation

```console
$ bin/rails db:reset    # Data reset
$ bin/rails db:populate # Create sample data
```
