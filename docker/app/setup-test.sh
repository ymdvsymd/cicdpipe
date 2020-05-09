#!/bin/sh -eu

BUNDLE_WITHOUT="development" bundle install
NODE_ENV="production" yarn install

SECRET_KEY_BASE=for_assets_precompile bundle exec rails assets:precompile

apk del --purge $BUILD_DEPS
rm -rf ${APP_ROOT}/node_modules
