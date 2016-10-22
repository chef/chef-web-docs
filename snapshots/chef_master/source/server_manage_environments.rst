=====================================================
Manage Environments
=====================================================

.. include:: ../../includes_chef_automate/includes_chef_automate_mark.rst 

.. note:: This topic is about using the Chef management console to manage environments.

.. include:: ../../includes_environment/includes_environment.rst

Manage
=====================================================
Environments can be managed from the Chef management console web user interface.

Add Environment
-----------------------------------------------------
To add an environment:

#. Open the Chef management console.
#. Click **Policy**.
#. Click **Environments**.
#. Click **Create**.
#. In the **Create an Environment** dialog box, enter the name of the environment and a description.

   .. image:: ../../images/step_manage_webui_policy_environment_add.png

   Click **Next**.
#. Optional. Set a constraint by choosing a name, an operator, and a version:

   .. image:: ../../images/step_manage_webui_policy_environment_add_constraint.png

   Click **Add**. Continue this process until all constraints are added. When finished, click **Next**.
#. Optional. Add default attributes as JSON data:

   .. image:: ../../images/step_manage_webui_policy_environment_add_default_attribute.png

   Click **Next**.
#. Optional. Add override attributes as JSON data:

   .. image:: ../../images/step_manage_webui_policy_environment_add_override_attribute.png

#. Click **Create Environment**.

Delete Environment
-----------------------------------------------------
To delete an environment:

#. Open the Chef management console.
#. Click **Policy**.
#. Click **Environments**.
#. Select an environment.
#. Click **Delete**.

   .. image:: ../../images/step_manage_webui_policy_environment_delete.png

Edit Details
-----------------------------------------------------
To edit the details of an environment:

#. Open the Chef management console.
#. Click **Policy**.
#. Click **Environments**.
#. Select an environment.
#. Click the **Details** tab.
#. Click **Edit**.

Set
-----------------------------------------------------
To set the environment for a node:

#. Open the Chef management console.
#. Click **Nodes**.
#. Select a node.
#. Click the **Details** tab.
#. In the top right, from the **Environment** drop-down, select the environment:

   .. image:: ../../images/step_manage_webui_node_details_set_environment.png

#. Click **Save**.

View Details
-----------------------------------------------------
To view environment details:

#. Open the Chef management console.
#. Click **Policy**.
#. Click **Environments**.
#. Select an environment.
#. Click the **Details** tab.

Default Attributes
=====================================================
.. include:: ../../includes_node/includes_node_attribute_type_default.rst

Edit
-----------------------------------------------------
To edit default attributes for an environment:

#. Open the Chef management console.
#. Click **Policy**.
#. Click **Environments**.
#. Select an environment.
#. Click the **Attributes** tab.
#. Under **Default Attributes**, click **Edit**.
#. In the **Edit Environment Attributes** dialog box, enter the JSON data that defines the attribute (or attributes).

   .. image:: ../../images/step_manage_webui_policy_environment_edit_attribute.png

#. Click **Save**.

View
-----------------------------------------------------
To view default attributes for an environment:

#. Open the Chef management console.
#. Click **Policy**.
#. Click **Environments**.
#. Select an environment.
#. Click the **Attributes** tab.

Override Attributes
=====================================================
.. include:: ../../includes_node/includes_node_attribute_type_override.rst

Edit
-----------------------------------------------------
To edit override attributes for an environment:

#. Open the Chef management console.
#. Click **Policy**.
#. Click **Environments**.
#. Select an environment.
#. Click the **Attributes** tab.
#. Under **Override Attributes**, click **Edit**.
#. In the **Edit Environment Attributes** dialog box, enter the JSON data that defines the attribute (or attributes).

   .. image:: ../../images/step_manage_webui_policy_environment_edit_attribute.png

#. Click **Save Attributes**.

View
-----------------------------------------------------
To view override attributes for an environment:

#. Open the Chef management console.
#. Click **Policy**.
#. Click **Environments**.
#. Select an environment.
#. Click the **Attributes** tab.

Permissions
=====================================================
.. include:: ../../includes_server_rbac/includes_server_rbac_permissions.rst

.. include:: ../../includes_server_rbac/includes_server_rbac_permissions_object.rst

Set
-----------------------------------------------------
To set permissions list for an environment object:

#. Open the Chef management console.
#. Click **Policy**.
#. Click **Environments**.
#. Select an environment.
#. Click the **Permissions** tab.
#. For each group listed under **Name**, select or de-select the **Read**, **Update**, **Delete**, and **Grant** permissions.

Update
-----------------------------------------------------
To update the permissions list for an environment object:

#. Open the Chef management console.
#. Click **Policy**.
#. Click **Environments**.
#. Select an environment.
#. Click the **Permissions** tab.
#. Click the **+ Add** button and enter the name of the user or group to be added.
#. Select or de-select **Read**, **Update**, **Delete**, and **Grant** to update the permissions list for the user or group.

View
-----------------------------------------------------
To view permissions for an environment object:

#. Open the Chef management console.
#. Click **Policy**.
#. Click **Environments**.
#. Select an enviromnent.
#. Click the **Permissions** tab.
#. Set the appropriate permissions: **Read**, **Update**, **Delete**, and **Grant**.
