+++
title = "Chef Manage"
description = "DESCRIPTION"
draft = false

aliases = "/manage.html"

[menu]
  [menu.docs]
    title = "About the Management Console"
    identifier = "about the management console/manage.html"
    parent = "features/management console"
    weight = 10
+++    

[\[edit on
GitHub\]](https://github.com/chef/chef-web-docs/blob/master/chef_master/source/manage.rst)

{{% chef_automate_mark %}}

{{% EOL_manage %}}

The Chef management console enables the management of nodes, data bags,
roles, environments, and cookbooks by using a web user interface. In
addition, access to nodes, data bags, roles, environments, and cookbooks
is configurable using role-based access control (RBAC).

Nodes
=====

{{% node %}}

The Chef management console provides ways for users to [delete nodes and
reset their private keys](/server_manage_nodes.html#manage), [edit node
attributes](/server_manage_nodes.html#node-attributes), [manage the
run-lists](/server_manage_nodes.html#run-lists), [configure user and
group permissions](/server_manage_nodes.html#permissions), and [manage
tags](/server_manage_nodes.html#manage-tags).

![image](/images/step_manage_webui_nodes.png)

Search
------

{{% search %}}

<div class="note" markdown="1">

<div class="admonition-title" markdown="1">

Note

</div>

The syntax for search queries in the Chef management console is
identical to the syntax for search queries used with knife, the command
line tool used to manage objects on the Chef Infra Server.

</div>

### Query Syntax

{{% search_query_syntax %}}

### Keys

{{% search_key %}}

#### Nested Fields

{{% search_key_nested %}}

### About Patterns

{{% search_pattern %}}

#### Exact Matching

{{% search_pattern_exact %}}

#### Wildcard Matching

{{% search_pattern_wildcard %}}

#### Range Matching

{{% search_pattern_range %}}

#### Fuzzy Matching

{{% search_pattern_fuzzy %}}

### About Operators

{{% search_boolean_operators %}}

{{% search_boolean_operators_andnot %}}

### Special Characters

{{% search_special_characters %}}

Policy
======

{{% policy_summary %}}

The Chef management console provides ways for users to manage [data
bags](/server_manage_data_bags/),
[environments](/server_manage_environments/),
[roles](/server_manage_roles/),
[cookbooks](/server_manage_cookbooks/),
[clients](/server_manage_clients/), and [managing
tags](/server_manage_nodes.html#manage-tags.html).

![image](/images/step_manage_webui_policy.png)

Admin
=====

Organizations, users, and groups can be managed from the Chef management
console, including role-based access control for any user and group to
any of the objects saved to the Chef Infra Server.

{{% server_rbac %}}

![image](/images/step_manage_webui_admin.png)

Install Chef Manage
===================

> {{% ctl_chef_server_install_features_download %}}

Chef Manage Local Installation
------------------------------

> {{% ctl_chef_server_install_features_manual %}}
