+++
title = "Manage Nodes"
draft = false
gh_repo = "chef-web-docs"
robots = "noindex"
aliases = ["/server_manage_nodes.html"]
product = []

[menu]
  [menu.legacy]
    title = "Nodes"
    identifier = "legacy/manage/server_manage_nodes.md Nodes"
    parent = "legacy/manage"
+++

{{< chef_automate_mark >}}

{{< warning >}}

{{< readfile file="content/reusable/md/EOL_manage.md" >}}

{{< /warning >}}

{{< note >}}

This topic is about using the Chef management console to manage nodes.

{{< /note >}}

{{< readfile file="content/reusable/md/node.md" >}}

## Manage

Nodes can be managed from the Chef management console web user
interface.

### Delete

To delete a node:

1. Open the Chef management console.

1. Click **Nodes**.

1. Select a node.

1. Click **Delete**.

1. Confirm:

    {{< figure src="/images/step_manage_webui_node_delete.png" alt="Dialog box asking user if they want to delete a node." class="no-shadow">}}

### Reset Key

To reset the validation key for a node:

1. Open the Chef management console.

1. Click **Nodes**.

1. Select a node.

1. Click **Edit Run List**.

1. In the **Reset Key** dialog box, confirm that the key should be
    regenerated and click the **Regenerate Key** button:

    {{< figure src="/images/step_manage_webui_admin_organization_reset_key.png" alt="Dialog box asking user to confirm that they want to delete a key." class="no-shadow">}}

1. In the **Reset Key** dialog box, copy the key directly from the
    dialog box or click the **Download** button to download the key
    your local machine:

    {{< figure src="/images/step_manage_webui_admin_organization_reset_key_regenerated.png" alt="Dialog box showing newly generated key." class="no-shadow">}}

### Search

To search nodes:

1. Open the Chef management console.

1. Click **Nodes**.

1. In the search box in the upper right, enter the search query and
    click the search icon.

    ![image](/images/step_manage_webui_nodes_search.png)

1. The results will appear in the list below.

## Node Attributes

An attribute is a specific detail about a node. Attributes are used by Chef Infra Client to understand:

- The current state of the node
- What the state of the node was at the end of the previous Chef Infra Client run
- What the state of the node should be at the end of the current Chef Infra Client run

Attributes are defined by:

- The node as saved on the Chef Infra Server
- Attributes passed using JSON on the command line
- Cookbooks (in attribute files and/or recipes)
- Policyfiles

During every Chef Infra Client run, Chef Infra Client builds the attribute list using:

- Attributes passed using JSON on the command line
- Data about the node collected by [Ohai](/ohai.html).
- The node object that was saved to the Chef Infra Server at the end of the previous Chef Infra Client run.
- The rebuilt node object from the current Chef Infra Client run, after it is updated for changes to cookbooks (attribute files and/or recipes) and/or Policyfiles, and updated for any changes to the state of the node itself.

After the node object is rebuilt, all of the attributes are compared, and then the node is updated based on attribute precedence. At the end of every Chef Infra Client run, the node object that defines the current state of the node is uploaded to the Chef Infra Server so that it can be indexed for search.

### Edit Attribute

To edit node attributes:

1. Open the Chef management console.

1. Click **Nodes**.

1. Select a node.

1. Click the **Attributes** tab.

1. Click **Edit**.

1. In the **Edit Node Attributes** dialog box, make your changes:

    ![image](/images/step_manage_webui_node_attributes_edit.png)

1. Click **Save Attributes**.

### View Attributes

To view the attributes for a node:

1. Open the Chef management console.
1. Click **Nodes**.
1. Select a node.
1. Click the **Attributes** tab.
1. Click **Edit**.

## Run-lists

{{< readfile file="content/reusable/md/node_run_list.md" >}}

### Add Recipe

{{< readfile file="content/reusable/md/manage_webui_node_run_list_add_role_or_recipe.md" >}}

### Add Role

{{< readfile file="content/reusable/md/manage_webui_node_run_list_add_role_or_recipe.md" >}}

### Edit

To edit a run-list:

1. Open the Chef management console.
1. Click **Nodes**.
1. Select a node.
1. Click **Edit Run List**.
1. In the **Edit Node Run List** dialog box, make your changes.
1. Click **Save Run List**.

### Remove Recipe

{{< readfile file="content/reusable/md/manage_webui_node_run_list_remove_role_or_recipe.md" >}}

### Remove Role

{{< readfile file="content/reusable/md/manage_webui_node_run_list_remove_role_or_recipe.md" >}}

### View Current

To view the current run-list for a node:

1. Open the Chef management console.

1. Click **Nodes**.

1. Select a node.

1. Click the **Details** tab.

1. The current run-list is shown in the lower right:

    ![image](/images/step_manage_webui_node_run_list_view_current.png)

## Permissions

{{< readfile file="content/server/reusable/md/server_rbac_permissions.md" >}}

{{< readfile file="content/server/reusable/md/server_rbac_permissions_object.md" >}}

### Set

To set permissions list for a node object:

1. Open the Chef management console.
1. Click **Nodes**.
1. Select a node.
1. Click the **Permissions** tab.
1. For each group listed under **Name**, select or de-select the
    **Read**, **Update**, **Delete**, and **Grant** permissions.

### Update

To update the permissions list for a node object:

1. Open the Chef management console.
1. Click **Nodes**.
1. Select a node.
1. Click the **Permissions** tab.
1. Click the **+ Add** button and enter the name of the user or group
    to be added.
1. Select or de-select **Read**, **Update**, **Delete**, and **Grant**
    to update the permissions list for the user or group.

### View

To view permissions for a node:

1. Open the Chef management console.
1. Click **Nodes**.
1. Select a node.
1. Click the **Permissions** tab.
1. Set the appropriate permissions: **Delete**, **Grant**, **Read**,
    and/or **Update**.

## Manage Tags

{{< readfile file="content/reusable/md/chef_tags.md" >}}

### Add

To add tags to a node (or a group of nodes):

1. Open the Chef management console.

1. Click **Nodes**.

1. Select a node (or a group of nodes).

1. Click **Manage Tags**.

1. In the **Manage Node Tags** dialog box, enter the name of the tag
    and then select **Add Tags** from the drop-down.

    ![image](/images/step_manage_webui_node_tags_add.png)

1. Click **Update Tags**.

### Delete

To delete tags for a node (or a group of nodes):

1. Open the Chef management console.

1. Click **Nodes**.

1. Select a node (or a group of nodes).

1. Click **Manage Tags**.

1. In the **Manage Node Tags** dialog box, enter the name of the tag
    and then select **Delete Tags** from the drop-down.

    ![image](/images/step_manage_webui_node_tags_delete.png)

1. Click **Update Tags**.

### View

To view all of the nodes:

1. Open the Chef management console.

1. Click **Nodes**.

1. Select a node.

1. Select the **Details** tab.

1. The tags for the node appear under the **Tags** header:

    ![image](/images/step_manage_webui_nodes_view_tags.png)
