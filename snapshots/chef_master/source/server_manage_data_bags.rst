=====================================================
Manage Data Bags
=====================================================

.. include:: ../../includes_chef_automate/includes_chef_automate_mark.rst 

.. note:: This topic is about using the Chef management console to manage data bags.

.. include:: ../../includes_data_bag/includes_data_bag.rst

Manage
=====================================================
Data bags can be managed from the Chef management console web user interface.

Add Data Bag
-----------------------------------------------------
To add a data bag:

#. Open the Chef management console.
#. Click **Policy**.
#. Click **Data Bags**.
#. Click **Create**.
#. In the **Create a Data Bag** dialog box, enter the name of the data bag.

   .. image:: ../../images/step_manage_webui_policy_data_bag_add.png

#. Click **Create Data Bag**.

Delete Data Bag
-----------------------------------------------------
To delete a data bag:

#. Open the Chef management console.
#. Click **Policy**.
#. Click **Data Bags**.
#. Select a data bag.
#. Click **Delete**.

   .. image:: ../../images/step_manage_webui_policy_data_bag_delete.png

Manage Items
=====================================================
.. include:: ../../includes_data_bag/includes_data_bag_item.rst

Add Item
-----------------------------------------------------
To add a data bag item:

#. Open the Chef management console.
#. Click **Policy**.
#. Click **Data Bags**.
#. Select a data bag.
#. Click **Create Item**.
#. In the **Create a Data Bag Item** dialog box, enter the data bag identifier, and then JSON data that defines the data bag item.

   .. image:: ../../images/step_manage_webui_policy_data_bag_add_item.png

#. Click **Create Data Bag Item**.

Delete Item
-----------------------------------------------------
To delete a data bag item:

#. Open the Chef management console.
#. Click **Policy**.
#. Click **Data Bags**.
#. Select a data bag.
#. Select the **Items** tab.
#. Select a data bag.
#. Click **Delete**.

   .. image:: ../../images/step_manage_webui_policy_data_bag_delete_item.png

Edit Item
-----------------------------------------------------
To edit a data bag item:

#. Open the Chef management console.
#. Click **Policy**.
#. Click **Data Bags**.
#. Select a data bag.
#. Select the **Items** tab.
#. Select a data bag.
#. Click **Edit**.

   .. image:: ../../images/step_manage_webui_policy_data_bag_edit_item.png

#. Make your changes.
#. Click **Save Item**.

View Item
-----------------------------------------------------
To view data bag items for a data bag:

#. Open the Chef management console.
#. Click **Policy**.
#. Click **Data Bags**.
#. Select a data bag.
#. Select the **Items** tab.

Manage Permissions
=====================================================
.. include:: ../../includes_server_rbac/includes_server_rbac_permissions.rst

.. include:: ../../includes_server_rbac/includes_server_rbac_permissions_object.rst

Set
-----------------------------------------------------
To set permissions list for a data bag object:

#. Open the Chef management console.
#. Click **Policy**.
#. Click **Data Bags**.
#. Select a data bag.
#. Click the **Permissions** tab.
#. For each group listed under **Name**, select or de-select the **Read**, **Update**, **Delete**, and **Grant** permissions.

Update
-----------------------------------------------------
To update the permissions list for a data bag object:

#. Open the Chef management console.
#. Click **Policy**.
#. Click **Data Bags**.
#. Select a data bag.
#. Click the **Permissions** tab.
#. Click the **+ Add** button and enter the name of the user or group to be added.
#. Select or de-select **Read**, **Update**, **Delete**, and **Grant** to update the permissions list for the user or group.

View
-----------------------------------------------------
To view permissions for a data bag object:

#. Open the Chef management console.
#. Click **Policy**.
#. Click **Data Bags**.
#. Select a data bag.
#. Click the **Permissions** tab.
#. Set the appropriate permissions: **Read**, **Update**, **Delete**, and **Grant**.

