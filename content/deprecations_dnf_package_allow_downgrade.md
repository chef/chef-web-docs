+++
title = "Deprecation: DNF Package allow_downgrade Property (CHEF-10)"
draft = false

gh_repo = "chef-web-docs"
robots = "noindex"


aliases = "/deprecations_dnf_package_allow_downgrade.html"
+++

The underlying `dnf` command in Red Hat based operating systems does not
require `--allow-downgrade` like the previous `yum` command did. This
property does not affect the `dnf_resource` resource execution and
should be removed.

## Remediation

Remove the `allow_downgrade` property on the `dnf_package` resource.
