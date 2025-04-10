+++
title = "Deprecation: Old Exit Codes (CHEF-2)"
draft = false

gh_repo = "chef-web-docs"
robots = "noindex"
sitemapExclude = true
aliases = "/deprecations_exit_code.html"
+++

In older versions of Chef Infra Client, it wasn't possible to discern why a
chef run exited simply by examining the error code. This makes it
tricky for tools such as Test Kitchen to reason about the status of a
Chef Infra Client run. Starting in Chef Infra Client 12.11, there are now well
defined exit codes that the Chef Infra Client can use to communicate the
status of the run.

This deprecation was added in Chef Infra Client 12.11. In Chef Infra Client 13, only
the extended set of exit codes will be supported. For further
information on the list of defined error codes, please see [RFC 62,
which defines
them](https://github.com/chef/chef-rfc/blob/main/rfc062-exit-status.md).

## Remediation

If you have built automation that's dependent on the old behavior of
Chef Infra Client, we strongly recommend updating it to support the extended
set of exit codes. However, it's still possible to enable the old
behavior. Add the setting

```ruby
exit_status :disabled
```

to the Chef config file.
