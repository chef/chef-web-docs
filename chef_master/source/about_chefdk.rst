=====================================================
About ChefDK
=====================================================
`[edit on GitHub] <https://github.com/chef/chef-web-docs/blob/master/chef_master/source/about_chefdk.rst>`__

.. note:: `Chef Workstation <https://downloads.chef.io/chef-workstation/>`__ gives you everything you need to get started with Chef Infra — ad hoc remote execution, remote scanning, configuration tasks, cookbook creation tools as well as robust dependency and testing software — all in one easy-to-install package. Chef Workstation replaces ChefDK, combining all the existing features with new features, such as ad-hoc task support and the new Chef Workstation desktop application. Chef will continue to maintain ChefDK, but new development will take place in Chef Workstation without backporting features.

.. tag chef_dk

ChefDK, short for Chef Development Kit, is a package that contains everything that is needed to start using Chef:

* Chef Infra Client
* chef and knife command line tools
* Testing tools such as Test Kitchen, ChefSpec, Cookstyle, and Foodcritic
* Chef InSpec
* Everything else needed to author cookbooks and upload them to the Chef Infra Server

.. end_tag

Getting Started
=====================================================
.. This page is used as the short overview on the index page at docs.chef.io

Chef Infra is a systems and cloud infrastructure automation framework that makes it easy to deploy servers and applications to any physical, virtual, or cloud location, no matter the size of the infrastructure. Each organization is comprised of one (or more) ChefDK installations, a single server, and every node that will be configured and maintained by Chef Infra Client. Cookbooks (and recipes) are used to tell Chef Infra Client how each node in your organization should be configured. Chef Infra Client---which is installed on every node---does the actual configuration.



* `An Overview of Chef </chef_overview.html>`_
* `Install ChefDK </install_dk.html>`_
* `Ruby Guide </ruby.html>`_

.. note:: See this `blog post by Irving Popovetsky about running ChefDK on Windows. <https://www.chef.io/blog/2014/11/04/the-chefdk-on-windows-survival-guide/>`__

About Workflow
-----------------------------------------------------
ChefDK defines a common workflow for cookbook development:

#. Create a skeleton cookbook. This is a cookbook with the standard files already included. The package manager is often Berkshelf, which is included as part of ChefDK, plus a revision control system, typically Git. Berkshelf helps manage cookbooks and cookbook dependencies.

#. Create a virtual machine environment using Test Kitchen. This is the environment that will be used to develop the cookbook, including the location in which automated testing and debugging of that cookbook will be done as it is being developed.

#. Write the recipes for the cookbook and debug those recipes as they are being written. This is typically an iterative process, where cookbook are tested as they are developed, bugs are fixed quickly, and then cookbooks are tested again. A text editor---Sublime Text, vim, TextMate, EditPad, or any other preferred text editor---is used to author the files in the cookbook.

#. Perform acceptance tests. These tests are not done in a development environment, but rather are done against a full Chef Infra Server using an environment that matches the production environment as closely as possible.

#. When the cookbooks pass all the acceptance tests and have been verified to work in the desired manner, deploy the cookbooks to the production environment.

Tools
=====================================================
ChefDK installs a collection of tools and libraries into a single directory structure, which makes it easier to manage any dependencies these tools may have on each other and the dependencies that Chef has on Ruby.

The most important tools included in ChefDK are:

.. list-table::
   :widths: 60 420
   :header-rows: 1

   * - Tool
     - Description
   * - Berkshelf
     - A dependency manager for cookbooks.
   * - chef
     - A workflow tool for Chef.
   * - Chef Infra Client
     - The agent that runs Chef.
   * - chef-vault
     - Use to encrypt data bag items using the public keys of a list of nodes. This allows only those nodes to decrypt the encrypted values.
   * - ChefSpec
     - A unit testing framework that tests resources locally.
   * - Cookstyle
     - A Rubocop-based style-checking tool for writing clean cookbooks.
   * - Delivery CLI
     - A command-line tool for continuous delivery workflow. Is used to setup and execute phase jobs on a Chef Automate server.
   * - Fauxhai
     - A gem for mocking Ohai data in ChefSpec tests.
   * - Foodcritic
     - A lint tool for static analysis of recipe code.
   * - Test Kitchen
     - An integration testing framework tool that tests cookbooks across platforms.
   * - kitchen-dokken
     - A test-kitchen plugin that provides a driver, transport, and provisioner for rapid cookbook testing and container development using Docker and Chef.
   * - kitchen-vagrant
     - A Kitchen driver for Vagrant.
   * - Ruby
     - The reference language for Chef.

ChefDK Tools
-----------------------------------------------------
The following tools are available only in ChefDK:

`chef (executable) </ctl_chef.html>`_ |
`Policyfiles </policyfile.html>`_

Community Tools
-----------------------------------------------------
The following tools have been developed by members of the Chef community. These tools are considered to be a useful part of the Chef workflow and have been packaged as part of ChefDK. (They are all available independently of ChefDK, as well.) The use of these tools as part of your workflow is recommended, but at the same time is completely optional. Use them in the way that makes sense for your organization:

`Berkshelf </berkshelf.html>`_ |
`Chef Vault </chef_vault.html>`_ |
`ChefSpec </chefspec.html>`_ |
`FoodCritic </foodcritic.html>`_ |
`Test Kitchen </kitchen.html>`_ |
`kitchen-vagrant </plugin_kitchen_vagrant.html>`_ |
`Cookstyle </cookstyle.html>`_
