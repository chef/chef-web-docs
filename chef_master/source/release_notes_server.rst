=====================================================
Release Notes: Chef Server 12.0 - 12.16
=====================================================
`[edit on GitHub] <https://github.com/chef/chef-web-docs/blob/master/chef_master/source/release_notes_server.rst>`__

.. tag chef_index

.. This page is used as the short overview on the index page at docs.chef.io

Chef is a systems and cloud infrastructure automation framework that makes it easy to deploy servers and applications to any physical, virtual, or cloud location, no matter the size of the infrastructure. Each organization is comprised of one (or more) workstations, a single server, and every node that will be configured and maintained by the chef-client. Cookbooks (and recipes) are used to tell the chef-client how each node in your organization should be configured. The chef-client (which is installed on every node) does the actual configuration.

.. end_tag

What's New in 12.16
=====================================================
The following items are new for Chef server 12.16:

* **Upgrade to PostgreSQL 9.6**
* **Elasticsearch 5 support**
* **Changes to Erlang Port Mapper Daemon (EPMD) listening ports**
* **RabbitMQ health check in status endpoint**
* **Notification of affected services when updating secrets with set-secret**

Upgrade to PostgreSQL 9.6
-----------------------------------------------------

Chef server now uses the latest stable version of the 9.6 series (9.6.3). Upgrades of existing installations are done automatically, but creating backups is advised.

The information below only applies if you have set a custom value set for ``checkpoint_segments`` in your ``/etc/opscode/chef-server.rb``. If you have not set a custom value, there is nothing to change:

The ``checkpoint_segments`` configuration setting is gone, so if you previously used the following parameter:

.. code-block:: ruby

   postgresql['checkpoint_segments'] = 10

You would instead use:

.. code-block:: ruby

   postgresql['max_wal_size'] = '3G'

This is just an example configuration - seee the `PostgreSQL release notes <https://www.postgresql.org/docs/9.6/static/release-9-5.html>`__ for more information on tuning this option. The default setting for ``max_wal_size`` is ``1G``. The PostgreSQL release notes mention a conversion rule: ``max_wal_size = (3 * checkpoint_segments) * 16MB``. They also state that the default value for ``max_wal_size`` (1GB) should be sufficient in most settings, so this conversion is not performed automatically.

The ``shmmax`` and ````shmall`` configuration settings are no longer used, as PostgreSQL 9.6 relies on System V shared memory much less than PostgreSQL 9.2. The ``shared_buffers`` configuration setting is still respected, and can be used to modify the amount of shared memory used by PostgreSQL.

This update also adds two new configurables in the "Checkpoints" group: ``min_wal_size`` and ``checkpoint_flush_after``.

As part of the upgrade procedure, ``chef-server-ctl cleanup`` will remove Postgres 9.2's data and logs.

Elasticsearch 5 support
-----------------------------------------------------
Chef server now supports Elasticsearch 5. This allows Chef server and Chef Automate 1.6 to use the same Elasticsearch instance.

Changes to EPMD listening ports
-----------------------------------------------------
The Erlang Port Mapper Daemon (EPMD) included in version 12.16 is patched to only listen on the addresses specified in ``ERL_EPMD_ADDRESS``. Before, it would implicitly add ``::1`` and ``127.0.0.1`` to the set of listening addresses, which caused trouble for systems without ``::1``.

RabbitMQ health check in status endpoint
-----------------------------------------------------
Chef server's ``_status`` endpoint now checks the health of the analytics and internal RabbitMQ vhosts. For these checks to work, the RabbitMQ management plugin must be installed. If it is not, the checks are not performed. If Chef server is configured not to use Actions, a check will not be performed against the Actions vhost. If an indexing queue is not used, the ``chef_index`` RabbitMQ vhost will not be checked.

Notification of affected services when updating secrets with set-secret
-------------------------------------------------------------------------
``chef-server-ctl set-secret`` will notify the user of services that depend on the secret that is being changed. When used with the optional ``--with-restart`` flag, ``chef-server-ctl set-secret`` will attempt to automatically restart the dependent services.

What's New in 12.15
=====================================================
The following items are new for Chef server 12.15:

* **Supports SUSE Linux Enterprise on x86_64**
* **Add required_recipe endpoint**
* **ACLs and groups can refer to global groups**
* **User customization of field mapping**

Supports SUSE Linux Enterprise Server on x86_64
-----------------------------------------------------
Support for a new platform was added: SUSE Linux Enterprise Server 11 & 12 on x86_64.

Add required_recipe endpoint
-----------------------------------------------------
Added the ability to serve a required recipe file to chef-clients.

The setting ``required_recipe["enable"]`` in chef-server.rb enables the required recipe feature.

The setting ``required_recipe["path"]`` in chef-server.rb specifies the recipe file to serve.

The ``/organizations/<orgname>/required_recipe`` endpoint returns 404 for all organizations by default. It returns 401 when the request is not made by a client from the requested org and the feature is enabled.

The ``/organizations/<orgname>/required_recipe`` endpoint returns the required recipe and 200 only when the endpoint is enabled and requested by an authorized client.

See `Chef RFC 89 <https://github.com/chef/chef-rfc/blob/master/rfc089-server-enforced-recipe.md>`_ for a complete description on the ``required_recipe`` endpoint.

ACLs and groups can refer to global groups
-----------------------------------------------------
The server-admins group is useful, but it breaks roundtripping when it appears in an organizations ACLs and groups. This makes it difficult when using the API for backups.

A new syntax '::' was added to indicate scoping. ``::GROUPNAME`` without a prefix indicates a global (across multiple orgs) entity, while ``ORGNAME::GROUPNAME`` refers to a group in an another org.
So if the server-admins appears in an organizations ACL, you will see the name ``::server-admins``.

User customization of field mapping
-----------------------------------------------------
Attributes from a user's LDAP record are used during account-linking to populate the erchef user record when it is created. Previously, the mapping between LDAP attributes and chef user attributes were fixed. Now, they are configurable. For example, if the user's LDAP record stores their email address in a field named 'address' instead of 'mail', then you could set the following in ``private-chef.rb``:

.. code-block:: ruby

   ldap['email_attribute'] = "address"

Bug Fixes
-----------------------------------------------------
Fixed regression in oc-id. The identity service was using the wrong Chef Server API version level.

Fixed regression in the nginx proxy that prevented Automate-based Compliance profiles from being reachable.

Fixed regression in Bookshelf's preflight checks.

Fixed regression that would cause Manage to be misconfigured to enable LDAP by default.

PUT to  ``/users/USERNAME/_acl/PERM`` will no longer return a 400 when the request is valid.

What's New in 12.14
=====================================================
The following items are new for Chef server 12.14:

* **Reduce password proliferation**

Reduce password proliferation
-----------------------------------------------------
We've substantially reduced the number of configuration files that contain plaintext passwords. Now, no passwords or credentials are rendered outside of ``/etc/opscode/`` in Chef server's default configuration.

To ensure backwards compatibility, Chef server still renders passwords and keys to multiple files in ``/etc/opscode``. However, if you are not using any Chef Server add-ons, or if you have updated to the latest releases of all add-ons, you can set the following:

.. code-block:: ruby

   insecure_addon_compat false

in ``/etc/opscode/chef-server.rb`` and remove these other occurrences of secrets as well.

If you are using LDAP integration, external postgresql, or other Chef server features that require providing passwords in ``/etc/opscode/chef-server.rb``, we've also provided commands that allow you to set these passwords outside of the configuration file. For information about these commands see `Secrets Management </ctl_chef_server.html#secrets-management>`_.

.. note:: Users of the DRBD-based HA configuration may still see passwords related to keepalived and DRBD in ``/var/opt/opscode``.

For further information see:

See `Chef Server Credentials Management </server_security.html#chef-server-credentials-management>`_ for more details.

What's New in 12.13
=====================================================
The following items are new for Chef server 12.13:

* **Supports Red Hat Enterprise Linux 6 on s390x (RHEL6/s390x)**
* **Disables the Solr4 Admin API/UI by default**
* **FIPS runtime flag exposed on RHEL systems** Setting ``fips true`` and reconfiguring will start the server in FIPS mode.  Packages for other systems will not have the required OpenSSL FIPS module and will fail to start if reconfigured with ``fips true``.

New platform: RHEL6/s390x
-----------------------------------------------------
Support for a new platform was added: Red Hat Enterprise Linux 6 on s390x.

Solr4 Admin API/UI disabled by default
-----------------------------------------------------
With this release, the admin UI of Solr4 has been removed. The underlying API
has also been disabled. Users that depend on the admin API endpoints can enable
them via adding:

.. code-block:: ruby

    opscode_solr4['enable_full_admin_api'] = true

to ``chef-server.rb``.

FIPS runtime flag exposed
-----------------------------------------------------
The Chef Server package now exposes a ``fips`` configuration flag in
``chef-server.rb``. Setting ``fips true`` and reconfiguring will start the
server in FIPS mode. The default value of this flag is ``false`` except
on systems where FIPS is enabled at the Kernel where it defaults to ``true``.

The only supported systems at this time for FIPS mode are RHEL. Packages for
other systems will be missing the required OpenSSL FIPS module and will fail
to start if reconfigured with ``fips true``.


What's New in 12.12
=====================================================
The following items are new for Chef server 12.12:

* **chef-server-ctl backup correctly backs up configuration data** Starting in version 12.10.0, a bug in the ``backup`` command produced backups that did not include the configuration data in the resulting tarball. This bug is now resolved. We recommend taking a new backup after upgrading to 12.12.0.
* **Correct number of rows are returned when searching with ElasticSearch** When configured to use ElasticSearch, Chef server now correctly respects the ``rows`` parameter in search requests rather than returning all rows.
* **Solr 4 GC logging is now used by Chef server** Java's native rotation is used for the gclog.
* **New oc_id email configuration options** Outbound email address can now be configured.

Solr 4 GC Logging
-----------------------------------------------------
Chef server now uses Java's native rotation for the gclog. This prevents situations where logrotate creates large sparse files on disk, which may be problematic to manage with tools that can't handle sparse files.

The Solr 4 GC log can now be found at ``/var/log/opscode/opscode-solr4/gclog.log.N.current`` where *N* is an integer. The ``.current`` extension denotes the log currently being written to.

To remove the older GC logs, run ``sudo chef-server-ctl cleanup`` after upgrading to Chef server 12.12.

To suppress the GC log completely, set the following option in ``/etc/opscode/chef-server.rb``:

.. code-block:: ruby

   # true (default) to enable gc logging,
   # false to disable gc logging
   opscode_solr4['log_gc'] = false

oc_id Email Configuration Options
-----------------------------------------------------
The ``oc_id`` service now includes configuration for outbound email to ensure password reset emails can be sent correctly.

You can now set the following options in ``/etc/opscode/chef-server.rb``:

.. code-block:: ruby

   # defaults to the value of the from_email configuration option
   oc_id['email_from_address'] = "oc_id@example.com"
   # defaults to the api_fqdn
   oc_id['origin'] = "mail.yourco.io"


What's New in 12.11
=====================================================
The following items are new for Chef server 12.11:

New Endpoints
-----------------------------------------------------
* **/organizations/ORGNAME/validate/PATH** accepts a signed request and validates it as if it had been sent to `PATH`. It returns 200 if the request is authentic and 401 if it is not.
* **/organizations/ORGNAME/data-collector** forwards requests for a data-collector service after authenticating the request using Chef Server's standard authentication headers.  To use this endpoint, users must set both of the following options in /etc/opscode/chef-server.rb:

  .. code-block:: ruby

     data_collector['token']
     data_collector['root_url']

* **/organizations/ORGNAME/owners/OWNER/compliance[/PROFILE]** forwards requests for compliance profiles to a user-configurable Chef Automate server after authenticating the request using Chef Server's standard authentication headers. To use this endpoint, users must set both of the following options in `/etc/opscode/chef-server.rb`:

  .. code-block:: ruby

     profiles['root_url']
     data_collector['token']

Security Updates
-----------------------------------------------------

* The default allowed SSL ciphers now include AES256-GCM-SHA384 to ensure compatibility with AWS's Classic ELB health check tool.
* **chef-server-ctl psql** previously revealed the postgresql password via `ps`.

What's New in 12.10
=====================================================
The following items are new for Chef server 12.10:

* Smaller download - the download size has been reduced by around 35% via removal of redundant, cached, and unused components. The installed size has been similarly reduced.
* add retry support to opscode-expander
* chef-server-ctl reindex will now continue even if some objects are not indexable, and will show which objects failed at the conclusion of the run.
* Data Collector support for Policyfiles.
* chef-server-ctl install add-on installation now pulls from the correct source.
* Regression fix: that caused errors on reconfigure when LDAP bind password is nil has been fixed.

Security Updates
-----------------------------------------------------
* Upgrade to OpenSSL 1.0.2j. The prior release (1.0.1u) is approaching EOL.
* Updated TLS ciphers. See compatibility notes, below.

Compatibility Notes
-----------------------------------------------------

* The change of TLS ciphers can cause older tooling to fail to negotiate SSL sessions with the Chef Server. The changes to the cipher list are captured here. Upgrading any custom clients of the Chef Server API to use a current SSL release will resolve this.

  Alternatively, you can set ``nginx['ssl_protocols']`` in ``/etc/opscode/chef-server.rb`` to a set of ciphers that are compatible with your tooling, then running chef-server-ctl reconfigure to pick up the changes.

* With this TLS cipher suite change, the Reporting add-on will report errors when opscode-reporting-ctl test is run. A fix for this is available in the current channel for reporting, and will be released to stable in November. This issue does not otherwise affect the Reporting add-on, but you can resolve this locally by modifying /etc/opscode-reporting/pedant_config.rb and adding the following line: ssl_version :TLSv1_2

What's New in 12.9.1
=====================================================
The following items are new for Chef server 12.9.1:

The update of OpenSSL 1.0.1u addresses the following CVEs:

* CVE-2016-6304
* CVE-2016-2183
* CVE-2016-6303
* CVE-2016-6302
* CVE-2016-2182
* CVE-2016-2180
* CVE-2016-2177
* CVE-2016-2178
* CVE-2016-2179
* CVE-2016-2181
* CVE-2016-6306

What's New in 12.9
=====================================================
The following items are new for Chef server 12.9:

* **New warning and functionality when trying to delete user in multiple 'admin' groups** If a user is in an admininstrator group in any organization, the ``chef-server-ctl user-delete`` subcommand does not allow you to remove the user from that group. To provide more information when the ``user-delete`` subcommand fails for this reason, the error message contains a list of organizations the user is an adminstrator of. Using the new flag ``--remove-from-admin-groups``, you can now remove that user provided they are not the only user in the ``admin`` group.
* **LDAP bind passwords now support special characters**
* **Updated to OpenSSL 1.0.1u** Updated version of OpenSSL to address security vunerabilities.
* **Multiple ACL updates on the Chef server API** The ``_acl`` endpoint now requires that any users being added to an object's ACL exist in the same organization as the object itself. Existing users that are not organization members and have already been added to an ACL will not be affected, and will still be in the GET response for this API. Additional changes can be found `here <https://github.com/chef/chef-server/blob/master/RELEASE_NOTES.md#api-changes>`__.

What's New in 12.8
=====================================================
The following items are new for Chef server 12.8:

* **Initial support for sending updates to a data collector service**
* **Minor bug fixes in postgresql setup**

What's New in 12.7
=====================================================
The following items are new for Chef server 12.7:

* **Support for service credential rotation through Veil** Veil is a library for securely creating, storing, and rotating Chef server secrets. It is also required when using the new ``chef-server-ctl require-credential-rotation`` command.
* **Filtering by external authentication ID in Chef server API** Users can now be filtered by ``external_authentication_uid``, which is needed to support SAML authentication in Chef Manage.
* **Updated to OpenSSL 1.0.1t** Version 1.0.1t contains several security fixes.

Service credential rotation support
-----------------------------------------------------
`Veil <https://github.com/chef/chef-server/blob/3ff412b5a2e6ad54cfa79bca6865e1bbca28fe5e/omnibus/files/veil/README.md>`_ is a new library to manage Chef server secrets. It allows any Chef server with a given set of secrets to create new service credentials and rotate them without requiring the secrets files to be copied between each Chef server in a cluster.

Five new commands have been created to support credential rotation:

* `require-credential-rotation </ctl_chef_server.html#require-credential-rotation>`_
* `rotate-all-credentials </ctl_chef_server.html#rotate-all-credentials>`_
* `rotate-credentials </ctl_chef_server.html#rotate-credentials>`_
* `rotate-shared-secrets </ctl_chef_server.html#rotate-shared-secrets>`_
* `show-service-credentials </ctl_chef_server.html#show-service-credentials>`_

Your secrets file is located at ``/etc/opscode/private-chef-secrets.json``, so whenever you rotate your service credentials, or update your shared secrets, this file will contain the changes.

Supporting SAML-authentication in Chef Manage
-----------------------------------------------------
To support SAML-authentication in Chef Manage, you can now filter users using ``external_authentication_uid`` in a GET request against the Chef server API. For example, to retrieve users where the ``external_authentication_uid`` is ``jane@doe.com``, do the following:

.. code-block:: none

   GET /users?external_authentication_uid=jane%40doe.com

What's New in 12.6
=====================================================
The following items are new for Chef server 12.6:

* **Chef licenses** All Chef products have a license that governs the entire product and includes links to license files for any third-party software included in Chef packages. This release updates the Chef server for the Chef license.

About Chef Licenses
-----------------------------------------------------
.. tag chef_license_summary

All Chef products have a license that governs the entire product and includes links to license files for any third-party software included in Chef packages. The ``/opt/<PRODUCT-NAME>/LICENSES`` directory contains individual copies of all referenced licenses.

.. end_tag

.. warning:: .. tag chef_license_note_current

             The ``chef-server-ctl install`` command no longer works in the 12.5 (and earlier) versions of the Chef server due to a change in how packages are downloaded from Chef.

             .. end_tag

Apache 2.0
-----------------------------------------------------
.. tag chef_license_apache

.. no swaps used for the "such as ..." section to ensure the correct legal name and not the names for these products as otherwise used globally in the documentation.

All open source Chef products---such as the Chef client, the Chef server, or InSpec---are governed by the Apache 2.0 license.

.. end_tag

What's New in 12.5
=====================================================
The following items are new for Chef server 12.5:

* **New group for key-related Chef server API endpoints** The ``public_key_read_access`` group defines which users and clients have read permissions to key-related endpoints in the Chef server API.

public_key_read_access
-----------------------------------------------------
.. tag server_rbac_permissions_default_public_key_read_access

The ``public_key_read_access`` group controls which users and clients have :doc:`read permissions to the following endpoints </api_chef_server>`:

* GET /clients/CLIENT/keys
* GET /clients/CLIENT/keys/KEY
* GET /users/USER/keys
* GET /users/USER/keys/

By default, the ``public_key_read_access`` assigns all members of the ``users`` and ``clients`` group permission to these endpoints:

.. list-table::
   :widths: 160 100 100 100 100 100
   :header-rows: 1

   * - Group
     - Create
     - Delete
     - Grant
     - Read
     - Update
   * - admins
     - no
     - no
     - no
     - no
     - no
   * - clients
     - yes
     - yes
     - yes
     - yes
     - yes
   * - users
     - yes
     - yes
     - yes
     - yes
     - yes

.. end_tag

What's New in 12.4
=====================================================
The following items are new for Chef server 12.4:

* **/universe endpoint** Use the ``/universe`` endpoint to retrieve the known collection of cookbooks, and then use it with Berkshelf and Chef Supermarket.
* **opscode-expander-reindexer service** The ``opscode-expander-reindexer`` service is deprecated.
* **Global server administrator list** Use the ``grant-server-admin-permissions``, ``remove-server-admin-permissions``, and ``list-server-admins`` to manage the list of users who belong to the ``server-admins`` group.

/universe
-----------------------------------------------------
.. tag api_chef_server_endpoint_universe

Use the ``/universe`` endpoint to retrieve the known collection of cookbooks, and then use it with Berkshelf and Chef Supermarket.

The ``/universe`` endpoint has the following methods: ``GET``.

.. end_tag

GET
-----------------------------------------------------
.. tag api_chef_server_endpoint_universe_get

The ``GET`` method is used to retrieve the universe data.

This method has no parameters.

**Request**

.. code-block:: none

   GET /universe

**Response**

The response will return an embedded hash, with the name of each cookbook as a top-level key. Each cookbook will list each version, along with its location information and dependencies:

.. code-block:: javascript

   {
     "ffmpeg": {
       "0.1.0": {
         "location_path": "http://supermarket.chef.io/api/v1/cookbooks/ffmpeg/0.1.0/download"
         "location_type": "supermarket",
         "dependencies": {
           "git": ">= 0.0.0",
           "build-essential": ">= 0.0.0",
           "libvpx": "~> 0.1.1",
           "x264": "~> 0.1.1"
         },
       },
       "0.1.1": {
         "location_path": "http://supermarket.chef.io/api/v1/cookbooks/ffmpeg/0.1.1/download"
         "location_type": "supermarket",
         "dependencies": {
           "git": ">= 0.0.0",
           "build-essential": ">= 0.0.0",
           "libvpx": "~> 0.1.1",
           "x264": "~> 0.1.1"
         },
       },
      "pssh": {
       "0.1.0": {
         "location_path": "http://supermarket.chef.io/api/v1/cookbooks/pssh.1.0/download"
         "location_type": "supermarket",
         "dependencies": {},
       }
     }
   }

.. list-table::
   :widths: 200 300
   :header-rows: 1

   * - Response Code
     - Description
   * - ``200``
     - OK. The request was successful. One (or more) cookbooks and associated cookbook version information was returned.

.. end_tag

Server Admins
-----------------------------------------------------
.. tag server_rbac_server_admins

The ``server-admins`` group is a global group that grants its members permission to create, read, update, and delete user accounts, with the exception of superuser accounts. The ``server-admins`` group is useful for users who are responsible for day-to-day administration of the Chef server, especially user management via the ``knife user`` subcommand. Before members can be added to the ``server-admins`` group, they must already have a user account on the Chef server.

.. end_tag

Scenario
-----------------------------------------------------
.. tag server_rbac_server_admins_scenario

The following user accounts exist on the Chef server: ``pivotal`` (a superuser account), ``alice``, ``bob``, ``carol``, and ``dan``. Run the following command to view a list of users on the Chef server:

.. code-block:: bash

   $ chef-server-ctl user-list

and it returns the same list of users:

.. code-block:: bash

   pivotal
   alice
   bob
   carol
   dan

Alice is a member of the IT team whose responsibilities include day-to-day administration of the Chef server, in particular managing the user accounts on the Chef server that are used by the rest of the organization. From a workstation, Alice runs the following command:

.. code-block:: bash

   $ knife user list -c ~/.chef/alice.rb

and it returns the following error:

.. code-block:: bash

   ERROR: You authenticated successfully to <chef_server_url> as alice
          but you are not authorized for this action
   Response: Missing read permission

Alice is not a superuser and does not have permissions on other users because user accounts are global to organizations in the Chef server. Let's add Alice to the ``server-admins`` group:

.. code-block:: bash

   $ chef-server-ctl grant-server-admin-permissions alice

and it returns the following response:

.. code-block:: bash

   User alice was added to server-admins.

Alice can now create, read, update, and delete user accounts on the Chef server, even for organizations to which Alice is not a member. From a workstation, Alice re-runs the following command:

.. code-block:: bash

   $ knife user list -c ~/.chef/alice.rb

which now returns:

.. code-block:: bash

   pivotal
   alice
   bob
   carol
   dan

Alice is now a server administrator and can use the following knife subcommands to manage users on the Chef server:

* ``knife user-create``
* ``knife user-delete``
* ``knife user-edit``
* ``knife user-list``
* ``knife user-show``

For example, Alice runs the following command:

.. code-block:: bash

   $ knife user edit carol -c ~/.chef/alice.rb

and the $EDITOR opens in which Alice makes changes, and then saves them.

.. end_tag

Superuser Accounts
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. tag server_rbac_server_admins_superusers

Superuser accounts may not be managed by users who belong to the ``server-admins`` group. For example, Alice attempts to delete the ``pivotal`` superuser account:

.. code-block:: bash

   $ knife user delete pivotal -c ~/.chef/alice.rb

and the following error is returned:

.. code-block:: bash

   ERROR: You authenticated successfully to <chef_server_url> as user1
          but you are not authorized for this action
   Response: Missing read permission

Alice's action is unauthorized even with membership in the ``server-admins`` group.

.. end_tag

Manage server-admins Group
-----------------------------------------------------
.. tag ctl_chef_server_server_admin

Membership of the ``server-admins`` group is managed with a set of ``chef-server-ctl`` subcommands:

* ``chef-server-ctl grant-server-admin-permissions``
* ``chef-server-ctl list-server-admins``
* ``chef-server-ctl remove-server-admin-permissions``

.. end_tag

Add Members
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. tag ctl_chef_server_server_admin_grant_user

The ``grant-server-admin-permissions`` subcommand is used to add a user to the ``server-admins`` group. Run the command once per user added.

This subcommand has the following syntax:

.. code-block:: bash

   $ chef-server-ctl grant-server-admin-permissions USER_NAME

where ``USER_NAME`` is the user to add to the list of server administrators.

For example:

.. code-block:: bash

   $ chef-server-ctl grant-server-admin-permissions bob

returns:

.. code-block:: bash

   User bob was added to server-admins. This user can now list,
   read, and create users (even for orgs they are not members of)
   for this Chef Server.

.. end_tag

Remove Members
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. tag ctl_chef_server_server_admin_remove_user

The ``remove-server-admin-permissions`` subcommand is used to remove a user from the ``server-admins`` group. Run the command once per user removed.

This subcommand has the following syntax:

.. code-block:: bash

   $ chef-server-ctl remove-server-admin-permissions USER_NAME

where ``USER_NAME`` is the user to remove from the list of server administrators.

For example:

.. code-block:: bash

   $ chef-server-ctl remove-server-admin-permissions bob

returns:

.. code-block:: bash

   User bob was removed from server-admins. This user can no longer
   list, read, and create users for this Chef Server except for where
   they have default permissions (such as within an org).

.. end_tag

List Membership
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. tag ctl_chef_server_server_admin_list

The ``list-server-admins`` subcommand is used to return a list of users who are members of the ``server-admins`` group.

This subcommand has the following syntax:

.. code-block:: bash

   $ chef-server-ctl list-server-admins

and will return a list of users similar to:

.. code-block:: bash

   pivotal
   alice
   bob
   carol
   dan

.. end_tag

What's New in 12.3
=====================================================
The following items are new for Chef server 12.3:

* **Nginx stub_status module is enabled** The Nginx ``stub_status`` module is enabled by default and may be viewed at the ``/nginx_status`` endpoint. The settings for this module are configurable.
* **RabbitMQ queue tuning** New settings for managing RabbitMQ queues allow the size of the queue used by Chef Analytics to be configured, including settings for the queue length monitor and for tuning the rabbitmq-management plugin.

Nginx stub_status Module
-----------------------------------------------------
The following configuration settings are new and enable the Nginx ``stub_status`` module:

``nginx['enable_stub_status']``
   Enables the Nginx ``stub_status`` module. See ``nginx['stub_status']['allow_list']``, ``nginx['stub_status']['listen_host']``, ``nginx['stub_status']['listen_port']``, and ``nginx['stub_status']['location']``. Default value: ``true``.

``nginx['stub_status']['allow_list']``
   The IP address on which accessing the ``stub_status`` endpoint is allowed. Default value: ``["127.0.0.1"]``.

``nginx['stub_status']['listen_host']``
   The host on which the Nginx ``stub_status`` module listens. Default value: ``"127.0.0.1"``.

``nginx['stub_status']['listen_port']``
   The port on which the Nginx ``stub_status`` module listens. Default value: ``"9999"``.

``nginx['stub_status']['location']``
   The name of the Nginx ``stub_status`` endpoint used to access data generated by the Nginx ``stub_status`` module. Default value: ``"/nginx_status"``.

RabbitMQ Queues
-----------------------------------------------------
.. tag server_tuning_rabbitmq_analytics_queue

If the RabbitMQ queue that is used by Chef Analytics stops consuming messages, the Chef server data partition will fill up and may affect the overall performance of the Chef server application itself. The settings for the RabbitMQ queue are tunable, including for queue length monitoring, queue capacity, maximum number of messages that can be in the queue before messages are dropped, the point at which messages are dropped, for settings used by the rabbitmq-management plugin, and so on.

.. end_tag

.. tag server_tuning_rabbitmq_analytics_queue_settings

The following settings may be used for tuning RabbitMQ queues used by Chef Analytics and the Chef server:

``rabbitmq['analytics_max_length']``
   The maximum number of messages that can be queued before RabbitMQ automatically drops messages from the front of the queue to make room for new messages. Default value: ``10000``.

``rabbitmq['drop_on_full_capacity']``
   Specify if messages will stop being sent to the RabbitMQ queue when it is at capacity. Default value: ``true``.

``rabbitmq['management_enabled']``
   Specify if the rabbitmq-management plugin is enabled. Default value: ``true``.

``rabbitmq['management_password']``
   The rabbitmq-management plugin password. Default value: ``'chefrocks'``.

``rabbitmq['management_port']``
   The rabbitmq-management plugin port. Default value: ``15672``.

``rabbitmq['management_user']``
   The rabbitmq-management plugin user. Default value: ``'rabbitmgmt'``.

``rabbitmq['prevent_erchef_startup_on_full_capacity']``
   Specify if the Chef server will start when the monitored RabbitMQ queue is full. Default value: ``false``.

``rabbitmq['queue_at_capacity_affects_overall_status']``
   Specify if the ``_status`` endpoint in the Chef server API will fail if the monitored queue is at capacity. Default value: ``false``.

``rabbitmq['queue_length_monitor_enabled']``
   Specify if the queue length monitor is enabled. Default value: ``true``.

``rabbitmq['queue_length_monitor_millis']``
   The frequency (in milliseconds) at which the length of the RabbitMQ queue is checked. Default value: ``30000``.

``rabbitmq['queue_length_monitor_timeout_millis']``
   The timeout (in milliseconds) at which calls to the queue length monitor will stop if the Chef server is overloaded. Default value: ``5000``.

``rabbitmq['queue_length_monitor_queue']``
   The RabbitMQ queue that is observed by queue length monitor. Default value: ``'alaska'``.

``rabbitmq['queue_length_monitor_vhost']``
   The virtual host for the RabbitMQ queue that is observed by queue length monitor. Default value: ``'/analytics'``.

``rabbitmq['rabbit_mgmt_http_cull_interval']``
   The maximum cull interval (in seconds) for the HTTP connection pool that is used by the rabbitmq-management plugin. Default value: ``60``.

``rabbitmq['rabbit_mgmt_http_init_count']``
   The initial worker count for the HTTP connection pool that is used by the rabbitmq-management plugin. Default value: ``25``.

``rabbitmq['rabbit_mgmt_http_max_age']``
   The maximum connection worker age (in seconds) for the HTTP connection pool that is used by the rabbitmq-management plugin. Default value: ``70``.

``rabbitmq['rabbit_mgmt_http_max_connection_duration']``
   The maximum connection duration (in seconds) for the HTTP connection pool that is used by the rabbitmq-management plugin. Default value: ``70``.

``rabbitmq['rabbit_mgmt_http_max_count']``
   The maximum worker count for the HTTP connection pool that is used by the rabbitmq-management plugin. Default value: ``100``.

``rabbitmq['rabbit_mgmt_ibrowse_options']``
   An array of comma-separated key-value pairs of ibrowse options for the HTTP connection pool that is used by the rabbitmq-management plugin. Default value: ``'{connect_timeout, 10000}'``.

``rabbitmq['rabbit_mgmt_timeout']``
   The timeout for the HTTP connection pool that is used by the rabbitmq-management plugin. Default value: ``30000``.

``rabbitmq['ssl_versions']``
   The SSL versions used by the rabbitmq-management plugin. (See also |url rabbitmqssl|.) Default value: ``['tlsv1.2', 'tlsv1.1']``.

.. end_tag

What's New
-----------------------------------------------------
The following items are new for Chef server 12.2:

* **Solr to Solr4 settings** Built-in transition for Apache Solr memory and JVM settings from Enterprise Chef to Chef server version 12.
* **Configurable Postgresql** Postgresql can be configured for an external database.
* **New endpoints for the Chef server API** Endpoints have been added to the Chef server API: ``DELETE /policy_groups``.
* **New subcommmands for chef-server-ctl** Use the ``backup`` and ``restore`` subcommmands to back up and restore Chef server data. Use the ``psql`` subcommmand to log into a PostgreSQL database that is associated with a service running in the Chef server configuration.
* **New options for chef-server-ctl reindex** The ``reindex`` subcommand has new options: ``--all-orgs`` (reindex all organizations), ``--disable-api`` (disable the Chef server API during reindexing), ``--with-timing`` (print timing information), and ``--wait`` (wait for reindex queue to clear before exiting).

Solr => Solr 4 Changes
-----------------------------------------------------
.. tag 2_solr_to_solr4

Chef server version 12 is upgraded to Apache Solr 4. If Apache Solr options were added to the private-chef.rb file under ``opscode_solr`` for Enterprise Chef, those configuration options are now stored under ``opscode_solr4`` in the chef-server.rb file for Chef server version 12.

Some ``opscode_solr`` settings are imported automatically, such as heap, new size, and Java options, but many settings are ignored. If your Enterprise Chef configuration is highly tuned for Apache Solr, review `these configuration settings </config_rb_server_optional_settings.html#opscode-solr4>`__ before re-tuning Apache Solr for Chef server version 12.

.. end_tag

External PostgreSQL
-----------------------------------------------------
.. tag server_ha_external_postgresql

The following diagram highlights the specific changes that occur when PostgreSQL is configured and managed independently of the Chef server configuration.

.. image:: ../../images/server_components_postgresql.svg
   :width: 500px

The following table describes the components in an external PostgreSQL configuration that are different from the default configuration of the Chef server:

.. list-table::
   :widths: 60 420
   :header-rows: 1

   * - Component
     - Description
   * - Chef Server
     - The Chef server configuration file is updated to point to an independently configured set of servers for PostgreSQL.
   * - PostgreSQL
     - .. tag chef_server_component_postgresql

       PostgreSQL is the data storage repository for the Chef server.

       .. end_tag

       This represents the independently configured set of servers that are running PostgreSQL and are configured to act as the data store for the Chef server.

.. end_tag

.. note:: The following ``chef-server-ctl`` subcommands for managing services are disabled when an external PostgreSQL database is configured for the Chef server: ``hup``, ``int``, ``kill``, ``once``, ``restart``, ``start``, ``stop``, ``tail``, and ``term``.

Settings
-----------------------------------------------------

Use the following configuration settings in the chef-server.rb file to configure PostgreSQL for use with the Chef server:

.. list-table::
   :widths: 200 300
   :header-rows: 1

   * - Setting
     - Description
   * - ``postgresql['db_superuser']``
     - Required when ``postgresql['external']`` is set to ``true``. The PostgreSQL user name. This user must be granted either the ``CREATE ROLE`` and ``CREATE DATABASE`` permissions in PostgreSQL or be granted ``SUPERUSER`` permission. This user must also have an entry in the host-based authentication configuration file used by PostgreSQL (traditionally named ``pg_hba.conf``). Default value: ``'superuser_userid'``.
   * - ``postgresql['db_superuser_password']``
     - Required when ``postgresql['external']`` is set to ``true``. The password for the user specified by ``postgresql['db_superuser']``. Default value: ``'the password'``.
   * - ``postgresql['external']``
     - Required. Set to ``true`` to run PostgreSQL external to the Chef server. Must be set once only on a new installation of the Chef server before the first ``chef-server-ctl reconfigure`` command is run. If this is set after a reconfigure or set to ``false``, any reconfigure of the Chef server will return an error. Default value: ``false``.
   * - ``postgresql['port']``
     - Optional when ``postgresql['external']`` is set to ``true``. The port on which the service is to listen. The port used by PostgreSQL if that port is **not** 5432. Default value: ``5432``.
   * - ``postgresql['vip']``
     - Required when ``postgresql['external']`` is set to ``true``. The virtual IP address. The host for this IP address must be online and reachable from the Chef server via the port specified by ``postgresql['port']``. Set this value to the IP address or hostname for the machine on which external PostgreSQL is located when ``postgresql['external']`` is set to ``true``.

Backup / Restore
-----------------------------------------------------
Use the following commands to manage backups of Chef server data, and then to restore those backups.

backup
-----------------------------------------------------
.. tag ctl_chef_server_backup

The ``backup`` subcommand is used to back up all Chef server data. This subcommand:

* Requires rsync to be installed on the Chef server prior to running the command
* Requires a ``chef-server-ctl reconfigure`` prior to running the command
* Should not be run in a Chef server configuration with an external PostgreSQL database; `use knife ec backup <https://github.com/chef/knife-ec-backup>`__ instead
* Puts the initial backup in the ``/var/opt/chef-backup`` directory as a tar.gz file; move this backup to a new location for safe keeping

.. end_tag

**Options**

.. tag ctl_chef_server_backup_options

This subcommand has the following options:

``-y``, ``--yes``
   Use to specify if the Chef server can go offline during tar.gz-based backups.

.. end_tag

**Syntax**

.. tag ctl_chef_server_backup_syntax

This subcommand has the following syntax:

.. code-block:: bash

   $ chef-server-ctl backup

.. end_tag

restore
-----------------------------------------------------
.. tag ctl_chef_server_restore

The ``restore`` subcommand is used to restore Chef server data from a backup that was created by the ``backup`` subcommand. This subcommand may also be used to add Chef server data to a newly-installed server. This subcommand:

* Requires rsync to be installed on the Chef server prior to running the command
* Requires a ``chef-server-ctl reconfigure`` prior to running the command
* Should not be run in a Chef server configuration with an external PostgreSQL database; `use knife ec backup <https://github.com/chef/knife-ec-backup>`__ instead

.. note :: The ``restore`` command does not support transferring backups across different versions of Chef server. Backups taken with the ``backup`` command must restore to the same version of Chef server that was in use when they were created.

.. end_tag

**Options**

.. tag ctl_chef_server_restore_options

This subcommand has the following options:

``-c``, ``--cleanse``
   Use to remove all existing data on the Chef server; it will be replaced by the data in the backup archive.

``-d DIRECTORY``, ``--staging-dir DIRECTORY``
   Use to specify that the path to an empty directory to be used during the restore process. This directory must have enough disk space to expand all data in the backup archive.

.. end_tag

**Syntax**

.. tag ctl_chef_server_restore_syntax

This subcommand has the following syntax:

.. code-block:: bash

   $ chef-server-ctl restore PATH_TO_BACKUP (options)

.. end_tag

**Examples**

.. code-block:: bash

   $ chef-server-ctl restore /path/to/tar/archive.tar.gz

psql
-----------------------------------------------------
.. tag ctl_chef_server_psql

The ``psql`` subcommand is used to log into the PostgreSQL database associated with the named service. This subcommand:

* Uses ``psql`` (the interactive terminal for PostgreSQL)
* Has read-only access by default
* Is the recommended way to interact with any PostgreSQL database that is part of the Chef server
* Automatically handles authentication

.. end_tag

**Syntax**

.. tag ctl_chef_server_psql_syntax

This subcommand has the following syntax:

.. code-block:: bash

   $ chef-server-ctl psql SERVICE_NAME (options)

.. end_tag

**Options**

.. tag ctl_chef_server_psql_options

This subcommand has the following options:

``--write``
   Use to enable write access to the PostgreSQL database.

.. end_tag

reindex Options
-----------------------------------------------------
.. tag ctl_chef_server_reindex_options

This subcommand has the following options:

``-a``, ``--all-orgs``
   Use to reindex all organizations on the Chef server. This option will override any organization specified as part of the command, i.e. ``chef-server-ctl reindex ORG_NAME -a`` will reindex all organizations and not just the specified organization.

``-d``, ``--disable-api``
   Use to disable the Chef server API to prevent writes during reindexing.

``-t``, ``--with-timing``
   Use to print timing information for the reindex processes.

``-w``, ``--wait``
   Use to wait for the reindexing queue to clear before exiting.

.. end_tag

Chef server API Endpoints
-----------------------------------------------------
The following endpoints have been added to the Chef server API:

/policy_groups/NAME
-----------------------------------------------------
.. tag api_chef_server_endpoint_policy_groups

The ``/policy_groups`` endpoint has the following methods: ``GET``.

.. end_tag

DELETE
+++++++++++++++++++++++++++++++++++++++++++++++++++++
The ``DELETE`` method is used to delete a policy group that is stored on the Chef server.

This method has no parameters.

**Request**

.. code-block:: none

   DELETE /organizations/NAME/policy_groups/NAME

**Response**

The response returns the policy details and is similar to:

.. code-block:: javascript

   {
     "uri": "https://chef.example/organizations/org1/policy_groups/dev",
     "policies": {
       "aar": {
         "revision_id": "95040c199302c85c9ccf1bcc6746968b820b1fa25d92477ea2ec5386cd58b9c5"
       },
       "jenkins": {
         "revision_id": "613f803bdd035d574df7fa6da525b38df45a74ca82b38b79655efed8a189e073"
       }
     }
   }

**Response Codes**

.. list-table::
   :widths: 200 300
   :header-rows: 1

   * - Response Code
     - Description
   * - ``200``
     - OK. The request was successful.
   * - ``401``
     - Unauthorized. The user or client who made the request could not be authenticated. Verify the user/client name, and that the correct key was used to sign the request.
   * - ``403``
     - Forbidden. The user who made the request is not authorized to perform the action.
   * - ``404``
     - Not found. The requested object does not exist.

/policies/NAME
-----------------------------------------------------
The ``/policies/NAME`` endpoint has the following methods: ``DELETE`` and ``GET``. These endpoints enables the management of policies as they relate to a specific policy group.

GET
+++++++++++++++++++++++++++++++++++++++++++++++++++++
The ``GET`` method is used to return a policy document.

This method has no parameters.

**Request**

.. code-block:: none

   GET /organizations/NAME/policies/NAME

**Response**

The response is similar to:

.. code-block:: none

   xxxxx

**Response Codes**

.. list-table::
   :widths: 200 300
   :header-rows: 1

   * - Response Code
     - Description
   * - ``200``
     - OK. The request was successful.
   * - ``401``
     - Unauthorized. The user or client who made the request could not be authenticated. Verify the user/client name, and that the correct key was used to sign the request.
   * - ``403``
     - Forbidden. The user who made the request is not authorized to perform the action.
   * - ``404``
     - Not found. The requested object does not exist.

DELETE
+++++++++++++++++++++++++++++++++++++++++++++++++++++
The ``DELETE`` method is used to delete a policy.

This method has no parameters.

**Request**

.. code-block:: none

   DELETE /organizations/NAME/policies/NAME

**Response**

The response returns the policy details and is similar to:

.. code-block:: javascript

   {
     "revisions":
       {
         "37f9b658cdd1d9319bac8920581723efcc2014304b5f3827ee0779e10ffbdcc9": {},
         "95040c199302c85c9ccf1bcc6746968b820b1fa25d92477ea2ec5386cd58b9c5": {},
         "d81e80ae9bb9778e8c4b7652d29b11d2111e763a840d0cadb34b46a8b2ca4347": {}
       }
   }

**Response Codes**

.. list-table::
   :widths: 200 300
   :header-rows: 1

   * - Response Code
     - Description
   * - ``200``
     - OK. The request was successful.
   * - ``401``
     - Unauthorized. The user or client who made the request could not be authenticated. Verify the user/client name, and that the correct key was used to sign the request.
   * - ``403``
     - Forbidden. The user who made the request is not authorized to perform the action.
   * - ``404``
     - Not found. The requested object does not exist.

/policies/NAME/revisions
-----------------------------------------------------
The ``/roles`` endpoint has the following methods: ``POST``.

POST
+++++++++++++++++++++++++++++++++++++++++++++++++++++
The ``POST`` method is used to create a new policy revision.

This method has no parameters.

**Request**

.. code-block:: none

   POST /organizations/NAME/policies/NAME/revisions

with a request body similar to:

.. code-block:: none

   xxxxx

**Response**

The response is similar to:

.. code-block:: none

   xxxxx

**Response Codes**

.. list-table::
   :widths: 200 300
   :header-rows: 1

   * - Response Code
     - Description
   * - ``201``
     - OK. The request was successful.
   * - ``400``
     - Bad request. The contents of the request are not formatted correctly.
   * - ``401``
     - Unauthorized. The user or client who made the request could not be authenticated. Verify the user/client name, and that the correct key was used to sign the request.
   * - ``403``
     - Forbidden. The user who made the request is not authorized to perform the action.
   * - ``409``
     - Conflict. The object already exists.
   * - ``413``
     - Request entity too large. A request may not be larger than 1000000 bytes.

/policies/NAME/revisions/ID
-----------------------------------------------------
The ``/policies/NAME/revisions/ID`` endpoint has the following methods: ``DELETE`` and ``GET``.

GET
+++++++++++++++++++++++++++++++++++++++++++++++++++++
The ``GET`` method is used to return a policy document for a specific policy revision.

This method has no parameters.

**Request**

.. code-block:: none

   GET /organizations/NAME/GROUP/policies/NAME/revisions/ID

**Response**

The response is similar to:

.. code-block:: javascript

   {
     "revision_id": "37f9b658cdd1d9319bac8920581723efcc2014304b5f3827ee0779e10ffbdcc9",
     "name": "aar",
     "run_list": [
       "recipe[aar::default]"
     ],
     "cookbook_locks": {
       "aar": {
         "version": "0.1.0",
         "identifier": "29648fe36333f573d5fe038a53256e23733618aa",
         "dotted_decimal_identifier": "11651043203167221.32604909279531813.121098535835818",
         "source": "cookbooks/aar",
         "cache_key": null,
         "scm_info": {
           "scm": "git",
           "remote": null,
           "revision": "a2c8cbb24a08625921d753cde36e8320465116c3",
           "working_tree_clean": false,
           "published": false,
           "synchronized_remote_branches": []
         },
         "source_options": {
           "path": "cookbooks/aar"
         }
       },
       "apt": {
         "version": "2.7.0",
         "identifier": "16c57abbd056543f7d5a15dabbb03261024a9c5e",
         "dotted_decimal_identifier": "6409580415309396.17870749399956400.55392231660638",
         "cache_key": "apt-2.7.0-supermarket.chef.io",
         "origin": "https://supermarket.chef.io/api/v1/cookbooks/apt/versions/2.7.0/download",
         "source_options": {
           "artifactserver": "https://supermarket.chef.io/api/v1/cookbooks/apt/versions/2.7.0/download",
           "version": "2.7.0"
         }
       }
     },
     "default_attributes": {},
     "override_attributes": {},
     "solution_dependencies": {
       "Policyfile": [
         [
           "aar",
           ">= 0.0.0"
         ],
         [
           "apt",
           "= 2.7.0"
         ],
       ],
       "dependencies": {
         "apt (2.7.0)": [],
         "aar (0.1.0)": [
           [
             "apt",
             ">= 0.0.0"
           ]
         ]
       }
     }
   }

**Response Codes**

.. list-table::
   :widths: 200 300
   :header-rows: 1

   * - Response Code
     - Description
   * - ``200``
     - OK. The request was successful.
   * - ``401``
     - Unauthorized. The user or client who made the request could not be authenticated. Verify the user/client name, and that the correct key was used to sign the request.
   * - ``403``
     - Forbidden. The user who made the request is not authorized to perform the action.
   * - ``404``
     - Not found. The requested object does not exist.

DELETE
+++++++++++++++++++++++++++++++++++++++++++++++++++++
The ``DELETE`` method is used to delete a policy document for a specific policy revision.

This method has no parameters.

**Request**

.. code-block:: none

   DELETE /organizations/NAME/GROUP/policies/NAME/revisions/ID

**Response**

The response returns the policy details and is similar to:

.. code-block:: javascript

   {
     "revision_id": "37f9b658cdd1d9319bac8920581723efcc2014304b5f3827ee0779e10ffbdcc9",
     "name": "aar",
     "run_list": [
       "recipe[aar::default]"
     ],
     "cookbook_locks": {
       "aar": {
         "version": "0.1.0",
         "identifier": "29648fe36333f573d5fe038a53256e23733618aa",
         "dotted_decimal_identifier": "11651043203167221.32604909279531813.121098535835818",
         "source": "cookbooks/aar",
         "cache_key": null,
         "scm_info": {
           "scm": "git",
           "remote": null,
           "revision": "a2c8cbb24a08625921d753cde36e8320465116c3",
           "working_tree_clean": false,
           "published": false,
           "synchronized_remote_branches": []
         },
         "source_options": {
           "path": "cookbooks/aar"
         }
       },
       "apt": {
         "version": "2.7.0",
         "identifier": "16c57abbd056543f7d5a15dabbb03261024a9c5e",
         "dotted_decimal_identifier": "6409580415309396.17870749399956400.55392231660638",
         "cache_key": "apt-2.7.0-supermarket.chef.io",
         "origin": "https://supermarket.chef.io/api/v1/cookbooks/apt/versions/2.7.0/download",
         "source_options": {
           "artifactserver": "https://supermarket.chef.io/api/v1/cookbooks/apt/versions/2.7.0/download",
           "version": "2.7.0"
         }
       }
     },
     "default_attributes": {},
     "override_attributes": {},
     "solution_dependencies": {
       "Policyfile": [
         [
           "aar",
           ">= 0.0.0"
         ],
         [
           "apt",
           "= 2.7.0"
         ],
       ],
       "dependencies": {
         "apt (2.7.0)": [],
         "aar (0.1.0)": [
           [
             "apt",
             ">= 0.0.0"
           ]
         ]
       }
     }
   }

**Response Codes**

.. list-table::
   :widths: 200 300
   :header-rows: 1

   * - Response Code
     - Description
   * - ``200``
     - OK. The request was successful.
   * - ``401``
     - Unauthorized. The user or client who made the request could not be authenticated. Verify the user/client name, and that the correct key was used to sign the request.
   * - ``403``
     - Forbidden. The user who made the request is not authorized to perform the action.
   * - ``404``
     - Not found. The requested object does not exist.

What's New in 12.1
=====================================================
The following items are new for Chef server 12.1:

* **chef-server-ctl key commands use the chef-client Chef::Key object** The key rotation commands (``chef-server-ctl key``) for ``create``, ``delete``, ``edit``, ``list``, and ``show`` keys for users and clients. These were a preview in the Chef server 12.0.3 release, and are now fully integrated.
* **New version headers for Chef Server API** The Chef server API uses the ``X-Ops-Server-API-Version`` header to specify the version of the API that is used as part of a request to the Chef server API.
* **New endpoints for policy and policy files** The Chef server API adds the following endpoints: ``/policies``, ``/policy_groups``, and ``/POLICY_GROUP/policies/POLICY_NAME``.
* **New endpoints for client key management** The Chef server API adds the following endpoints: ``/clients/CLIENT/keys`` and ``/clients/CLIENT/keys/KEY``.
* **New endpoints for user key management** The Chef server API adds the following endpoints: ``/user/USER/keys`` and ``/user/USER/keys/KEY``.
* **New configuration setting** Use the ``estatsd['protocol']`` setting to send application statistics with StatsD protocol formatting.

Key Rotation
-----------------------------------------------------
The ``knife user`` and ``knife client`` subcommands support key rotation. Use the ``create``, ``delete``, ``edit``, ``list``, and ``show`` subcommands to manage keys for users and clients, such as creating multiple expiring keys for a single user and also for basic key management. See /knife_user.html and /knife_client.html for more information about these subcommands.

X-Ops-Server-API-Version
-----------------------------------------------------
.. tag api_chef_server_headers_x_ops_server_api_version

Use ``X-Ops-Server-API-Version`` to specify the version of the Chef server API. For example: ``X-Ops-Server-API-Version: 1``. ``X-Ops-Server-API-Version: 0`` is supported for use with the version 12 Chef server, but will be deprecated as part of the next major release.

.. end_tag

/clients/CLIENT/keys/
-----------------------------------------------------
.. tag api_chef_server_endpoint_keys_clients

The ``/clients/CLIENT/keys`` endpoint has the following methods: ``GET`` and ``POST``.

.. end_tag

GET
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. tag api_chef_server_endpoint_keys_clients_get

The ``GET`` method is used to retrieve all of the named client's key identifiers, associated URIs, and expiry states.

This method has no parameters.

**Request**

.. code-block:: none

   GET /organizations/NAME/clients/CLIENT/keys

**Response**

The response is similar to:

.. code-block:: javascript

   [
     { "name" : "default",
                "uri" : "https://chef.example/organizations/example/clients/client1/keys/default",
                "expired" : false },
     { "name" : "key1",
                "uri" : "https://chef.example/organizations/example/clients/client1/keys/key1",
                "expired" : true }
   ]

**Response Codes**

.. list-table::
   :widths: 200 300
   :header-rows: 1

   * - Response Code
     - Description
   * - ``200``
     - OK. The request was successful.
   * - ``401``
     - Unauthorized. The user or client who made the request could not be authenticated. Verify the user/client name, and that the correct key was used to sign the request.
   * - ``403``
     - Forbidden. The user who made the request is not authorized to perform the action.
   * - ``404``
     - Not found. The requested object does not exist.

.. end_tag

POST
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. tag api_chef_server_endpoint_keys_clients_post

The ``POST`` method is used to add a key for the specified client.

This method has no parameters.

**Request**

.. code-block:: none

   POST /organizations/NAME/clients/CLIENT/keys

with a request body similar to:

.. code-block:: javascript

   {
     "name": "key1",
     "public_key": "-------- BEGIN PUBLIC KEY ----and a valid key here",
     "expiration_date": "infinity"
   }

**Response**

The response is similar to:

.. code-block:: javascript

   {
     "uri": "https://chef.example/organizations/example/clients/client1/keys/key1"
   }

**Response Codes**

.. list-table::
   :widths: 200 300
   :header-rows: 1

   * - Response Code
     - Description
   * - ``201``
     - Created. The object was created.
   * - ``401``
     - Unauthorized. The user or client who made the request could not be authenticated. Verify the user/client name, and that the correct key was used to sign the request.
   * - ``403``
     - Forbidden. The user who made the request is not authorized to perform the action.
   * - ``404``
     - Not found. The requested object does not exist.

.. end_tag

/clients/CLIENT/keys/KEY
-----------------------------------------------------
.. tag api_chef_server_endpoint_key_client

The ``/clients/CLIENT/keys/KEY`` endpoint has the following methods: ``DELETE``, ``GET``, and ``PUT``.

.. end_tag

DELETE
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. tag api_chef_server_endpoint_key_client_delete

The ``DELETE`` method is used to delete the specified key for the specified client.

This method has no parameters.

**Request**

.. code-block:: none

   DELETE /organizations/NAME/clients/CLIENT/keys/KEY

**Response**

The response returns the information about the deleted key and is similar to:

.. code-block:: javascript

   {
     "name" : "default",
     "public_key" : "-------- BEGIN PUBLIC KEY --------- ...",
     "expiration_date" : "2020-12-31T00:00:00Z"
   }

**Response Codes**

.. list-table::
   :widths: 200 300
   :header-rows: 1

   * - Response Code
     - Description
   * - ``200``
     - OK. The request was successful.
   * - ``401``
     - Unauthorized. The user or client who made the request could not be authenticated. Verify the user/client name, and that the correct key was used to sign the request.
   * - ``403``
     - Forbidden. The user who made the request is not authorized to perform the action.
   * - ``404``
     - Not found. The requested object does not exist.

.. end_tag

GET
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. tag api_chef_server_endpoint_key_client_get

The ``GET`` method is used to return details for a specific key for a specific client.

This method has no parameters.

**Request**

.. code-block:: none

   GET /organizations/NAME/clients/CLIENT/keys/KEY

**Response**

The response is similar to:

.. code-block:: javascript

   {
     "name" : "default",
     "public_key" : "-------- BEGIN PUBLIC KEY --------- ...",
     "expiration_date" : "2020-12-31T00:00:00Z"
   }

**Response Codes**

.. list-table::
   :widths: 200 300
   :header-rows: 1

   * - Response Code
     - Description
   * - ``200``
     - OK. The request was successful.
   * - ``401``
     - Unauthorized. The user or client who made the request could not be authenticated. Verify the user/client name, and that the correct key was used to sign the request.
   * - ``403``
     - Forbidden. The user who made the request is not authorized to perform the action.
   * - ``404``
     - Not found. The requested object does not exist.

.. end_tag

PUT
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. tag api_chef_server_endpoint_key_client_put

The ``PUT`` method is used to update one or more properties for a specific key for a specific client.

This method has no parameters.

**Request**

.. code-block:: none

   PUT /organizations/NAME/clients/CLIENT/keys/KEY

with a request body similar to:

.. code-block:: javascript

   {
     "name" : "new_key_name",
     "public_key" : "-------- BEGIN PUBLIC KEY ----and a valid key here",
     "expiration_date" : "2020-12-31T00:00:00Z"
   }

**Response**

The response contains the updated inforamtion for the key, and is similar to:

.. code-block:: javascript

   {
     "name" : "new_key_name",
     "public_key" : "-------- BEGIN PUBLIC KEY --------- ...",
     "expiration_date" : "2020-12-31T00:00:00Z"
   }

**Response Codes**

.. list-table::
   :widths: 200 300
   :header-rows: 1

   * - Response Code
     - Description
   * - ``200``
     - OK. The request was successful.
   * - ``201``
     - Created. The object was created.
   * - ``401``
     - Unauthorized. The user or client who made the request could not be authenticated. Verify the user/client name, and that the correct key was used to sign the request.
   * - ``403``
     - Forbidden. The user who made the request is not authorized to perform the action.
   * - ``404``
     - Not found. The requested object does not exist.

.. end_tag

/user/USER/keys/
-----------------------------------------------------
.. tag api_chef_server_endpoint_keys_users

The ``/users/USER/keys`` endpoint has the following methods: ``GET`` and ``POST``.

.. end_tag

GET
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. tag api_chef_server_endpoint_keys_users_get

The ``GET`` method is used to retrieve all of the named user's key identifiers, associated URIs, and expiry states.

This method has no parameters.

**Request**

.. code-block:: none

   GET /users/USER/keys/

**Response**

The response is similar to:

.. code-block:: javascript

   [
     { "name" : "default",
                "uri" : "https://chef.example/users/USER/keys/default",
                "expired" : false },
     { "name" : "key1",
                "uri" : "https://chef.example/users/USER/keys/key1",
                "expired" : false}
   ]

**Response Codes**

.. list-table::
   :widths: 200 300
   :header-rows: 1

   * - Response Code
     - Description
   * - ``200``
     - OK. The request was successful.
   * - ``401``
     - Unauthorized. The user or client who made the request could not be authenticated. Verify the user/client name, and that the correct key was used to sign the request.
   * - ``403``
     - Forbidden. The user who made the request is not authorized to perform the action.
   * - ``404``
     - Not found. The requested object does not exist.

.. end_tag

POST
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. tag api_chef_server_endpoint_keys_users_post

The ``POST`` method is used to add a key for the specified user.

This method has no parameters.

**Request**

.. code-block:: none

   POST /users/USER/keys/

with a request body similar to:

.. code-block:: javascript

   {
     "name" : "key1",
     "public_key" : "-------- BEGIN PUBLIC KEY ----and a valid key here",
     "expiration_date" : "infinity"
   }

**Response**

The response is similar to:

.. code-block:: javascript

   {
     "uri" : "https://chef.example/users/user1/keys/key1"
   }

**Response Codes**

.. list-table::
   :widths: 200 300
   :header-rows: 1

   * - Response Code
     - Description
   * - ``201``
     - Created. The object was created.
   * - ``401``
     - Unauthorized. The user or client who made the request could not be authenticated. Verify the user/client name, and that the correct key was used to sign the request.
   * - ``403``
     - Forbidden. The user who made the request is not authorized to perform the action.
   * - ``404``
     - Not found. The requested object does not exist.

.. end_tag

/user/USER/keys/KEY
-----------------------------------------------------
.. tag api_chef_server_endpoint_key_user

The ``/users/USER/keys/KEY`` endpoint has the following methods: ``DELETE``, ``GET``, and ``PUT``.

.. end_tag

DELETE
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. tag api_chef_server_endpoint_key_user_delete

The ``DELETE`` method is used to delete the specified key for the specified user.

This method has no parameters.

**Request**

.. code-block:: none

   DELETE /users/USER/keys/KEY

**Response**

The response returns the information about the deleted key and is similar to:

.. code-block:: javascript

   {
     "name" : "default",
     "public_key" : "-------- BEGIN PUBLIC KEY --------- ...",
     "expiration_date" : "2020-12-31T00:00:00Z"
   }

**Response Codes**

.. list-table::
   :widths: 200 300
   :header-rows: 1

   * - Response Code
     - Description
   * - ``200``
     - OK. The request was successful.
   * - ``401``
     - Unauthorized. The user or client who made the request could not be authenticated. Verify the user/client name, and that the correct key was used to sign the request.
   * - ``403``
     - Forbidden. The user who made the request is not authorized to perform the action.
   * - ``404``
     - Not found. The requested object does not exist.

.. end_tag

GET
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. tag api_chef_server_endpoint_key_user_get

The ``GET`` method is used to return details for a specific key for a specific user.

This method has no parameters.

**Request**

.. code-block:: none

   GET /users/USER/keys/KEY

**Response**

The response is similar to:

.. code-block:: javascript

   {
     "name" : "default",
     "public_key" : "-------- BEGIN PUBLIC KEY --------- ...",
     "expiration_date" : "2020-12-31T00:00:00Z"
   }

**Response Codes**

.. list-table::
   :widths: 200 300
   :header-rows: 1

   * - Response Code
     - Description
   * - ``200``
     - OK. The request was successful.
   * - ``401``
     - Unauthorized. The user or client who made the request could not be authenticated. Verify the user/client name, and that the correct key was used to sign the request.
   * - ``403``
     - Forbidden. The user who made the request is not authorized to perform the action.
   * - ``404``
     - Not found. The requested object does not exist.

.. end_tag

PUT
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. tag api_chef_server_endpoint_key_user_put

The ``PUT`` method is used to update one or more properties for a specific key for a specific user.

This method has no parameters.

**Request**

.. code-block:: none

   PUT /users/USER/keys/KEY

with a request body similar to:

.. code-block:: javascript

   {
     "name" : "new_key_name",
     "public_key" : "-------- BEGIN PUBLIC KEY ----and a valid key here",
     "expiration_date" : "2020-12-31T00:00:00Z"
   }

**Response**

The response contains the updated inforamtion for the key, and is similar to:

.. code-block:: javascript

   {
     "name" : "new_key_name",
     "public_key" : "-------- BEGIN PUBLIC KEY --------- ...",
     "expiration_date" : "2020-12-31T00:00:00Z"
   }

**Response Codes**

.. list-table::
   :widths: 200 300
   :header-rows: 1

   * - Response Code
     - Description
   * - ``200``
     - OK. The request was successful.
   * - ``201``
     - Created. The object was created.
   * - ``401``
     - Unauthorized. The user or client who made the request could not be authenticated. Verify the user/client name, and that the correct key was used to sign the request.
   * - ``403``
     - Forbidden. The user who made the request is not authorized to perform the action.
   * - ``404``
     - Not found. The requested object does not exist.

.. end_tag

/policies
-----------------------------------------------------
.. tag api_chef_server_endpoint_policies

The ``/policies`` endpoint has the following methods: ``GET``.

.. end_tag

GET
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. tag api_chef_server_endpoint_policies_get

The ``GET`` method is used to get a list of policies (including policy revisions) from the Chef server.

This method has no parameters.

**Request**

.. code-block:: none

   GET /organizations/NAME/policies

**Response**

The response groups policies by name and revision and is similar to:

.. code-block:: javascript

   {
     "aar": {
       "uri": "https://chef.example/organizations/org1/policies/aar",
       "revisions": {
         "37f9b658cdd1d9319bac8920581723efcc2014304b5f3827ee0779e10ffbdcc9": {
         },
         "95040c199302c85c9ccf1bcc6746968b820b1fa25d92477ea2ec5386cd58b9c5": {
         },
         "d81e80ae9bb9778e8c4b7652d29b11d2111e763a840d0cadb34b46a8b2ca4347": {
         }
       }
     },
     "jenkins": {
       "uri": "https://chef.example/organizations/org1/policies/jenkins",
       "revisions": {
         "613f803bdd035d574df7fa6da525b38df45a74ca82b38b79655efed8a189e073": {
         },
         "6fe753184c8946052d3231bb4212116df28d89a3a5f7ae52832ad408419dd5eb": {
         },
         "cc1a0801e75df1d1ea5b0d2c71ba7d31c539423b81478f65e6388b9ee415ad87": {
         }
       }
     }
   }

**Response Codes**

.. list-table::
   :widths: 200 300
   :header-rows: 1

   * - Response Code
     - Description
   * - ``200``
     - OK. The request was successful.
   * - ``403``
     - Forbidden. The user who made the request is not authorized to perform the action.

.. end_tag

/policy_groups
-----------------------------------------------------
.. tag api_chef_server_endpoint_policy_groups

The ``/policy_groups`` endpoint has the following methods: ``GET``.

.. end_tag

.. tag policy_group_relates_to_nodes

Each node has a 1:many relationship with policy settings stored on the Chef server. This relationship is based on the policy group to which the node is associated, and then the policy settings assigned to that group:

* A policy is typically named after the functional role ahost performs, such as "application server", "chat server", "load balancer", and so on
* A policy group defines a set of hosts in a deployed units, typically mapped to organizational requirements such as "dev", "test", "staging", and "production", but can also be mapped to more detailed requirements as needed

.. end_tag

GET
+++++++++++++++++++++++++++++++++++++++++++++++++++++
The ``GET`` method is used to retrieve all of the policy groups that are stored on the Chef server.

This method has no parameters.

**Request**

.. code-block:: none

   GET /organizations/NAME/policy_groups

**Response**

The response is similar to:

.. code-block:: javascript

   {
     "dev": {
       "uri": "https://chef.example/organizations/org1/policy_groups/dev",
         "policies": {
           "aar": {
             "revision_id": "95040c199302c85c9ccf1bcc6746968b820b1fa25d92477ea2ec5386cd58b9c5"
           },
           "jenkins": {
             "revision_id": "613f803bdd035d574df7fa6da525b38df45a74ca82b38b79655efed8a189e073"
         }
       }
       },
       "production": {
       "uri": "https://chef.example/organizations/org1/policy_groups/production",
         "policies": {
           "aar": {
             "revision_id": "95040c199302c85c9ccf1bcc6746968b820b1fa25d92477ea2ec5386cd58b9c5"
         }
       }
     }
   }

**Response Codes**

.. list-table::
   :widths: 200 300
   :header-rows: 1

   * - Response Code
     - Description
   * - ``200``
     - OK. The request was successful.
   * - ``401``
     - Unauthorized. The user or client who made the request could not be authenticated. Verify the user/client name, and that the correct key was used to sign the request.
   * - ``403``
     - Forbidden. The user who made the request is not authorized to perform the action.
   * - ``404``
     - Not found. The requested object does not exist.

/policies/NAME
-----------------------------------------------------
The ``/policies/NAME`` endpoint has the following methods: ``DELETE``, ``GET``, and ``PUT``. These endpoints enable the management of policies as they relate to a specific policy group.

.. tag policy_group_relates_to_nodes

Each node has a 1:many relationship with policy settings stored on the Chef server. This relationship is based on the policy group to which the node is associated, and then the policy settings assigned to that group:

* A policy is typically named after the functional role ahost performs, such as "application server", "chat server", "load balancer", and so on
* A policy group defines a set of hosts in a deployed units, typically mapped to organizational requirements such as "dev", "test", "staging", and "production", but can also be mapped to more detailed requirements as needed

.. end_tag

Each policy group and individual policy are separate objects for the purposes of authentication. This enables each policy and policy group to have restricted access, such as for specific nodes that handle sensitive data or for specific production groups that require sign-off as part of organizational requirements.

A requestor must have permission to both the policy and the policy group in order for any action to be authorized.

DELETE
+++++++++++++++++++++++++++++++++++++++++++++++++++++
The ``DELETE`` method is used to delete the association between a specific policy document, specific policy group, and specific policy revision. This method does not delete anything from the Chef server.

This method has no parameters.

**Request**

.. code-block:: none

   DELETE /organizations/NAME/GROUP/policies/NAME

**Response**

The response returns the policy details and is similar to:

.. code-block:: javascript

   {
     "revision_id": "37f9b658cdd1d9319bac8920581723efcc2014304b5f3827ee0779e10ffbdcc9",
     "name": "aar",
     "run_list": [
       "recipe[aar::default]"
     ],
     "cookbook_locks": {
       "aar": {
         "version": "0.1.0",
         "identifier": "29648fe36333f573d5fe038a53256e23733618aa",
         "dotted_decimal_identifier": "11651043203167221.32604909279531813.121098535835818",
         "source": "cookbooks/aar",
         "cache_key": null,
         "scm_info": {
           "scm": "git",
           "remote": null,
           "revision": "a2c8cbb24a08625921d753cde36e8320465116c3",
           "working_tree_clean": false,
           "published": false,
           "synchronized_remote_branches": [
           ]
         },
         "source_options": {
           "path": "cookbooks/aar"
         }
       },
       "apt": {
         "version": "2.7.0",
         "identifier": "16c57abbd056543f7d5a15dabbb03261024a9c5e",
         "dotted_decimal_identifier": "6409580415309396.17870749399956400.55392231660638",
         "cache_key": "apt-2.7.0-supermarket.chef.io",
         "origin": "https://supermarket.chef.io/api/v1/cookbooks/apt/versions/2.7.0/download",
         "source_options": {
           "artifactserver": "https://supermarket.chef.io/api/v1/cookbooks/apt/versions/2.7.0/download",
           "version": "2.7.0"
         }
       }
     },
     "default_attributes": {
     },
     "override_attributes": {
     },
     "solution_dependencies": {
       "Policyfile": [
         [
           "aar",
           ">= 0.0.0"
         ],
         [
           "apt",
           "= 2.7.0"
         ],
       ],
       "dependencies": {
         "apt (2.7.0)": [
         ],
         "aar (0.1.0)": [
           [
             "apt",
             ">= 0.0.0"
           ]
         ]
       }
     }
   }

**Response Codes**

.. list-table::
   :widths: 200 300
   :header-rows: 1

   * - Response Code
     - Description
   * - ``200``
     - OK. The request was successful.
   * - ``401``
     - Unauthorized. The user or client who made the request could not be authenticated. Verify the user/client name, and that the correct key was used to sign the request.
   * - ``403``
     - Forbidden. The user who made the request is not authorized to perform the action.
   * - ``404``
     - Not found. The requested object does not exist.

GET
+++++++++++++++++++++++++++++++++++++++++++++++++++++
The ``GET`` method is used to return a policy document for a specific policy group and policy.

This method has no parameters.

**Request**

.. code-block:: none

   GET /organizations/NAME/GROUP/policies/NAME

**Response**

The response is similar to:

.. code-block:: javascript

   {
     "revision_id": "37f9b658cdd1d9319bac8920581723efcc2014304b5f3827ee0779e10ffbdcc9",
     "name": "aar",
     "run_list": [
       "recipe[aar::default]"
     ],
     "cookbook_locks": {
       "aar": {
         "version": "0.1.0",
         "identifier": "29648fe36333f573d5fe038a53256e23733618aa",
         "dotted_decimal_identifier": "11651043203167221.32604909279531813.121098535835818",
         "source": "cookbooks/aar",
         "cache_key": null,
         "scm_info": {
           "scm": "git",
           "remote": null,
           "revision": "a2c8cbb24a08625921d753cde36e8320465116c3",
           "working_tree_clean": false,
           "published": false,
           "synchronized_remote_branches": [
           ]
         },
         "source_options": {
           "path": "cookbooks/aar"
         }
       },
       "apt": {
         "version": "2.7.0",
         "identifier": "16c57abbd056543f7d5a15dabbb03261024a9c5e",
         "dotted_decimal_identifier": "6409580415309396.17870749399956400.55392231660638",
         "cache_key": "apt-2.7.0-supermarket.chef.io",
         "origin": "https://supermarket.chef.io/api/v1/cookbooks/apt/versions/2.7.0/download",
         "source_options": {
           "artifactserver": "https://supermarket.chef.io/api/v1/cookbooks/apt/versions/2.7.0/download",
           "version": "2.7.0"
         }
       }
     },
     "default_attributes": {
     },
     "override_attributes": {
     },
     "solution_dependencies": {
       "Policyfile": [
         [
           "aar",
           ">= 0.0.0"
         ],
         [
           "apt",
           "= 2.7.0"
         ],
       ],
       "dependencies": {
         "apt (2.7.0)": [
         ],
         "aar (0.1.0)": [
           [
             "apt",
             ">= 0.0.0"
           ]
         ]
       }
     }
   }

**Response Codes**

.. list-table::
   :widths: 200 300
   :header-rows: 1

   * - Response Code
     - Description
   * - ``200``
     - OK. The request was successful.
   * - ``401``
     - Unauthorized. The user or client who made the request could not be authenticated. Verify the user/client name, and that the correct key was used to sign the request.
   * - ``403``
     - Forbidden. The user who made the request is not authorized to perform the action.
   * - ``404``
     - Not found. The requested object does not exist.

PUT
+++++++++++++++++++++++++++++++++++++++++++++++++++++
The ``PUT`` method is used to create or update an association between a specific policy document, specific policy group, and specific policy revision.

This method has no parameters.

**Request**

.. code-block:: none

   PUT /organizations/NAME/GROUP/policies/NAME

with a request body similar to:

.. code-block:: javascript

   {
     "revision_id": "37f9b658cdd1d9319bac8920581723efcc2014304b5f3827ee0779e10ffbdcc9",
     "name": "aar",
     "run_list": [
       "recipe[aar::default]"
     ],
     "cookbook_locks": {
       "aar": {
         "version": "0.1.0",
         "identifier": "29648fe36333f573d5fe038a53256e23733618aa",
         "dotted_decimal_identifier": "11651043203167221.32604909279531813.121098535835818",
         "source": "cookbooks/aar",
         "cache_key": null,
         "scm_info": {
           "scm": "git",
           "remote": null,
           "revision": "a2c8cbb24a08625921d753cde36e8320465116c3",
           "working_tree_clean": false,
           "published": false,
           "synchronized_remote_branches": [
           ]
         },
         "source_options": {
           "path": "cookbooks/aar"
         }
       },
       "apt": {
         "version": "2.7.0",
         "identifier": "16c57abbd056543f7d5a15dabbb03261024a9c5e",
         "dotted_decimal_identifier": "6409580415309396.17870749399956400.55392231660638",
         "cache_key": "apt-2.7.0-supermarket.chef.io",
         "origin": "https://supermarket.chef.io/api/v1/cookbooks/apt/versions/2.7.0/download",
         "source_options": {
           "artifactserver": "https://supermarket.chef.io/api/v1/cookbooks/apt/versions/2.7.0/download",
           "version": "2.7.0"
         }
       }
     },
     "default_attributes": {
     },
     "override_attributes": {
     },
     "solution_dependencies": {
       "Policyfile": [
         [
           "aar",
           ">= 0.0.0"
         ],
         [
           "apt",
           "= 2.7.0"
         ],
       ],
       "dependencies": {
         "apt (2.7.0)": [
         ],
         "aar (0.1.0)": [
           [
             "apt",
             ">= 0.0.0"
           ]
         ]
       }
     }
   }

**Response**

The response returns the policy details and is similar to:

.. code-block:: javascript

   {
     "revision_id": "37f9b658cdd1d9319bac8920581723efcc2014304b5f3827ee0779e10ffbdcc9",
     "name": "aar",
     "run_list": [
       "recipe[aar::default]"
     ],
     "cookbook_locks": {
       "aar": {
         "version": "0.1.0",
         "identifier": "29648fe36333f573d5fe038a53256e23733618aa",
         "dotted_decimal_identifier": "11651043203167221.32604909279531813.121098535835818",
         "source": "cookbooks/aar",
         "cache_key": null,
         "scm_info": {
           "scm": "git",
           "remote": null,
           "revision": "a2c8cbb24a08625921d753cde36e8320465116c3",
           "working_tree_clean": false,
           "published": false,
           "synchronized_remote_branches": [
           ]
         },
         "source_options": {
           "path": "cookbooks/aar"
         }
       },
       "apt": {
         "version": "2.7.0",
         "identifier": "16c57abbd056543f7d5a15dabbb03261024a9c5e",
         "dotted_decimal_identifier": "6409580415309396.17870749399956400.55392231660638",
         "cache_key": "apt-2.7.0-supermarket.chef.io",
         "origin": "https://supermarket.chef.io/api/v1/cookbooks/apt/versions/2.7.0/download",
         "source_options": {
           "artifactserver": "https://supermarket.chef.io/api/v1/cookbooks/apt/versions/2.7.0/download",
           "version": "2.7.0"
         }
       }
     },
     "default_attributes": {
     },
     "override_attributes": {
     },
     "solution_dependencies": {
       "Policyfile": [
         [
           "aar",
           ">= 0.0.0"
         ],
         [
           "apt",
           "= 2.7.0"
         ],
       ],
       "dependencies": {
         "apt (2.7.0)": [
         ],
         "aar (0.1.0)": [
           [
             "apt",
             ">= 0.0.0"
           ]
         ]
       }
     }
   }

**Response Codes**

.. list-table::
   :widths: 200 300
   :header-rows: 1

   * - Response Code
     - Description
   * - ``200``
     - OK. The request was successful.
   * - ``201``
     - Created. The object was created.
   * - ``401``
     - Unauthorized. The user or client who made the request could not be authenticated. Verify the user/client name, and that the correct key was used to sign the request.
   * - ``403``
     - Forbidden. The user who made the request is not authorized to perform the action.
   * - ``404``
     - Not found. The requested object does not exist.

New Config Settings
-----------------------------------------------------
The following configuration settings are new for the Chef server:

.. list-table::
   :widths: 200 300
   :header-rows: 1

   * - Setting
     - Description
   * - ``estatsd['protocol']``
     - Use to send application statistics with StatsD protocol formatting. Set this value to ``statsd`` to apply StatsD protocol formatting.

What's New in 12.0
=====================================================
The following items are new for Chef server 12:

* **Upgrades from Open Source Chef and Enterprise Chef servers to Chef 12 server** Upgrades to Chef server 12 are supported from Enterprise Chef 11 high availability and standalone configurations and Open Source Chef 11 standalone configurations. View the topic :doc:`Upgrade to Chef Server 12 </upgrade_server>` for more information about these processes.
* **chef-server.rb configuration file is created by default** Previous versions of the Chef server did not create the chef-server.rb file and users had to create the file first, before updates to tuneable settings could be made.
* **Pluggable high availability architecture** Support for high availability now provides alternatives to DRBD, including using Amazon Web Services (AWS).
* **High availability using Amazon Web Services** Amazon Web Services (AWS) is a supported high availability configuration option for the Chef server. Machines are stored as Amazon Elastic Block Store (EBS) volumes. A passive node monitors the availabilty of the active node, and will take over if required.
* **Chef server replication** Chef replication provides a way to asynchronously distribute cookbook, environment, role, and data bag data from a single, primary Chef server to one (or more) replicas of that Chef server.
* **New chef-server-ctl command line tool** The chef-server-ctl command line tool is an update of the private-chef-ctl command line tool. All of the previous functionality remains, with some new commands added that are specific to Chef server version 12.
* **New command for installing features of the Chef server** The ``install`` subcommand may be used to install Chef management console, Chef push jobs, Chef replication, and Reporting.
* **New commands for managing organizations** New subcommands for the chef-server-ctl command line tool: ``org-user-add``, ``org-create``, ``org-delete``, ``org-user-remove``, ``org-list``, and ``org-show``.
* **New commands for managing users** New subcommands for the chef-server-ctl command line tool: ``user-create``, ``user-delete``, ``user-edit``, ``user-list``, and ``user-show``.
* **New command for log files** Use the ``gather-logs`` command to create a tarball of important log files and system information.
* **Solr has been upgraded to Solr 4** The search capabilities of the Chef server now use Apache Solr 4. The config item for Apache Solr 4 has changed names from opscode-solr to opscode-solr4. Change ``/etc/opscode/chef-server.rb`` accordingly.
* **CouchDB removed** CouchDB is no longer a component of the Chef server. All data is migrated to PostgreSQL.
* **Services removed** The following services have been removed from the Chef server: ``opscode-account``, ``opscode-certificate``, ``oc_authz_migrator``, ``opscode-org-creator``, ``orgmapper``, and ``opscode-webui``. ``opscode-webui`` is replaced by the Chef management console.
* **private-chef.rb is now called chef-server.rb** The name of the configuration file used by the Chef server has been changed. A symlink from private-chef.rb to chef-server.rb is created during upgrades from older versions of the Chef server.
* **New setting for the default organization name** Use the ``default_orgname`` setting to ensure compatibility with Open Source Chef version 11.
* **New settings for oc_chef_authz** The **opscode-authz** service handles authorization requests to the Chef server.
* **Organization policy changes** Users must be removed from the ``admins`` security group before they can be removed from an organization. The chef-client is not granted **Create**, **Delete**, or **Update** permissions to data bags when organizations are created.
* **Administrators cannot be removed from organizations** The Chef server requires that a member of an organization's ``admins`` group cannot be removed from the organization without first being removed from the ``admins`` group.
* **New settings for managing LDAP encryption** New settings that manage LDAP encryption have been added, existing settings have been deprecated.
* **New commands for managing keys** The following commands are new: ``add-client-key``, ``add-user-key``, ``delete-client-key``, ``delete-user-key``, ``list-client-keys``, and ``list-user-keys``. (These are preview commands, new as-of the Chef server 12.0.3 release.)

Upgrade to Chef server 12!
-----------------------------------------------------
Upgrades to Chef server 12 are supported for both Enterprise Chef and Open Source Chef users. See /server/upgrade_server.html for more information about upgrades. If you are upgrading from Open Source Chef, please see /server/upgrade_server_open_source_notes.html as well.

HA using AWS
-----------------------------------------------------
.. tag server_ha_aws

Amazon Web Services (AWS) is a supported high availability configuration option for the Chef server.

.. image:: ../../images/chef_server_ha_aws.svg
   :width: 600px
   :align: center

Backend servers make use of a single Amazon Elastic Block Store (EBS) volume.

For more information about Amazon Elastic Block Store (EBS), see http://aws.amazon.com/ebs/.

.. end_tag

View the topic :doc:`High Availability: AWS </install_server_ha_aws>` for more information about how to set up the Chef server for high availability in Amazon Web Services (AWS).

Chef Replication
-----------------------------------------------------
.. tag server_replication_summary

Chef replication provides a way to asynchronously distribute cookbook, environment, role, and data bag data from a single, primary Chef server to one (or more) replicas of that Chef server.

.. end_tag

**Scenarios**

.. tag server_replication_scenarios

Replication is configured on a per-organization and also a per-replica basis. Each organization must be configured to synchronize with each replica instance. Each organization may be configured to synchronize with all, some, or none of the available replica instances.

For example, a single primary Chef server and a single replica:

.. image:: ../../images/chef_server_replication.png

and for example, a single primary Chef server and multiple replicas:

.. image:: ../../images/chef_server_replication_many.png

Chef replication should not be used for:

* Disaster recovery or backup/restore processes. The replication process is read-only and cannot be changed to read-write
* Synchronizing a replica instance with another replica instance
* Node re-registration. A node may be associated only with a single Chef server

.. end_tag

**How Replication Works**

.. tag server_replication_how_it_works

A daemon named **ec-syncd** runs on each of the replica instances of the Chef server and periodically polls the primary Chef server via the ``updated_since`` endpoint in the Chef server API. The **ec-syncd** daemon requests a list of objects that have been updated since the last successful synchronization time. If there are updates, the **ec-syncd** daemon then pulls down the updated data from the primary Chef server to the replica.

.. image:: ../../images/chef_server_replication_sequence.png

.. end_tag

View the topic :doc:`Chef Replication </server_replication>` for more information about how to set up the Chef server for replication.

chef-server-ctl
-----------------------------------------------------
The command line tool for the Chef server has been renamed from private-chef-ctl to chef-server-ctl. The same set of subcommands available for private-chef-ctl are also available for chef-server-ctl, but with an updated syntax:

.. code-block:: bash

   $ chef-server-ctl command

In addition, the ``install`` subcommand is added, plus two new subcommand groupings---``org-*`` and ``user-*``---have been added for managing organizations and users. See below for more information about these new subcommands.

install Command
-----------------------------------------------------
.. tag ctl_chef_server_install

The ``install`` subcommand is used to install premium features of the Chef server: Chef management console, Chef Analytics, chef-client run reporting, high availability configurations, Chef push jobs, and Chef server replication.

.. end_tag

**Syntax**

.. tag ctl_chef_server_install_syntax

This subcommand has the following syntax:

.. code-block:: bash

   $ chef-server-ctl install name_of_addon (options)

where ``name_of_addon`` represents the command line value associated with the add-on or premium feature.

.. end_tag

**Options**

.. tag ctl_chef_server_install_options

This subcommand has the following options:

``--path PATH``
   Use to specify the location of a package. This option is not required when packages are downloaded from https://packages.chef.io/.

.. end_tag

**Use Downloads**

.. tag ctl_chef_server_install_features_download

The ``install`` subcommand downloads packages from https://packages.chef.io/ by default. For systems that are not behind a firewall (and have connectivity to https://packages.chef.io/), these packages can be installed as described below.

.. list-table::
   :widths: 100 400
   :header-rows: 1

   * - Feature
     - Command
   * - Chef Manage
     - Use Chef management console to manage data bags, attributes, run-lists, roles, environments, and cookbooks from a web user interface.

       On the Chef server, run:

       .. code-block:: bash

          $ chef-server-ctl install chef-manage

       then:

       .. code-block:: bash

          $ chef-server-ctl reconfigure

       and then:

       .. code-block:: bash

          $ chef-manage-ctl reconfigure

       .. note:: .. tag chef_license_reconfigure_manage

                 Starting with the Chef management console 2.3.0, the :doc:`Chef MLSA </chef_license>` must be accepted when reconfiguring the product. If the Chef MLSA has not already been accepted, the reconfigure process will prompt for a ``yes`` to accept it. Or run ``chef-manage-ctl reconfigure --accept-license`` to automatically accept the license.

                 .. end_tag

   * - Chef Push Jobs
     - Use Chef push jobs to run jobs---an action or a command to be executed---against nodes independently of a chef-client run.

       On the Chef server, run:

       .. code-block:: bash

          $ chef-server-ctl install opscode-push-jobs-server

       then:

       .. code-block:: bash

          $ chef-server-ctl reconfigure

       and then:

       .. code-block:: bash

          $ opscode-push-jobs-server-ctl reconfigure

   * - Reporting
     - Use Reporting to keep track of what happens during every chef-client runs across all of the infrastructure being managed by Chef. Run Reporting with Chef management console to view reports from a web user interface.

       On the Chef server, run:

       .. code-block:: bash

          $ chef-server-ctl install opscode-reporting

       then:

       .. code-block:: bash

          $ chef-server-ctl reconfigure

       and then:

       .. code-block:: bash

          $ opscode-reporting-ctl reconfigure

.. end_tag

**Use Local Packages**

.. tag ctl_chef_server_install_features_manual

The ``install`` subcommand downloads packages from https://packages.chef.io/ by default. For systems that are behind a firewall (and may not have connectivity to packages.chef.io), these packages can be downloaded from https://downloads.chef.io/chef-manage/, and then installed manually. First download the package that is appropriate for the platform, save it to a local path, and then run the ``install`` command using the ``--path`` option to specify the directory in which the package is located:

.. code-block:: bash

   $ chef-server-ctl install PACKAGE_NAME --path /path/to/package/directory

For example:

.. code-block:: bash

   $ chef-server-ctl install chef-manage --path /root/packages

The ``chef-server-ctl`` command will install the first ``chef-manage`` package found in the ``/root/packages`` directory.

.. end_tag

gather-logs Command
-----------------------------------------------------
.. tag ctl_chef_server_gather_logs

The ``gather-logs`` subcommand is used to gather the Chef server log files into a tarball that contains all of the important log files and system information.

This subcommand has the following syntax:

.. code-block:: bash

   $ chef-server-ctl gather-logs

.. end_tag

user-* Commands
-----------------------------------------------------
The following subcommands can be used to manage users:

user-create
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. tag ctl_chef_server_user_create

The ``user-create`` subcommand is used to create a user. (The validation key for the organization may be returned to ``STDOUT`` when creating a user with this command.)

.. end_tag

**Syntax**

.. tag ctl_chef_server_user_create_syntax

This subcommand has the following syntax:

.. code-block:: bash

   $ chef-server-ctl user-create USER_NAME FIRST_NAME [MIDDLE_NAME] LAST_NAME EMAIL 'PASSWORD' (options)

.. end_tag

**Options**

.. tag ctl_chef_server_user_create_options

This subcommand has the following options:

``-f FILE_NAME``, ``--filename FILE_NAME``
   Write the USER.pem to a file instead of ``STDOUT``.

.. end_tag

**Examples**

.. code-block:: bash

   $ chef-server-ctl user-create john_smith John Smith john_smith@example.com p@s5w0rD!

.. code-block:: bash

   $ chef-server-ctl user-create jane_doe Jane Doe jane_doe@example.com p@s5w0rD! -f /tmp/jane_doe.key

.. code-block:: bash

   $ chef-server-ctl user-create waldendude Henry David Thoreau waldendude@example.com excursions

user-delete
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. tag ctl_chef_server_user_delete

The ``user-delete`` subcommand is used to delete a user.

.. end_tag

**Syntax**

.. tag ctl_chef_server_user_delete_syntax

This subcommand has the following syntax:

.. code-block:: bash

   $ chef-server-ctl user-delete USER_NAME

.. end_tag

**Examples**

.. code-block:: bash

   $ chef-server-ctl user-delete john_smith

.. code-block:: bash

   $ chef-server-ctl user-delete jane_doe

user-edit
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. tag ctl_chef_server_user_edit

The ``user-edit`` subcommand is used to edit the details for a user. The data will be made available in the $EDITOR for editing.

.. end_tag

**Syntax**

.. tag ctl_chef_server_user_edit_syntax

This subcommand has the following syntax:

.. code-block:: bash

   $ chef-server-ctl user-edit USER_NAME

.. end_tag

**Examples**

.. code-block:: bash

   $ chef-server-ctl user-edit john_smith

.. code-block:: bash

   $ chef-server-ctl user-edit jane_doe

user-list
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. tag ctl_chef_server_user_list

The ``user-list`` subcommand is used to view a list of users.

.. end_tag

**Syntax**

.. tag ctl_chef_server_user_list_syntax

This subcommand has the following syntax:

.. code-block:: bash

   $ chef-server-ctl user-list (options)

.. end_tag

**Options**

.. tag ctl_chef_server_user_list_options

This subcommand has the following options:

``-w``, ``--with-uri``
   Show the corresponding URIs.

.. end_tag

user-show
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. tag ctl_chef_server_user_show

The ``user-show`` subcommand is used to show the details for a user.

.. end_tag

**Syntax**

.. tag ctl_chef_server_user_show_syntax

This subcommand has the following syntax:

.. code-block:: bash

   $ chef-server-ctl user-show USER_NAME (options)

.. end_tag

**Options**

.. tag ctl_chef_server_user_show_options

This subcommand has the following options:

``-l``, ``--with-orgs``
   Show all organizations.

.. end_tag

org-* Commands
-----------------------------------------------------
The following subcommands can be used to manage organizations:

org-create
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. tag ctl_chef_server_org_create

The ``org-create`` subcommand is used to create an organization. (The validation key for the organization is returned to ``STDOUT`` when creating an organization with this command.)

.. end_tag

**Syntax**

.. tag ctl_chef_server_org_create_syntax

This subcommand has the following syntax:

.. code-block:: bash

   $ chef-server-ctl org-create ORG_NAME "ORG_FULL_NAME" (options)

where:

* The name must begin with a lower-case letter or digit, may only contain lower-case letters, digits, hyphens, and underscores, and must be between 1 and 255 characters. For example: ``chef``.
* The full name must begin with a non-white space character and must be between 1 and 1023 characters. For example: ``"Chef Software, Inc."``.

.. end_tag

**Options**

.. tag ctl_chef_server_org_create_options

This subcommand has the following options:

``-a USER_NAME``, ``--association_user USER_NAME``
   Associate a user with an organization and add them to the ``admins`` and ``billing_admins`` security groups.

``-f FILE_NAME``, ``--filename FILE_NAME``
   Write the ORGANIZATION-validator.pem to ``FILE_NAME`` instead of printing it to ``STDOUT``.

.. end_tag

**Examples**

.. code-block:: bash

   $ chef-server-ctl org-create prod Production

.. code-block:: bash

   $ chef-server-ctl org-create staging Staging -a chef-admin

.. code-block:: bash

   $ chef-server-ctl org-create dev Development -f /tmp/id-dev.key

org-delete
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. tag ctl_chef_server_org_delete

The ``org-delete`` subcommand is used to delete an organization.

.. end_tag

**Syntax**

.. tag ctl_chef_server_org_delete_syntax

This subcommand has the following syntax:

.. code-block:: bash

   $ chef-server-ctl org-delete ORG_NAME

.. end_tag

**Examples**

.. code-block:: bash

   $ chef-server-ctl org-delete infra-testing-20140909

.. code-block:: bash

   $ chef-server-ctl org-delete pedant-testing-org

org-list
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. tag ctl_chef_server_org_list

The ``org-list`` subcommand is used to list all of the organizations currently present on the Chef server.

.. end_tag

**Syntax**

.. tag ctl_chef_server_org_list_syntax

This subcommand has the following syntax:

.. code-block:: bash

   $ chef-server-ctl org-list (options)

.. end_tag

**Options**

.. tag ctl_chef_server_org_list_options

This subcommand has the following options:

``-a``, ``--all-orgs``
   Show all organizations.

``-w``, ``--with-uri``
   Show the corresponding URIs.

.. end_tag

org-show
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. tag ctl_chef_server_org_show

The ``org-show`` subcommand is used to show the details for an organization.

.. end_tag

**Syntax**

.. tag ctl_chef_server_org_show_syntax

This subcommand has the following syntax:

.. code-block:: bash

   $ chef-server-ctl org-show ORG_NAME

.. end_tag

org-user-add
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. warning:: Early RC candidates for the Chef server 12 release named this command ``org-associate``. This is the same command, with the exception of the ``--admin`` flag, which is added to the command (along with the rename) for the upcoming final release of Chef server 12.

.. tag ctl_chef_server_org_user_add

The ``org-user-add`` subcommand is used to add a user to an organization.

.. end_tag

**Syntax**

.. tag ctl_chef_server_org_user_add_syntax

This subcommand has the following syntax:

.. code-block:: bash

   $ chef-server-ctl org-user-add ORG_NAME USER_NAME (options)

.. end_tag

**Options**

.. tag ctl_chef_server_org_user_add_options

This subcommand has the following options:

``--admin``
   Add the user to the ``admins`` group.

.. end_tag

**Examples**

.. code-block:: bash

   $ chef-server-ctl org-user-add prod john_smith

.. code-block:: bash

   $ chef-server-ctl org-user-add preprod testmaster

.. code-block:: bash

   $ chef-server-ctl org-user-add dev grantmc --admin

org-user-remove
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. warning:: Early RC candidates for the Chef server 12 release named this command ``org-disociate``. This is the same command, but renamed for the upcoming final release of Chef server 12.

.. tag ctl_chef_server_org_user_remove

The ``org-user-remove`` subcommand is used to remove a user from an organization.

.. end_tag

**Syntax**

.. tag ctl_chef_server_org_user_remove_syntax

This subcommand has the following syntax:

.. code-block:: bash

   $ chef-server-ctl org-user-remove ORG_NAME USER_NAME (options)

.. end_tag

**Examples**

.. code-block:: bash

   $ chef-server-ctl org-user-remove prod john_smith

.. code-block:: bash

   $ chef-server-ctl org-user-remove prod testmaster

Configuration Settings
-----------------------------------------------------
The name of the Chef server configuration file is now chef-server.rb.

The following configuration settings are new for Chef server version 12:

.. list-table::
   :widths: 200 300
   :header-rows: 1

   * - Setting
     - Description
   * - ``default_orgname``
     - The Chef server API used by the Open Source Chef server does not have an ``/organizations/ORG_NAME`` endpoint. Use this setting to ensure that migrated Open Source Chef servers are able to connect to the Chef server API. This value should be the same as the name of the organization that was created during the upgrade from Open Source Chef version 11 to Chef server version 12, which means it will be identical to the ``ORG_NAME`` part of the ``/organizations`` endpoint in Chef server version 12. Default value: the name of the organization specified during the upgrade process from Open Source Chef 11 to Chef server 12.
   * - ``postgresql['log_min_duration_statement']``
     - When to log a slow PostgreSQL query statement. Possible values: ``-1`` (disabled, do not log any statements), ``0`` (log every statement), or an integer greater than zero. When the integer is greater than zero, this value is the amount of time (in milliseconds) that a query statement must have run before it is logged. Default value: ``-1``.

The following configuration settings have updated default values starting with Chef server version 12:

.. list-table::
   :widths: 200 300
   :header-rows: 1

   * - Setting
     - Description
   * - ``api_version``
     - The version of the Chef server. Default value: ``"12.0.0"``.

The following configuration settings are new in Chef server version 12.0.5:

.. list-table::
   :widths: 200 300
   :header-rows: 1

   * - Setting
     - Description
   * - ``opscode_erchef['nginx_bookshelf_caching']``
     - Whether Nginx is used to cache cookbooks. When ``:on``, Nginx serves up the cached content instead of forwarding the request. Default value: ``:off``.
   * - ``opscode_erchef['s3_url_expiry_window_size']``
     - The frequency at which unique URLs are generated. This value may be a specific amount of time, i.e. ``15m`` (fifteen minutes) or a percentage of the value of ``s3_url_ttl``, i.e. ``10%``. Default value: ``:off``.

oc_chef_authz
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. tag server_services_authz

The **opscode-authz** service is used to handle authorization requests to the Chef server.

.. end_tag

.. tag config_rb_server_settings_oc_chef_authz

This configuration file has the following settings for ``oc_chef_authz``:

``oc_chef_authz['http_cull_interval']``
   Default value: ``'{1, min}'``.

``oc_chef_authz['http_init_count']``
   Default value: ``25``.

``oc_chef_authz['http_max_age']``
   Default value: ``'{70, sec}'``.

``oc_chef_authz['http_max_connection_duration']``
   Default value: ``'{70, sec}'``.

``oc_chef_authz['http_max_count']``
   Default value: ``100``.

``oc_chef_authz['ibrowse_options']``
   The amount of time (in milliseconds) to wait for a connection to be established. Default value: ``'[{connect_timeout, 5000}]'``.

.. end_tag

Data Bag Policy Changes
-----------------------------------------------------
In previous versions of the Chef server, the default permissions allowed data bags to be updated by the chef-client during a chef-client run. Starting with Chef server version 12, the chef-client is not granted **Create**, **Delete**, or **Update** permissions to data bags when organizations are created. Use the Chef management console or the ``knife-acl`` plugin (https://github.com/chef/knife-acl) to manage permissions to data bags as required. For example:

.. code-block:: bash

   $ knife acl add containers data update group clients

For cookbooks that create or delete data bags:

.. code-block:: bash

   $ knife acl add containers data create group clients

   $ knife acl add containers data delete group clients

For existing organizations that want to remove the **Create**, **Delete**, or **Update** permissions from existing nodes:

.. code-block:: bash

   $ knife acl remove containers data update group clients

   $ knife acl remove containers data delete group clients

   $ knife acl remove containers data create group clients

See this blog post for more information about the ``knife-acl`` plugin: https://www.chef.io/blog/2014/11/10/security-update-hosted-chef/

New Settings for LDAP
-----------------------------------------------------
The following settings are new:

.. list-table::
   :widths: 200 300
   :header-rows: 1

   * - Setting
     - Description
   * - ``ldap['ssl_enabled']``
     - Use to enable SSL. Default value: ``false``. Must be ``false`` when ``ldap['tls_enabled']`` is ``true``.
   * - ``ldap['tls_enabled']``
     - Use to enable TLS. When enabled, communication with the LDAP server is done via a secure SSL connection on a dedicated port. When ``true``, ``ldap['port']`` is also set to ``636``. Default value: ``false``. Must be ``false`` when ``ldap['ssl_enabled']`` is ``true``.

.. note:: Previous versions of the Chef server used the ``ldap['ssl_enabled']`` setting to first enable SSL, and then the ``ldap['encryption']`` setting to specify the encryption type. These settings are deprecated.

Key Rotation
-----------------------------------------------------
Use the following commands to manage public and private key rotation for users and clients.

add-client-key
-----------------------------------------------------
.. tag ctl_chef_server_add_client_key

Use the ``add-client-key`` subcommand to add a client key.

.. end_tag

**Syntax**

.. tag ctl_chef_server_add_client_key_syntax

This subcommand has the following syntax:

.. code-block:: bash

   $ chef-server-ctl add-client-key ORG_NAME CLIENT_NAME [--public-key-path PATH] [--expiration-date DATE] [--key-name NAME]

.. warning:: All options for this subcommand must follow all arguments.

.. end_tag

**Options**

.. tag ctl_chef_server_add_client_key_options

This subcommand has the following options:

``CLIENT_NAME``
   The name of the client that you wish to add a key for.

``-e DATE`` ``--expiration-date DATE``
   An ISO 8601 formatted string: ``YYYY-MM-DDTHH:MM:SSZ``. For example: ``2013-12-24T21:00:00Z``. If not passed, expiration will default to infinity.

``-k NAME`` ``--key-name NAME``
   String defining the name of your new key for this client. If not passed, it will default to the fingerprint of the public key.

``ORG_NAME``
   The short name for the organization to which the client belongs.

``-p PATH`` ``--public-key-path PATH``
   The location to a file containing valid PKCS#1 public key to be added. If not passed, then the server will generate a new one for you and return the private key to STDOUT.

.. end_tag

add-user-key
-----------------------------------------------------
.. tag ctl_chef_server_add_user_key

Use the ``add-user-key`` subcommand to add a user key.

.. end_tag

**Syntax**

.. tag ctl_chef_server_add_user_key_syntax

This subcommand has the following syntax:

.. code-block:: bash

   $ chef-server-ctl add-user-key USER_NAME [--public-key-path PATH] [--expiration-date DATE] [--key-name NAME]

.. warning:: All options for this subcommand must follow all arguments.

.. end_tag

**Options**

.. tag ctl_chef_server_add_user_key_options

This subcommand has the following options:

``-e DATE`` ``--expiration-date DATE``
   An ISO 8601 formatted string: ``YYYY-MM-DDTHH:MM:SSZ``. For example: ``2013-12-24T21:00:00Z``. If not passed, expiration will default to infinity.

``-k NAME`` ``--key-name NAME``
   String defining the name of your new key for this user. If not passed, it will default to the fingerprint of the public key.

``-p PATH`` ``--public-key-path PATH``
   The location to a file containing valid PKCS#1 public key to be added. If not passed, then the server will generate a new one for you and return the private key to STDOUT.

``USER_NAME``
   The user name for the user for which a key is added.

.. end_tag

delete-client-key
-----------------------------------------------------
.. tag ctl_chef_server_delete_client_key

Use the ``delete-client-key`` subcommand to delete a client key.

.. end_tag

**Syntax**

.. tag ctl_chef_server_delete_client_key_syntax

This subcommand has the following syntax:

.. code-block:: bash

   $ chef-server-ctl delete-client-key ORG_NAME CLIENT_NAME KEY_NAME

.. end_tag

**Options**

.. tag ctl_chef_server_delete_client_key_options

This subcommand has the following arguments:

``ORG_NAME``
   The short name for the organization to which the client belongs.

``CLIENT_NAME``
   The name of the client.

``KEY_NAME``
   The unique name to be assigned to the key you wish to delete.

.. end_tag

delete-user-key
-----------------------------------------------------
.. tag ctl_chef_server_delete_user_key

Use the ``delete-user-key`` subcommand to delete a user key.

.. end_tag

**Syntax**

.. tag ctl_chef_server_delete_user_key_syntax

This subcommand has the following syntax:

.. code-block:: bash

   $ chef-server-ctl delete-user-key USER_NAME KEY_NAME

.. warning:: The parameters for this subcommand must be in the order specified above.

.. end_tag

**Options**

.. tag ctl_chef_server_delete_user_key_options

This subcommand has the following arguments:

``USER_NAME``
   The user name.

``KEY_NAME``
   The unique name to be assigned to the key you wish to delete.

.. end_tag

list-client-key
-----------------------------------------------------
.. tag ctl_chef_server_list_client_keys

Use the ``list-client-keys`` subcommand to list client keys.

.. end_tag

**Syntax**

.. tag ctl_chef_server_list_client_keys_syntax

This subcommand has the following syntax:

.. code-block:: bash

   $ chef-server-ctl list-client-keys ORG_NAME CLIENT_NAME [--verbose]

.. warning::  All options for this subcommand must follow all arguments.

.. end_tag

**Options**

.. tag ctl_chef_server_list_client_keys_options

This subcommand has the following options:

``CLIENT_NAME``
   The name of the client.

``ORG_NAME``
   The short name for the organization to which the client belongs.

``--verbose``
   Use to show the full public key strings in command output.

.. end_tag

list-user-key
-----------------------------------------------------
.. tag ctl_chef_server_list_user_keys

Use the ``list-user-keys`` subcommand to list client keys.

.. end_tag

**Syntax**

.. tag ctl_chef_server_list_user_keys_syntax

This subcommand has the following syntax:

.. code-block:: bash

   $ chef-server-ctl list-user-keys USER_NAME [--verbose]

.. warning:: All options for this subcommand must follow all arguments.

.. end_tag

**Options**

.. tag ctl_chef_server_list_user_keys_options

This subcommand has the following options:

``USER_NAME``
   The user name you wish to list keys for.

``--verbose``
   Use to show the full public key strings in command output.

.. end_tag

**Example**

.. code-block:: bash

   $ chef-server-ctl list-user-keys applejack

Returns:

.. code-block:: bash

   2 total key(s) found for user applejack

   key_name: test-key
   expires_at: Infinity
   public_key:
   -----BEGIN PUBLIC KEY-----
   MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEA4q9Dh+bwJSjhU/VI4Y8s
   9WsbIPfpmBpoZoZVPL7V6JDfIaPUkdcSdZpynhRLhQwv9ScTFh65JwxC7wNhVspB
   4bKZeW6vugNGwCyBIemMfxMlpKZQDOc5dnBiRMMOgXSIimeiFtL+NmMXnGBBHDaE
   b+XXI8oCZRx5MTnzEs90mkaCRSIUlWxOUFzZvnv4jBrhWsd/yBM/h7YmVfmwVAjL
   VST0QG4MnbCjNtbzToMj55NAGwSdKHCzvvpWYkd62ZOquY9f2UZKxYCX0bFPNVQM
   EvBQGdNG39XYSEeF4LneYQKPHEZDdqe7TZdVE8ooU/syxlZgADtvkqEoc4zp1Im3
   2wIDAQAB
   -----END PUBLIC KEY-----

   key_name: default
   expires_at: Infinity
   public_key:
   -----BEGIN PUBLIC KEY-----
   MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEA4q9Dh+bwJSjhU/VI4Y8s
   9WsbIPfpmBpoZoZVPL7V6JDfIaPUkdcSdZpynhRLhQwv9ScTFh65JwxC7wNhVspB
   4bKZeW6vugNGwCyBIemMfxMlpKZQDOc5dnBiRMMOgXSIimeiFtL+NmMXnGBBHDaE
   b+XXI8oCZRx5MTnzEs90mkaCRSIUlWxOUFzZvnv4jBrhWsd/yBM/h7YmVfmwVAjL
   VST0QG4MnbCjNtbzToMj55NAGwSdKHCzvvpWYkd62ZOquY9f2UZKxYCX0bFPNVQM
   EvBQGdNG39XYSEeF4LneYQKPHEZDdqe7TZdVE8ooU/syxlZgADtvkqEoc4zp1Im3
   2wIDAQAB
   -----END PUBLIC KEY-----

Changelog
-----------------------------------------------------
For the list of issues that were addressed for this release, please see the changelog on GitHub: https://github.com/chef/chef-server/blob/master/CHANGELOG.md
