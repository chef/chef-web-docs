=====================================================
Release Notes: |chef server_title| 12.0
=====================================================

.. include:: ../../includes_chef/includes_chef_index.rst

What's New
=====================================================
The following items are new for |chef server| 12:

* **Upgrades from Open Source Chef and Enterprise Chef servers to Chef 12 server** Upgrades to |chef server| 12 are supported from |chef server oec| 11 high availability and standalone configurations and |chef server osc| 11 standalone configurations. View the topic :doc:`Upgrade to Chef Server 12 </upgrade_server>` for more information about these processes.
* **chef-server.rb configuration file is created by default** Previous versions of the |chef server| did not create the |chef server rb| file and users had to create the file first, before updates to tuneable settings could be made.
* **Pluggable high availability architecture** Support for high availability now provides alternatives to |drbd|, including using |amazon aws|.
* **High availability using Amazon Web Services** |amazon aws| is a supported high availability configuration option for the |chef server|. Machines are stored as |amazon ebs| volumes. A passive node monitors the availabilty of the active node, and will take over if required.
* **Chef server replication** |chef replication| provides a way to asynchronously distribute cookbook, environment, role, and data bag data from a single, primary |chef server| to one (or more) replicas of that |chef server|.
* **New chef-server-ctl command line tool** The |chef server ctl| command line tool is an update of the |private chef ctl| command line tool. All of the previous functionality remains, with some new commands added that are specific to |chef server| version 12.
* **New command for installing features of the Chef server** The ``install`` subcommand may be used to install |chef manage|, |push jobs|, |chef replication|, and |reporting|.
* **New commands for managing organizations** New subcommands for the |chef server ctl| command line tool: ``org-user-add``, ``org-create``, ``org-delete``, ``org-user-remove``, ``org-list``, and ``org-show``.
* **New commands for managing users** New subcommands for the |chef server ctl| command line tool: ``user-create``, ``user-delete``, ``user-edit``, ``user-list``, and ``user-show``.
* **New command for log files** Use the ``gather-logs`` command to create a tarball of important log files and system information.
* **Solr has been upgraded to Solr 4** The search capabilities of the |chef server| now use |apache solr| 4. The config item for |apache solr| 4 has changed names from opscode-solr to opscode-solr4. Change ``/etc/opscode/chef-server.rb`` accordingly.
* **CouchDB removed** |couch db| is no longer a component of the |chef server|. All data is migrated to |postgresql|.
* **Services removed** The following services have been removed from the |chef server|: ``opscode-account``, ``opscode-certificate``, ``oc_authz_migrator``, ``opscode-org-creator``, ``orgmapper``, and ``opscode-webui``. ``opscode-webui`` is replaced by the |chef manage|.
* **private-chef.rb is now called chef-server.rb** The name of the configuration file used by the |chef server| has been changed. A symlink from |private chef rb| to |chef server rb| is created during upgrades from older versions of the |chef server|.
* **New setting for the default organization name** Use the ``default_orgname`` setting to ensure compatibility with |chef server osc| version 11.
* **New settings for oc_chef_authz** The |service authz| service handles authorization requests to the |chef server|.
* **Organization policy changes** Users must be removed from the |webui group admins| security group before they can be removed from an organization. The |chef client| is not granted **Create**, **Delete**, or **Update** permissions to data bags when organizations are created.
* **Administrators cannot be removed from organizations** The |chef server| requires that a member of an organization's |webui group admins| group cannot be removed from the organization without first being removed from the |webui group admins| group.
* **New settings for managing LDAP encryption** New settings that manage LDAP encryption have been added, existing settings have been deprecated.
* **New commands for managing keys** The following commands are new: ``add-client-key``, ``add-user-key``, ``delete-client-key``, ``delete-user-key``, ``list-client-keys``, and ``list-user-keys``. (These are preview commands, new as-of the |chef server| 12.0.3 release.)

Upgrade to |chef server| 12!
-----------------------------------------------------
Upgrades to |chef server| 12 are supported for both |chef server oec| and |chef server osc| users. See https://docs.chef.io/server/upgrade_server.html for more information about upgrades. If you are upgrading from |chef server osc|, please see https://docs.chef.io/server/upgrade_server_open_source_notes.html as well.

HA using AWS
-----------------------------------------------------
.. include:: ../../includes_server_ha/includes_server_ha_aws.rst

View the topic :doc:`High Availability: AWS </install_server_ha_aws>` for more information about how to set up the |chef server| for high availability in |amazon aws|.

|chef replication_title|
-----------------------------------------------------
.. include:: ../../includes_server_replication/includes_server_replication.rst

**Scenarios**

.. include:: ../../includes_server_replication/includes_server_replication_scenarios.rst

**How Replication Works**

.. include:: ../../includes_server_replication/includes_server_replication_how_it_works.rst

View the topic :doc:`Chef Replication </server_replication>` for more information about how to set up the |chef server| for replication.

|chef server ctl|
-----------------------------------------------------
The command line tool for the |chef server| has been renamed from |private chef ctl| to |chef server ctl|. The same set of subcommands available for |private chef ctl| are also available for |chef server ctl|, but with an updated syntax:

.. code-block:: bash

   $ chef-server-ctl command

In addition, the ``install`` subcommand is added, plus two new subcommand groupings---``org-*`` and ``user-*``---have been added for managing organizations and users. See below for more information about these new subcommands.

install Command
-----------------------------------------------------
.. include:: ../../includes_ctl_chef_server/includes_ctl_chef_server_install.rst

**Syntax**

.. include:: ../../includes_ctl_chef_server/includes_ctl_chef_server_install_syntax.rst

**Options**

.. include:: ../../includes_ctl_chef_server/includes_ctl_chef_server_install_options.rst

**Use Downloads**

.. include:: ../../includes_ctl_chef_server/includes_ctl_chef_server_install_features_download.rst

**Use Local Packages**

.. include:: ../../includes_ctl_chef_server/includes_ctl_chef_server_install_features_manual.rst

gather-logs Command
-----------------------------------------------------
.. include:: ../../includes_ctl_chef_server/includes_ctl_chef_server_gather_logs.rst

user-* Commands
-----------------------------------------------------
The following subcommands can be used to manage users:

user-create
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_ctl_chef_server/includes_ctl_chef_server_user_create.rst

**Syntax**

.. include:: ../../includes_ctl_chef_server/includes_ctl_chef_server_user_create_syntax.rst

**Options**

.. include:: ../../includes_ctl_chef_server/includes_ctl_chef_server_user_create_options.rst

**Examples**

.. code-block:: bash

   $ chef-server-ctl user-create john_smith John Smith john_smith@example.com p@s5w0rD!

.. code-block:: bash

   $ chef-server-ctl user-create jane_doe Jane Doe jane_doe@example.com p@s5w0rD! -f /tmp/jane_doe.key

.. code-block:: bash

   $ chef-server-ctl user-create waldendude Henry David Thoreau waldendude@example.com excursions

user-delete
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_ctl_chef_server/includes_ctl_chef_server_user_delete.rst

**Syntax**

.. include:: ../../includes_ctl_chef_server/includes_ctl_chef_server_user_delete_syntax.rst

**Examples**

.. code-block:: bash

   $ chef-server-ctl user-delete john_smith

.. code-block:: bash

   $ chef-server-ctl user-delete jane_doe

user-edit
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_ctl_chef_server/includes_ctl_chef_server_user_edit.rst

**Syntax**

.. include:: ../../includes_ctl_chef_server/includes_ctl_chef_server_user_edit_syntax.rst

**Examples**

.. code-block:: bash

   $ chef-server-ctl user-edit john_smith

.. code-block:: bash

   $ chef-server-ctl user-edit jane_doe

user-list
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_ctl_chef_server/includes_ctl_chef_server_user_list.rst

**Syntax**

.. include:: ../../includes_ctl_chef_server/includes_ctl_chef_server_user_list_syntax.rst

**Options**

.. include:: ../../includes_ctl_chef_server/includes_ctl_chef_server_user_list_options.rst

user-show
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_ctl_chef_server/includes_ctl_chef_server_user_show.rst

**Syntax**

.. include:: ../../includes_ctl_chef_server/includes_ctl_chef_server_user_show_syntax.rst

**Options**

.. include:: ../../includes_ctl_chef_server/includes_ctl_chef_server_user_show_options.rst

org-* Commands
-----------------------------------------------------
The following subcommands can be used to manage organizations:

org-create
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_ctl_chef_server/includes_ctl_chef_server_org_create.rst

**Syntax**

.. include:: ../../includes_ctl_chef_server/includes_ctl_chef_server_org_create_syntax.rst

**Options**

.. include:: ../../includes_ctl_chef_server/includes_ctl_chef_server_org_create_options.rst

**Examples**

.. code-block:: bash

   $ chef-server-ctl org-create prod Production

.. code-block:: bash

   $ chef-server-ctl org-create staging Staging -a chef-admin

.. code-block:: bash

   $ chef-server-ctl org-create dev Development -f /tmp/id-dev.key

org-delete
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_ctl_chef_server/includes_ctl_chef_server_org_delete.rst

**Syntax**

.. include:: ../../includes_ctl_chef_server/includes_ctl_chef_server_org_delete_syntax.rst

**Examples**

.. code-block:: bash

   $ chef-server-ctl org-delete infra-testing-20140909

.. code-block:: bash
      
   $ chef-server-ctl org-delete pedant-testing-org

org-list
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_ctl_chef_server/includes_ctl_chef_server_org_list.rst

**Syntax**

.. include:: ../../includes_ctl_chef_server/includes_ctl_chef_server_org_list_syntax.rst

**Options**

.. include:: ../../includes_ctl_chef_server/includes_ctl_chef_server_org_list_options.rst

org-show
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_ctl_chef_server/includes_ctl_chef_server_org_show.rst

**Syntax**

.. include:: ../../includes_ctl_chef_server/includes_ctl_chef_server_org_show_syntax.rst

org-user-add
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. warning:: Early RC candidates for the |chef server| 12 release named this command ``org-associate``. This is the same command, with the exception of the ``--admin`` flag, which is added to the command (along with the rename) for the upcoming final release of |chef server| 12.

.. include:: ../../includes_ctl_chef_server/includes_ctl_chef_server_org_user_add.rst

**Syntax**

.. include:: ../../includes_ctl_chef_server/includes_ctl_chef_server_org_user_add_syntax.rst

**Options**

.. include:: ../../includes_ctl_chef_server/includes_ctl_chef_server_org_user_add_options.rst

**Examples**

.. code-block:: bash

   $ chef-server-ctl org-user-add prod john_smith

.. code-block:: bash

   $ chef-server-ctl org-user-add preprod testmaster

.. code-block:: bash

   $ chef-server-ctl org-user-add dev grantmc --admin


org-user-remove
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. warning:: Early RC candidates for the |chef server| 12 release named this command ``org-disociate``. This is the same command, but renamed for the upcoming final release of |chef server| 12.

.. include:: ../../includes_ctl_chef_server/includes_ctl_chef_server_org_user_remove.rst

**Syntax**

.. include:: ../../includes_ctl_chef_server/includes_ctl_chef_server_org_user_remove_syntax.rst

**Examples**

.. code-block:: bash

   $ chef-server-ctl org-user-remove prod john_smith

.. code-block:: bash

   $ chef-server-ctl org-user-remove prod testmaster


Configuration Settings
-----------------------------------------------------
The name of the |chef server| configuration file is now |chef server rb|.

The following configuration settings are new for |chef server| version 12:

.. list-table::
   :widths: 200 300
   :header-rows: 1

   * - Setting
     - Description
   * - ``default_orgname``
     - |default_orgname|
   * - ``postgresql['log_min_duration_statement']``
     - |log_rotation min_duration| Possible values: ``-1`` (disabled, do not log any statements), ``0`` (log every statement), or an integer greater than zero. When the integer is greater than zero, this value is the amount of time (in milliseconds) that a query statement must have run before it is logged. Default value: ``-1``.

The following configuration settings have updated default values starting with |chef server| version 12:

.. list-table::
   :widths: 200 300
   :header-rows: 1

   * - Setting
     - Description
   * - ``api_version``
     - |version chef_server| Default value: ``"12.0.0"``.

The following configuration settings are new in |chef server| version 12.0.5:

.. list-table::
   :widths: 200 300
   :header-rows: 1

   * - Setting
     - Description
   * - ``opscode_erchef['nginx_bookshelf_caching']``
     - |nginx bookshelf_caching| Default value: ``:off``.
   * - ``opscode_erchef['s3_url_expiry_window_size']``
     - |s3_url_expiry_window_size| Default value: ``:off``.

oc_chef_authz
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_server_services/includes_server_services_authz.rst

.. include:: ../../includes_config/includes_config_rb_server_settings_oc_chef_authz.rst


Data Bag Policy Changes
-----------------------------------------------------
In previous versions of the |chef server|, the default permissions allowed data bags to be updated by the |chef client| during a |chef client| run. Starting with |chef server| version 12, the |chef client| is not granted **Create**, **Delete**, or **Update** permissions to data bags when organizations are created. Use the |chef manage| or the ``knife-acl`` plugin (https://github.com/chef/knife-acl) to manage permissions to data bags as required. For example:

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
     - Use to enable |ssl|. Default value: ``false``. Must be ``false`` when ``ldap['tls_enabled']`` is ``true``.
   * - ``ldap['tls_enabled']``
     - Use to enable TLS. When enabled, communication with the |ldap| server is done via a secure |ssl| connection on a dedicated port. When ``true``, ``ldap['port']`` is also set to ``636``. Default value: ``false``. Must be ``false`` when ``ldap['ssl_enabled']`` is ``true``.

.. note:: Previous versions of the |chef server| used the ``ldap['ssl_enabled']`` setting to first enable |ssl|, and then the ``ldap['encryption']`` setting to specify the encryption type. These settings are deprecated.


Key Rotation
=====================================================
Use the following commands to manage public and private key rotation for users and clients.

add-client-key
-----------------------------------------------------
.. include:: ../../includes_ctl_chef_server/includes_ctl_chef_server_add_client_key.rst

.. warning:: This subcommand is a preview command available in the |chef server| 12.0.3 release.

**Syntax**

.. include:: ../../includes_ctl_chef_server/includes_ctl_chef_server_add_client_key_syntax.rst

**Options**

.. include:: ../../includes_ctl_chef_server/includes_ctl_chef_server_add_client_key_options.rst

add-user-key
-----------------------------------------------------
.. include:: ../../includes_ctl_chef_server/includes_ctl_chef_server_add_user_key.rst

.. warning:: This subcommand is a preview command available in the |chef server| 12.0.3 release.

**Syntax**

.. include:: ../../includes_ctl_chef_server/includes_ctl_chef_server_add_user_key_syntax.rst

**Options**

.. include:: ../../includes_ctl_chef_server/includes_ctl_chef_server_add_user_key_options.rst

delete-client-key
-----------------------------------------------------
.. include:: ../../includes_ctl_chef_server/includes_ctl_chef_server_delete_client_key.rst

.. warning:: This subcommand is a preview command available in the |chef server| 12.0.3 release.

**Syntax**

.. include:: ../../includes_ctl_chef_server/includes_ctl_chef_server_delete_client_key_syntax.rst

**Options**

.. include:: ../../includes_ctl_chef_server/includes_ctl_chef_server_delete_client_key_options.rst

delete-user-key
-----------------------------------------------------
.. include:: ../../includes_ctl_chef_server/includes_ctl_chef_server_delete_user_key.rst

.. warning:: This subcommand is a preview command available in the |chef server| 12.0.3 release.

**Syntax**

.. include:: ../../includes_ctl_chef_server/includes_ctl_chef_server_delete_user_key_syntax.rst

**Options**

.. include:: ../../includes_ctl_chef_server/includes_ctl_chef_server_delete_user_key_options.rst

list-client-key
-----------------------------------------------------
.. include:: ../../includes_ctl_chef_server/includes_ctl_chef_server_list_client_keys.rst

.. warning:: This subcommand is a preview command available in the |chef server| 12.0.3 release.

**Syntax**

.. include:: ../../includes_ctl_chef_server/includes_ctl_chef_server_list_client_keys_syntax.rst

**Options**

.. include:: ../../includes_ctl_chef_server/includes_ctl_chef_server_list_client_keys_options.rst

list-user-key
-----------------------------------------------------
.. include:: ../../includes_ctl_chef_server/includes_ctl_chef_server_list_user_keys.rst

.. warning:: This subcommand is a preview command available in the |chef server| 12.0.3 release.

**Syntax**

.. include:: ../../includes_ctl_chef_server/includes_ctl_chef_server_list_user_keys_syntax.rst

**Options**

.. include:: ../../includes_ctl_chef_server/includes_ctl_chef_server_list_user_keys_options.rst

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


What's Fixed
=====================================================
For the list of issues that were addressed for this release, please see the changelog on |github|: https://github.com/chef/chef-server/blob/master/CHANGELOG.md
