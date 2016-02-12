=====================================================
Manage Cookbooks
=====================================================

.. note:: This topic is about using the |chef manage| to manage cookbooks.

.. include:: ../../includes_cookbooks/includes_cookbooks.rst

Manage
=====================================================
Cookbooks can be viewed from the |chef manage| web user interface. Cookbooks are managed using |knife|.

View Cookbook Details
-----------------------------------------------------
.. include:: ../../step_manage_webui/step_manage_webui_policy_cookbook_view_details.rst

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

       .. warning:: Starting with |chef client| 12.5, it is recommended to `build custom resources <https://docs.chef.io/custom_resources.html>`__ instead of definitions and to `migrate existing definitions to be custom resources <https://docs.chef.io/definitions.html>`__.

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

All of the file types that are part of any cookbook uploaded to the |chef server| are visible from the |chef manage|.

Download File
-----------------------------------------------------
.. include:: ../../step_manage_webui/step_manage_webui_policy_cookbook_file_download.rst

View a File
-----------------------------------------------------
.. include:: ../../step_manage_webui/step_manage_webui_policy_cookbook_file_view.rst

Permissions
=====================================================
.. include:: ../../includes_server_rbac/includes_server_rbac_permissions.rst

.. include:: ../../includes_server_rbac/includes_server_rbac_permissions_object.rst

Set
-----------------------------------------------------
.. include:: ../../step_manage_webui/step_manage_webui_policy_cookbook_permissions_set.rst

Update
-----------------------------------------------------
.. include:: ../../step_manage_webui/step_manage_webui_policy_cookbook_permissions_add.rst

View
-----------------------------------------------------
.. include:: ../../step_manage_webui/step_manage_webui_policy_cookbook_permissions_view.rst

