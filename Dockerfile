FROM ruby:2.5

ENV LANG C.UTF-8

RUN cp /usr/share/zoneinfo/Asia/Tokyo /etc/localtime

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        build-essential \
        libpq-dev \
        libmysqlclient-dev \
        postgresql-client \
        nodejs \
        vim \
    && rm -rf /var/lib/apt/lists/*

RUN gem install bundler

RUN mkdir /rails
WORKDIR /rails
ADD Gemfile /rails/Gemfile
ADD Gemfile.lock /rails/Gemfile.lock

RUN bundle install --jobs=4
ADD . /rails

EXPOSE 3000
EXPOSE 1234
