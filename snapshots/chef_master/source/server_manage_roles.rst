=====================================================
Manage Roles
=====================================================

.. note:: This topic is about using the Chef management console to manage roles.

.. include:: ../../includes_chef_automate/includes_chef_automate_mark.rst 

.. include:: ../../includes_role/includes_role.rst

Manage
=====================================================
Roles can be managed from the Chef management console web user interface.

Add Role
-----------------------------------------------------
To add a role:

#. Open the Chef management console.
#. Click **Policy**.
#. Click **Roles**.
#. Click **Create**.
#. In the **Create Role** dialog box, enter the name of the role and a description.

   .. image:: ../../images/step_manage_webui_policy_role_add.png

   Click **Next**.
#. Optional. Build the run-list from the list of available roles and recipes:

   .. image:: ../../images/step_manage_webui_policy_role_add_run_list.png

   Click **Next**.
#. Optional. Add default attributes as JSON data:

   .. image:: ../../images/step_manage_webui_policy_role_add_default_attribute.png

   Click **Next**.
#. Optional. Add override attributes as JSON data:

   .. image:: ../../images/step_manage_webui_policy_role_add_override_attribute.png

#. Click **Create Role**.

Delete Role
-----------------------------------------------------
To delete a role:

#. Open the Chef management console.
#. Click **Policy**.
#. Click **Roles**.
#. Select a role.
#. Click **Delete**.

   .. image:: ../../images/step_manage_webui_policy_role_delete.png

View All Roles
-----------------------------------------------------
To view all roles uploaded to the Chef server organization:

#. Open the Chef management console.
#. Click **Policy**.
#. Click **Roles**.

Run-lists
=====================================================
.. include:: ../../includes_node/includes_node_run_list.rst

Edit Role Run-list
-----------------------------------------------------
To edit the run-list for a role:

#. Open the Chef management console.
#. Click **Policy**.
#. Click **Roles**.
#. Select a role.
#. Click **Edit Run List**.

   .. image:: ../../images/step_manage_webui_policy_role_edit_run_list.png

#. Make your changes.
#. Click **Save Run List**.

Default Attributes
=====================================================
.. include:: ../../includes_node/includes_node_attribute_type_default.rst

Edit Default Attributes
-----------------------------------------------------
To edit default attributes for a role:

#. Open the Chef management console.
#. Click **Policy**.
#. Click **Roles**.
#. Select a role.
#. Click the **Attributes** tab.
#. Under **Default Attributes**, click **Edit**.
#. In the **Edit Role Attributes** dialog box, enter the JSON data that defines the attribute (or attributes).

   .. image:: ../../images/step_manage_webui_policy_role_edit_attribute.png

#. Click **Save Attributes**.

View Default Attributes
-----------------------------------------------------
To view default attributes for a role:

#. Open the Chef management console.
#. Click **Policy**.
#. Click **Roles**.
#. Select a role.
#. Click the **Attributes** tab.

Override Attributes
=====================================================
.. include:: ../../includes_node/includes_node_attribute_type_override.rst

Edit Override Attributes
-----------------------------------------------------
To edit override attributes for a role:

#. Open the Chef management console.
#. Click **Policy**.
#. Click **Roles**.
#. Select a role.
#. Click the **Attributes** tab.
#. Under **Override Attributes**, click **Edit**.
#. In the **Edit Role Attributes** dialog box, enter the JSON data that defines the attribute (or attributes).

   .. image:: ../../images/step_manage_webui_policy_role_edit_attribute.png

#. Click **Save Attributes**.

View Override Attributes
-----------------------------------------------------
To view role details:

#. Open the Chef management console.
#. Click **Policy**.
#. Click **Roles**.
#. Select a role.
#. Click the **Details** tab.

Permissions
=====================================================
.. include:: ../../includes_server_rbac/includes_server_rbac_permissions.rst

.. include:: ../../includes_server_rbac/includes_server_rbac_permissions_object.rst

Set
-----------------------------------------------------
To set permissions list for a role object:

#. Open the Chef management console.
#. Click **Policy**.
#. Click **Roles**.
#. Select a role.
#. Click the **Permissions** tab.
#. For each group listed under **Name**, select or de-select the **Read**, **Update**, **Delete**, and **Grant** permissions.

Update
-----------------------------------------------------
To update the permissions list for a role object:

#. Open the Chef management console.
#. Click **Policy**.
#. Click **Roles**.
#. Select a role.
#. Click the **Permissions** tab.
#. Click the **+ Add** button and enter the name of the user or group to be added.
#. Select or de-select **Read**, **Update**, **Delete**, and **Grant** to update the permissions list for the user or group.

View
-----------------------------------------------------
To view permissions for a role object:

#. Open the Chef management console.
#. Click **Policy**.
#. Click **Roles**.
#. Select a role.
#. Click the **Permissions** tab.
#. Set the appropriate permissions: **Delete**, **Grant**, **Read**, and/or **Update**.
