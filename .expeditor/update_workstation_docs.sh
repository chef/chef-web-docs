#!/bin/bash

set -evx

# Copy shortcode files from chef/chef-workstation/www/layouts/shortcodes
# to chef/chef-web-docs/layouts/shortcodes

git clone https://x-access-token:${GITHUB_TOKEN}@github.com/chef/chef-workstation/

curl -T "chef-workstation/www/layouts/shortcodes/*" https://api.github.com/repos/chef/chef-web-docs/layouts/shortcodes/

# Update the semver version of the chef/chef-workstation module that chef-web-docs will
# build the workstation docs from.
# See https://gohugo.io/hugo-modules/use-modules/#get-a-specific-version

hugo mod get github.com/chef/chef-workstation/@${EXPEDITOR_VERSION}
