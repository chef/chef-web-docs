#!/bin/bash

set -eoux pipefail


branch="expeditor/update_docs_chef_automate"
git checkout -b "$branch"

# Update the semver version of the documentation module that chef-web-docs will
# use to build the docs from.
# See https://gohugo.io/hugo-modules/use-modules/#update-one-module

hugo mod get github.com/chef/automate/components/docs-chef-io
hugo mod tidy

# Update the vendored files in chef-web-docs
# See https://gohugo.io/hugo-modules/use-modules/#vendor-your-modules

hugo mod vendor

# submit pull request to chef/chef-web-docs

git add .

# give a friendly message for the commit and make sure it's noted for any future
# audit of our codebase that no DCO sign-off is needed for this sort of PR since
#it contains no intellectual property

dco_safe_git_commit "Bump Hugo module chef/automate to latest release."

open_pull_request

# Get back to master and cleanup the leftovers - any changed files left over at
# the end of this script will get committed to master.
git checkout -
git branch -D "$branch"
