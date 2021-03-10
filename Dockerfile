FROM ruby:2.7

RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - \
    && echo "deb https://dl.yarnpkg.com/debian/ stable main" > /etc/apt/sources.list.d/yarn.list
RUN apt update -qq && apt install -y nodejs chromium-driver yarn && apt clean && rm -rf /var/lib/apt/lists/*
RUN mkdir /app
COPY Gemfile Gemfile.lock package.json yarn.lock /app/
WORKDIR /app
RUN gem install bundler
RUN bundle install
RUN yarn install
