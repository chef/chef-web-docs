=====================================================
Manage Data Bags
=====================================================
`[edit on GitHub] <https://github.com/chef/chef-web-docs/blob/master/chef_master/source/server_manage_data_bags.rst>`__

.. meta:: 
    :robots: noindex 

.. tag EOL_manage

.. warning:: Chef Manage is `deprecated </versions.html#deprecated-products-and-versions>`__. The `Chef Enterprise Automation Stack <https://www.chef.io/products/enterprise-automation-stack>`_ allows you to define infrastructure, security policies, and application dependencies as code, deliver the stack via an automated pipeline to any platform, and deploy, observe, and manage the stack over its lifecycle. Chef Automate is included as part of the Chef license agreement and is `available via subscription <https://www.chef.io/pricing/>`_.

.. end_tag


.. note:: This topic is about using the Chef management console to manage data bags.

.. tag data_bag

Data bags store global variables as JSON data. Data bags are indexed for searching and can be loaded by a cookbook or accessed during a search.

.. end_tag

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
.. tag data_bag_item

A data bag is a container of related data bag items, where each individual data bag item is a JSON file. knife can load a data bag item by specifying the name of the data bag to which the item belongs and then the filename of the data bag item. The only structural requirement of a data bag item is that it must have an ``id``:

.. code-block:: javascript

   {
     /* This is a supported comment style */
     // This style is also supported
     "id": "ITEM_NAME",
     "key": "value"
   }

where

* ``key`` and ``value`` are the ``key:value`` pair for each additional attribute within the data bag item
* ``/* ... */`` and ``// ...`` show two ways to add comments to the data bag item

.. end_tag

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
#. Select an item.
#. Click **Delete**.

   .. image:: ../../images/step_manage_webui_policy_data_bag_delete_item.png

Edit Item
-----------------------------------------------------
.. tag manage_webui_policy_data_bag_edit_item

To edit a data bag item:

#. Open the Chef management console.
#. Click **Policy**.
#. Click **Data Bags**.
#. Select a data bag.
#. Select the **Items** tab.
#. Select an item.
#. Click **Edit**.

   .. image:: ../../images/step_manage_webui_policy_data_bag_edit_item.png

#. Make your changes.
#. Click **Save Item**.

.. end_tag

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
.. tag server_rbac_permissions

Permissions are used in the Chef Infra Server to define how users and groups can interact with objects on the server. Permissions are configured per-organization.

.. end_tag

.. tag server_rbac_permissions_object

The Chef Infra Server includes the following object permissions:

.. list-table::
   :widths: 60 420
   :header-rows: 1

   * - Permission
     - Description
   * - **Delete**
     - Use the **Delete** permission to define which users and groups may delete an object. This permission is required for any user who uses the ``knife [object] delete [object_name]`` argument to interact with objects on the Chef Infra Server.
   * - **Grant**
     - Use the **Grant** permission to define which users and groups may configure permissions on an object. This permission is required for any user who configures permissions using the **Administration** tab in the Chef management console.
   * - **Read**
     - Use the **Read** permission to define which users and groups may view the details of an object. This permission is required for any user who uses the ``knife [object] show [object_name]`` argument to interact with objects on the Chef Infra Server.
   * - **Update**
     - Use the **Update** permission to define which users and groups may edit the details of an object. This permission is required for any user who uses the ``knife [object] edit [object_name]`` argument to interact with objects on the Chef Infra Server and for any Chef Infra Client to save node data to the Chef Infra Server at the conclusion of a Chef Infra Client run.

.. end_tag

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

