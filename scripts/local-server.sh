#!/bin/bash

set -eou pipefail

###
# Local deploy preview using Netlify CLI
# https://docs.netlify.com/cli/get-started/
# Run 'netlify dev'
###

npm install
npm ls

hugo server -b localhost:1313
