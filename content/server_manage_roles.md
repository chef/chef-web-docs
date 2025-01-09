+++
title = "Manage Roles"
draft = false
gh_repo = "chef-web-docs"
robots = "noindex"
aliases = ["/server_manage_roles.html"]
product = []

[menu]
  [menu.legacy]
    title = "Roles"
    identifier = "legacy/manage/server_manage_roles.md Roles"
    parent = "legacy/manage"
+++

{{< chef_automate_mark >}}

{{< warning >}}

{{< readfile file="content/reusable/md/EOL_manage.md" >}}

This document is no longer maintained.

{{< /warning >}}

{{< note >}}

This topic is about using the Chef management console to manage roles.

{{< /note >}}

{{< readfile file="content/reusable/md/role.md" >}}

## Manage

Roles can be managed from the Chef management console web user
interface.

### Add Role

To add a role:

1. Open the Chef management console.

1. Click **Policy**.

1. Click **Roles**.

1. Click **Create**.

1. In the **Create Role** dialog box, enter the name of the role and a
    description.

    ![image](/images/step_manage_webui_policy_role_add.png)

    Click **Next**.

1. Optional. Build the run-list from the list of available roles and
    recipes:

    ![image](/images/step_manage_webui_policy_role_add_run_list.png)

    Click **Next**.

1. Optional. Add default attributes as JSON data:

    ![image](/images/step_manage_webui_policy_role_add_default_attribute.png)

    Click **Next**.

1. Optional. Add override attributes as JSON data:

    ![image](/images/step_manage_webui_policy_role_add_override_attribute.png)

1. Click **Create Role**.

### Delete Role

To delete a role:

1. Open the Chef management console.

1. Click **Policy**.

1. Click **Roles**.

1. Select a role.

1. Click **Delete**.

    ![image](/images/step_manage_webui_policy_role_delete.png)

### View All Roles

To view all roles uploaded to the Chef Infra Server organization:

1. Open the Chef management console.
2. Click **Policy**.
3. Click **Roles**.

## Run-lists

{{< readfile file="content/reusable/md/node_run_list.md" >}}

### Edit Role Run-list

To edit the run-list for a role:

1. Open the Chef management console.

1. Click **Policy**.

1. Click **Roles**.

1. Select a role.

1. Click **Edit Run List**.

    ![image](/images/step_manage_webui_policy_role_edit_run_list.png)

1. Make your changes.

1. Click **Save Run List**.

## Default Attributes

{{< readfile file="content/reusable/md/node_attribute_type_default.md" >}}

### Edit Default Attributes

To edit default attributes for a role:

1. Open the Chef management console.

1. Click **Policy**.

1. Click **Roles**.

1. Select a role.

1. Click the **Attributes** tab.

1. Under **Default Attributes**, click **Edit**.

1. In the **Edit Role Attributes** dialog box, enter the JSON data that
    defines the attribute (or attributes).

    ![image](/images/step_manage_webui_policy_role_edit_attribute.png)

1. Click **Save Attributes**.

### View Default Attributes

To view default attributes for a role:

1. Open the Chef management console.
1. Click **Policy**.
1. Click **Roles**.
1. Select a role.
1. Click the **Attributes** tab.

## Override Attributes

{{< readfile file="content/reusable/md/node_attribute_type_override.md" >}}

### Edit Override Attributes

To edit override attributes for a role:

1. Open the Chef management console.

1. Click **Policy**.

1. Click **Roles**.

1. Select a role.

1. Click the **Attributes** tab.

1. Under **Override Attributes**, click **Edit**.

1. In the **Edit Role Attributes** dialog box, enter the JSON data that
    defines the attribute (or attributes).

    ![image](/images/step_manage_webui_policy_role_edit_attribute.png)

1. Click **Save Attributes**.

### View Override Attributes

To view role details:

1. Open the Chef management console.
1. Click **Policy**.
1. Click **Roles**.
1. Select a role.
1. Click the **Details** tab.

## Permissions

{{< readfile file="content/server/reusable/md/server_rbac_permissions.md" >}}

{{< readfile file="content/server/reusable/md/server_rbac_permissions_object.md" >}}

### Set

To set permissions list for a role object:

1. Open the Chef management console.
1. Click **Policy**.
1. Click **Roles**.
1. Select a role.
1. Click the **Permissions** tab.
1. For each group listed under **Name**, select or de-select the
    **Read**, **Update**, **Delete**, and **Grant** permissions.

### Update

To update the permissions list for a role object:

1. Open the Chef management console.
1. Click **Policy**.
1. Click **Roles**.
1. Select a role.
1. Click the **Permissions** tab.
1. Click the **+ Add** button and enter the name of the user or group
   to be added.
1. Select or de-select **Read**, **Update**, **Delete**, and **Grant**
    to update the permissions list for the user or group.

### View

To view permissions for a role object:

1. Open the Chef management console.
1. Click **Policy**.
1. Click **Roles**.
1. Select a role.
1. Click the **Permissions** tab.
1. Set the appropriate permissions: **Delete**, **Grant**, **Read**,
    and/or **Update**.
