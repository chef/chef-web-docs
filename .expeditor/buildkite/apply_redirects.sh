#!/bin/bash

set -euo pipefail

aws-configure chef-cd

bucket_name="chef-web-docs-$ENVIRONMENT.cd.chef.co"
# This is the key our `cd_hugo_static_site` Terraform module uses to
# purge Fastly.
surrogate_key="hugo/chef-cd/chef-web-docs-$ENVIRONMENT"

# Process the legacy redirects
while IFS== read -r key value; do
  aws s3api put-object \
    --profile chef-cd \
    --acl public-read \
    --bucket $bucket_name \
    --key $key \
    --website-redirect-location $value \
    --metadata "{\"surrogate-key\": \"$surrogate_key\"}" > /dev/null

  echo "Created $key -> $value redirect object in $bucket_name"
done < <(jq -r 'to_entries | .[] | .key + "=" + .value ' config/redirects.json)
