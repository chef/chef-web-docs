+++
title = "About Nodes"
draft = false

gh_repo = "chef-web-docs"

aliases = ["/nodes.html"]

[menu]
  [menu.infra]
    title = "Nodes"
    identifier = "chef_infra/concepts/nodes.md Nodes"
    parent = "chef_infra/concepts"
    weight = 60
+++

{{% node %}}

{{% node_types %}}

The key components of nodes that are under management by Chef include:

<table>
<colgroup>
<col style="width: 19%" />
<col style="width: 80%" />
</colgroup>
<thead>
<tr class="header">
<th>Component</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td><p><img src="/images/icon_chef_client.svg" class="align-center" width="100" alt="image" /></p></td>
<td><p>{{< readFile_shortcode file="chef_client_summary.md" >}}</p>
<p>{{< readFile_shortcode file="security_key_pairs_chef_client.md" >}}</p></td>
</tr>
<tr class="even">
<td><img src="/images/icon_ohai.svg" class="align-center" width="100" alt="image" /></td>
<td>{{< readFile_shortcode file="ohai_summary.md" >}}</td>
</tr>
</tbody>
</table>

## Node Names

The name of a node is required as part of the authentication process to
the Chef Infra Server. The name of each node must be unique within an
organization, but otherwise can be any string that matches the following
regular expression:

    /^[\-[:alnum:]_:.]+$/

The name of a node can be obtained from the `node_name` attribute in the
client.rb file or by allowing Ohai to collect this data during a Chef
Infra Client run. When Ohai collects this data during a Chef Infra
Client run, it uses the node's FQDN, which is always unique within an
organization, as the name of the node.

Using the FQDN as the node name, and then allowing Ohai to collect this
information during each Chef Infra Client run, is the recommended
approach and the easiest way to ensure that the names of all nodes
across the organization are unique.

## Node Objects

For Chef Infra Client, two important aspects of nodes are groups of
attributes and run-lists. An attribute is a specific piece of data about
the node, such as a network interface, a file system, the number of
clients a service running on a node is capable of accepting, and so on.
A run-list is an ordered list of recipes and/or roles that are run in an
exact order. The node object consists of the run-list and node
attributes, which is a JSON file that is stored on the Chef Infra
Server. Chef Infra Client gets a copy of the node object from the Chef
Infra Server during each Chef Infra Client run and places an updated
copy on the Chef Infra Server at the end of each Chef Infra Client run.

{{% node_attribute %}}

### Attributes

{{% node_attribute_when_to_use %}}

See [Attributes](/attributes) for detailed information on the different types of node attributes and how they are used to set policy on nodes.

### Run-lists

{{% node_run_list %}}

#### Run-list Format

{{% node_run_list_format %}}

## Managing Nodes

You can manage nodes directly using Knife, Chef Automate, or by using command-line tools that are specific to Chef Infra Client.

- [Knife](/workstation/knife/) can be used to create, edit, view, list, tag, and delete nodes.
- Knife plug-ins can be used to create, edit, and manage nodes that are located on cloud providers.
- Chef Infra Client can be used to manage node data using the command line and JSON files. Each JSON file contains a hash, the elements of which are added as node attributes. In addition, the `run_list` setting allows roles and/or recipes to be added to the node.
- The command line can also be used to edit JSON files and files that are related to third-party services, such as Amazon EC2, where the JSON files can contain per-instance metadata that is stored in a file on-disk and then read by Chef Infra Client as required.
