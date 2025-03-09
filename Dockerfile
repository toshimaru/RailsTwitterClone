FROM ruby:3.3 AS base
WORKDIR /app

FROM base AS bundle-installer

COPY Gemfile Gemfile.lock ./
RUN bundle install --jobs=4

FROM base

RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - \
    && echo "deb https://dl.yarnpkg.com/debian/ stable main" > /etc/apt/sources.list.d/yarn.list
RUN curl -sL https://deb.nodesource.com/setup_16.x | bash -
RUN apt update -qq && apt install -y nodejs chromium-driver yarn && apt clean && rm -rf /var/lib/apt/lists/*
COPY Gemfile Gemfile.lock package.json yarn.lock ./

RUN yarn install
COPY --from=bundle-installer /usr/local/bundle/ /usr/local/bundle/
RUN bundle install
