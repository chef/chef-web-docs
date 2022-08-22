#!/bin/bash

set -eoux pipefail

branch="expeditor/update_docs_${EXPEDITOR_REPO}_${EXPEDITOR_NUMBER}"
git checkout -b "$branch"


# Update the documentation module that chef-web-docs will
# use to build the docs from.
# See https://gohugo.io/hugo-modules/use-modules/#update-one-module

if [ "${EXPEDITOR_REPO}" == "chef/compliance-remediation-2022" ]; then
    module_suffix=""
else
    module_suffix="/docs-chef-io"
fi

hugo mod get -u github.com/${EXPEDITOR_REPO}${module_suffix}
hugo mod tidy

# Update the vendored files in chef-web-docs
# See https://gohugo.io/hugo-modules/use-modules/#vendor-your-modules

hugo mod vendor

# Clean the go.sum file

rm go.sum
hugo mod clean

# submit pull request to chef/chef-web-docs

git add .

# give a friendly message for the commit and make sure it's noted for any future
# audit of our codebase that no DCO sign-off is needed for this sort of PR since
#it contains no intellectual property

dco_safe_git_commit "Bump Hugo module ${EXPEDITOR_REPO} for ${EXPEDITOR_AGENT_CONFIG_GITHUB_REPO}#${EXPEDITOR_NUMBER}."

open_pull_request

# Get back to main and cleanup the leftovers - any changed files left over at
# the end of this script will get committed to main.
git checkout -
git branch -D "$branch"
