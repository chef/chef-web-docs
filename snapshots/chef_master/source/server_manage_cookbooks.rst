=====================================================
Manage Cookbooks
=====================================================

.. include:: ../../includes_chef_automate/includes_chef_automate_mark.rst 

.. note:: This topic is about using the Chef management console to manage cookbooks.

.. include:: ../../includes_cookbooks/includes_cookbooks.rst

Manage
=====================================================
Cookbooks can be viewed from the Chef management console web user interface. Cookbooks are managed using knife.

View Cookbook Details
-----------------------------------------------------
To view cookbook details:

#. Open the Chef management console.
#. Click **Policy**.
#. Click **Cookbooks**.
#. Select a cookbook.
#. Click the **Details** tab:

   .. image:: ../../images/step_manage_webui_policy_cookbook_view_details.png

Cookbook Files
=====================================================
A cookbook can contain the following types of files:

.. list-table::
   :widths: 60 420
   :header-rows: 1

   * - File Type
     - Description
   * - Attributes
     - .. include:: ../../includes_cookbooks/includes_cookbooks_attribute.rst
   * - Definitions
     - .. include:: ../../includes_definition/includes_definition_12-4.rst

       .. warning:: Starting with chef-client 12.5, it is recommended to `build custom resources <https://docs.chef.io/custom_resources.html>`__ instead of definitions and to `migrate existing definitions to be custom resources <https://docs.chef.io/definitions.html>`__.

   * - Files
     - .. include:: ../../includes_resources/includes_resource_cookbook_file.rst
   * - Libraries
     - .. include:: ../../includes_libraries/includes_libraries.rst
   * - Recipes
     - .. include:: ../../includes_cookbooks/includes_cookbooks_recipe.rst
   * - Resources
     - .. include:: ../../includes_resources_common/includes_resources_common.rst
   * - Templates
     - .. include:: ../../includes_template/includes_template.rst

All of the file types that are part of any cookbook uploaded to the Chef server are visible from the Chef management console.

Download File
-----------------------------------------------------
To download a file that is located in a cookbook:

#. Open the Chef management console.
#. Click **Policy**.
#. Click **Cookbooks**.
#. Select the file type: **Attributes**, **Definitions**, **Files**, **Recipes**, **Templates**, or **Root Files**.
#. Select a file.
#. Click **Download File**:

   .. image:: ../../images/step_manage_webui_policy_cookbook_download.png

#. Specify the location to which the file should be saved.

View a File
-----------------------------------------------------
To view a cookbook file:

#. Open the Chef management console.
#. Click **Policy**.
#. Click **Cookbooks**.
#. Select a cookbook.
#. Click the **Content** tab.
#. Select the file type: **Attributes**, **Definitions**, **Files**, **Recipes**, **Templates**, or **Root Files**.
#. Select a file:

   .. image:: ../../images/step_manage_webui_policy_cookbook_file_view.png

Permissions
=====================================================
.. include:: ../../includes_server_rbac/includes_server_rbac_permissions.rst

.. include:: ../../includes_server_rbac/includes_server_rbac_permissions_object.rst

Set
-----------------------------------------------------
To set permissions list for a cookbook object:

#. Open the Chef management console.
#. Click **Policy**.
#. Click **Cookbooks**.
#. Select a cookbook.
#. Click the **Permissions** tab.
#. For each group listed under **Name**, select or de-select the **Read**, **Update**, **Delete**, and **Grant** permissions.

Update
-----------------------------------------------------
To update the permissions list for a cookbook object:

#. Open the Chef management console.
#. Click **Policy**.
#. Click **Cookbooks**.
#. Select a cookbook.
#. Click the **Permissions** tab.
#. Click the **+ Add** button and enter the name of the user or group to be added.
#. Select or de-select **Read**, **Update**, **Delete**, and **Grant** to update the permissions list for the user or group.

View
-----------------------------------------------------
To view permissions for a cookbook object:

#. Open the Chef management console.
#. Click **Policy**.
#. Click **Cookbooks**.
#. Select a cookbook.
#. Click the **Permissions** tab.
#. Set the appropriate permissions: **Delete**, **Grant**, **Read**, and/or **Update**.

