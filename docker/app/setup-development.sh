#!/bin/bash -eu

bundle install
yarn install

apt-get purge -y --auto-remove $TMP_DEPS && apt-get clean
