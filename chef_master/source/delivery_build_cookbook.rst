=======================================================
About the build-cookbook
=======================================================

.. include:: ../../includes_delivery_cookbook/includes_delivery_cookbook_build.rst

Build Cookbook Structure
=======================================================
.. include:: ../../includes_delivery_cookbook/includes_delivery_cookbook_build_structure.rst

The following recipes should be configured to include the corresponding ``delivery-truck`` recipe as a dependency:

``default.rb``
   .. include:: ../../includes_delivery_cookbook/includes_delivery_cookbook_common_recipe_default.rst

``deploy.rb``
   .. include:: ../../includes_delivery_cookbook/includes_delivery_cookbook_common_recipe_deploy.rst

``functional.rb``
   .. include:: ../../includes_delivery_cookbook/includes_delivery_cookbook_common_recipe_functional.rst

``lint.rb``
   .. include:: ../../includes_delivery_cookbook/includes_delivery_cookbook_common_recipe_lint.rst

``provision.rb``
   .. include:: ../../includes_delivery_cookbook/includes_delivery_cookbook_common_recipe_provision.rst

``publish.rb``
   .. include:: ../../includes_delivery_cookbook/includes_delivery_cookbook_common_recipe_publish.rst

``quality.rb``
   .. include:: ../../includes_delivery_cookbook/includes_delivery_cookbook_common_recipe_quality.rst

``security.rb``
   .. include:: ../../includes_delivery_cookbook/includes_delivery_cookbook_common_recipe_security.rst

``smoke.rb``
   .. include:: ../../includes_delivery_cookbook/includes_delivery_cookbook_common_recipe_smoke.rst

``syntax.rb``
   .. include:: ../../includes_delivery_cookbook/includes_delivery_cookbook_common_recipe_syntax.rst

``unit.rb``
   .. include:: ../../includes_delivery_cookbook/includes_delivery_cookbook_common_recipe_unit.rst


Create Build Cookbook
=======================================================
.. include:: ../../includes_delivery_cookbook/includes_delivery_cookbook_setup.rst

.. note:: This section assumes that |delivery| is already configured, a project exists, a user may access that project and submit changes, and that all work is being done from that project's root directory.

Edit the |berksfile|
-------------------------------------------------------
.. include:: ../../includes_delivery_cookbook/includes_delivery_cookbook_setup_berksfile.rst

Edit |metadata rb|
-------------------------------------------------------
.. include:: ../../includes_delivery_cookbook/includes_delivery_cookbook_setup_metadata.rst

Add delivery-truck to Recipes
-------------------------------------------------------
.. include:: ../../includes_delivery_cookbook/includes_delivery_cookbook_setup_recipes.rst


Set Up Projects
=======================================================
.. include:: ../../includes_delivery/includes_delivery_projects.rst

Use the Delivery CLI
-------------------------------------------------------
.. include:: ../../includes_delivery/includes_delivery_projects_add_with_delivery_truck.rst

Use the Web UI
-------------------------------------------------------
.. include:: ../../includes_delivery/includes_delivery_projects_add_with_webui.rst
