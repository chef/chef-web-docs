#!/bin/bash

set -eoux pipefail

# different chef product repos have their documentation in different subdirectories
# this variable has to be defined so we can copy content from the proper subdirectory
# that contains the docs content and properly execute the `hugo mod get` command.

if [[ "${EXPEDITOR_PROJECT}" == *"automate"* ]]; then
  org="chef"
  product_key="automate"
  subdirectory="components/docs-chef-io"
  manifest="https://packages.chef.io/files/${EXPEDITOR_TARGET_CHANNEL}/automate/latest/manifest.json"
  git_sha="$(curl -s $manifest | jq -r -c ".git_sha")"
elif [[ "${EXPEDITOR_PROJECT}" == *"habitat"* ]]; then
  org="habitat-sh"
  product_key="habitat"
  subdirectory="components/docs-chef-io"
  manifest="https://packages.chef.io/files/${EXPEDITOR_TARGET_CHANNEL}/habitat/latest/manifest.json"
  git_sha="$(curl -s $manifest | jq -r -c ".sha")"
fi

branch="expeditor/update_docs_${product_key}_${git_sha}"
git checkout -b "$branch"

# Update the semver version of the documentation module that chef-web-docs will
# use to build the docs from.
# See https://gohugo.io/hugo-modules/use-modules/#update-one-module

hugo mod get "github.com/${org}/${product_key}/${subdirectory}@${git_sha}"
hugo mod tidy

# Update the vendored files in chef-web-docs
# See https://gohugo.io/hugo-modules/use-modules/#vendor-your-modules

hugo mod vendor

###
# Manage Habitat generated pages
###

# Habitat has two generated files (habitat_cli.md and service_templates.md) that
# are made during the release pipeline.
# Those two pages are generated and then pushed up to
# https://packages.chef.io/files/stable/habitat/latest/generated-documentation.tar.gz

# To add these files to chef-web-docs and doc.chef.io, this script uses curl to pull down the
# generated-documentation.tar.gz file, and then overwrite the blank pages pulled
# in by Hugo from github.com/habitat-sh/habitat

# See:
# - https://github.com/habitat-sh/habitat/pull/7993
# - github.com/habitat-sh/habitat/blob/master/components/docs-chef-io/content/habitat/habitat_cli.md
# - github.com/habitat-sh/habitat/blob/master/components/docs-chef-io/content/habitat/service_templates.md
# - github.com/chef/chef-web-docs/blob/master/_vendor/github.com/habitat-sh/habitat/components/docs-chef-io/content/habitat/habitat_cli.md
# - github.com/chef/chef-web-docs/blob/master/_vendor/github.com/habitat-sh/habitat/components/docs-chef-io/content/habitat/service_templates.md

if [[ "${EXPEDITOR_PROJECT}" == *"habitat"* ]]; then
  curl --silent --output generated-documentation.tar.gz https://packages.chef.io/files/${EXPEDITOR_TARGET_CHANNEL}/habitat/latest/generated-documentation.tar.gz
  tar xvzf generated-documentation.tar.gz -C content/habitat
  rm generated-documentation.tar.gz
fi


# submit pull request to chef/chef-web-docs

git add .

# give a friendly message for the commit and make sure it's noted for any future
# audit of our codebase that no DCO sign-off is needed for this sort of PR since
#it contains no intellectual property

dco_safe_git_commit "Bump Hugo module $product_key to latest $EXPEDITOR_TARGET_CHANNEL release ($git_sha)."

open_pull_request

# Get back to master and cleanup the leftovers - any changed files left over at
# the end of this script will get committed to master.
git checkout -
git branch -D "$branch"
