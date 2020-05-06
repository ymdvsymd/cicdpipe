FROM ruby:2.6.6-slim

ARG BUILD_CONTEXT

ENV RAILS_ENV $BUILD_CONTEXT
ENV NODE_ENV $BUILD_CONTEXT

# 警告 "debconf: delaying package configuration, since apt-utils is not installed" 抑止のため
ENV DEBCONF_NOWARNINGS yes
# Node.js 最新版インストールのため
ENV APT_KEY_DONT_WARN_ON_DANGEROUS_USAGE 1
# 入力待ちを防ぐため
ENV DEBIAN_FRONTEND noninteractive
# 一時変数としてARGを使う
ARG APP_DEPS=' \
    postgresql-client \
    locales \
    '
ARG BUILD_DEPS=' \
    build-essential \
    libpq-dev \
    nodejs \
    yarn \
    '
ARG TMP_DEPS=' \
    apt-transport-https \
    curl \
    '

# bundlerとPATHを設定
ENV LANG=C.UTF-8 \
    GEM_HOME=/bundle \
    BUNDLE_JOBS=4 \
    BUNDLE_RETRY=3
ENV BUNDLE_PATH $GEM_HOME
ENV BUNDLE_APP_CONFIG=$BUNDLE_PATH \
    BUNDLE_BIN=$BUNDLE_PATH/bin
ENV PATH /app/bin:$BUNDLE_BIN:$PATH

WORKDIR /cicdpipe
# 開発環境ではホストのアプリディレクトリをマウントするため不要だが、リリース時に必要
COPY . .

# gem update --systemで、bundlerのverは上がるので、gem install bundlerしない
RUN apt-get -qq update && apt-get install -yq --no-install-recommends $TMP_DEPS && \
    curl -sL https://deb.nodesource.com/setup_10.x | bash - && \
    curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
    echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list && \
    apt-get -qq update && apt-get install -yq --no-install-recommends $APP_DEPS $BUILD_DEPS && \
    echo "ja_JP.UTF-8 UTF-8" > /etc/locale.gen && locale-gen ja_JP.UTF-8 && \
    gem update --system

ENV LC_ALL ja_JP.UTF-8

RUN chmod +x ./docker/app/setup-${BUILD_CONTEXT}.sh && \
    ./docker/app/setup-${BUILD_CONTEXT}.sh

# 元に戻す
ENV DEBIAN_FRONTEND dialog
