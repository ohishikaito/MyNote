FROM ruby:2.5.1

RUN apt-get update -qq && \
  apt-get install -y apt-utils \
  build-essential \
  libpq-dev \
  nodejs \
  vim \
  default-mysql-client

# 作業ディレクトリの作成、設定
RUN mkdir /app
##作業ディレクトリ名をAPP_ROOTに割り当てて、以下$APP_ROOTで参照
ENV APP_ROOT /app
WORKDIR $APP_ROOT

# ホスト側（ローカル）のGemfileを追加する（ローカルのGemfileは【３】で作成）
ADD ./Gemfile $APP_ROOT/Gemfile
ADD ./Gemfile.lock $APP_ROOT/Gemfile.lock

# bundlerのバージョンを2系にする
ENV BUNDLER_VERSION='2.1.4'
RUN gem install bundler --no-document -v '2.1.4'

# Gemfileのbundle install
RUN bundle install
ADD . $APP_ROOT

RUN mkdir -p $APP_ROOT/tmp/sockets

EXPOSE 3000

