#!/bin/bash -eu

BUNDLE_WITHOUT="development test" bundle install
yarn install

bundle exec rails assets:precompile

apt-get purge -y --auto-remove $TMP_DEPS $BUILD_DEPS && apt-get clean
rm -rf ./node_modules /var/lib/apt/lists/* /tmp/* /var/tmp/*
truncate -s 0 /var/log/*log

chmod +x ./entrypoint.sh
