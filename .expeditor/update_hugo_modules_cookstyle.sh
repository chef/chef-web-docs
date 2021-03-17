#!/bin/bash

set -eoux pipefail

# Create a new branch and checkout that branch.

branch="expeditor/update_docs_cookstyle"
git checkout -b "$branch"

# Update the go.mod and go.sum for chef/cookstyle

hugo mod get "github.com/chef/cookstyle"
hugo mod get "github.com/chef/cookstyle/docs-chef-io"
hugo mod tidy

# Update the vendored files in chef-web-docs.
# See https://gohugo.io/hugo-modules/use-modules/#vendor-your-modules

hugo mod vendor

# Submit pull request to chef/chef-web-docs.

git add .

# Give a friendly message for the commit and make sure it's noted for any future
# audit of our codebase that no DCO sign-off is needed for this sort of PR since
# it contains no intellectual property

dco_safe_git_commit "Bump Hugo module ${EXPEDITOR_PROJECT} to latest {$EXPEDITOR_TARGET_CHANNEL}."

open_pull_request

# Get back to master and cleanup the leftovers - any changed files left over at
# the end of this script will get committed to master.
git checkout -
git branch -D "$branch"
