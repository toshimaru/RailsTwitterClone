[![RSpec](https://github.com/toshimaru/RailsTwitterClone/actions/workflows/rspec.yml/badge.svg?branch=main)](https://github.com/toshimaru/RailsTwitterClone/actions/workflows/rspec.yml)
[![Maintainability](https://qlty.sh/gh/toshimaru/projects/RailsTwitterClone/maintainability.svg)](https://qlty.sh/gh/toshimaru/projects/RailsTwitterClone)
[![Code Coverage](https://qlty.sh/gh/toshimaru/projects/RailsTwitterClone/coverage.svg)](https://qlty.sh/gh/toshimaru/projects/RailsTwitterClone)
[![CircleCI](https://circleci.com/gh/toshimaru/RailsTwitterClone.svg?style=svg)](https://circleci.com/gh/toshimaru/RailsTwitterClone)
![Supported Ruby Version](https://img.shields.io/badge/Ruby-v3.3-green)
![Supported Rails Version](https://img.shields.io/badge/Rails-v6.1-green)

# Rails Twitter Clone

Simple Twitter clone using Ruby on Rails 6.

![Twitter Clone Screen Capture](https://user-images.githubusercontent.com/803398/154789978-e2a4c50d-150b-4d21-885a-81209fc6893e.png)

## Implementation

This implementation is based on [Ruby on Rails Tutorial](https://www.railstutorial.org/book) by [@mhartl](https://github.com/mhartl).

## Supported Ruby version

- v3.3
- v3.2
- v3.1

## Setup

Check out this repository and then,

```console
$ bin/setup
```

### Start Rails server

```console
$ bin/rails server
```

## Features

This application doesn't provide many features in order to keep it simple. Here are the features that it does include:

* See TimeLine
* Post new Tweet with image
* Follow/Unfollow User
* Edit user profile

## Used gem

### JavaScript

- webpacker
- @rails/ujs

### CSS

- bootstrap (v5)

### Database

- sqlite3

### For testing

* rspec
* capybara
* factory_bot
* faker
* simplecov

### For debugging

* bullet
* debug
* rack-mini-profiler
* rubocop
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

## Other Resources

- [mhartl/sample_app_6th_ed: The main sample app for the Ruby on Rails Tutorial, 6th Edition](https://github.com/mhartl/sample_app_6th_ed)
- [Ruby on Rails Guides (v6.1)](https://guides.rubyonrails.org/v6.1/)
