+++
title = "Deprecation: DNF Package allow_downgrade Property (CHEF-10)"
draft = false

gh_repo = "chef-web-docs"
robots = "noindex"
sitemapExclude = true
aliases = "/deprecations_dnf_package_allow_downgrade.html"
+++

The underlying `dnf` command in Red Hat based operating systems doesn't
require `--allow-downgrade` like the previous `yum` command did. This
property doesn't affect the `dnf_resource` resource execution and
should be removed.

## Remediation

Remove the `allow_downgrade` property on the `dnf_package` resource.
