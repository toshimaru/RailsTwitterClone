# frozen_string_literal: true

source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

gem "rails", "~> 6.0.4"

gem "active_storage_validations"
gem "bcrypt"
gem "bootsnap", require: false
gem "bootstrap-sass"
gem "font-awesome-sass", "~> 4.3"
gem "image_processing"
gem "puma"
gem "sass-rails"
gem "sqlite3"
gem "tzinfo-data", platforms: [:mingw, :mswin, :x64_mingw, :jruby]
gem "webpacker"
gem "will_paginate-bootstrap"
gem "will_paginate"

# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 4.0'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
# gem 'jbuilder', '~> 2.5'

group :development, :test do
  gem "byebug", platforms: [:mri, :mingw, :x64_mingw]
  gem "capybara"
  gem "factory_bot_rails"
  gem "faker"
  gem "pry-byebug"
  gem "pry-rails"
  gem "rspec_junit_formatter"
  gem "rspec-rails"
  gem "selenium-webdriver"
  gem "simplecov", require: false
  gem "net-smtp", require: false
end

group :development do
  gem "bullet"
  gem "listen"
  gem "rubocop"
  gem "rubocop-rails_config"
  gem "web-console"
end
