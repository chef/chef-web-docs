#!/bin/bash

set -eou pipefail

###
# Local deploy preview using Netlify CLI
# https://docs.netlify.com/cli/get-started/
# Run 'netlify dev'
###

echo Hugo env: $HUGO_ENV

npm install
npm ls

# Netlify CLI prepends node_modules/.bin to PATH when running this script.
# The pure-JS sass build in node_modules/.bin does not support the
# --embedded protocol that Hugo requires, causing an "unexpected EOF" error.
# Prepend the Homebrew bin directory so the native Dart Sass binary is
# found first.
BREW_PREFIX=$(brew --prefix 2>/dev/null || echo "/usr/local")
export PATH="${BREW_PREFIX}/bin:${PATH}"

hugo server -b localhost:1313
