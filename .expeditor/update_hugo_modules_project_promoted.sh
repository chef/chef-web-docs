#!/bin/bash

set -euo pipefail
set -x

# different chef product repos have their documentation in different subdirectories
# this variable has to be defined so we can copy content from the proper subdirectory
# that contains the docs content and properly execute the `hugo mod get` command.

case "${EXPEDITOR_PROJECT}" in
  *"automate-private"*)
    org="chef"
    product_key="automate-private"
    subdirectory="components/docs-chef-io"
    ;;
  *"habitat"*)
    org="habitat-sh"
    product_key="habitat"
    subdirectory="components/docs-chef-io"
    ;;
  *)
    echo "Unsupported EXPEDITOR_PROJECT: ${EXPEDITOR_PROJECT}" >&2
    exit 1
    ;;
esac

timestamp="$(date '+%Y-%m-%dT%H-%M-%S')"
branch="expeditor/update_docs_${product_key}_${timestamp}"
git checkout -B "$branch"

# Update the semver version of the documentation module that chef-web-docs will
# use to build the docs from.
# See https://gohugo.io/hugo-modules/use-modules/#update-one-module

hugo mod get "github.com/${org}/${product_key}/${subdirectory}"
hugo mod tidy

# Update the vendored files in chef-web-docs
# See https://gohugo.io/hugo-modules/use-modules/#vendor-your-modules

hugo mod vendor

# Clean the go.sum file

rm -f go.sum
hugo mod clean

# submit pull request to chef/chef-web-docs

git add .

if git diff --cached --quiet; then
  echo "No documentation module updates found for ${product_key}."
  git checkout -
  git branch -D "$branch"
  exit 0
fi

# give a friendly message for the commit and make sure it's noted for any future
# audit of our codebase that no DCO sign-off is needed for this sort of PR since
#it contains no intellectual property

dco_safe_git_commit "Bump Hugo module ${product_key} to latest ${EXPEDITOR_TARGET_CHANNEL} release."

open_pull_request

# Get back to main and cleanup the leftovers - any changed files left over at
# the end of this script will get committed to main.
git checkout -
git branch -D "$branch"
