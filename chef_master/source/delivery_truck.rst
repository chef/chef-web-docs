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


Create a build-cookbook
=====================================================
.. include:: ../../includes_delivery_cookbook/includes_delivery_cookbook_setup.rst

.. note:: This section assumes that |automate| is already configured, a project exists, a user may access that project and submit changes, and that all work is being done from that project's root directory.

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

To learn more about how to set up a project pipeline for a single cookbook and simple application, follow the steps outlined in the `Build a continuous deployment pipeline with Chef Automate <https://learn.chef.io/tutorials/#chef-automate>`__ tutorial on https://learn.chef.io/tutorials/.


Project Cookbooks
=====================================================
.. include:: ../../includes_delivery_cookbook/includes_delivery_cookbook_project.rst

Single Cookbook
-----------------------------------------------------
.. include:: ../../includes_delivery_cookbook/includes_delivery_cookbook_project_single.rst

Add Project Cookbook
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_delivery_cookbook/includes_delivery_cookbook_project_single_create.rst

Configure default.rb
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_delivery_cookbook/includes_delivery_cookbook_project_single_configure.rst

Promote the Project
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_delivery_cookbook/includes_delivery_cookbook_project_single_promote.rst

Update the Project
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_delivery_cookbook/includes_delivery_cookbook_project_single_update.rst

Multiple Cookbooks
-----------------------------------------------------
.. include:: ../../includes_delivery_cookbook/includes_delivery_cookbook_project_multiple.rst


Project Applications
=====================================================
.. include:: ../../includes_delivery_cookbook/includes_delivery_cookbook_project_application.rst

Configure Project Application
-----------------------------------------------------
.. include:: ../../includes_delivery_cookbook/includes_delivery_cookbook_project_application_configure.rst

Example Project Application
-----------------------------------------------------
.. include:: ../../includes_delivery_cookbook/includes_delivery_cookbook_project_application_example.rst


Validate the Installation
=====================================================
The surest way to validate a |automate| installation is to create a cookbook, and then submit it to |automate| to kick off a new build in the pipeline.

.. include:: ../../includes_delivery/includes_delivery_build_cookbook_create.rst

.. include:: ../../includes_delivery/includes_delivery_projects_add_with_delivery_truck.rst

Using ``delivery-truck`` in air-gapped environment
========================================================

|automate| can be set up to deploy cookbooks and applications in an air-gapped environment and this section describes 
how to set up a basic cookbook to be delivered through |automate| using the `delivery-truck cookbook <https://github.com/chef-cookbooks/delivery-truck>`__
in that environment.

.. note:: By default, the delivery-truck cookbook is configured for use with |automate|-backed cookbook projects.

Prerequisites
-----------------------------------------------------

* Ensure you have a private Supermarket installed, setup, and running. See `Install Private Supermarket <https://docs.chef.io/install_supermarket.html>`__ for more information.
* Ensure you have a Chef server with the Chef identify authentication/authorization service configured, a |automate| server setup that references your private Supermarket, and at least one |automate| build node installed, setup, and running. See `Install Chef Automate <https://docs.chef.io/install_chef_automate.html>`__ and `Chef Identify <https://docs.chef.io/install_supermarket.html#chef-identify>`__ for more information.
* Ensure you have created a project in |automate|. Follow these instructions to `Set Up Projects <https://docs.chef.io/delivery_build_cookbook.html#set-up-projects>`__.
* Ensure you have `ChefDK <https://downloads.chef.io/chef-dk/>`__ installed on your `workstation <https://docs.chef.io/workstation.html>`__.


Share cookbooks with your private Supermarket
-----------------------------------------------------

To use ``delivery-truck`` and its dependency, ``delivery-sugar``, you must first share them with a private Supermarket that is authenticated with your Chef server.

#. From a workstation, create a cookbooks directory, ``$COOKBOOKS_DIR``:

   .. code-block:: bash
   
      mkdir -p $COOKBOOKS_DIR

#. Clone the ``delivery-truck`` cookbook and its dependency ``deliver-sugar`` from GitHub:

   .. code-block:: bash
   
      cd $COOKBOOKS_DIR
      git clone https://github.com/chef-cookbooks/delivery-sugar.git
      git clone https://github.com/chef-cookbooks/delivery-truck.git

#. To ensure your private Supermarket does not try to connect to third-party services, log into it and set the ``AIR_GAPPED`` environment variable to ``'true'`` in the ``/etc/supermarket/supermarket.rb`` file.

   .. code-block:: ruby

      default['supermarket']['air_gapped'] = 'true'

#. Save your changes and close the file.
#. Reconfigure your private Supermarket.

   .. code-block:: bash

      supermarket-ctl reconfigure

#. Share the ``delivery-truck`` and ``delivery-sugar`` cookbooks with your private Supermarket using the ``knife`` command-line tool. If you have not configured ``knife`` to share cookbooks with your private Supermarket, see `Upload a Cookbook <https://docs.chef.io/supermarket.html#upload-a-cookbook>`__ before running the following ``knife`` subcommands.

   .. code-block::bash

      knife cookbook site share 'delivery-truck'
      knife cookbook site share 'delivery-sugar'


Generate a cookbook
-----------------------------------------------------

#. On your workstation, use ChefDK's `cookbook generator command <https://docs.chef.io/ctl_chef.html#chef-generate-cookbook>`__ to create a default cookbook directory structure called ``my_cookbook``.

   .. code-block:: bash
      
      chef generate cookbook my_cookbook

#. Run ``delivery init`` in your ``my_cookbook`` local directory to create a new project in |automate| and push your first change for review.

   .. code-block:: bash

      cd my_cookbook
      delivery init

#. Finally, check out the added files and commit your changes.


Use the ``delivery-truck`` cookbook in your project
-----------------------------------------------------

From the root of your project's directory, do the following:

#. Modify the build cookbook's Berksfile to reference ``delivery-truck`` and ``delivery-sugar``. By default, this file is located at ``.delivery/build-cookbook/Berksfile``.

   .. code-block:: ruby

      source 'https://your_private_supermarket_url'

      metadata

      group :delivery do
        cookbook 'delivery-sugar'
        cookbook 'delivery-truck'
      end

#. Modify the build cookbook's metadata to include ``delivery-truck``. By default, this file is located at ``.delivery/build-cookbook/metadata.rb``.

   .. code-block:: ruby

      depends 'delivery-truck'

#. Edit your build cookbook's recipes to include the corresponding ``delivery-truck`` recipe.

   .. code-block:: none

      # Cookbook Name:: $BUILD_COOKBOOK_NAME
      # Recipe:: $RECIPE
      #
      # Copyright (c) 2016 The Authors, All Rights Reserved.

      include_recipe "delivery-truck::$RECIPE"

   By default, each build cookbook recipe ``$RECIPE`` is located at ``.delivery/build-cookbook/recipes/$RECIPE.rb``.

#. Increment your build cookbook's version in the cookbook's metadata file.

#. Commit your changes and run ``delivery review``. Changes to your cookbook project can now be managed by your |automate| cluster.