FROM ruby:2.4

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

RUN mkdir /%app_name%
WORKDIR /%app_name%
ADD Gemfile /%app_name%/Gemfile
ADD Gemfile.lock /%app_name%/Gemfile.lock

RUN bundle install --path vendor/bundle
ADD . /%app_name%

EXPOSE 3000
EXPOSE 1234
