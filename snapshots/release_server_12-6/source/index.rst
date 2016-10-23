.. THIS PAGE DOCUMENTS Chef server version 12.6

=====================================================
About Chef Server 12.6
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

.. raw:: html

   &nbsp;&nbsp;&nbsp;   <a href="https://docs.chef.io/release/server_12-6/install_server.html">Install the Chef Server</a> </br>
   &nbsp;&nbsp;&nbsp;   <a href="https://docs.chef.io/release/server_12-6/upgrade_server.html">Upgrade the Chef Server</a> </br>

The Chef server may be configured for high availability to enable failover on backend and load balancing on frontend machines. The following high availability scenarios are supported:

.. raw:: html

   &nbsp;&nbsp;&nbsp;   <a href="https://docs.chef.io/release/server_12-6/install_server_ha_aws.html">High Availability: Amazon Web Services</a> </br>
   &nbsp;&nbsp;&nbsp;   <a href="https://docs.chef.io/release/server_12-6/install_server_ha_drbd.html">High Availability: DRBD</a> </br>


.. note:: Premium features of the Chef server must be installed and configured after the Chef server. The Chef management console must be installed before Reporting because they share the same web user interface. The Chef management console, Reporting, and Chef replication can all be installed using the `chef-server-ctl install <https://docs.chef.io/release/server_12-6/ctl_chef_server.html#install>`_ command. 


Manage the Chef Server
=====================================================
The Chef server can be managed in the following ways:

.. raw:: html

   &nbsp;&nbsp;&nbsp;   <a href="https://docs.chef.io/runbook.html">Runbook</a> </br>
   &nbsp;&nbsp;&nbsp;   <a href="https://docs.chef.io/release/server_12-6/server_backup_restore.html">Backup / Restore</a> </br>
   &nbsp;&nbsp;&nbsp;   <a href="https://docs.chef.io/release/server_12-6/server_data.html">Data</a> </br>
   &nbsp;&nbsp;&nbsp;   <a href="https://docs.chef.io/release/server_12-6/server_firewalls_and_ports.html">Firewalls and Ports</a> </br>
   &nbsp;&nbsp;&nbsp;   <a href="https://docs.chef.io/release/server_12-6/server_high_availability.html">High Availability</a> </br>
   &nbsp;&nbsp;&nbsp;   <a href="https://docs.chef.io/release/server_12-6/server_logs.html">Log Files</a> </br>
   &nbsp;&nbsp;&nbsp;   <a href="https://docs.chef.io/release/server_12-6/server_monitor.html">Monitor</a> </br>
   &nbsp;&nbsp;&nbsp;   <a href="https://docs.chef.io/release/server_12-6/server_orgs.html">Organizations, Groups, and Users</a> </br>
   &nbsp;&nbsp;&nbsp;   <a href="https://docs.chef.io/release/server_12-6/server_replication.html">Replication</a> </br>
   &nbsp;&nbsp;&nbsp;   <a href="https://docs.chef.io/release/server_12-6/server_security.html">Security</a> </br>
   &nbsp;&nbsp;&nbsp;   <a href="https://docs.chef.io/release/server_12-6/server_services.html">Services</a> </br>
   &nbsp;&nbsp;&nbsp;   <a href="https://docs.chef.io/release/server_12-6/server_tuning.html">Server Tuning</a> </br>


Management Console
-----------------------------------------------------
The Chef management console provides a web user interface with access to objects, such as nodes and cookbooks, through role-based access control:

.. raw:: html

   &nbsp;&nbsp;&nbsp;   <a href="https://docs.chef.io/release/server_12-6/server_manage_clients.html">Manage Clients</a> </br>
   &nbsp;&nbsp;&nbsp;   <a href="https://docs.chef.io/release/server_12-6/server_manage_cookbooks.html">Manage Cookbooks</a> </br>
   &nbsp;&nbsp;&nbsp;   <a href="https://docs.chef.io/release/server_12-6/server_manage_data_bags.html">Manage Data Bags</a> </br>
   &nbsp;&nbsp;&nbsp;   <a href="https://docs.chef.io/release/server_12-6/server_manage_environments.html">Manage Environments</a> </br>
   &nbsp;&nbsp;&nbsp;   <a href="https://docs.chef.io/release/server_12-6/server_manage_nodes.html">Manage Nodes</a> </br>
   &nbsp;&nbsp;&nbsp;   <a href="https://docs.chef.io/release/server_12-6/server_manage_reports.html">Manage Reports</a> </br>
   &nbsp;&nbsp;&nbsp;   <a href="https://docs.chef.io/release/server_12-6/server_manage_roles.html">Manage Roles</a> </br>

Reference
=====================================================
This section contains links to topics about configuration files, command-line tools, and APIs that are used by the Chef server and its premium features.

**Configuration Files**

.. raw:: html

   &nbsp;&nbsp;&nbsp;   <a href="https://docs.chef.io/release/server_12-6/config_rb_server.html">chef-server.rb</a> </br>
   &nbsp;&nbsp;&nbsp;   <a href="https://docs.chef.io/release/server_12-6/config_rb_manage.html">manage.rb</a> </br>

**Command-line Tools**

.. raw:: html

   &nbsp;&nbsp;&nbsp;   <a href="https://docs.chef.io/release/server_12-6/ctl_chef_server.html">chef-server-ctl</a> </br>
   &nbsp;&nbsp;&nbsp;   <a href="https://docs.chef.io/release/server_12-6/ctl_opscode_expander.html">opscode-expander-ctl</a> </br>

**APIs**

.. raw:: html

   &nbsp;&nbsp;&nbsp;   <a href="https://docs.chef.io/release/server_12-6/api_chef_server.html">Chef Server API</a> </br>
   &nbsp;&nbsp;&nbsp;   <a href="https://docs.chef.io/release/server_12-6/api_push_jobs.html">Push Jobs API</a> </br>

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
