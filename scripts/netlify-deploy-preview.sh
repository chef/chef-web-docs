#!/bin/bash

set -eou pipefail

###
# Generate Netlify build previews for a pull request
# https://docs.netlify.com/site-deploys/overview/#branches-and-deploys
###

echo Branch: $HEAD
echo Branch deploy URL: $DEPLOY_PRIME_URL

pushd themes/docs-new && npm install && popd
hugo --gc --minify --enableGitInfo --buildFuture
