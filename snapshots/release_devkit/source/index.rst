=====================================================
About the Chef DK
=====================================================

.. tag chef_dk

The Chef development kit is a package that contains everything that is needed to start using Chef:

* chef-client
* chef
* Ohai
* chef-zero
* Testing tools like Kitchen, ChefSpec, and Foodcritic
* Policy, including policy files
* Chef provisioning
* Everything else needed to author cookbooks and upload them to the Chef server

.. end_tag

Getting Started
=====================================================
.. tag chef_index

Chef is a systems and cloud infrastructure automation framework that makes it easy to deploy servers and applications to any physical, virtual, or cloud location, no matter the size of the infrastructure. Each organization is comprised of one (or more) workstations, a single server, and every node that will be configured and maintained by the chef-client. Cookbooks (and recipes) are used to tell the chef-client how each node in your organization should be configured. The chef-client (which is installed on every node) does the actual configuration.

.. end_tag

:doc:`chef_overview`
:doc:`install_dk`
:doc:`ruby`

.. note:: See this blog post by Irving Popovetsky about running the Chef DK on Windows: https://www.chef.io/blog/2014/11/04/the-chefdk-on-windows-survival-guide/.

About Workflow
-----------------------------------------------------
The Chef development kit defines a common workflow for cookbook development:

#. Create a skeleton cookbook. This is a cookbook with the standard files already included. The package manager is often Berkshelf, which is included as part of the Chef development kit, plus a revision control system, typically git. Berkshelf helps manage cookbooks and cookbook dependencies.

#. Create a virtual machine environment using Kitchen. This is the environment that will be used to develop the cookbook, including the location in which automated testing and debugging of that cookbook will be done as it is being developed.

#. Write the recipes for the cookbook and debug those recipes as they are being written. This is typically an iterative process, where cookbook are tested as they are developed, bugs are fixed quickly, and then cookbooks are tested again. A text editor---Sublime Text, vim, TextMate, EditPad, or any other preferred text editor---is used to author the files in the cookbook.

#. Perform acceptance tests. These tests are not done in a development environment, but rather are done against a full Chef server using an environment that matches the production environment as closely as possible.

#. When the cookbooks pass all the acceptance tests and have been verified to work in the desired manner, deploy the cookbooks to the production environment.

Tools
=====================================================
The Chef development kit installs a collection of tools and libraries into a single directory structure, which makes it easier to manage any dependencies these tools may have on each other and the dependencies that Chef has on Ruby.

The most important tools included in the Chef development kit are:

.. list-table::
   :widths: 60 420
   :header-rows: 1

   * - Tool
     - Description
   * - Berkshelf
     - A dependency manager for cookbooks.
   * - chef
     - A workflow tool for Chef.
   * - Chef DK
     - The Chef development kit omnibus package.
   * - chef-client
     - The agent that runs Chef.
   * - chef-vault
     - Use to encrypt data bag items using the public keys of a list of nodes. This allows only those nodes to decrypt the encrypted values.
   * - ChefSpec
     - A unit testing framework that tests resources locally.
   * - Delivery CLI 
     - A command-line tool for continuous delivery workflow. Is used to setup and execute phase jobs on an Chef Automate server.
   * - Fauxhai
     - A gem for mocking Ohai data.
   * - Foodcritic
     - A lint tool for static analysis of recipe code.
   * - Kitchen
     - An integration testing framework tool that tests cookbooks across platforms.
   * - kitchen-dokken
     - A test-kitchen plugin that provides a driver, transport, and provisioner for rapid cookbook testing and container development using Docker and Chef.
   * - kitchen-vagrant
     - A Kitchen driver for Vagrant.
   * - knife-spork
     - A workflow plugin for knife that helps groups of people work together in the same chef-repo and Chef server.
   * - Ruby
     - The reference language for Chef.
   * - cookstyle
     - A Rubocop-based style-checking tool for writing clean cookbooks.

Chef DK Tools
-----------------------------------------------------
The following tools are available only in the Chef development kit:

:doc:`ctl_chef`
:doc:`policyfile`
:doc:`config_rb_policyfile`

Chef Provisioning
-----------------------------------------------------
The following resources are part of Chef provisioning and are now available in the Chef development kit:

:doc:`resource_machine`
:doc:`resource_machine_batch`
:doc:`resource_machine_execute`
:doc:`resource_machine_file`
:doc:`resource_machine_image`

The following resources are available in the Chef development kit and may be used as part of Chef provisioning:

:doc:`resource_chef_acl`
:doc:`resource_chef_client`
:doc:`resource_chef_container`
:doc:`resource_chef_data_bag_item`
:doc:`resource_chef_data_bag`
:doc:`resource_chef_environment`
:doc:`resource_chef_group`
:doc:`resource_chef_mirror`
:doc:`resource_chef_node`
:doc:`resource_chef_organization`
:doc:`resource_chef_role`
:doc:`resource_chef_user`
:doc:`resource_private_key`
:doc:`resource_public_key`

Community Tools
-----------------------------------------------------
The following tools have been developed by members of the Chef community. These tools are considered to be a useful part of the Chef workflow and have been packaged as part of the Chef development kit. (They are all available independently of the Chef development kit, as well.) The use of these tools as part of your workflow is recommended, but at the same time is completely optional. Use them in the way that makes sense for your organization:

:doc:`berkshelf`
:doc:`chef_vault`
:doc:`chefspec`
:doc:`foodcritic`
:doc:`kitchen`
:doc:`ctl_kitchen`
:doc:`config_yml_kitchen`
:doc:`plugin_kitchen_vagrant`
:doc:`rubocop`

.. Hide the TOC from this file.

.. toctree::
   :hidden:

   attributes
   berkshelf
   chef_client
   chef_overview
   chef_repo
   chef_search
   chef_vault
   chefspec
   config_rb_client
   config_rb_knife_optional_settings
   config_rb_knife
   config_rb_metadata
   config_rb_policyfile
   config_yml_kitchen
   cookbook_repo
   cookbook_versions
   cookbooks
   cookstyle
   ctl_chef
   ctl_chef_client
   ctl_delivery
   ctl_kitchen
   ctl_push_jobs_client
   custom_resources
   definitions
   dsl_recipe
   files
   foodcritic
   handlers
   install_bootstrap
   install_dk
   inspec
   kitchen
   knife_bootstrap
   knife_client
   knife_common_options
   knife_configure
   knife_cookbook_site
   knife_cookbook
   knife_data_bag
   knife_delete
   knife_deps
   knife_diff
   knife_download
   knife_edit
   knife_environment
   knife_exec
   knife_list
   knife_node
   knife_raw
   knife_recipe_list
   knife_role
   knife_search
   knife_serve
   knife_show
   knife_ssh
   knife_ssl_check
   knife_ssl_fetch
   knife_status
   knife_tag
   knife_upload
   knife_user
   knife_using
   knife_xargs
   knife
   libraries
   nodes
   plugin_community
   plugin_knife_spork
   plugin_knife_supermarket
   plugin_kitchen_vagrant
   policyfile
   provisioning
   provisioning_aws
   provisioning_fog
   provisioning_vagrant
   proxies
   recipes
   resource_apt_package
   resource_apt_update
   resource_bash
   resource_batch
   resource_bff_package
   resource_breakpoint
   resource_chef_acl
   resource_chef_client
   resource_chef_container
   resource_chef_data_bag_item
   resource_chef_data_bag
   resource_chef_environment
   resource_chef_gem
   resource_chef_group
   resource_chef_handler
   resource_chef_mirror
   resource_chef_node
   resource_chef_organization
   resource_chef_role
   resource_chef_user
   resource_chocolatey_package
   resource_common
   resource_cookbook_file
   resource_cron
   resource_csh
   resource_deploy
   resource_directory
   resource_dpkg_package
   resource_dsc_resource
   resource_dsc_script
   resource_easy_install_package
   resource_env
   resource_erlang_call
   resource_execute
   resource_file
   resource_freebsd_package
   resource_gem_package
   resource_git
   resource_group
   resource_homebrew_package
   resource_http_request
   resource_ifconfig
   resource_ips_package
   resource_ksh
   resource_launchd
   resource_link
   resource_load_balancer
   resource_log
   resource_machine_batch
   resource_machine_execute
   resource_machine_file
   resource_machine_image
   resource_machine
   resource_macports_package
   resource_mdadm
   resource_mount
   resource_ohai
   resource_openbsd_package
   resource_osx_profile
   resource_package
   resource_pacman_package
   resource_paludis_package
   resource_perl
   resource_portage_package
   resource_powershell_script
   resource_private_key
   resource_public_key
   resource_python
   resource_reboot
   resource_registry_key
   resource_remote_directory
   resource_remote_file
   resource_route
   resource_rpm_package
   resource_ruby_block
   resource_ruby
   resource_script
   resource_service
   resource_smartos_package
   resource_solaris_package
   resource_subversion
   resource_template
   resource_user
   resource_windows_package
   resource_windows_service
   resource_yum
   resource
   resources
   rubocop
   ruby
   serverspec
   server_components
   templates
   workstation
