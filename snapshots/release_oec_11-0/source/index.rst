=====================================================
About Enterprise Chef 11.0
=====================================================

Chef is a systems and cloud infrastructure automation framework that makes it easy to deploy servers and applications to any physical, virtual, or cloud location, no matter the size of the infrastructure. Each organization is comprised of one (or more) workstations, a single server, and every node that will be configured and maintained by the chef-client. Cookbooks (and recipes) are used to tell the chef-client how each node in your organization should be configured. The chef-client (which is installed on every node) does the actual configuration.

The Enterprise Chef is a centralized location where all of the objects needed by Chef are stored, including data that has been uploaded from the chef-repo, data that is needed by the chef-client while it configures nodes, and data that is uploaded to the Chef server by the chef-client at the conclusion of every chef-client run.

.. note:: This set of topics is only about the Enterprise Chef server, version 11.1. For information about the chef-client, Ohai, cookbooks, and so on, see |url docs|.

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
:doc:`api_omnitruck`

Installation scenarios:

:doc:`install_server_pre`
:doc:`install_server_standalone`
:doc:`install_server_be`
:doc:`install_server_fe`
:doc:`install_server_febe`

:doc:`migrate_to_enterprise`

:doc:`upgrade_server_standalone`
:doc:`upgrade_server_ha`

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
