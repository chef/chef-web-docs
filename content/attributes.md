+++
title = "About Attributes"
draft = false

aliases = ["/attributes.html"]

[menu]
  [menu.infra]
    title = "Attributes"
    identifier = "chef_infra/cookbook_reference/attributes/attributes.md Attributes"
    parent = "chef_infra/cookbook_reference/attributes"
    weight = 10
+++

[\[edit on GitHub\]](https://github.com/chef/chef-web-docs/blob/master/content/attributes.md)

n attribute is a specific detail about a node. Attributes are used by Chef Infra Client to understand:

- The current state of the node
- What the state of the node was at the end of the previous Chef Infra Client run
- What the state of the node should be at the end of the current Chef Infra Client run

Attributes are defined by:

- The node as saved on the Chef Infra Server
- Attributes passed via JSON on the command line
- Cookbooks (in attribute files and/or recipes)
- Policyfiles

During every Chef Infra Client run, Chef Infra Client builds the attribute list using:

- Attributes passed via JSON on the command line
- Data about the node collected by [Ohai](/ohai.html).
- The node object that was saved to the Chef Infra Server at the end of the previous Chef Infra Client run.
- The rebuilt node object from the current Chef Infra Client run, after it is updated for changes to cookbooks (attribute files and/or recipes) and/or Policyfiles, and updated for any changes to the state of the node itself.

After the node object is rebuilt, all of the attributes are compared, and then the node is updated based on attribute precedence. At the end of every Chef Infra Client run, the node object that defines the current state of the node is uploaded to the Chef Infra Server so that it can be
indexed for search.
## Attribute Types

{{% node_attribute_type %}}

<table>
<colgroup>
<col style="width: 40%" />
<col style="width: 60%" />
</colgroup>
<thead>
<tr class="header">
<th>Attribute Type</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td><code>default</code></td>
<td>{{< readFile_shortcode file="node_attribute_type_default.md" >}}</td>
</tr>
<tr class="even">
<td><code>force_default</code></td>
<td>{{< readFile_shortcode file="node_attribute_type_force_default.md" >}}</td>
</tr>
<tr class="odd">
<td><code>normal</code></td>
<td>{{< readFile_shortcode file="node_attribute_type_normal.md" >}}</td>
</tr>
<tr class="even">
<td><code>override</code></td>
<td>{{< readFile_shortcode file="node_attribute_type_override.md" >}}</td>
</tr>
<tr class="odd">
<td><code>force_override</code></td>
<td>{{< readFile_shortcode file="node_attribute_type_force_override.md" >}}</td>
</tr>
<tr class="even">
<td><code>automatic</code></td>
<td>{{< readFile_shortcode file="node_attribute_type_automatic.md" >}}</td>
</tr>
</tbody>
</table>

## Attribute Persistence

{{% node_attribute_persistence %}}

### Limiting Attribute Persistence

Some organizations find it helpful to control attribute data stored to the Chef Infra Server in order to limit the disk and CPU resources used when processing unused attributes. For example, your organization may find the data from the Ohai `Package` plugin useful when writing cookbooks, but you don't see the need in saving ~100k of package information for each Chef Infra Client run. By limiting the data that is saved to the Chef Infra Server, it will still be available on the node within cookbooks, but won't be saved to the Chef Infra Server where it is available in searches.

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

#### Attribute Blocklist

{{% node_attribute_blocklist %}}

#### Attribute Allowlist

{{% node_attribute_allowlist %}}
