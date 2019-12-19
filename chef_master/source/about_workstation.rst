=====================================================
About Chef Workstation
=====================================================
`[edit on GitHub] <https://github.com/chef/chef-web-docs/blob/master/chef_master/source/about_chef_workstation.rst>`__

.. tag chef_workstation

Chef Workstation contains everything that is needed to start using Chef Infra and Chef InSpec:

* Chef Infra Client
* Chef InSpec
* chef and knife command line tools
* Testing tools such as Test Kitchen, ChefSpec, and Cookstyle
* Everything else needed to author cookbooks and upload them to the Chef Infra Server

.. end_tag

Getting Started
=====================================================
.. This page is used as the short overview on the index page at docs.chef.io

Chef Infra is a systems and cloud infrastructure automation framework that makes it easy to deploy servers and applications to any physical, virtual, or cloud location, no matter the size of the infrastructure. Each organization is comprised of one (or more) Chef Workstation installations, a single server, and every node that will be configured and maintained by Chef Infra Client. Cookbooks (and recipes) are used to tell Chef Infra Client how each node in your organization should be configured. Chef Infra Client---which is installed on every node---does the actual configuration.

* `An Overview of Chef </chef_overview.html>`_
* `Install Chef Workstation </install_workstation.html>`_
* `Ruby Guide </ruby.html>`_

Cookbook Development Workflow
-----------------------------------------------------
Chef Infra defines a common workflow for cookbook development:

#. Create a skeleton cookbook by running `chef generate cookbook MY_COOKBOOK_NAME`. This will generate a cookbook with a single recipe and testing configuration with with ChefSpec and Delivery Local Mode.

#. Write cookbook recipes or resources and debug those recipes as they are being written using Cookstyle and Test Kitchen. This is typically an iterative process, where cookbook are tested as they are developed, bugs are fixed quickly, and then cookbooks are tested again. A text editor---Visual Studio Code, Atom, vim, or any other preferred text editor---is used to author the files in the cookbook.

#. Perform acceptance tests. These tests are not done in a development environment, but rather are done against a full Chef Infra Server using an environment that matches the production environment as closely as possible.

#. When the cookbooks pass all the acceptance tests and have been verified to work in the desired manner, deploy the cookbooks to the production environment.

Tools
=====================================================
Chef Workstation packages all the tools necessary to be successful with Chef Infra and InSpec. These tools are combined into native packages for common operating systems and include all the dependencies you need to get started.

The most important tools included in Chef Workstation are:

.. list-table::
   :widths: 60 420
   :header-rows: 1

   * - Tool
     - Description
   * - Chef CLI
     - A workflow tool for Chef.
   * - Chef Infra Client
     - The agent that runs Chef.
   * - ChefSpec
     - A unit testing framework that tests resources locally.
   * - Cookstyle
     - A linting tool that helps you write better Chef Infra cookbooks by detecting and automatically correcting style, syntax, and logic mistakes in your code.
   * - Delivery CLI
     - A command-line tool for continuous delivery workflow. Is used to setup and execute phase jobs on a Chef Automate server.
   * - Test Kitchen
     - An integration testing framework tool that tests cookbooks across platforms.
   * - kitchen-dokken
     - A Test Kitchen plugin that provides a driver, transport, and provisioner for rapid cookbook testing and container development using Docker and Chef.
   * - kitchen-vagrant
     - A Test Kitchen plugin for local cookbook testing using Vagrant with VirtualBox, Parallels, VMware, and Hyper-V hypervisors
   * - kitchen-ec2, kitchen-google, kitchen-azurerm
     - Test Kitchen drivers for cookbook testinng on common cloud providers
   * - Ruby
     - The reference language for Chef Infra and InSpec.

Community Tools
-----------------------------------------------------
The following tools have been developed by members of the Chef community. These tools are considered to be a useful part of the Chef workflow and have been packaged as part of Chef Workstation. (They are all available independently of Chef Workstation, as well.) The use of these tools as part of your workflow is recommended, but at the same time is completely optional. Use them in the way that makes sense for your organization:

`Berkshelf </berkshelf.html>`_ |
`Chef Vault </chef_vault.html>`_ |
`ChefSpec </chefspec.html>`_ |
`Test Kitchen </kitchen.html>`_ |
`kitchen-vagrant </plugin_kitchen_vagrant.html>`_ |
