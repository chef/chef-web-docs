+++
title = "Organizations and Groups"
description = "DESCRIPTION"
draft = false

aliases = "/server_orgs.html"

[menu]
  [menu.docs]
    title = "Organizations & Groups"
    identifier = "organizations & groups/server_orgs.html"
    parent = "chef infra/managing the server"
    weight = 80
+++    

[\[edit on
GitHub\]](https://github.com/chef/chef-web-docs/blob/master/chef_master/source/server_orgs.rst)

{{% server_rbac %}}

{{% server_rbac_components %}}

{{% server_rbac_workflow %}}

Organizations
=============

{{% server_rbac_orgs_multi %}}

{{% server_rbac_orgs_multi_use %}}

Permissions
-----------

{{% server_rbac_permissions %}}

### Object Permissions

{{% server_rbac_permissions_object %}}

### Global Permissions

{{% server_rbac_permissions_global %}}

### Client Key Permissions

<div class="note" markdown="1">

<div class="admonition-title" markdown="1">

Note

</div>

This is only necessary after migrating a client from one Chef Infra
Server to another. Permissions must be reset for client keys after the
migration.

</div>

{{% server_rbac_permissions_key %}}

### Knife ACL

The knife plugin [knife-acl](https://github.com/chef/knife-acl) provides
a fine-grained approach to modifying permissions, by wrapping API calls
to the `_acl` endpoint and makes such permission changes easier to
manage.

{{% EOL_manage %}}

<span class="title-ref">knife-acl</span> and the Chef Manage browser
interface are incompatible. After engaging <span
class="title-ref">knife-acl</span>, you will need to discontinue using
the Chef Manage browser interface from that point forward due to
possible incompatibilities.

Groups
======

The Chef Infra Server includes the following default groups:

<table>
<colgroup>
<col style="width: 12%" />
<col style="width: 87%" />
</colgroup>
<thead>
<tr class="header">
<th>Group</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td><code>admins</code></td>
<td>The <code>admins</code> group defines the list of users who have administrative rights to all objects and object types for a single organization.</td>
</tr>
<tr class="even">
<td><code>billing_admins</code></td>
<td>The <code>billing_admins</code> group defines the list of users who have permission to manage billing information. This permission exists only for the hosted Chef Infra Server.</td>
</tr>
<tr class="odd">
<td><code>clients</code></td>
<td>The <code>clients</code> group defines the list of nodes on which a Chef Infra Client is installed and under management by Chef. In general, think of this permission as "all of the non-human actors---Chef Infra Client, in nearly every case---that get data from, and/or upload data to, the Chef server". Newly-created Chef Infra Client instances are added to this group automatically.</td>
</tr>
<tr class="even">
<td><code>public_key_read_access</code></td>
<td>The <code>public_key_read_access</code> group defines which users and clients have read permissions to key-related endpoints in the Chef Infra Server API.</td>
</tr>
<tr class="odd">
<td><code>users</code></td>
<td>The <code>users</code> group defines the list of users who use knife and the Chef management console to interact with objects and object types. In general, think of this permission as "all of the non-admin human actors who work with data that is uploaded to and/or downloaded from the Chef server".</td>
</tr>
</tbody>
</table>

Example Default Permissions
---------------------------

The following sections show the default permissions assigned by the Chef
Infra Server to the `admins`, `billing_admins`, `clients`, and `users`
groups.

<div class="note" markdown="1">

<div class="admonition-title" markdown="1">

Note

</div>

The creator of an object on the Chef Infra Server is assigned `create`,
`delete`, `grant`, `read`, and `update` permission to that object.

</div>

### admins

The `admins` group is assigned the following:

<table style="width:100%;">
<colgroup>
<col style="width: 24%" />
<col style="width: 15%" />
<col style="width: 15%" />
<col style="width: 15%" />
<col style="width: 15%" />
<col style="width: 15%" />
</colgroup>
<thead>
<tr class="header">
<th>Group</th>
<th>Create</th>
<th>Delete</th>
<th>Grant</th>
<th>Read</th>
<th>Update</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td>admins</td>
<td>yes</td>
<td>yes</td>
<td>yes</td>
<td>yes</td>
<td>yes</td>
</tr>
<tr class="even">
<td>clients</td>
<td>yes</td>
<td>yes</td>
<td>yes</td>
<td>yes</td>
<td>yes</td>
</tr>
<tr class="odd">
<td>users</td>
<td>yes</td>
<td>yes</td>
<td>yes</td>
<td>yes</td>
<td>yes</td>
</tr>
</tbody>
</table>

### billing_admins

The `billing_admins` group is assigned the following:

<table>
<colgroup>
<col style="width: 28%" />
<col style="width: 17%" />
<col style="width: 17%" />
<col style="width: 17%" />
<col style="width: 17%" />
</colgroup>
<thead>
<tr class="header">
<th>Group</th>
<th>Create</th>
<th>Delete</th>
<th>Read</th>
<th>Update</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td>billing_admins</td>
<td>no</td>
<td>no</td>
<td>yes</td>
<td>yes</td>
</tr>
</tbody>
</table>

### clients

The `clients` group is assigned the following:

<table>
<colgroup>
<col style="width: 28%" />
<col style="width: 17%" />
<col style="width: 17%" />
<col style="width: 17%" />
<col style="width: 17%" />
</colgroup>
<thead>
<tr class="header">
<th>Object</th>
<th>Create</th>
<th>Delete</th>
<th>Read</th>
<th>Update</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td>clients</td>
<td>no</td>
<td>no</td>
<td>no</td>
<td>no</td>
</tr>
<tr class="even">
<td>cookbooks</td>
<td>no</td>
<td>no</td>
<td>yes</td>
<td>no</td>
</tr>
<tr class="odd">
<td>cookbook_artifacts</td>
<td>no</td>
<td>no</td>
<td>yes</td>
<td>no</td>
</tr>
<tr class="even">
<td>data</td>
<td>no</td>
<td>no</td>
<td>yes</td>
<td>no</td>
</tr>
<tr class="odd">
<td>environments</td>
<td>no</td>
<td>no</td>
<td>yes</td>
<td>no</td>
</tr>
<tr class="even">
<td>nodes</td>
<td>yes</td>
<td>no</td>
<td>yes</td>
<td>no</td>
</tr>
<tr class="odd">
<td>organization</td>
<td>no</td>
<td>no</td>
<td>yes</td>
<td>no</td>
</tr>
<tr class="even">
<td>policies</td>
<td>no</td>
<td>no</td>
<td>yes</td>
<td>no</td>
</tr>
<tr class="odd">
<td>policy_groups</td>
<td>no</td>
<td>no</td>
<td>yes</td>
<td>no</td>
</tr>
<tr class="even">
<td>roles</td>
<td>no</td>
<td>no</td>
<td>yes</td>
<td>no</td>
</tr>
<tr class="odd">
<td>sandboxes</td>
<td>no</td>
<td>no</td>
<td>no</td>
<td>no</td>
</tr>
</tbody>
</table>

### public_key_read_access

The `public_key_read_access` group controls which users and clients have
[read permissions to the following endpoints](/api_chef_server/):

-   GET /clients/CLIENT/keys
-   GET /clients/CLIENT/keys/KEY
-   GET /users/USER/keys
-   GET /users/USER/keys/

By default, the `public_key_read_access` assigns all members of the
`users` and `clients` group permission to these endpoints:

<table style="width:100%;">
<colgroup>
<col style="width: 24%" />
<col style="width: 15%" />
<col style="width: 15%" />
<col style="width: 15%" />
<col style="width: 15%" />
<col style="width: 15%" />
</colgroup>
<thead>
<tr class="header">
<th>Group</th>
<th>Create</th>
<th>Delete</th>
<th>Grant</th>
<th>Read</th>
<th>Update</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td>admins</td>
<td>no</td>
<td>no</td>
<td>no</td>
<td>no</td>
<td>no</td>
</tr>
<tr class="even">
<td>clients</td>
<td>yes</td>
<td>yes</td>
<td>yes</td>
<td>yes</td>
<td>yes</td>
</tr>
<tr class="odd">
<td>users</td>
<td>yes</td>
<td>yes</td>
<td>yes</td>
<td>yes</td>
<td>yes</td>
</tr>
</tbody>
</table>

### users

The `users` group is assigned the following:

<table>
<colgroup>
<col style="width: 28%" />
<col style="width: 17%" />
<col style="width: 17%" />
<col style="width: 17%" />
<col style="width: 17%" />
</colgroup>
<thead>
<tr class="header">
<th>Object</th>
<th>Create</th>
<th>Delete</th>
<th>Read</th>
<th>Update</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td>clients</td>
<td>no</td>
<td>yes</td>
<td>yes</td>
<td>no</td>
</tr>
<tr class="even">
<td>cookbooks</td>
<td>yes</td>
<td>yes</td>
<td>yes</td>
<td>yes</td>
</tr>
<tr class="odd">
<td>cookbook_artifacts</td>
<td>yes</td>
<td>yes</td>
<td>yes</td>
<td>yes</td>
</tr>
<tr class="even">
<td>data</td>
<td>yes</td>
<td>yes</td>
<td>yes</td>
<td>yes</td>
</tr>
<tr class="odd">
<td>environments</td>
<td>yes</td>
<td>yes</td>
<td>yes</td>
<td>yes</td>
</tr>
<tr class="even">
<td>nodes</td>
<td>yes</td>
<td>yes</td>
<td>yes</td>
<td>yes</td>
</tr>
<tr class="odd">
<td>organization</td>
<td>no</td>
<td>no</td>
<td>yes</td>
<td>no</td>
</tr>
<tr class="even">
<td>policies</td>
<td>yes</td>
<td>yes</td>
<td>yes</td>
<td>yes</td>
</tr>
<tr class="odd">
<td>policy_groups</td>
<td>yes</td>
<td>yes</td>
<td>yes</td>
<td>yes</td>
</tr>
<tr class="even">
<td>roles</td>
<td>yes</td>
<td>yes</td>
<td>yes</td>
<td>yes</td>
</tr>
<tr class="odd">
<td>sandboxes</td>
<td>yes</td>
<td>no</td>
<td>no</td>
<td>no</td>
</tr>
</tbody>
</table>

chef-validator
--------------

{{% security_chef_validator %}}

The chef-validator is allowed to do the following at the start of a Chef
Infra Client run. After the Chef Infra Client is registered with Chef
Infra Server, that Chef Infra Client is added to the `clients` group:

<table>
<colgroup>
<col style="width: 28%" />
<col style="width: 17%" />
<col style="width: 17%" />
<col style="width: 17%" />
<col style="width: 17%" />
</colgroup>
<thead>
<tr class="header">
<th>Object</th>
<th>Create</th>
<th>Delete</th>
<th>Read</th>
<th>Update</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td>clients</td>
<td>yes</td>
<td>no</td>
<td>no</td>
<td>no</td>
</tr>
</tbody>
</table>

Chef Push Jobs Groups
---------------------

{{% push_jobs_summary %}}

{{% server_rbac_groups_push_jobs %}}

Server Admins
=============

{{% server_rbac_server_admins %}}

Scenario
--------

{{% server_rbac_server_admins_scenario %}}

### Superuser Accounts

{{% server_rbac_server_admins_superusers %}}

Manage server-admins Group
--------------------------

{{% ctl_chef_server_server_admin %}}

### Add Members

{{% ctl_chef_server_server_admin_grant_user %}}

### Remove Members

{{% ctl_chef_server_server_admin_remove_user %}}

### List Membership

{{% ctl_chef_server_server_admin_list %}}

Manage Organizations
====================

{{% ctl_chef_server_org %}}

org-create
----------

{{% ctl_chef_server_org_create %}}

**Syntax**

{{% ctl_chef_server_org_create_syntax %}}

**Options**

{{% ctl_chef_server_org_create_options %}}

org-delete
----------

{{% ctl_chef_server_org_delete %}}

**Syntax**

{{% ctl_chef_server_org_delete_syntax %}}

org-list
--------

{{% ctl_chef_server_org_list %}}

**Syntax**

{{% ctl_chef_server_org_list_syntax %}}

**Options**

{{% ctl_chef_server_org_list_options %}}

org-show
--------

{{% ctl_chef_server_org_show %}}

**Syntax**

{{% ctl_chef_server_org_show_syntax %}}

org-user-add
------------

{{% ctl_chef_server_org_user_add %}}

**Syntax**

{{% ctl_chef_server_org_user_add_syntax %}}

**Options**

{{% ctl_chef_server_org_user_add_options %}}

org-user-remove
---------------

{{% ctl_chef_server_org_user_remove %}}

**Syntax**

{{% ctl_chef_server_org_user_remove_syntax %}}
