=====================================================
Manage Environments
=====================================================
`[edit on GitHub] <https://github.com/chef/chef-web-docs/blob/master/chef_master/source/server_manage_environments.rst>`__

.. meta::
    :robots: noindex

.. note:: This topic is about using the Chef management console to manage environments.

.. tag EOL_manage

.. warning:: Chef Manage is `deprecated </versions.html#deprecated-products-and-versions>`__. The `Chef Enterprise Automation Stack <https://www.chef.io/products/enterprise-automation-stack>`_ allows you to define infrastructure, security policies, and application dependencies as code, deliver the stack via an automated pipeline to any platform, and deploy, observe, and manage the stack over its lifecycle. Chef Automate is included as part of the Chef license agreement and is `available via subscription <https://www.chef.io/pricing/>`_.

.. end_tag


.. tag environment

An environment is a way to map an organization's real-life workflow to what can be configured and managed when using Chef Infra. This mapping is accomplished by setting attributes and pinning cookbooks at the environment level. With environments, you can change cookbook configurations depending on the system's designation. For example, by designating different staging and production environments, you can then define the correct URL of a database server for each environment. Environments also allow organizations to move new cookbook releases from staging to production with confidence by stepping releases through testing environments before entering production.

.. end_tag

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
.. tag node_attribute_type_default

A ``default`` attribute is automatically reset at the start of every Chef Infra Client run and has the lowest attribute precedence. Use ``default`` attributes as often as possible in cookbooks.

.. end_tag

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
.. tag node_attribute_type_override

An ``override`` attribute is automatically reset at the start of every Chef Infra Client run and has a higher attribute precedence than ``default``, ``force_default``, and ``normal`` attributes. An ``override`` attribute is most often specified in a recipe, but can be specified in an attribute file, for a role, and/or for an environment. A cookbook should be authored so that it uses ``override`` attributes only when required.

.. end_tag

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
#. Select an environment.
#. Click the **Permissions** tab.
#. Set the appropriate permissions: **Read**, **Update**, **Delete**, and **Grant**.
