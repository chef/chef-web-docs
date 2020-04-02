#!/bin/bash

set -evx

# Copy shortcode files from chef product repo
# to chef/chef-web-docs/layouts/shortcodes

git clone https://x-access-token:${GITHUB_TOKEN}@github.com/chef/${EXPEDITOR_PRODUCT_KEY}/

pushd ${EXPEDITOR_PRODUCT_KEY}
git checkout ${EXPEDITOR_VERSION}
cp www/layouts/shortcodes/* ../chef-web-docs/layouts/shortcodes/
popd

# Update the semver version of the chef/chef-workstation module that chef-web-docs will
# build the workstation docs from.
# See https://gohugo.io/hugo-modules/use-modules/#get-a-specific-version

hugo mod get github.com/chef/${EXPEDITOR_PRODUCT_KEY}/@${EXPEDITOR_VERSION}

# submit pull request to chef/chef-web-docs

git add .

git commit --message "Bump Hugo module $EXPEDITOR_PRODUCT_KEY to $EXPEDITOR_VERSION" --message "The new commit for $EXPEDITOR_PRODUCT_KEY is $EXPEDITOR_BUILD_COMMIT" --message "This pull request was triggered automatically via Expeditor when $EXPEDITOR_PRODUCT_KEY $EXPEDITOR_VERSION was promoted to stable." --message "This change falls under the obvious fix policy so no Developer Certificate of Origin (DCO) sign-off is required."

open_pull_request
