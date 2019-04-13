#!/bin/bash

set -euo pipefail

if [ "$ENVIRONMENT" == "acceptance" ]; then
  export TF_ENVIRONMENT=acceptance
elif [ "$ENVIRONMENT" == "production" ]; then
  export TF_ENVIRONMENT=delivered
else
  puts "We do not currently support deploying $ENVIRONMENT"
  exit 1
fi

configure-github-account chef-ci
aws-configure chef-cd

cd terraform
make apply
