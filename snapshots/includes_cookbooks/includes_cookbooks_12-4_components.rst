.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


Cookbooks are comprised of the following components:

.. list-table::
   :widths: 100 420
   :header-rows: 1

   * - Component
     - Description
   * - .. image:: ../../images/icon_cookbook_attributes.svg
          :width: 100px
          :align: center

     - .. include:: ../../includes_cookbooks/includes_cookbooks_attribute.rst
   * - .. image:: ../../images/icon_cookbook_definitions.svg
          :width: 100px
          :align: center

     - .. include:: ../../includes_definition/includes_definition_12-4.rst
   * - .. image:: ../../images/icon_cookbook_files.svg
          :width: 100px
          :align: center

     - .. include:: ../../includes_resources/includes_resource_cookbook_file.rst
   * - .. image:: ../../images/icon_cookbook_libraries.svg
          :width: 100px
          :align: center

     - .. include:: ../../includes_libraries/includes_libraries.rst
   * - .. image:: ../../images/icon_cookbook_metadata.svg
          :width: 100px
          :align: center

     - .. include:: ../../includes_cookbooks/includes_cookbooks_metadata.rst
   * - .. image:: ../../images/icon_cookbook_recipes.svg
          :width: 100px
          :align: center

       .. image:: ../../images/icon_recipe_dsl.svg
          :width: 100px
          :align: center


     - .. include:: ../../includes_cookbooks/includes_cookbooks_recipe.rst

       The chef-client will run a recipe only when asked. When the chef-client runs the same recipe more than once, the results will be the same system state each time. When a recipe is run against a system, but nothing has changed on either the system or in the recipe, the chef-client won't change anything.

       .. include:: ../../includes_dsl_recipe/includes_dsl_recipe.rst

   * - .. image:: ../../images/icon_cookbook_resources.svg
          :width: 100px
          :align: center

       .. image:: ../../images/icon_cookbook_providers.svg
          :width: 100px
          :align: center

     - .. include:: ../../includes_resources_common/includes_resources_common.rst

       .. include:: ../../includes_resources_common/includes_resources_common_provider.rst

       Chef has `many built-in resources <https://docs.chef.io/resources.html>`__ that cover all of the most common actions across all of the most common platforms. You can `build your own resources <https://docs.chef.io/lwrp.html>`__ to handle any situation that isn't covered by a built-in resource.
   * - .. image:: ../../images/icon_cookbook_templates.svg
          :width: 100px
          :align: center

     - .. include:: ../../includes_template/includes_template.rst
   * - .. image:: ../../images/icon_cookbook_tests.svg
          :width: 100px
          :align: center

     - Testing cookbooks improves the quality of those cookbooks by ensuring they are doing what they are supposed to do and that they are authored in a consistent manner. Unit and integration testing validates the recipes in cookbooks. Syntax testing---often called linting---validates the quality of the code itself. The following tools are popular tools used for testing Chef recipes: Kitchen, ChefSpec, and Foodcritic.
