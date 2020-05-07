#!/bin/sh -eu

BUNDLE_WITHOUT="development" bundle install
NODE_ENV="production" yarn install
