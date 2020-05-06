ARG APP_NAME=cicdpipe
ARG APP_DEPS=' \
    postgresql-client \
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

FROM ruby:2.6.6-slim AS dev-env

ARG BUILD_CONTEXT
ARG APP_NAME
ARG APP_DEPS
ARG BUILD_DEPS
ARG TMP_DEPS

ENV RAILS_ENV $BUILD_CONTEXT
ENV NODE_ENV $BUILD_CONTEXT
# Node.js 最新版インストールのため
ENV APT_KEY_DONT_WARN_ON_DANGEROUS_USAGE 1
# bundlerとPATHを設定
ENV LANG=C.UTF-8\
    GEM_HOME=/bundle\
    BUNDLE_JOBS=4 \
    BUNDLE_RETRY=3
ENV BUNDLE_PATH $GEM_HOME
ENV BUNDLE_APP_CONFIG=$BUNDLE_PATH \
    BUNDLE_BIN=$BUNDLE_PATH/bin
ENV PATH /${APP_NAME}/bin:$BUNDLE_BIN:$PATH

WORKDIR /${APP_NAME}
# 開発環境ではホストのアプリディレクトリをマウントするため不要だが、リリース時に必要
COPY . .

# gem update --systemで、bundlerのverは上がるので、gem install bundlerしない
RUN apt-get -qq update && apt-get install -yq --no-install-recommends $TMP_DEPS && \
    curl -sL https://deb.nodesource.com/setup_10.x | bash - && \
    curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
    echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list && \
    apt-get -qq update && apt-get install -yq --no-install-recommends $APP_DEPS $BUILD_DEPS && \
    gem update --system

RUN chmod +x ./docker/app/setup-${BUILD_CONTEXT}.sh && \
    ./docker/app/setup-${BUILD_CONTEXT}.sh

#
# for production
#
FROM ruby:2.6.6-alpine

ARG APP_NAME
ARG APP_DEPS

ENV RAILS_ENV production
ENV NODE_ENV production
ENV LANG=C.UTF-8\
    GEM_HOME=/bundle\
    BUNDLE_JOBS=4 \
    BUNDLE_RETRY=3
ENV BUNDLE_PATH $GEM_HOME
ENV BUNDLE_APP_CONFIG=$BUNDLE_PATH \
    BUNDLE_BIN=$BUNDLE_PATH/bin
ENV PATH /${APP_NAME}/bin:$BUNDLE_BIN:$PATH

WORKDIR /${APP_NAME}
COPY . .
COPY --from=dev-env /bundle /bundle

RUN apk add --no-cache $APP_DEPS && \
    gem update --system && \
    chmod +x ./entrypoint.sh
