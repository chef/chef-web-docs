#!/bin/bash

set -eou pipefail

aws-configure chef-cd

ceval "aws s3 sync build s3://chef-web-docs-${ENVIRONMENT}.cd.chef.co --profile chef-cd"