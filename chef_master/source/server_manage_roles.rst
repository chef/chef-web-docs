=====================================================
Manage Roles
=====================================================
`[edit on GitHub] <https://github.com/chef/chef-web-docs/blob/master/chef_master/source/server_manage_roles.rst>`__

.. meta:: 
    :robots: noindex 

.. tag EOL_manage

.. warning:: Chef Manage is `deprecated </versions.html#deprecated-products-and-versions>`__. The `Chef Enterprise Automation Stack <https://www.chef.io/products/enterprise-automation-stack>`_ allows you to define infrastructure, security policies, and application dependencies as code, deliver the stack via an automated pipeline to any platform, and deploy, observe, and manage the stack over its lifecycle. Chef Automate is included as part of the Chef license agreement and is `available via subscription <https://www.chef.io/pricing/>`_.

.. end_tag


.. note:: This topic is about using the Chef management console to manage roles.

.. tag role

A role is a way to define certain patterns and processes that exist across nodes in an organization as belonging to a single job function. Each role consists of zero (or more) attributes and a run-list. Each node can have zero (or more) roles assigned to it. When a role is run against a node, the configuration details of that node are compared against the attributes of the role, and then the contents of that role's run-list are applied to the node's configuration details. When a Chef Infra Client runs, it merges its own attributes and run-lists with those contained within each assigned role.

.. end_tag

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
To view all roles uploaded to the Chef Infra Server organization:

#. Open the Chef management console.
#. Click **Policy**.
#. Click **Roles**.

Run-lists
=====================================================
.. tag node_run_list

A run-list defines all of the information necessary for Chef to configure a node into the desired state. A run-list is:

* An ordered list of roles and/or recipes that are run in the exact order defined in the run-list; if a recipe appears more than once in the run-list, Chef Infra Client will not run it twice
* Always specific to the node on which it runs; nodes may have a run-list that is identical to the run-list used by other nodes
* Stored as part of the node object on the Chef server
* Maintained using knife and then uploaded from the workstation to the Chef Infra Server, or maintained using Chef Automate

.. end_tag

Edit Role Run-list
-----------------------------------------------------
.. tag manage_webui_policy_role_edit_run_list

To edit the run-list for a role:

#. Open the Chef management console.
#. Click **Policy**.
#. Click **Roles**.
#. Select a role.
#. Click **Edit Run List**.

   .. image:: ../../images/step_manage_webui_policy_role_edit_run_list.png

#. Make your changes.
#. Click **Save Run List**.

.. end_tag

Default Attributes
=====================================================
.. tag node_attribute_type_default

A ``default`` attribute is automatically reset at the start of every Chef Infra Client run and has the lowest attribute precedence. Use ``default`` attributes as often as possible in cookbooks.

.. end_tag

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
.. tag node_attribute_type_override

An ``override`` attribute is automatically reset at the start of every Chef Infra Client run and has a higher attribute precedence than ``default``, ``force_default``, and ``normal`` attributes. An ``override`` attribute is most often specified in a recipe, but can be specified in an attribute file, for a role, and/or for an environment. A cookbook should be authored so that it uses ``override`` attributes only when required.

.. end_tag

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
