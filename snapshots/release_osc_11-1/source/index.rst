=====================================================
About Open Source Chef 11.1
=====================================================

Chef is a systems and cloud infrastructure automation framework that makes it easy to deploy servers and applications to any physical, virtual, or cloud location, no matter the size of the infrastructure. Each organization is comprised of one (or more) workstations, a single server, and every node that will be configured and maintained by the chef-client. Cookbooks (and recipes) are used to tell the chef-client how each node in your organization should be configured. The chef-client (which is installed on every node) does the actual configuration.

The Open Source Chef is a centralized location where all of the objects needed by Chef are stored, including data that has been uploaded from the chef-repo, data that is needed by the chef-client while it configures nodes, and data that is uploaded to the Chef server by the chef-client at the conclusion of every chef-client run.

.. note:: This set of topics is only about the Open Source Chef server, version 11.1. For information about the chef-client, Ohai, cookbooks, and so on, see |url docs|.

Server Essentials
=====================================================
The server acts as a hub for all of the data needed by the chef-client while it configures a node:

* A `node object <https://docs.chef.io/nodes.html>`_ exists for each node that is being managed by the chef-client
* Each node object consists of a `run-list <https://docs.chef.io/nodes.html>`_ and a `collection of attributes <https://docs.chef.io/attributes.html>`_
* Cookbooks are the fundamental unit of configuration and policy distribution and include: `attribute files <https://docs.chef.io/attributes.html>`_, `definitions <https://docs.chef.io/definitions.html>`_, `files, <https://docs.chef.io/files.html>`_, `libraries <https://docs.chef.io/libraries.html>`_, `metadata <https://docs.chef.io/cookbook_repo.html>`_, `recipes <https://docs.chef.io/recipes.html>`_, `resources <https://docs.chef.io/resources.html>`_, `templates <https://docs.chef.io/templates.html>`_, and `versions <https://docs.chef.io/cookbook_versions.html>`_
* All data that is stored on the Chef server---including everything uploaded to the server from the chef-repo and by the chef-client---is `searchable <https://docs.chef.io/chef_search.html>`_ from both recipes (using the `search method <https://docs.chef.io/dsl_recipe.html#search>`_ in the Recipe DSL) and the workstation (using the `knife search <https://docs.chef.io/knife_search.html>`_ subcommand). The chef-client does the actual configuration on `the nodes <https://docs.chef.io/nodes.html>`_. The chef-client receives its instructions from cookbooks (`recipes <https://docs.chef.io/recipes.html>`_, mostly). The process of configuring a node is called `the chef-client run <https://docs.chef.io/nodes.html>`_. At the beginning of each run, the chef-client `validates to the server <https://docs.chef.io/chef_client.html>`_, `collects important data about that node <https://docs.chef.io/ohai.html>`_, and then configures the node. At the end of each run, the chef-client `reports the successes and failures that may have occurred <https://docs.chef.io/handlers.html>`_
* The Chef server can apply `global policy settings <https://docs.chef.io/policy.html>`_ to all nodes across the organization, including for `data bags <https://docs.chef.io/data_bags.html>`_, `environments <https://docs.chef.io/environments.html>`_, and `roles <https://docs.chef.io/roles.html>`_
* The `authentication <https://docs.chef.io/auth.html#authentication>`_ process ensures that requests can only be made to the Chef server by authorized users
* Users, once `authorized <https://docs.chef.io/auth.html#authorization>`_ can only perform certain actions

Server Components
=====================================================
The Open Source Chef acts as a hub for configuration data. The :doc:`components that make up the server </server_components>` work together to store cookbooks, provide a management layer, and databases that store cookbook and node data.

Install Open Source Chef
=====================================================
The Chef server can be installed via download or by using the Omnitruck API:

.. raw:: html

   &nbsp;&nbsp;&nbsp;   <a href="https://docs.chef.io/release/osc_11-1/install_server.html">Install the Enterprise Chef Server</a> </br>
   &nbsp;&nbsp;&nbsp;   <a href="https://docs.chef.io/release/osc_11-1/api_omnitruck.html">Download the chef-client using the Omnitruck API</a> </br>

The Chef server can be upgraded:

.. raw:: html

   &nbsp;&nbsp;&nbsp;   <a href="https://docs.chef.io/release/osc_11-1/upgrade_server_open_source.html">Upgrade to Open Source Chef Server 11.0</a> </br>
   
Settings and Tools 
=====================================================
The following settings files are used to configure behavior for the Chef server:

.. raw:: html

   &nbsp;&nbsp;&nbsp;   <a href="https://docs.chef.io/release/osc_11-1/config_rb_chef_server.html">chef-server.rb</a> </br>

The following command-line tools can be run on the Chef server:

.. raw:: html

   &nbsp;&nbsp;&nbsp;   <a href="https://docs.chef.io/release/osc_11-1/ctl_chef_server.html">ctl-chef-server</a> </br>

APIs
=====================================================
The following APIs can be used to access data on the Chef server:

.. raw:: html

   &nbsp;&nbsp;&nbsp;   <a href="https://docs.chef.io/release/osc_11-1/api_chef_server.html">Chef Server API</a> </br>


.. Hide the TOC from this file.


.. toctree::
   :hidden:

   api_chef_server
   config_rb_chef_server
   config_rb_chef_server_optional_settings
   ctl_chef_server
   install_server
   release_notes
   server_components
   upgrade_server_open_source
