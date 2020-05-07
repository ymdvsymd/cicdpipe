FROM node:14.1.0-alpine as node

RUN apk add --no-cache bash curl && \
    curl -o- -L https://yarnpkg.com/install.sh | bash -s -- --version 1.21.1


FROM ruby:2.6.6-alpine as dev

ARG APP_ROOT
ARG BUILD_CONTEXT
ARG APP_DEPS=' \
    postgresql-client \
    postgresql-dev \
    '
ARG DEV_DEPS=' \
    build-base \
    git \
    less \
    libxml2-dev \
    libxslt-dev \
    tzdata \
    '
ENV RAILS_ENV $BUILD_CONTEXT
ENV NODE_ENV $BUILD_CONTEXT

WORKDIR $APP_ROOT

COPY --from=node /usr/local/bin/node /usr/local/bin/node
COPY --from=node /opt/yarn-* /opt/yarn
RUN ln -fs /opt/yarn/bin/yarn /usr/local/bin/yarn

RUN apk add --no-cache $APP_DEPS $DEV_DEPS && \
    cp /usr/share/zoneinfo/Asia/Tokyo /etc/localtime

ENV LANG=ja_JP.UTF-8 \
    GEM_HOME=/bundle \
    BUNDLE_JOBS=4 \
    BUNDLE_RETRY=3
ENV BUNDLE_PATH $GEM_HOME
ENV BUNDLE_APP_CONFIG=$BUNDLE_PATH \
    BUNDLE_BIN=$BUNDLE_PATH/bin
ENV PATH /${APP_NAME}/bin:$BUNDLE_BIN:$PATH

RUN gem update --system && \
    gem install --no-document bundler:2.1.4

COPY . .
RUN chmod +x ./docker/app/setup-${BUILD_CONTEXT}.sh && \
    ./docker/app/setup-${BUILD_CONTEXT}.sh


FROM ruby:2.6-alpine

ARG APP_ROOT

WORKDIR $APP_ROOT

RUN apk add --no-cache $APP_DEPS tzdata && \
    cp /usr/share/zoneinfo/Asia/Tokyo /etc/localtime && \
    apk del --purge tzdata

COPY --from=dev /bundle /bundle
COPY . .

# RUN chmod +x ./entrypoint.sh

ENV LANG=ja_JP.UTF-8 \
    GEM_HOME=/bundle
ENV BUNDLE_PATH $GEM_HOME
ENV BUNDLE_APP_CONFIG=$BUNDLE_PATH \
    BUNDLE_BIN=$BUNDLE_PATH/bin
ENV PATH /${APP_NAME}/bin:$BUNDLE_BIN:$PATH

# ENTRYPOINT ["./entrypoint.sh"]
