FROM ruby:2.7.0-slim
MAINTAINER Katsuma Narisawa <katsuma.narisawa@gmail.com>

RUN apt-get update -qq \
  && DEBIAN_FRONTEND=noninteractive apt-get install -yq --no-install-recommends \
    build-essential \
    gnupg2 \
    curl \
    less \
    git \
    vim \
    file \
    mariadb-client \
    libmariadbd-dev \
    libxml2-dev \
    apt-transport-https \
  && apt-get clean -y \
  && rm -rf /var/cache/apt/archives/* \
  && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* \
  && truncate -s 0 /var/log/*log

ENV LANG=C.UTF-8 \
    APP_PATH=/app
WORKDIR ${APP_PATH}

RUN gem install bundler:2.0.2
RUN bundle config path /usr/local/bundle

# For production image
ADD Gemfile ${APP_PATH}/Gemfile
ADD Gemfile.lock ${APP_PATH}/Gemfile.lock
RUN bundle install
COPY . $APP_PATH
