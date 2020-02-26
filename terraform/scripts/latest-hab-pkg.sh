#!/bin/bash

#
# This file is used to determine if any of the Hugo source files have been
# modified, thus indicating it is necessary to rebuild the Hugo site.
#

function error_exit() {
  echo "$1" 1>&2
  exit 1
}

function check_deps() {
  test -f "$(command -v jq)" || error_exit "jq command not detected in path, please install it"
}

function parse_input() {
  # jq reads from stdin so we don't have to set up any inputs, but let's validate the outputs
  eval "$(jq -r '@sh "export CHANNEL=\(.channel)"')"
  if [[ "${CHANNEL:-}x" == "x" ]]; then export CHANNEL="acceptance"; fi
}

function calculate_pkg_ident() {
  PKG_IDENT=$(curl https://bldr.habitat.sh/v1/depot/channels/chef/${CHANNEL}/pkgs/docs-chef-io/latest | jq -r -e '.ident_array | join("/")')
  jq -n --arg pkg_ident "$PKG_IDENT" '{"pkg_ident":$pkg_ident}'
}

# main
check_deps
parse_input
calculate_pkg_ident
