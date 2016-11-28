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
.. tag ctl_private_chef_gather_logs

The ``gather-logs`` subcommand is used to gather the Chef server log files into a tarball that contains all of the important log files and system information.

This subcommand has the following syntax:

.. code-block:: bash

   $ private-chef-ctl gather-logs

.. end_tag

**oc-id** service
-----------------------------------------------------
.. tag server_services_oc_id

The **oc-id** service enables OAuth 2.0 authentication to the Chef server by external applications, including Chef Supermarket and Chef Analytics. OAuth 2.0 uses token-based authentication, where external applications use tokens that are issued by the **oc-id** provider. No special credentials---``webui_priv.pem`` or privileged keys---are stored on the external application.

.. end_tag

.. tag config_rb_server_settings_oc_id

This configuration file has the following settings for ``oc-id``:

``oc_id['administrators']``
   An array of Chef server user names who may add applications to the identity service. For example, ``['user1', 'user2']``. Default value: ``[ ]``.

``oc_id['applications']``
   A Hash that contains OAuth 2 application information. Default value: ``{ }``.

   .. tag config_ocid_application_hash_supermarket

   To define OAuth 2 information for Chef Supermarket, create a Hash similar to:

      .. code-block:: ruby

         oc_id['applications'] ||= {}
         oc_id['applications']['supermarket'] = {
           'redirect_uri' => 'https://supermarket.mycompany.com/auth/chef_oauth2/callback'
         }

   .. end_tag

   To define OAuth 2 information for Chef Analytics, create a Hash similar to:

      .. code-block:: ruby

         oc_id['applications'] ||= {}
         oc_id['applications']['analytics'] = {
           'redirect_uri' => 'https://analytics.rhel.aws'
         }

``oc_id['db_pool_size']``
   The number of open connections to PostgreSQL that are maintained by the service. Default value: ``'20'``.

``oc_id['dir']``
   The working directory. The default value is the recommended value. Default value: none.

``oc_id['enable']``
   Enable a service. Default value: ``true``.

``oc_id['ha']``
   Run the Chef server in a high availability topology. When ``topology`` is set to ``ha``, this setting defaults to ``true``. Default value: ``false``.

``oc_id['log_directory']``
   The directory in which log data is stored. The default value is the recommended value. Default value: ``'/var/opt/opscode/oc_id'``.

``oc_id['log_rotation']``
   The log rotation policy for this service. Log files are rotated when they exceed ``file_maxbytes``. The maximum number of log files in the rotation is defined by ``num_to_keep``. Default value:

   .. code-block:: ruby

      { 'file_maxbytes' => 104857600, 'num_to_keep' => 10 }

``oc_id['num_to_keep']``
   The number of log files to keep. Default value: ``10``.

``oc_id['port']``
   The port on which the service is to listen. Default value: ``9090``.

``oc_id['sql_database']``
   The name of the database. Default value: ``oc_id``.

``oc_id['sql_password']``
   The password for the ``sql_user``. Default value: ``snakepliskin``.

``oc_id['sql_user']``
   The user with permission to write to ``sql_database``. Default value: ``oc_id``.

``oc_id['vip']``
   The virtual IP address. Default value: ``'127.0.0.1'``.

.. end_tag

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
