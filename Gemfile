# frozen_string_literal: true

source "https://rubygems.org"

gem "rails", "~> 6.1.7.10"

gem "active_storage_validations"
gem "bcrypt"
gem "bootsnap", require: false
gem "image_processing"
gem "inline_svg"
gem "puma"
gem "sqlite3", "~> 1.7.3"
gem "tzinfo-data", platforms: [:mingw, :mswin, :x64_mingw, :jruby]
gem "webpacker"
gem "will_paginate-bootstrap-style"
gem "will_paginate"

# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 4.0'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
# gem 'jbuilder', '~> 2.5'

group :development, :test do
  gem "capybara"
  gem "debug", platforms: %i[ mri mingw x64_mingw ]
  gem "factory_bot_rails"
  gem "faker"
  gem "rspec_junit_formatter"
  gem "rspec-rails"
  gem "selenium-webdriver"
  gem "simplecov", require: false
end

group :development do
  gem "bullet"
  gem "listen"
  gem "rack-mini-profiler"
  gem "web-console"
end

group :rubocop do
  gem "code-scanning-rubocop", require: false
  gem "rubocop-rails_config"
  gem "rubocop", "~> 1.75.5"
end

gem "net-imap", "~> 0.4.22"
gem "zeitwerk", "~> 2.6.0"
gem "concurrent-ruby", "1.3.4"
