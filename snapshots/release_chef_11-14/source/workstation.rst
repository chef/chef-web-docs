

=====================================================
Workstations
=====================================================

.. tag workstation_24

.. This file is included in Chef Automate docs

A workstation is a computer that is configured to run various Chef command-line tools that synchronize with a chef-repo, author cookbooks, interact with the Chef server, and interact with nodes.

The workstation is the location from which most users do most of their work, including:

* Developing cookbooks and recipes (and authoring them using Ruby syntax and patterns)
* Keeping the chef-repo synchronized with version source control
* Using command-line tools
* Configuring organizational policy, including defining roles and environments and ensuring that critical data is stored in data bags
* Interacting with nodes, as (or when) required, such as performing a bootstrap operation

.. end_tag

Some important components of workstations include:

.. list-table::
   :widths: 60 420
   :header-rows: 1

   * - Feature
     - Description
   * - :doc:`Knife </knife>`
     - .. tag knife_24

       knife is a command-line tool that provides an interface between a local chef-repo and the Chef server. knife helps users to manage:

       * Nodes
       * Cookbooks and recipes
       * Roles
       * Stores of JSON data (data bags), including encrypted data
       * Environments
       * Cloud resources, including provisioning
       * The installation of the chef-client on management workstations
       * Searching of indexed data on the Chef server

       .. end_tag

   * - :doc:`The chef-repo </chef_repo>`
     - .. tag chef_repo_26

       The chef-repo is the repository structure in which cookbooks are authored, tested, and maintained:

       * Cookbooks contain recipes, attributes, custom resources, libraries, definitions, files, templates, tests, and metadata
       * The chef-repo should be synchronized with a version control system (such as git), and then managed as if it were source code

       .. end_tag

       .. tag chef_repo_structure

       The directory structure within the chef-repo varies. Some organizations prefer to keep all of their cookbooks in a single chef-repo, while other organizations prefer to use a chef-repo for every cookbook.

       .. end_tag

   * - :doc:`knife.rb </config_rb_knife>`
     - .. tag config_rb_knife_25

       A knife.rb file is used to specify the chef-repo-specific configuration details for knife.

       .. end_tag

   * - :doc:`metadata.rb </config_rb_metadata>`
     - .. tag cookbooks_metadata

       Every cookbook requires a small amount of metadata. A file named metadata.rb is located at the top of every cookbook directory structure. The contents of the metadata.rb file provides hints to the Chef server to help ensure that cookbooks are deployed to each node correctly.

       .. end_tag

