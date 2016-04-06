=====================================================
About the delivery-truck Cookbook
=====================================================

.. include:: ../../includes_delivery_cookbook/includes_delivery_cookbook_delivery_truck.rst

.. note:: The ``delivery-truck`` cookbook has a dependency on the ``delivery-sugar`` cookbook, which contains a set of helper methods and custom resources that may be used in build cookbook recipes. Using these helper methods and custom resources in a build cookbook is optional.


delivery-truck Recipes
=====================================================
The following recipes are available by default in the ``delivery-truck`` cookbook:

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
=====================================================
.. include:: ../../includes_delivery_cookbook/includes_delivery_cookbook_setup.rst

.. note:: This section assumes that |delivery| is already configured, a project exists, a user may access that project and submit changes, and that all work is being done from that project's root directory.

Edit the |berksfile|
-----------------------------------------------------
.. include:: ../../includes_delivery_cookbook/includes_delivery_cookbook_setup_berksfile.rst

Edit |metadata rb|
-----------------------------------------------------
.. include:: ../../includes_delivery_cookbook/includes_delivery_cookbook_setup_metadata.rst

Add delivery-truck to Recipes
-----------------------------------------------------
.. include:: ../../includes_delivery_cookbook/includes_delivery_cookbook_setup_recipes.rst


Read the Tutorial
=====================================================
To learn more about how to set up a project pipeline for a single cookbook and simple application, follow the steps outlined in the `Build a continuous deployment pipeline with Chef Delivery <https://learn.chef.io/delivery/get-started/>`__ tutorial on https://learn.chef.io/tutorials/.





Project Applications
=====================================================
.. include:: ../../includes_delivery/includes_delivery_project_application.rst

Configure Project Application
-----------------------------------------------------
.. include:: ../../includes_delivery/includes_delivery_project_application_configure.rst

Example Project Application
-----------------------------------------------------
.. include:: ../../includes_delivery/includes_delivery_project_application_example.rst




Validate the Installation
=====================================================
The surest way to validate a |delivery| installation is to create a cookbook, and then submit it to |delivery| to kick off a new build in the pipeline.

.. include:: ../../includes_delivery/includes_delivery_build_cookbook_create.rst

.. include:: ../../includes_delivery/includes_delivery_projects_add_with_delivery_truck.rst