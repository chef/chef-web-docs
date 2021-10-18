+++
title = "Deprecation: Easy Install Resource (CHEF-6)"
draft = false

gh_repo = "chef-web-docs"
robots = "noindex"
sitemapExclude = true
aliases = "/deprecations_easy_install.html"
+++

The Python community recommends that users prefer `pip` rather than
`easy_install` to install python packages.

The `easy_install` resource was deprecated in Chef Client 12.10, and
will be removed in Chef Client 13.

The [Cookstyle](/workstation/cookstyle/) cop
[ChefDeprecations/EasyInstallResource](https://github.com/chef/cookstyle/blob/main/docs/cops_chefdeprecations.md#chefdeprecationseasyinstallresource)
has been introduced to detect this deprecation.

## Remediation

There is no built-in replacement for `easy_install` in Chef Infra Client
at this time.
