FROM ruby:2.7

RUN apt-get update -qq && apt-get install -y nodejs chromium-driver && apt-get clean && rm -rf /var/lib/apt/lists/*
RUN mkdir /app
COPY Gemfile Gemfile.lock /app/
WORKDIR /app
RUN gem install bundler
RUN bundle install
