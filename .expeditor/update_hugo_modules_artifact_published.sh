#!/bin/bash

set -eoux pipefail

branch="expeditor/update_docs_${EXPEDITOR_PRODUCT_KEY}_${EXPEDITOR_VERSION}"
git checkout -b "$branch"

# different chef product repos have their documentation in different subdirectories
# this variable has to be defined so we can copy content from the proper subdirectory
# that contains the docs content and properly execute the `hugo mod get` command.

if [ "${EXPEDITOR_PRODUCT_KEY}" == "chef-workstation" ]; then
  subdirectory="docs-chef-io"
  org="chef"
  tag_prefix=""
  tag_suffix=""
elif [ "${EXPEDITOR_PRODUCT_KEY}" == "inspec" ]; then
  subdirectory="docs-chef-io"
  org="inspec"
  tag_prefix="v"
  tag_suffix="^{}"
fi

# Return the commit SHA that matches the product tag.

git_sha="$(git ls-remote https://github.com/${org}/${EXPEDITOR_PRODUCT_KEY}.git rev-list --refs -n 1 ${tag_prefix}${EXPEDITOR_VERSION}${tag_suffix} | cut -f 1)"

# Update the repository commit that chef-web-docs will
# use to build the InSpec or Workstation documentation.
# See https://gohugo.io/hugo-modules/use-modules/#update-one-module

hugo mod get "github.com/${org}/${EXPEDITOR_PRODUCT_KEY}/${subdirectory}@${git_sha}"
hugo mod tidy

# Update the vendored files in chef-web-docs
# See https://gohugo.io/hugo-modules/use-modules/#vendor-your-modules

hugo mod vendor

# submit pull request to chef/chef-web-docs

git add .

# give a friendly message for the commit and make sure it's noted for any future
# audit of our codebase that no DCO sign-off is needed for this sort of PR since
#it contains no intellectual property

dco_safe_git_commit "Bump Hugo module $EXPEDITOR_PRODUCT_KEY to $EXPEDITOR_VERSION."

open_pull_request

# Get back to master and cleanup the leftovers - any changed files left over at
# the end of this script will get committed to master.
git checkout -
git branch -D "$branch"
