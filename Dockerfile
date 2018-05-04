FROM ruby:2.5

ENV LANG=C.UTF-8 \
    BUNDLE_JOBS=4 \
    BUNDLE_PATH=/bundle \
    TZ=Asia/Tokyo \
    APP_HOME=/rails

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
    && rm -rf /var/lib/apt/lists/* \
    && mkdir -p ${APP_HOME}/tmp/cache

RUN gem install bundler

ADD Gemfile /rails/Gemfile
ADD Gemfile.lock /rails/Gemfile.lock

WORKDIR ${APP_HOME}
