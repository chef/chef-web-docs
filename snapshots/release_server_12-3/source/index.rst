.. THIS PAGE DOCUMENTS Chef server version 12.3

=====================================================
About Chef Server 12.3
=====================================================

.. include:: ../../includes_chef/includes_chef_index.rst

.. note:: Chef server 12 is the new Chef server! The documentation for Open Source Chef and Enterprise Chef is still available from the version list.

View the :doc:`release notes </release_notes>` for the current version of the Chef server.

Getting Started
=====================================================
If you are new to Chef, familiarize yourself with its main components: :doc:`the server, workstations, and nodes </chef_overview>`. For more information about workstations, cookbooks, and nodes, see the documentation for the chef-client.

The `Chef supermarket <https://supermarket.chef.io>`_ is the location in which community cookbooks are authored and maintained. Cookbooks that are part of the Chef Supermarket may be used by any Chef user.


Install, Upgrade
=====================================================
The Chef server can be installed on new hardware. Existing server configurations may be upgraded.

:doc:`<install_server>`
:doc:`<upgrade_server>`

The Chef server may be configured for high availability to enable failover on backend and load balancing on frontend machines. The following high availability scenarios are supported:

:doc:`<install_server_ha_aws>`
:doc:`<install_server_ha_drbd>`


.. note:: Premium features of the Chef server must be installed and configured after the Chef server. The Chef management console must be installed before Reporting because they share the same web user interface. The Chef management console, Reporting, and Chef replication can all be installed using the `chef-server-ctl install <https://docs.chef.io/release/server_12-3/ctl_chef_server.html#install>`_ command. 


Manage the Chef Server
=====================================================
The Chef server can be managed in the following ways:

:doc:`<runbook>`
:doc:`<server_backup_restore>`
:doc:`<server_data>`
:doc:`<server_firewalls_and_ports>`
:doc:`<server_high_availability>`
:doc:`<server_logs>`
:doc:`<server_monitor>`
:doc:`<server_orgs>`
:doc:`<server_replication>`
:doc:`<server_security>`
:doc:`<server_services>`
:doc:`<server_tuning>`


Management Console
-----------------------------------------------------
The Chef management console provides a web user interface with access to objects, such as nodes and cookbooks, through role-based access control:

:doc:`<server_manage_clients>`
:doc:`<server_manage_cookbooks>`
:doc:`<server_manage_data_bags>`
:doc:`<server_manage_environments>`
:doc:`<server_manage_nodes>`
:doc:`<server_manage_reports>`
:doc:`<server_manage_roles>`

Reference
=====================================================
This section contains links to topics about configuration files, command-line tools, and APIs that are used by the Chef server and its premium features.

**Configuration Files**

:doc:`<config_rb_server>`
:doc:`<config_rb_manage>`

**Command-line Tools**

:doc:`<ctl_chef_server>`
:doc:`<ctl_opscode_expander>`

**APIs**

:doc:`<api_chef_server>`
:doc:`<api_push_jobs>`

.. Hide the TOC from this file. Just keep these alphabetized please.

.. toctree::
   :hidden:

   api_chef_server
   auth
   chef_overview
   chef_search
   config_rb_server
   config_rb_server_optional_settings
   config_rb_manage
   ctl_chef_server
   ctl_opscode_expander
   install_server
   install_server_ha_aws
   install_server_ha_drbd
   install_server_post
   install_server_pre
   install_server_tiered
   manage
   release_notes
   server_backup_restore
   server_components
   server_data
   server_firewalls_and_ports
   server_high_availability
   server_ldap
   server_logs
   server_manage_clients
   server_manage_cookbooks
   server_manage_data_bags
   server_manage_environments
   server_manage_nodes
   server_manage_reports
   server_manage_roles
   server_monitor
   server_orgs
   server_replication
   server_security
   server_services
   server_tuning
   server_users
   upgrade_server
   upgrade_server_open_source_notes
