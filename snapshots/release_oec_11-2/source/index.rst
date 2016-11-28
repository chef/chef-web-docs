=====================================================
About Enterprise Chef 11.2
=====================================================

Chef is a systems and cloud infrastructure automation framework that makes it easy to deploy servers and applications to any physical, virtual, or cloud location, no matter the size of the infrastructure. Each organization is comprised of one (or more) workstations, a single server, and every node that will be configured and maintained by the chef-client. Cookbooks (and recipes) are used to tell the chef-client how each node in your organization should be configured. The chef-client (which is installed on every node) does the actual configuration.

The Enterprise Chef is a centralized location where all of the objects needed by Chef are stored, including data that has been uploaded from the chef-repo, data that is needed by the chef-client while it configures nodes, and data that is uploaded to the Chef server by the chef-client at the conclusion of every chef-client run.

.. note:: This set of topics is only about the Enterprise Chef server, version 11.2. For information about the chef-client, Ohai, cookbooks, and so on, see |url docs|.

View the :doc:`release notes </release_notes>` for Enterprise Chef 11.2.

Server Essentials
=====================================================
The server acts as a hub for all of the data needed by the chef-client while it configures a node:

* A node object exists for each node that is being managed by the chef-client
* Each node object consists of a run-list and a collection of attributes 
* Cookbooks are the fundamental unit of configuration and policy distribution and include: attribute files , definitions , files, , libraries , metadata , recipes , resources , templates , and versions 
* All data that is stored on the Chef server---including everything uploaded to the server from the chef-repo and by the chef-client---is :doc:`searchable <chef_search>` from both recipes and the workstation (using the `knife search <knife_search>` subcommand). The chef-client does the actual configuration on the nodes . The chef-client receives its instructions from cookbooks (recipes , mostly). The process of configuring a node is called the chef-client run . At the beginning of each run, the chef-client validates to the server , collects important data about that node , and then configures the node. At the end of each run, the chef-client reports the successes and failures that may have occurred 
* The Chef server can apply global policy settings to all nodes across the organization, including for data bags , environments , and roles 
* The :ref:`authentication <auth-authentication>` process ensures that requests can only be made to the Chef server by authorized users
* Users, once :ref:`authorized <auth-authorization>` can only perform certain actions

Server Components
=====================================================
The Enterprise Chef acts as a hub for configuration data. The :doc:`components that make up the server </server_components>` work together to store cookbooks, provide a management layer, and databases that store cookbook and node data.

Deployment Scenarios
=====================================================
.. tag server_deploy

There are several configuration options for the Chef server: hosted by Chef, all on a single machine (standalone), multiple machines and a scaled front end, multiple machines and a scaled back end, or multiple machines with both scaled front and back ends.

.. end_tag

The following sections discuss these deployment configuration options in greater detail:

:doc:`server_deploy_standalone`
:doc:`server_deploy_be`
:doc:`server_deploy_fe`
:doc:`server_deploy_febe`

.. note:: For more information about signing up for hosted Enterprise Chef, see https://manage.chef.io/signup.

Install Enterprise Chef
-----------------------------------------------------
The Chef server can be installed via download or by using the Omnitruck API:

:doc:`install_server`


Installation scenarios:

:doc:`install_server_pre`
:doc:`install_server_standalone`
:doc:`install_server_be`
:doc:`install_server_fe`
:doc:`install_server_febe`

:doc:`migrate_to_enterprise`

:doc:`upgrade_server_standalone`
:doc:`upgrade_server_ha`
:doc:`install_manage`

Options:

:doc:`install_server_ldap`
:doc:`install_server_users`
:doc:`install_server_orgs`

Manage Enterprise Chef
=====================================================
The Chef server can be managed in the following ways:

:doc:`server_backup_restore`
:doc:`server_firewalls_and_ports`
:doc:`server_high_availability`
:doc:`server_ldap`
:doc:`server_logs`
:doc:`server_monitor`
:doc:`server_tuning`
:doc:`server_security`
:doc:`server_services`
:doc:`server_users`

Settings and Tools 
=====================================================
The following settings files are used to configure behavior for the Chef server:

:doc:`config_rb_chef_server_enterprise`

The following command-line tools can be run on the Chef server:

:doc:`orgmapper`
:doc:`ctl_private_chef`

APIs
=====================================================
The following APIs can be used to access data on the Chef server:

:doc:`api_chef_server`

.. Hide the TOC from this file.

.. toctree::
   :hidden:

   api_chef_server
   auth
   chef_search
   config_rb_chef_server_enterprise
   config_rb_chef_server_enterprise_optional_settings
   ctl_private_chef
   install_manage
   install_server
   install_server_be
   install_server_fe
   install_server_febe
   install_server_hosted
   install_server_ldap
   install_server_orgs
   install_server_pre
   install_server_standalone
   install_server_users
   migrate_to_enterprise
   orgmapper
   release_notes
   server_backup_restore
   server_components
   server_deploy_be
   server_deploy_fe
   server_deploy_febe
   server_deploy_standalone
   server_firewalls_and_ports
   server_high_availability
   server_ldap
   server_logs
   server_monitor
   server_orgs
   server_security
   server_services
   server_tuning
   server_users
   upgrade_server_ha
   upgrade_server_ha_notes
   upgrade_server_standalone
   upgrade_server_standalone_notes
