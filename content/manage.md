+++
title = "Chef Manage"
draft = false
gh_repo = "chef-web-docs"
aliases = ["/manage.html"]
product = []

[menu]
  [menu.legacy]
    title = "About the Management Console"
    identifier = "legacy/manage/manage.md About the Management Console"
    parent = "legacy/manage"
    weight = 10
+++
{{< chef_automate_mark >}}

{{< warning >}}

{{< readfile file="content/reusable/md/EOL_manage.md" >}}

This document is no longer maintained.

{{< /warning >}}

{{< note >}}

Chef Automate 2 doesn't deploy Chef Manage alongside Chef Infra Server.

{{< /note >}}

The Chef management console enables the management of nodes, data bags, roles, environments, and cookbooks by using a web user interface. In addition, access to nodes, data bags, roles, environments, and cookbooks is configurable using role-based access control (RBAC).

## Nodes

{{< readfile file="content/reusable/md/node.md" >}}

The Chef management console provides ways for users to [delete nodes and reset their private keys](/server_manage_nodes/#manage), [edit node attributes](/server_manage_nodes/#node-attributes), [manage the run-lists](/server_manage_nodes/#run-lists), [configure user and group permissions](/server_manage_nodes/#permissions), and [manage tags](/server_manage_nodes/#manage-tags).

![image](/images/step_manage_webui_nodes.png)

### Search

{{< readfile file="content/reusable/md/search.md" >}}

{{< note >}}

The syntax for search queries in the Chef management console is identical to the syntax for search queries used with knife, the command line tool used to manage objects on the Chef Infra Server.

{{< /note >}}

#### Query Syntax

{{< readfile file="content/reusable/md/search_query_syntax.md" >}}

#### Keys

{{< readfile file="content/reusable/md/search_key.md" >}}

##### Nested Fields

{{< readfile file="content/reusable/md/search_key_nested.md" >}}

#### About Patterns

{{< readfile file="content/reusable/md/search_pattern.md" >}}

##### Exact Matching

{{< readfile file="content/reusable/md/search_pattern_exact.md" >}}

##### Wildcard Matching

{{< readfile file="content/reusable/md/search_pattern_wildcard.md" >}}

##### Range Matching

{{< readfile file="content/reusable/md/search_pattern_range.md" >}}

##### Fuzzy Matching

{{< readfile file="content/reusable/md/search_pattern_fuzzy.md" >}}

#### About Operators

{{< readfile file="content/reusable/md/search_boolean_operators.md" >}}

{{< readfile file="content/reusable/md/search_boolean_operators_andnot.md" >}}

#### Special Characters

{{< readfile file="content/reusable/md/search_special_characters.md" >}}

## Policy

{{< readfile file="content/reusable/md/policy_summary.md" >}}

The Chef management console provides ways for users to manage [data bags](/server_manage_data_bags/), [environments](/server_manage_environments/), [roles](/server_manage_roles/), [cookbooks](/server_manage_cookbooks/), [clients](/server_manage_clients/), and [managing tags](/server_manage_nodes/#manage-tags.html).

![image](/images/step_manage_webui_policy.png)

## Admin

Organizations, users, and groups can be managed from the Chef management console, including role-based access control for any user and group to any of the objects saved to the Chef Infra Server.

{{< readfile file="content/server/reusable/md/server_rbac.md" >}}

![image](/images/step_manage_webui_admin.png)

## Install Chef Manage

{{< readfile file="content/server/reusable/md/ctl_chef_server_install_features_download.md" >}}

### Chef Manage Local Installation

{{< readfile file="content/server/reusable/md/ctl_chef_server_install_features_manual.md" >}}
