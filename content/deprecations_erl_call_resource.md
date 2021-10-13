+++
title = "Deprecation: Deprecation of the erl_call resource (CHEF-22)"
draft = false

gh_repo = "chef-web-docs"
robots = "noindex"
sitemapExclude = true
aliases = "/deprecations_erl_call_resource.html"
+++

The erl_call resource was deprecated in Chef Client 13.7 and removed
from Chef Client 14.0 (April 2018).

The [Cookstyle](/workstation/cookstyle/) cop
[ChefDeprecations/ErlCallResource](https://github.com/chef/cookstyle/blob/main/docs/cops_chefdeprecations.md#chefdeprecationserlcallresource)
has been introduced to detect this deprecation.

## Remediation

Remove usage of the erl_call resource from all cookbooks.
