#!/bin/bash -eu

BUNDLE_WITHOUT="development test" bundle install
yarn install

SECRET_KEY_BASE=for_assets_precompile bundle exec rails assets:precompile

rm -rf ./node_modules
