#!/bin/bash

set -euo pipefail

aws-configure chef-cd

# Process the legacy redirects
while IFS== read -r key value; do
  aws s3api put-object \
    --profile chef-cd \
    --acl public-read \
    --bucket "chef-web-docs-$ENVIRONMENT.cd.chef.co" \
    --key $key \
    --website-redirect-location $value
done < <(jq -r 'to_entries | .[] | .key + "=" + .value ' config/redirects.json)
