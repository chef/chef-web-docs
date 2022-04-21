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

All attributes except for normal attributes are reset at the beginning
of a Chef Infra Client run. Attributes set using `chef-client -j` with a
JSON file have normal precedence and are persisted between Chef Infra
Client runs. Chef Infra Client rebuilds these attributes using automatic
attributes collected by Ohai at the beginning of each Chef Infra Client
run, and then uses default and override attributes that are specified in
cookbooks, roles, environments, and Policyfiles. All attributes are then
merged and applied to the node according to attribute precedence. The
attributes that were applied to the node are saved to the Chef Infra
Server as part of the node object at the conclusion of each Chef Infra
Client run.

## Limiting Attribute Persistence

Some organizations find it helpful to control attribute data stored to the Chef Infra Server to limit the disk and CPU resources used when processing unused attributes. For example, your organization may find the data from the Ohai `Package` plugin useful when writing cookbooks, but you do not see the need in saving ~100k of package information for each Chef Infra Client run. By limiting the data that is saved to the Chef Infra Server, it will still be available on the node within cookbooks, but will not be saved to the Chef Infra Server where it is available in searches.

{{< note >}}

In Chef Infra Client 16.3 the node Blacklist and Whitelist features were renamed to Blocklist and Allowlist. For backwards compatibility the old configuration values will continue to work, but this document will describe the Blocklist and Allowlist names. See each section below for the appropriate legacy configuration values if you are running legacy clients in your organization.

Legacy config mapping:

- automatic_attribute_blacklist -> blocked_automatic_attributes
- default_attribute_blacklist -> blocked_default_attributes
- normal_attribute_blacklist -> blocked_normal_attributes
- override_attribute_blacklist -> blocked_override_attributes
- automatic_attribute_whitelist -> allowed_automatic_attributes
- default_attribute_whitelist -> allowed_default_attributes
- normal_attribute_whitelist -> allowed_normal_attributes
- override_attribute_whitelist -> allowed_override_attributes
- enforce_path_sanity -> enforce_default_paths

{{< /note >}}

### Attribute Blocklist

{{% node_attribute_blocklist %}}

### Attribute Allowlist

{{% node_attribute_allowlist %}}
