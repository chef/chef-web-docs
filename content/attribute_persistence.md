+++
title = "Attribute Persistence"
draft = false

gh_repo = "chef-web-docs"

[menu]
  [menu.infra]
    title = "Attribute Persistence"
    identifier = "chef_infra/cookbook_reference/attributes/attribute_persistence.md Attributes"
    parent = "chef_infra/cookbook_reference/attributes"
+++

{{% node_attribute_persistence %}}

## Limiting Attribute Persistence

Some organizations find it helpful to control attribute data stored to the Chef Infra Server in order to limit the disk and CPU resources used when processing unused attributes. For example, your organization may find the data from the Ohai `Package` plugin useful when writing cookbooks, but you don't see the need in saving ~100k of package information for each Chef Infra Client run. By limiting the data that is saved to the Chef Infra Server, it will still be available on the node within cookbooks, but won't be saved to the Chef Infra Server where it is available in searches.

{{< note >}}

In Chef Infra Client 16.3 the node Blacklist and Whitelist features were renamed to Blocklist and Allowlist. For backwards compatibility the old configuration values will continue to work, but this document will describe the Blocklist and Allowlist names. See each section below for the appropriate legacy configuration values if you are running legacy clients in your organization.

Legacy config mapping:

- blocked_automatic_attributes -> blocked_automatic_attributes
- blocked_default_attributes -> blocked_default_attributes
- blocked_normal_attributes -> blocked_normal_attributes
- blocked_override_attributes -> blocked_override_attributes
- automatic_attribute_whitelist -> allowed_automatic_attributes
- allowed_default_attributes -> allowed_default_attributes
- allowed_normal_attributes -> allowed_normal_attributes
- allowed_override_attributes -> allowed_override_attributes
- enforce_default_paths -> enforce_default_paths

{{< /note >}}

### Attribute Blocklist

{{% node_attribute_blocklist %}}

### Attribute Allowlist

{{% node_attribute_allowlist %}}
