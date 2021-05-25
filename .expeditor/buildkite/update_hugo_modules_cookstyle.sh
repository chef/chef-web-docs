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

# There may be new cops added or old cops deleted. If that's the case, we need to regenerate the markdown files that are
# used to display the cookstyle cops pages. See the Makefile for more information.

if git ls-files --deleted --others _vendor/github.com/chef/cookstyle/docs-chef-io/data/cookstyle | grep -Eq '\.yml'; then
  make cookstyle_cops_pages
fi


# Clean the go.sum file

rm go.sum
hugo mod clean

# Submit pull request to chef/chef-web-docs.

git add .

# Give a friendly message for the commit and make sure it's noted for any future
# audit of our codebase that no DCO sign-off is needed for this sort of PR since
# it contains no intellectual property

git commit \
    --signoff \
    --message "Bump Hugo module chef/cookstyle to latest ${EXPEDITOR_TARGET_CHANNEL}."

gh pr create --title "Bump Hugo module chef/cookstyle" \
    --body "Bump Hugo module chef/cookstyle to latest ${EXPEDITOR_TARGET_CHANNEL}"

# Get back to master and cleanup the leftovers - any changed files left over at
# the end of this script will get committed to master.
git checkout -
git branch -D "$branch"
