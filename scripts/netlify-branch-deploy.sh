#!/bin/bash

set -eou pipefail

###
# Generate Netlify branch builds
# https://docs.netlify.com/site-deploys/overview/#branches-and-deploys
###

DART_SASS_VERSION="1.72.0"

echo Branch: $HEAD
echo Branch deploy URL: $DEPLOY_PRIME_URL

# Hugo requires dart-sass
# https://gohugo.io/functions/resources/tocss/#netlify

curl -LJO https://github.com/sass/dart-sass/releases/download/$DART_SASS_VERSION/dart-sass-$DART_SASS_VERSION-linux-x64.tar.gz
tar -xf dart-sass-$DART_SASS_VERSION-linux-x64.tar.gz
rm dart-sass-$DART_SASS_VERSION-linux-x64.tar.gz
export PATH=/opt/build/repo/dart-sass:$PATH

npm install
npm ls

hugo --gc --minify --enableGitInfo
