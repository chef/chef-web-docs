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

All attributes, except for normal attributes, are reset at the beginning
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

Some organizations find it helpful to control attribute data stored by the Chef Infra Server, whether to limit the disk and CPU resources used when processing unused attributes or to keep secrets like API keys from being submitted to the server. For example, your organization may find the data from the Ohai `Package` plugin useful when writing cookbooks, but do not see the need in saving ~100kB of package information for each Chef Infra Client run. Attribute data will still be available on the node within cookbooks, but any information you limit will not be saved to the Chef Infra Server for use in searches.

Allowing or blocking the saving of specific keys can be set in the [client.rb](/config_rb_client/) file. Each setting is an array of keys specifying each attribute to be filtered out or allowed. Use a "/" to separate subkeys, for example `network/interfaces`

For attributes containing slashes (`/`) within the attribute value, such as the `filesystem` attribute, use a nested array. For example:

```ruby
blocked_automatic_attributes [['filesystem', '/dev/diskos2']]
```

{{< note >}}

In Chef Infra Client 16.3, the node Blacklist and Whitelist features were renamed to Blocklist and Allowlist. For backwards compatibility the old configuration values will continue to work, but this document will describe the Blocklist and Allowlist names. See each section below for the appropriate legacy configuration values if you are running legacy clients in your organization.

Legacy attribute config mapping:

- automatic_attribute_blacklist -> blocked_automatic_attributes
- default_attribute_blacklist -> blocked_default_attributes
- normal_attribute_blacklist -> blocked_normal_attributes
- override_attribute_blacklist -> blocked_override_attributes
- automatic_attribute_whitelist -> allowed_automatic_attributes
- default_attribute_whitelist -> allowed_default_attributes
- normal_attribute_whitelist -> allowed_normal_attributes
- override_attribute_whitelist -> allowed_override_attributes

{{< /note >}}

### Attribute Blocklist

{{< warning >}}

{{< readfile file="content/reusable/md/node_attribute_blocklist_warning.md" >}}

{{< /warning >}}

{{< readfile file="content/reusable/md/node_attribute_blocklist.md" >}}

### Attribute Allowlist

{{< warning >}}

{{< readfile file="content/reusable/md/node_attribute_allowlist_warning.md" >}}

{{< /warning >}}

Attributes are allowlisted by attribute type, with each attribute type being allowlisted independently. Each attribute type---`automatic`, `default`, `normal`, and `override`---may define allowlists by using the following settings in the client.rb file:

`allowed_automatic_attributes`

: An array that allows saving specific `automatic` attributes. For example: `['network/interfaces/eth0']`. Default value: `nil`, all attributes are saved. If the array is empty, no attributes are saved.

`allowed_default_attributes`

: An array that allows saving specific `default` attributes. For example: `['filesystem/dev/disk0s2/size']`. Default value: `nil`, all attributes are saved. If the array is empty, no attributes are saved.

`allowed_normal_attributes`

: An array that allows saving specific `normal` attributes. For example: `['filesystem/dev/disk0s2/size']`. Default value: `nil`, all attributes are saved. If the array is empty, no attributes are saved.

`allowed_override_attributes`

: An array that allows specific `override` attributes, preventing blocklisted attributes from being saved. For example: `['map - autohome/size']`. Default value: `nil`, all attributes are saved. If the array is empty, no attributes are saved.
