=====================================================
Manage Client Keys
=====================================================
`[edit on GitHub] <https://github.com/chef/chef-web-docs/blob/master/chef_master/source/server_manage_clients.rst>`__

.. meta:: 
    :robots: noindex 

.. tag EOL_manage

.. warning:: Chef Manage is `deprecated </versions.html#deprecated-products-and-versions>`__. The `Chef Enterprise Automation Stack <https://www.chef.io/products/enterprise-automation-stack>`_ allows you to define infrastructure, security policies, and application dependencies as code, deliver the stack via an automated pipeline to any platform, and deploy, observe, and manage the stack over its lifecycle. Chef Automate is included as part of the Chef license agreement and is `available via subscription <https://www.chef.io/pricing/>`_.

.. end_tag

.. note:: This topic is about using the Chef management console to manage keys.

A client is an actor that has permission to access the Chef Infra Server. A client is most often a node (on which the Chef Infra Client runs), but is also a workstation (on which knife runs), or some other machine that is configured to use the Chef Infra Server API. Each request to the Chef Infra Server that is made by a client uses a private key for authentication that must be authorized by the public key on the Chef Infra Server.

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
To regenerate a client key:

#. Open the Chef management console.
#. Click **Policy**.
#. Click **Clients**.
#. Select a client key.
#. Click the **Details** tab.
#. Click **Reset Key**.
#. In the **Reset Key** dialog box, confirm that the key should be regenerated and click the **Reset Key** button:

   .. image:: ../../images/step_manage_webui_admin_organization_reset_key.png

#. Copy the private key:

   .. image:: ../../images/step_manage_webui_policy_client_reset_key_copy.png

   or download and save the private key locally:

   .. image:: ../../images/step_manage_webui_policy_client_reset_key_download.png

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
.. tag manage_webui_policy_client_permissions_add

To update the permissions list for a client key:

#. Open the Chef management console.
#. Click **Policy**.
#. Click **Clients**.
#. Select a client key.
#. Click the **Permissions** tab.
#. Click the **+ Add** button and enter the name of the user or group to be added.
#. Select or de-select **Read**, **Update**, **Delete**, and **Grant** to update the permissions list for the user or group.

.. end_tag

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
.. tag security_chef_validator

Every request made by Chef Infra Client to the Chef Infra Server must be an authenticated request using the Chef Infra Server API and a private key. When Chef Infra Client makes a request to the Chef Infra Server, Chef Infra Client authenticates each request using a private key located in ``/etc/chef/client.pem``.

.. end_tag

.. tag security_chef_validator_context

However, during the first Chef Infra Client run, this private key does not exist. Instead, Chef Infra Client attempts to use the private key assigned to the chef-validator, located in ``/etc/chef/validation.pem``. (If, for any reason, the chef-validator is unable to make an authenticated request to the Chef Infra Server, the initial Chef Infra Client run will fail.)

During the initial Chef Infra Client run, Chef Infra Client registers itself with the Chef Infra Server using the private key assigned to the chef-validator, after which Chef Infra Client will obtain a ``client.pem`` private key for all future authentication requests to the Chef Infra Server.

After the initial Chef Infra Client run has completed successfully, the chef-validator is no longer required and may be deleted from the node. Use the ``delete_validation`` recipe found in the ``chef-client`` cookbook (https://github.com/chef-cookbooks/chef-client) to remove the chef-validator.

.. end_tag

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
.. tag manage_webui_policy_validation_reset_key

To reset a chef-validator key:

#. Open the Chef management console.
#. Click **Policy**.
#. Click **Clients**.
#. Select a chef-validator key.
#. Click the **Details** tab.
#. Click **Reset Key**.
#. In the **Reset Key** dialog box, confirm that the key should be regenerated and click the **Reset Key** button:

   .. image:: ../../images/step_manage_webui_admin_organization_reset_key.png

#. Copy the private key:

   .. image:: ../../images/step_manage_webui_policy_client_reset_key_copy.png

   or download and save the private key locally:

   .. image:: ../../images/step_manage_webui_policy_client_reset_key_download.png

.. end_tag

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
.. tag manage_webui_policy_client_permissions_add

To update the permissions list for a client key:

#. Open the Chef management console.
#. Click **Policy**.
#. Click **Clients**.
#. Select a client key.
#. Click the **Permissions** tab.
#. Click the **+ Add** button and enter the name of the user or group to be added.
#. Select or de-select **Read**, **Update**, **Delete**, and **Grant** to update the permissions list for the user or group.

.. end_tag

View
+++++++++++++++++++++++++++++++++++++++++++++++++++++
To view permissions for a chef-validator key:

#. Open the Chef management console.
#. Click **Policy**.
#. Click **Clients**.
#. Select a chef-validator key.
#. Click the **Permissions** tab.
#. Set the appropriate permissions: **Delete**, **Grant**, **Read**, and/or **Update**.
