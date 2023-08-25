+++
title = "Manage Data Bags"
draft = false
gh_repo = "chef-web-docs"
robots = "noindex"
aliases = ["/server_manage_data_bags.html"]
product = []

[menu]
  [menu.legacy]
    title = "Data Bags"
    identifier = "legacy/manage/server_manage_data_bags.md Data Bags"
    parent = "legacy/manage"
+++

{{< chef_automate_mark >}}

{{< warning >}}

{{< readfile file="content/reusable/md/EOL_manage.md" >}}

{{< /warning >}}

{{< note >}}

This topic is about using the Chef management console to manage data
bags.

{{< /note >}}

{{< readfile file="content/reusable/md/data_bag.md" >}}

## Manage

Data bags can be managed from the Chef management console web user
interface.

### Add Data Bag

To add a data bag:

1. Open the Chef management console.
1. Click **Policy**.
1. Click **Data Bags**.
1. Click **Create**.
1. In the **Create a Data Bag** dialog box, enter the name of the data
   bag.

    ![image](/images/step_manage_webui_policy_data_bag_add.png)

1. Click **Create Data Bag**.

### Delete Data Bag

To delete a data bag:

1. Open the Chef management console.
1. Click **Policy**.
1. Click **Data Bags**.
1. Select a data bag.
1. Click **Delete**.

    ![image](/images/step_manage_webui_policy_data_bag_delete.png)

## Manage Items

{{< readfile file="content/reusable/md/data_bag_item.md" >}}

### Add Item

To add a data bag item:

1. Open the Chef management console.
1. Click **Policy**.
1. Click **Data Bags**.
1. Select a data bag.
1. Click **Create Item**.
1. In the **Create a Data Bag Item** dialog box, enter the data bag
    identifier, and then JSON data that defines the data bag item.

    ![image](/images/step_manage_webui_policy_data_bag_add_item.png)

1. Click **Create Data Bag Item**.

### Delete Item

To delete a data bag item:

1. Open the Chef management console.
1. Click **Policy**.
1. Click **Data Bags**.
1. Select a data bag.
1. Select the **Items** tab.
1. Select an item.
1. Click **Delete**.

    ![image](/images/step_manage_webui_policy_data_bag_delete_item.png)

### Edit Item

To edit a data bag item:

1. Open the Chef management console.
1. Click **Policy**.
1. Click **Data Bags**.
1. Select a data bag.
1. Select the **Items** tab.
1. Select an item.
1. Click **Edit**.
    ![image](/images/step_manage_webui_policy_data_bag_edit_item.png)

1. Make your changes.
1. Click **Save Item**.

### View Item

To view data bag items for a data bag:

1. Open the Chef management console.
2. Click **Policy**.
3. Click **Data Bags**.
4. Select a data bag.
5. Select the **Items** tab.

## Manage Permissions

{{< readfile file="content/server/reusable/md/server_rbac_permissions.md" >}}

{{< readfile file="content/server/reusable/md/server_rbac_permissions_object.md" >}}

### Set

To set permissions list for a data bag object:

1. Open the Chef management console.
2. Click **Policy**.
3. Click **Data Bags**.
4. Select a data bag.
5. Click the **Permissions** tab.
6. For each group listed under **Name**, select or de-select the
    **Read**, **Update**, **Delete**, and **Grant** permissions.

### Update

To update the permissions list for a data bag object:

1. Open the Chef management console.
2. Click **Policy**.
3. Click **Data Bags**.
4. Select a data bag.
5. Click the **Permissions** tab.
6. Click the **+ Add** button and enter the name of the user or group
    to be added.
7. Select or de-select **Read**, **Update**, **Delete**, and **Grant**
    to update the permissions list for the user or group.

### View

To view permissions for a data bag object:

1. Open the Chef management console.
2. Click **Policy**.
3. Click **Data Bags**.
4. Select a data bag.
5. Click the **Permissions** tab.
6. Set the appropriate permissions: **Read**, **Update**, **Delete**,
    and **Grant**.
