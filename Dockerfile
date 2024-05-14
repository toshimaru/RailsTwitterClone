FROM ruby:3.3 AS bundle-installer

WORKDIR /tmp
COPY Gemfile Gemfile.lock /tmp/
RUN bundle install --jobs=2

FROM ruby:3.3

RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - \
    && echo "deb https://dl.yarnpkg.com/debian/ stable main" > /etc/apt/sources.list.d/yarn.list
RUN curl -sL https://deb.nodesource.com/setup_16.x | bash -
RUN apt update -qq && apt install -y nodejs chromium-driver yarn && apt clean && rm -rf /var/lib/apt/lists/*
RUN mkdir /app
COPY Gemfile Gemfile.lock package.json yarn.lock /app/

WORKDIR /app
RUN yarn install
COPY --from=bundle-installer /usr/local/bundle/ /usr/local/bundle/
RUN bundle install
