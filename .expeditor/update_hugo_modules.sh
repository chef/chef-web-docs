#!/bin/bash

set -evx

# Copy shortcode files from chef product repo
# to chef/chef-web-docs/layouts/shortcodes

branch="expeditor/${EXPEDITOR_PRODUCT_KEY}_${EXPEDITOR_VERSION}"
git checkout -b "$branch"

git clone https://x-access-token:${GITHUB_TOKEN}@github.com/chef/${EXPEDITOR_PRODUCT_KEY}/

pushd ${EXPEDITOR_PRODUCT_KEY}
cp www/layouts/shortcodes/* ../layouts/shortcodes/
popd

# delete Chef product repo

rm -rf ${EXPEDITOR_PRODUCT_KEY}

# Update the semver version of the chef/chef-workstation module that chef-web-docs will
# build the workstation docs from.
# See https://gohugo.io/hugo-modules/use-modules/#get-a-specific-version

hugo mod get github.com/chef/${EXPEDITOR_PRODUCT_KEY}/@${EXPEDITOR_VERSION}
hugo mod tidy

# submit pull request to chef/chef-web-docs

git add .

# give a friendly message for the commit and make sure it's noted for any future
# audit of our codebase that no DCO sign-off is needed for this sort of PR since
#it contains no intellectual property

git commit --message "Bump Hugo module $EXPEDITOR_PRODUCT_KEY to $EXPEDITOR_VERSION" --message "The new commit for $EXPEDITOR_PRODUCT_KEY is $EXPEDITOR_BUILD_COMMIT" --message "This pull request was triggered automatically via Expeditor when $EXPEDITOR_PRODUCT_KEY $EXPEDITOR_VERSION was promoted to stable." --message "This change falls under the obvious fix policy so no Developer Certificate of Origin (DCO) sign-off is required."

open_pull_request

# Get back to master and cleanup the leftovers - any changed files left over at
# the end of this script will get committed to master.
git checkout -
git branch -D "$branch"
