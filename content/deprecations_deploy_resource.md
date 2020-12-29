+++
title = "Deprecation: Deploy Resource (CHEF-20)"
draft = false

gh_repo = "chef-web-docs"
robots = "noindex"


aliases = "/deprecations_deploy_resource.html"
+++

The `deploy` and `deploy_revision` resources have been deprecated as of
Chef Client 13.6, and will be removed in Chef Client 14.

## Remediation

For users that require the `deploy` or `deploy_revision` resources, they
are now part of the
[deploy_resource](https://supermarket.chef.io/cookbooks/deploy_resource)
backwards compatibility cookbook available on the Supermarket.
