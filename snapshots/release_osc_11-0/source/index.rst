=====================================================
About Open Source Chef 11.0
=====================================================

Chef is a systems and cloud infrastructure automation framework that makes it easy to deploy servers and applications to any physical, virtual, or cloud location, no matter the size of the infrastructure. Each organization is comprised of one (or more) workstations, a single server, and every node that will be configured and maintained by the chef-client. Cookbooks (and recipes) are used to tell the chef-client how each node in your organization should be configured. The chef-client (which is installed on every node) does the actual configuration.

The Open Source Chef is a centralized location where all of the objects needed by Chef are stored, including data that has been uploaded from the chef-repo, data that is needed by the chef-client while it configures nodes, and data that is uploaded to the Chef server by the chef-client at the conclusion of every chef-client run.

.. note:: This set of topics is only about the Open Source Chef server, version 11.1. For information about the chef-client, Ohai, cookbooks, and so on, see |url docs|.

Server Essentials
=====================================================
The server acts as a hub for all of the data needed by the chef-client while it configures a node:

* A :doc:`node object <nodes>` exists for each node that is being managed by the chef-client
* Each node object consists of a :doc:`run-list <nodes>` and a :doc:`collection of attributes <attributes>`
* Cookbooks are the fundamental unit of configuration and policy distribution and include: :doc:`attribute files <attributes>`, :doc:`definitions <definitions>`, :doc:`files, <files>`, :doc:`libraries <libraries>`, :doc:`metadata <cookbook_repo>`, :doc:`recipes <recipes>`, :doc:`resources <resources>`, :doc:`templates <templates>`, and :doc:`versions <cookbook_versions>`
* All data that is stored on the Chef server---including everything uploaded to the server from the chef-repo and by the chef-client---is :doc:`searchable <chef_search>` from both recipes and the workstation (using the `knife search <knife_search>` subcommand). The chef-client does the actual configuration on :doc:`the nodes <nodes>`. The chef-client receives its instructions from cookbooks (:doc:`recipes <recipes>`, mostly). The process of configuring a node is called :doc:`the chef-client run <nodes>`. At the beginning of each run, the chef-client :doc:`validates to the server <chef_client>`, :doc:`collects important data about that node <ohai>`, and then configures the node. At the end of each run, the chef-client :doc:`reports the successes and failures that may have occurred <handlers>`
* The Chef server can apply :doc:`global policy settings <policy>` to all nodes across the organization, including for :doc:`data bags <data_bags>`, :doc:`environments <environments>`, and :doc:`roles <roles>`
* The :ref:`authentication <auth-authentication>` process ensures that requests can only be made to the Chef server by authorized users
* Users, once :ref:`authorized <auth-authorization>` can only perform certain actions

Server Components
=====================================================
The Open Source Chef acts as a hub for configuration data. The :doc:`components that make up the server </server_components>` work together to store cookbooks, provide a management layer, and databases that store cookbook and node data.

Install Open Source Chef
=====================================================
The Chef server can be installed via download or by using the Omnitruck API:

:doc:`install_server`
:doc:`api_omnitruck`

The Chef server can be upgraded:

:doc:`upgrade_server_open_source`

Settings and Tools 
=====================================================
The following settings files are used to configure behavior for the Chef server:

:doc:`config_rb_chef_server`

The following command-line tools can be run on the Chef server:

:doc:`ctl_chef_server`

APIs
=====================================================
The following APIs can be used to access data on the Chef server:

:doc:`api_chef_server`

.. Hide the TOC from this file.

.. toctree::
   :hidden:

   api_chef_server
   config_rb_chef_server
   config_rb_chef_server_optional_settings
   ctl_chef_server
   install_server
   server_components
   upgrade_server_open_source
