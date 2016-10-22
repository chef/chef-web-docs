=====================================================
Manage Nodes
=====================================================

.. include:: ../../includes_chef_automate/includes_chef_automate_mark.rst 

.. note:: This topic is about using the Chef management console to manage nodes.

.. include:: ../../includes_node/includes_node.rst

Manage
=====================================================
Nodes can be managed from the Chef management console web user interface.

Delete
-----------------------------------------------------
To delete a node:

#. Open the Chef management console.
#. Click **Nodes**.
#. Select a node.
#. Click **Delete**.
#. Confirm:

   .. image:: ../../images/step_manage_webui_node_delete.png

Reset Key
-----------------------------------------------------
.. include:: ../../step_manage_webui/step_manage_webui_node_reset_key.rst

Search
-----------------------------------------------------
To search nodes:

#. Open the Chef management console.
#. Click **Nodes**.
#. In the search box in the upper right, enter the search query and click the search icon.

   .. image:: ../../images/step_manage_webui_nodes_search.png

#. The results will appear in the list below.

Node Attributes
=====================================================
.. include:: ../../includes_node/includes_node_attribute.rst

Edit Attribute
-----------------------------------------------------
To edit node attributes:

#. Open the Chef management console.
#. Click **Nodes**.
#. Select a node.
#. Click the **Attributes** tab.
#. Click **Edit**.
#. In the **Edit Node Attributes** dialog box, make your changes:

   .. image:: ../../images/step_manage_webui_node_attributes_edit.png

#. Click **Save Attributes**.

View Attributes
-----------------------------------------------------
To view the attributes for a node:

#. Open the Chef management console.
#. Click **Nodes**.
#. Select a node.
#. Click the **Attributes** tab.
#. Click **Edit**.

Run-lists
=====================================================
.. include:: ../../includes_node/includes_node_run_list.rst

Add Recipe to
-----------------------------------------------------
.. include:: ../../step_manage_webui/step_manage_webui_node_run_list_add_role_or_recipe.rst

Add Role to
-----------------------------------------------------
.. include:: ../../step_manage_webui/step_manage_webui_node_run_list_add_role_or_recipe.rst

Edit
-----------------------------------------------------
To edit a run-list:

#. Open the Chef management console.
#. Click **Nodes**.
#. Select a node.
#. Click **Edit Run List**.
#. In the **Edit Node Run List** dialog box, make your changes.
#. Click **Save Run List**.

Remove Recipe from
-----------------------------------------------------
.. include:: ../../step_manage_webui/step_manage_webui_node_run_list_remove_role_or_recipe.rst

Remove Role from
-----------------------------------------------------
.. include:: ../../step_manage_webui/step_manage_webui_node_run_list_remove_role_or_recipe.rst

View Current
-----------------------------------------------------
To view the current run-list for a node:

#. Open the Chef management console.
#. Click **Nodes**.
#. Select a node.
#. Click the **Details** tab.
#. The current run-list is shown in the lower right:

   .. image:: ../../images/step_manage_webui_node_run_list_view_current.png

Permissions
=====================================================
.. include:: ../../includes_server_rbac/includes_server_rbac_permissions.rst

.. include:: ../../includes_server_rbac/includes_server_rbac_permissions_object.rst

Set
-----------------------------------------------------
To set permissions list for a node object:

#. Open the Chef management console.
#. Click **Nodes**.
#. Select a node.
#. Click the **Permissions** tab.
#. For each group listed under **Name**, select or de-select the **Read**, **Update**, **Delete**, and **Grant** permissions.

Update
-----------------------------------------------------
To update the permissions list for a node object:

#. Open the Chef management console.
#. Click **Nodes**.
#. Select a node.
#. Click the **Permissions** tab.
#. Click the **+ Add** button and enter the name of the user or group to be added.
#. Select or de-select **Read**, **Update**, **Delete**, and **Grant** to update the permissions list for the user or group.

View
-----------------------------------------------------
To view permissions for a node:

#. Open the Chef management console.
#. Click **Nodes**.
#. Select a node.
#. Click the **Permissions** tab.
#. Set the appropriate permissions: **Delete**, **Grant**, **Read**, and/or **Update**.

Manage Tags
=====================================================
.. include:: ../../includes_chef/includes_chef_tags.rst

Add
-----------------------------------------------------
To add tags to a node (or a group of nodes):

#. Open the Chef management console.
#. Click **Nodes**.
#. Select a node (or a group of nodes).
#. Click **Manage Tags**.
#. In the **Manage Node Tags** dialog box, enter the name of the tag and then select **Add Tags** from the drop-down.

   .. image:: ../../images/step_manage_webui_node_tags_add.png

#. Click **Update Tags**.

Delete
-----------------------------------------------------
To delete tags for a node (or a group of nodes):

#. Open the Chef management console.
#. Click **Nodes**.
#. Select a node (or a group of nodes).
#. Click **Manage Tags**.
#. In the **Manage Node Tags** dialog box, enter the name of the tag and then select **Delete Tags** from the drop-down.

   .. image:: ../../images/step_manage_webui_node_tags_delete.png

#. Click **Update Tags**.

View
-----------------------------------------------------
To view all of the nodes:

#. Open the Chef management console.
#. Click **Nodes**.
#. Select a node.
#. Select the **Details** tab.
#. The tags for the node appear under the **Tags** header:

   .. image:: ../../images/step_manage_webui_nodes_view_tags.png




