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

.. note:: This section assumes that |automate| is already configured, a project exists, a user may access that project and submit changes, and that all work is being done from that project's root directory.

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


Custom build-cookbook
=======================================================
The pipeline cookbook---``pcb``---is available on |github| at https://github.com/chef-cookbooks/pcb. The ``pcb`` cookbook is a code generator cookbook that may be used with the ``chef generate`` commands packaged in the |chef dk| to generate a ``build-cookbook`` for use with a |automate| pipeline. The ``pcb`` cookbook serves as a complate example of a generated build cookbook, complete with tests, and ready for integration to |automate|, while at the same time may be cloned and then customized for your own purposes. This cookbook is not in |supermarket| because it is used by the ``delivery init`` command, which clones this cookbook to a cached location.

Generate the build-cookbook
-------------------------------------------------------
The following commands clone the ``pcb`` cookbook from |github|, and then uses the ``chef generate`` command to generate a ``build-cookbook`` using the ``pck`` cookbook as a template:

.. code-block:: bash

   $ git clone https://github.com/chef-cookbooks/pcb.git ~/.delivery/cache/generator-cookbooks/pcb

and then:

.. code-block:: bash

   $ chef generate cookbook .delivery/build-cookbook -g ~/.delivery/cache/generator-cookbooks/pcb
