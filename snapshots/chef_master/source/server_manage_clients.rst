=====================================================
Manage Client Keys
=====================================================

.. include:: ../../includes_chef_automate/includes_chef_automate_mark.rst 

.. note:: This topic is about using the Chef management console to manage keys.

.. include:: ../../includes_server_rbac/includes_server_rbac_clients.rst

Use the Chef management console to create a key pair, download the private key, and then set permissions, to delete a key, or to reset a key.

Manage Client Keys
=====================================================
Client keys can be managed from the Chef management console.

.. warning:: The images below refer to client keys as a "Client".

Add
-----------------------------------------------------
To add a client key:

#. Open the Chef management console.
#. Click **Policy**.
#. Click **Clients**.
#. Click **Create**.
#. In the **Create Client** dialog box, enter the name of the client key.

   .. image:: ../../images/step_manage_webui_policy_client_add.png

   Click **Create Client**.
#. Copy the private key:

   .. image:: ../../images/step_manage_webui_policy_client_add_private_key.png

   or download and save the private key locally:

   .. image:: ../../images/step_manage_webui_policy_client_add_private_key_download.png

Delete
-----------------------------------------------------
To delete a client key:

#. Open the Chef management console.
#. Click **Policy**.
#. Click **Clients**.
#. Select a client key.
#. Click **Delete**.

   .. image:: ../../images/step_manage_webui_policy_client_delete.png

Reset Key
-----------------------------------------------------
.. include:: ../../step_manage_webui/step_manage_webui_policy_client_reset_key.rst

View Details
-----------------------------------------------------
To view client key details:

#. Open the Chef management console.
#. Click **Policy**.
#. Click **Clients**.
#. Select a client key.
#. Click the **Details** tab.

Permissions
-----------------------------------------------------
.. include:: ../../includes_server_rbac/includes_server_rbac_permissions.rst

.. include:: ../../includes_server_rbac/includes_server_rbac_permissions_object.rst

Set
+++++++++++++++++++++++++++++++++++++++++++++++++++++
To set permissions list for a client key:

#. Open the Chef management console.
#. Click **Policy**.
#. Click **Clients**.
#. Select a client key.
#. Click the **Permissions** tab.
#. For each group listed under **Name**, select or de-select the **Read**, **Update**, **Delete**, and **Grant** permissions.

Update
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../step_manage_webui/step_manage_webui_policy_client_permissions_add.rst

View
+++++++++++++++++++++++++++++++++++++++++++++++++++++
To view permissions for a client key:

#. Open the Chef management console.
#. Click **Policy**.
#. Click **Clients**.
#. Select a client key.
#. Click the **Permissions** tab.
#. Set the appropriate permissions: **Delete**, **Grant**, **Read**, and/or **Update**.

chef-validator Keys
=====================================================
.. include:: ../../includes_security/includes_security_chef_validator.rst

.. include:: ../../includes_security/includes_security_chef_validator_context.rst

Add
-----------------------------------------------------
To add a chef-validator key:

#. Open the Chef management console.
#. Click **Policy**.
#. Click **Clients**.
#. Click **Create**.
#. In the **Create Client** dialog box, enter the name of the chef-validator key.

   .. image:: ../../images/step_manage_webui_policy_validation_add.png

   Select the **Validation Client** option. Click **Create Client**.
#. Copy the private key:

   .. image:: ../../images/step_manage_webui_policy_client_add_private_key.png

   or download and save the private key locally:

   .. image:: ../../images/step_manage_webui_policy_client_add_private_key_download.png

Delete
-----------------------------------------------------
To delete a chef-validator key:

#. Open the Chef management console.
#. Click **Policy**.
#. Click **Clients**.
#. Select a chef-validator key.
#. Click **Delete**.

   .. image:: ../../images/step_manage_webui_policy_validation_delete.png

Reset Key
-----------------------------------------------------
.. include:: ../../step_manage_webui/step_manage_webui_policy_validation_reset_key.rst

View Details
-----------------------------------------------------
To view details for a chef-validator key:

#. Open the Chef management console.
#. Click **Policy**.
#. Click **Clients**.
#. Select a chef-validator key.

   .. image:: ../../images/step_manage_webui_policy_validation_view_details.png

#. Click the **Details** tab.

Permissions
-----------------------------------------------------
.. include:: ../../includes_server_rbac/includes_server_rbac_permissions.rst

.. include:: ../../includes_server_rbac/includes_server_rbac_permissions_object.rst

Set
+++++++++++++++++++++++++++++++++++++++++++++++++++++
To update the permissions list for a chef-validator key:

#. Open the Chef management console.
#. Click **Policy**.
#. Click **Clients**.
#. Select a chef-validator key.
#. Click the **Permissions** tab.
#. Click the **+ Add** button and enter the name of the user or group to be added.
#. Select or de-select **Delete**, **Grant**, **Read**, and/or **Update** to update the permissions list for the user or group.

Update
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../step_manage_webui/step_manage_webui_policy_client_permissions_add.rst

View
+++++++++++++++++++++++++++++++++++++++++++++++++++++
To view permissions for a chef-validator key:

#. Open the Chef management console.
#. Click **Policy**.
#. Click **Clients**.
#. Select a chef-validator key.
#. Click the **Permissions** tab.
#. Set the appropriate permissions: **Delete**, **Grant**, **Read**, and/or **Update**.
