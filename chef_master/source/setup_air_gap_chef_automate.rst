========================================================
Set up |automate| in an air-gapped environment
========================================================

|automate| can be setup to deploy cookbooks and applications in an air-gapped environment. This topic describes 
how to setup a basic cookbook to be delivered through |automate| using the ` delivery-truck cookbook <https://github.com/chef-cookbooks/delivery-truck>`__
in an air-gapped environment.

.. note:: By default, the delivery-truck cookbook is configured for use with |automate|-backed cookbook projects.

Prerequisites
========================================================

* Ensure you have a Chef server with the Chef identify authentication/authorization service configured, a |automate| server, and at least one |automate|
build node installed, setup, and running. See `Install Chef Automate <https://docs.chef.io/install_chef_automate.html>`__ and `Chef Identify <https://docs.chef.io/install_supermarket.html#chef-identify>`__for more information.
* Ensure you have created a project in |automate|. Follow these instructions to
`Set Up Projects <https://docs.chef.io/delivery_build_cookbook.html#set-up-projects>`__.
* Ensure you have `ChefDK <https://downloads.chef.io/chef-dk/>`__ installed on your `workstation <https://docs.chef.io/workstation.html`__.
* Ensure you have a private Supermarket installed, setup, and running. See `Install Private Supermarket <https://docs.chef.io/install_supermarket.html>`__ for more information.

Share cookbooks with your private Supermarket
========================================================

To use ``delivery-truck`` and it's dependency, ``delivery-sugar``, you must first share them with a private Supermarket that is authenticated with your Chef server.

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

      ENV['AIR_GAPPED'] = 'true'

#. Log out of your private Supermarket.
#. Share the ``delivery-truck`` and ``delivery-sugar`` cookbooks with your private Supermarket using the ``knife`` command-line tool. 
If you have not configured ``knife`` to share cookbooks with your private Supermarket, see `Upload a Cookbook <https://docs.chef.io/supermarket.html#upload-a-cookbook>`__ before running the following ``knife`` subcommands.

   .. code-block::bash

      knife cookbook site share 'delivery-truck'
      knife cookbook site share 'delivery-sugar'


Generate a cookbook
========================================================

#. On your workstation, use ChefDK's `cookbook generator command <https://docs.chef.io/ctl_chef.html#chef-generate-cookbook>`__ to create a default cookbook directory structure called ``my_cookbook``.

.. code-block:: bash
   
   chef generate cookbook my_cookbook

#. Run ``delivery init`` in your ``my_cookbook`` local directory to create a new project in |automate| and push your first change for review.

.. code-block:: bash

      cd my_cookbook
      delivery init

#. Finally, check out the added files and commit your changes.


Use the ``delivery-truck`` cookbook in your project
========================================================

From the root of your project's directory, do the following:

#. Modify the build cookbook's Berksfile to reference ``delivery-truck`` and ``delivery-sugar``:

   .. code-block:: ruby

      source :chef_server

      metadata

      group :delivery do
        cookbook 'delivery-sugar'
        cookbook 'delivery-truck'
      end

  By default, this file is located at ``.delivery/build-cookbook/Berksfile``.

#. Modify the build cookbook's metadata to include ``delivery-truck``:

  .. code-block:: ruby

     depends 'delivery-truck'

  By default, this file is located at ``.delivery/build-cookbook/metadata.rb``.

#. Edit your build cookbook's recipes to include the corresponding ``delivery-truck`` recipe:

  .. code-block:: ruby

     # Cookbook Name:: $BUILD_COOKBOOK_NAME
     # Recipe:: $RECIPE
     #
     # Copyright (c) 2016 The Authors, All Rights Reserved.

     include_recipe "delivery-truck::$RECIPE"

  By default, each build cookbook recipe ``$RECIPE`` is located at ``.delivery/build-cookbook/recipes/$RECIPE.rb``.

#. Increment your build cookbook's version in the cookbook's metadata file.

#. Commit your changes and run ``delivery review``. Changes to your cookbook project can now be managed by your |automate| cluster.