#!/bin/bash

set -evx

# Copy shortcode files from chef product repo
# to chef/chef-web-docs/layouts/shortcodes

branch="expeditor/${EXPEDITOR_PRODUCT_KEY}_${EXPEDITOR_VERSION}"
git checkout -b "$branch"

# different chef product repos have their documentation in different subdirectories
# this variable has to be defined so we can copy content from the proper subdirectory
# that contains the docs content and properly execute the `hugo mod get` command.

if [ ${EXPEDITOR_PRODUCT_KEY} == "chef-workstation" ]
then subdirectory="www"
fi

git clone https://x-access-token:${GITHUB_TOKEN}@github.com/chef/${EXPEDITOR_PRODUCT_KEY}/

pushd ${EXPEDITOR_PRODUCT_KEY}
cp $subdirectory/layouts/shortcodes/* ../layouts/shortcodes/
popd

# delete Chef product repo

rm -rf ${EXPEDITOR_PRODUCT_KEY}

# Update the semver version of the chef/chef-workstation module that chef-web-docs will
# build the workstation docs from.
# See https://gohugo.io/hugo-modules/use-modules/#get-a-specific-version

hugo mod get github.com/chef/${EXPEDITOR_PRODUCT_KEY}/$subdirectory/@${EXPEDITOR_VERSION}
hugo mod tidy

# submit pull request to chef/chef-web-docs

git add .

# give a friendly message for the commit and make sure it's noted for any future
# audit of our codebase that no DCO sign-off is needed for this sort of PR since
#it contains no intellectual property

dco_safe_commit "Bump Hugo module $EXPEDITOR_PRODUCT_KEY to $EXPEDITOR_VERSION.

The new commit for $EXPEDITOR_PRODUCT_KEY is $EXPEDITOR_BUILD_COMMIT"

open_pull_request

# Get back to master and cleanup the leftovers - any changed files left over at
# the end of this script will get committed to master.
git checkout -
git branch -D "$branch"
