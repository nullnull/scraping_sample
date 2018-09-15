FROM ruby:2.5.1
MAINTAINER Katsuma Narisawa <katsuma.narisawa@gmail.com>

ENV LANG=C.UTF-8 \
    APP_PATH=/app
WORKDIR ${APP_PATH}

RUN curl -sL https://deb.nodesource.com/setup_9.x | bash -
RUN apt-get update -qq
RUN apt-get install -y apt-utils build-essential apt-transport-https libpq-dev vim-nox mysql-client libxml2-dev

ADD Gemfile ${APP_PATH}/Gemfile
ADD Gemfile.lock ${APP_PATH}/Gemfile.lock
RUN bundle install

COPY . $APP_PATH
