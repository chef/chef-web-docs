#!/bin/bash

set -eou pipefail

###
# Local deploy preview using Netlify CLI
# https://docs.netlify.com/cli/get-started/
# Run 'netlify dev'
###

pushd themes/docs-new && npm install && popd
hugo server -b localhost:1313
