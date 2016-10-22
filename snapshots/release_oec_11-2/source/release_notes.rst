=====================================================
Release Notes: Enterprise Chef 11.2
=====================================================

Chef is a systems and cloud infrastructure automation framework that makes it easy to deploy servers and applications to any physical, virtual, or cloud location, no matter the size of the infrastructure. Each organization is comprised of one (or more) workstations, a single server, and every node that will be configured and maintained by the chef-client. Cookbooks (and recipes) are used to tell the chef-client how each node in your organization should be configured. The chef-client (which is installed on every node) does the actual configuration.

What's New
=====================================================
The following items are new for Enterprise Chef 11.2 and/or are changes from previous versions:

* **gather-logs subcommand for the Chef Server** The ``gather-logs`` subcommand will create a tarball of recent log files and system information that can be used to send to Chef for support.
* **oc-id service** The identify service enables Chef Supermarket authentication for the Chef server.
* **dark_launch defaults to true** The ``dark_launch`` setting defaults to ``true``, which means that it no longer needs to be manually configured.

gather-logs subcommand
-----------------------------------------------------
.. include:: ../../includes_ctl_private_chef/includes_ctl_private_chef_gather_logs.rst

**oc-id** service
-----------------------------------------------------
.. include:: ../../includes_server_services/includes_server_services_oc_id.rst

.. include:: ../../includes_config/includes_config_rb_server_settings_oc_id.rst

What's Fixed
=====================================================
The following bugs were fixed:

* [OC-11297] tweak partybus migration-level subscribes for a more reliable workaround
* [OC-11585] Allow ['lb']['upstream'] to have a custom setting
* [OC-11459] Allow opscode-manage to easily be moved off of 443
* [OC-11540] Fix invalid opscode-account config when forcing SSL
* [OC-11575] Don't start services by default in HA topology
* [OC-11601] Fix a race condition that sometimes caused redis_lb to attempt to reconfigure itself before it was restarted. This causes redis_lb to restart during every reconfigure. This restart can cause a short period of 500 errors on the on the FE nodes.
* [OC-11668] enable ipv6 in standalone mode
* [OC-11672] Upgrade PostgreSQL to 9.2.9
* [OC-11673] Tune PostgreSQL keepalive timeouts
* [OC-11702] Fix bug that prevents ACL and group expansion when containing group that no longer exists
* [OC-11708] Fix user association bug when last updater of users group is no longer associated
* [OC-11710] Fix couchdb compaction log rotation
