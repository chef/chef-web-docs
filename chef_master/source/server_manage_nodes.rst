=====================================================
Manage Nodes
=====================================================
`[edit on GitHub] <https://github.com/chef/chef-web-docs/blob/master/chef_master/source/server_manage_nodes.rst>`__

.. meta::
    :robots: noindex

.. tag EOL_manage

.. warning:: Chef Manage is `deprecated </versions.html#deprecated-products-and-versions>`__. The `Chef Enterprise Automation Stack <https://www.chef.io/products/enterprise-automation-stack>`_ allows you to define infrastructure, security policies, and application dependencies as code, deliver the stack via an automated pipeline to any platform, and deploy, observe, and manage the stack over its lifecycle. Chef Automate is included as part of the Chef license agreement and is `available via subscription <https://www.chef.io/pricing/>`_.

.. end_tag


.. note:: This topic is about using the Chef management console to manage nodes.

.. tag node

A node is any device---physical, virtual, cloud, network device, etc.---that is under management by Chef Infra.

.. end_tag

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
To reset the validation key for a node:

#. Open the Chef management console.
#. Click **Nodes**.
#. Select a node.
#. Click **Edit Run List**.
#. In the **Reset Key** dialog box, confirm that the key should be regenerated and click the **Regenerate Key** button:

   .. image:: ../../images/step_manage_webui_admin_organization_reset_key.png

#. In the **Reset Key** dialog box, copy the key directly from the dialog box or click the **Download** button to download the key to your local machine:

   .. image:: ../../images/step_manage_webui_admin_organization_reset_key_regenerated.png

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
.. tag node_attribute

An attribute is a specific detail about a node. Attributes are used by Chef Infra Client to understand:

* The current state of the node
* What the state of the node was at the end of the previous Chef Infra Client run
* What the state of the node should be at the end of the current Chef Infra Client run

Attributes are defined by:

* The state of the node itself
* Attributes passed via JSON on the CLI
* Cookbooks (in attribute files and/or recipes)
* Roles
* Environments
* Policyfiles

During every Chef Infra Client run, Chef Infra Client builds the attribute list using:

* Attributes passed via JSON on the CLI
* Data about the node collected by `[Ohai] </ohai.html>`__.
* The node object that was saved to the Chef Infra Server at the end of the previous Chef Infra Client run.
* The rebuilt node object from the current Chef Infra Client run, after it is updated for changes to cookbooks (attribute files and/or recipes), roles, and/or environments, and updated for any changes to the state of the node itself.

After the node object is rebuilt, all of the attributes are compared, and then the node is updated based on attribute precedence. At the end of every Chef Infra Client run, the node object that defines the current state of the node is uploaded to the Chef Infra Server so that it can be indexed for search.

.. end_tag

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
.. tag node_run_list

A run-list defines all of the information necessary for Chef to configure a node into the desired state. A run-list is:

* An ordered list of roles and/or recipes that are run in the exact order defined in the run-list; if a recipe appears more than once in the run-list, Chef Infra Client will not run it twice
* Always specific to the node on which it runs; nodes may have a run-list that is identical to the run-list used by other nodes
* Stored as part of the node object on the Chef server
* Maintained using knife and then uploaded from the workstation to the Chef Infra Server, or maintained using Chef Automate

.. end_tag

Add Recipe to
-----------------------------------------------------
.. tag manage_webui_node_run_list_add_role_or_recipe

To add a role or recipe to a run-list:

#. Open the Chef management console.
#. Click **Nodes**.
#. Select a node.
#. Click **Edit Run List**.
#. In the **Edit Node Run List** dialog box, drag the role or recipe from the **Available Roles** or **Available Recipes** lists to the current run-list.

   .. image:: ../../images/step_manage_webui_node_run_list_add_role_or_recipe.png

#. Click **Save Run List**.

.. end_tag

Add Role to
-----------------------------------------------------
.. tag manage_webui_node_run_list_add_role_or_recipe

To add a role or recipe to a run-list:

#. Open the Chef management console.
#. Click **Nodes**.
#. Select a node.
#. Click **Edit Run List**.
#. In the **Edit Node Run List** dialog box, drag the role or recipe from the **Available Roles** or **Available Recipes** lists to the current run-list.

   .. image:: ../../images/step_manage_webui_node_run_list_add_role_or_recipe.png

#. Click **Save Run List**.

.. end_tag

Edit
-----------------------------------------------------
.. tag manage_webui_node_run_list_edit

To edit a run-list:

#. Open the Chef management console.
#. Click **Nodes**.
#. Select a node.
#. Click **Edit Run List**.
#. In the **Edit Node Run List** dialog box, make your changes.
#. Click **Save Run List**.

.. end_tag

Remove Recipe from
-----------------------------------------------------
.. tag manage_webui_node_run_list_remove_role_or_recipe

To remove a role or recipe from a run-list:

#. Open the Chef management console.
#. Click **Nodes**.
#. Select a node.
#. Click **Edit Run List**.
#. In the **Edit Node Run List** dialog box, drag the role or recipe from the **Current Run List** to the list of available roles or recipes.

   .. image:: ../../images/step_manage_webui_node_run_list_remove_role_or_recipe.png

#. Click **Save Run List**.

.. end_tag

Remove Role from
-----------------------------------------------------
.. tag manage_webui_node_run_list_remove_role_or_recipe

To remove a role or recipe from a run-list:

#. Open the Chef management console.
#. Click **Nodes**.
#. Select a node.
#. Click **Edit Run List**.
#. In the **Edit Node Run List** dialog box, drag the role or recipe from the **Current Run List** to the list of available roles or recipes.

   .. image:: ../../images/step_manage_webui_node_run_list_remove_role_or_recipe.png

#. Click **Save Run List**.

.. end_tag

View Current
-----------------------------------------------------
.. tag manage_webui_node_run_list_view_current

To view the current run-list for a node:

#. Open the Chef management console.
#. Click **Nodes**.
#. Select a node.
#. Click the **Details** tab.
#. The current run-list is shown in the lower right:

   .. image:: ../../images/step_manage_webui_node_run_list_view_current.png

.. end_tag

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
.. tag chef_tags

A tag is a custom description that is applied to a node. A tag, once applied, can be helpful when managing nodes using knife or when building recipes by providing alternate methods of grouping similar types of information.

.. end_tag

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
