FROM ruby:2.5

ENV LANG C.UTF-8

RUN cp /usr/share/zoneinfo/Asia/Tokyo /etc/localtime
RUN curl -sL https://deb.nodesource.com/setup_8.x | bash -
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - \
    && echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        build-essential \
        libpq-dev \
        default-libmysqlclient-dev \
        postgresql-client \
        nodejs \
        vim \
        yarn \
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
