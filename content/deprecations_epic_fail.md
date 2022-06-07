+++
title = "Deprecation: epic_fail (CHEF-24)"
draft = false

gh_repo = "chef-web-docs"
robots = "noindex"
sitemapExclude = true
aliases = "/deprecations_epic_fail.html"
+++

The original name for the `ignore_failure` property in resources was
`epic_fail`. Our documentation has not referred to `epic_fail` for years
and out of the 3500 cookbooks on the Supermarket only one uses
`epic_fail`. In Chef Infra Client 14 we will remove the `epic_fail` property
entirely.

The [Cookstyle](/workstation/cookstyle/) cop
[ChefDeprecations/EpicFail](https://github.com/chef/cookstyle/blob/main/docs/cops_chefdeprecations.md#chefdeprecationsepicfail)
has been introduced to detect and autocorrect this deprecation.

## Remediation

Replace any usage of `epic_fail` with `ignore_failure`.
