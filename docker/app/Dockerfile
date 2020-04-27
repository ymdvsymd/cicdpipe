FROM ruby:2.6.6-slim

WORKDIR /cicdpipe
# 開発環境ではホストのアプリディレクトリをマウントするため不要だが、リリース時に必要
COPY . .

# 警告 "debconf: delaying package configuration, since apt-utils is not installed" 抑止のため
ENV DEBCONF_NOWARNINGS yes

# bundlerとPATHを設定
ENV LANG=C.UTF-8 \
    GEM_HOME=/bundle \
    BUNDLE_JOBS=4 \
    BUNDLE_RETRY=3
ENV BUNDLE_PATH $GEM_HOME
ENV BUNDLE_APP_CONFIG=$BUNDLE_PATH \
    BUNDLE_BIN=$BUNDLE_PATH/bin
ENV PATH /app/bin:$BUNDLE_BIN:$PATH

# Node.js 最新版インストールのため
ENV APT_KEY_DONT_WARN_ON_DANGEROUS_USAGE 1

RUN appdeps=' \
    build-essential \
    libpq-dev \
    postgresql-client \
    locales \
    ' \
    tmpdeps=' \
    curl \
    apt-transport-https \
    wget \
    ' && \
    apt-get -q update && \
    env DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends $appdeps $tmpdeps && \
    echo "ja_JP.UTF-8 UTF-8" > /etc/locale.gen && \
    locale-gen ja_JP.UTF-8 && \
    gem update --system && gem install bundler && bundle install && \
    curl -sL https://deb.nodesource.com/setup_10.x | bash - && \
    curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
    echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list && \
    apt-get -q update && \
    apt-get install -y --no-install-recommends nodejs yarn && yarn install && \
    apt-get purge -y --auto-remove $tmpdeps && apt-get clean && \
    chmod +x ./entrypoint.sh

ENV LC_ALL ja_JP.UTF-8
