#!/bin/bash

set -eou pipefail

# This block translates the "channel" into the appropriate set of VPC settings
# used in terraform/Makefile. These settings still rely on old Workflow-isms,
# which is why the TF_ENVIRONMENT name doesn't match up with the CHANNEL.
if [ "$ENVIRONMENT" == "acceptance" ]; then
  export TF_ENVIRONMENT=acceptance
elif [ "$ENVIRONMENT" == "production" ]; then
  export TF_ENVIRONMENT=delivered
else
  puts "We do not currently support deploying channel $CHANNEL"
  exit 1
fi

aws-configure chef-cd

cd terraform
make apply