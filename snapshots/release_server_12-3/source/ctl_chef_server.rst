.. THIS PAGE DOCUMENTS Chef server version 12.3

=====================================================
chef-server-ctl (executable)
=====================================================

.. include:: ../../includes_ctl_chef_server/includes_ctl_chef_server.rst


Backup / Restore
=====================================================
Use the following commands to manage backups of Chef server data, and then to restore those backups.

backup
-----------------------------------------------------
.. include:: ../../includes_ctl_chef_server/includes_ctl_chef_server_backup.rst

**Options**

.. include:: ../../includes_ctl_chef_server/includes_ctl_chef_server_backup_options.rst

**Syntax**

.. include:: ../../includes_ctl_chef_server/includes_ctl_chef_server_backup_syntax.rst

restore
-----------------------------------------------------
.. include:: ../../includes_ctl_chef_server/includes_ctl_chef_server_restore.rst

**Options**

.. include:: ../../includes_ctl_chef_server/includes_ctl_chef_server_restore_options.rst

**Syntax**

.. include:: ../../includes_ctl_chef_server/includes_ctl_chef_server_restore_syntax.rst

**Examples**

.. code-block:: bash

   $ chef-server-ctl restore /path/to/tar/archive.tar.gz


backup-recover
=====================================================
.. include:: ../../includes_ctl_chef_server/includes_ctl_chef_server_backup_recover.rst


cleanse
=====================================================
.. include:: ../../includes_ctl_chef_server/includes_ctl_chef_server_cleanse.rst

**Options**

.. include:: ../../includes_ctl_chef_server/includes_ctl_chef_server_cleanse_options.rst

**Syntax**

.. include:: ../../includes_ctl_chef_server/includes_ctl_chef_server_cleanse_syntax.rst


gather-logs
=====================================================
.. include:: ../../includes_ctl_chef_server/includes_ctl_chef_server_gather_logs.rst


ha-status
=====================================================
.. include:: ../../includes_ctl_chef_server/includes_ctl_chef_server_ha_status.rst


help
=====================================================
.. include:: ../../includes_ctl_chef_server/includes_ctl_chef_server_help.rst


install
=====================================================
.. include:: ../../includes_ctl_chef_server/includes_ctl_chef_server_install.rst

.. warning:: .. include:: ../../includes_chef_license/includes_chef_license_note_12-5.rst

**Syntax**

.. include:: ../../includes_ctl_chef_server/includes_ctl_chef_server_install_syntax.rst

**Options**

.. include:: ../../includes_ctl_chef_server/includes_ctl_chef_server_install_options.rst

Use Downloads
-----------------------------------------------------
.. include:: ../../includes_ctl_chef_server/includes_ctl_chef_server_install_features_download.rst

Use Local Packages
-----------------------------------------------------
.. include:: ../../includes_ctl_chef_server/includes_ctl_chef_server_install_features_manual.rst


Key Rotation
=====================================================
Use the following commands to manage public and private key rotation for users and clients.

add-client-key
-----------------------------------------------------
.. include:: ../../includes_ctl_chef_server/includes_ctl_chef_server_add_client_key.rst

**Syntax**

.. include:: ../../includes_ctl_chef_server/includes_ctl_chef_server_add_client_key_syntax.rst

**Options**

.. include:: ../../includes_ctl_chef_server/includes_ctl_chef_server_add_client_key_options.rst

add-user-key
-----------------------------------------------------
.. include:: ../../includes_ctl_chef_server/includes_ctl_chef_server_add_user_key.rst

**Syntax**

.. include:: ../../includes_ctl_chef_server/includes_ctl_chef_server_add_user_key_syntax.rst

**Options**

.. include:: ../../includes_ctl_chef_server/includes_ctl_chef_server_add_user_key_options.rst

delete-client-key
-----------------------------------------------------
.. include:: ../../includes_ctl_chef_server/includes_ctl_chef_server_delete_client_key.rst

**Syntax**

.. include:: ../../includes_ctl_chef_server/includes_ctl_chef_server_delete_client_key_syntax.rst

**Options**

.. include:: ../../includes_ctl_chef_server/includes_ctl_chef_server_delete_client_key_options.rst

delete-user-key
-----------------------------------------------------
.. include:: ../../includes_ctl_chef_server/includes_ctl_chef_server_delete_user_key.rst

**Syntax**

.. include:: ../../includes_ctl_chef_server/includes_ctl_chef_server_delete_user_key_syntax.rst

**Options**

.. include:: ../../includes_ctl_chef_server/includes_ctl_chef_server_delete_user_key_options.rst

list-client-keys
-----------------------------------------------------
.. include:: ../../includes_ctl_chef_server/includes_ctl_chef_server_list_client_keys.rst

**Syntax**

.. include:: ../../includes_ctl_chef_server/includes_ctl_chef_server_list_client_keys_syntax.rst

**Options**

.. include:: ../../includes_ctl_chef_server/includes_ctl_chef_server_list_client_keys_options.rst

list-user-keys
-----------------------------------------------------
.. include:: ../../includes_ctl_chef_server/includes_ctl_chef_server_list_user_keys.rst

**Syntax**

.. include:: ../../includes_ctl_chef_server/includes_ctl_chef_server_list_user_keys_syntax.rst

**Options**

.. include:: ../../includes_ctl_chef_server/includes_ctl_chef_server_list_user_keys_options.rst

**Example**

.. include:: ../../step_ctl_chef_server/step_ctl_chef_server_list_user_keys.rst


master-recover
=====================================================
.. include:: ../../includes_ctl_chef_server/includes_ctl_chef_server_master_recover.rst

Organization Management
=====================================================
.. include:: ../../includes_ctl_chef_server/includes_ctl_chef_server_org.rst

org-create
-----------------------------------------------------
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

.. code-block:: bash

   $ chef-server-ctl org-create dev Development --association_user grantmc


org-delete
-----------------------------------------------------
.. include:: ../../includes_ctl_chef_server/includes_ctl_chef_server_org_delete.rst

**Syntax**

.. include:: ../../includes_ctl_chef_server/includes_ctl_chef_server_org_delete_syntax.rst

**Examples**

.. code-block:: bash

   $ chef-server-ctl org-delete infra-testing-20140909

.. code-block:: bash

   $ chef-server-ctl org-delete pedant-testing-org


org-list
-----------------------------------------------------
.. include:: ../../includes_ctl_chef_server/includes_ctl_chef_server_org_list.rst

**Syntax**

.. include:: ../../includes_ctl_chef_server/includes_ctl_chef_server_org_list_syntax.rst

**Options**

.. include:: ../../includes_ctl_chef_server/includes_ctl_chef_server_org_list_options.rst


org-show
-----------------------------------------------------
.. include:: ../../includes_ctl_chef_server/includes_ctl_chef_server_org_show.rst

**Syntax**

.. include:: ../../includes_ctl_chef_server/includes_ctl_chef_server_org_show_syntax.rst


org-user-add
-----------------------------------------------------
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
-----------------------------------------------------
.. include:: ../../includes_ctl_chef_server/includes_ctl_chef_server_org_user_remove.rst

.. warning:: .. include:: ../../step_knife/step_knife_edit_admin_users.rst

**Syntax**

.. include:: ../../includes_ctl_chef_server/includes_ctl_chef_server_org_user_remove_syntax.rst

**Options**

.. include:: ../../includes_ctl_chef_server/includes_ctl_chef_server_org_user_remove_options.rst

**Examples**

.. code-block:: bash

   $ chef-server-ctl org-user-remove prod john_smith

.. code-block:: bash

   $ chef-server-ctl org-user-remove prod testmaster

.. code-block:: bash

   $ chef-server-ctl org-user-remove grantmc --force


password
=====================================================
.. include:: ../../includes_ctl_chef_server/includes_ctl_chef_server_password.rst

psql
=====================================================
.. include:: ../../includes_ctl_chef_server/includes_ctl_chef_server_psql.rst

**Syntax**

.. include:: ../../includes_ctl_chef_server/includes_ctl_chef_server_psql_syntax.rst

**Options**

.. include:: ../../includes_ctl_chef_server/includes_ctl_chef_server_psql_options.rst

reconfigure
=====================================================
.. include:: ../../includes_ctl_chef_server/includes_ctl_chef_server_reconfigure.rst


reindex
=====================================================
.. include:: ../../includes_ctl_chef_server/includes_ctl_chef_server_reindex.rst

**Options**

.. include:: ../../includes_ctl_chef_server/includes_ctl_chef_server_reindex_options.rst

show-config
=====================================================
.. include:: ../../includes_ctl_chef_server/includes_ctl_chef_server_show_config.rst

..
..
.. Uncomment when https://github.com/chef/chef-server/issues/35 is available.
..
.. show-versions
.. =====================================================
.. .. warning:: This command will be added to the Chef server in an upcoming release.
..
.. .. include:: ../../includes_ctl_chef_server/includes_ctl_chef_server_show-versions.rst
..
..


uninstall
=====================================================
.. include:: ../../includes_ctl_chef_server/includes_ctl_chef_server_uninstall.rst


upgrade
=====================================================
.. include:: ../../includes_ctl_chef_server/includes_ctl_chef_server_upgrade.rst

**Syntax**

.. include:: ../../includes_ctl_chef_server/includes_ctl_chef_server_upgrade_syntax.rst

**Options**

.. note:: Options for the ``upgrade`` subcommand may only be used when upgrading from Open Source Chef 11 to Chef server 12.

.. include:: ../../includes_ctl_chef_server/includes_ctl_chef_server_upgrade_options.rst

User Management
=====================================================
.. include:: ../../includes_ctl_chef_server/includes_ctl_chef_server_user.rst

user-create
-----------------------------------------------------
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
-----------------------------------------------------
.. include:: ../../includes_ctl_chef_server/includes_ctl_chef_server_user_delete.rst

**Syntax**

.. include:: ../../includes_ctl_chef_server/includes_ctl_chef_server_user_delete_syntax.rst

**Examples**

.. code-block:: bash

   $ chef-server-ctl user-delete john_smith

.. code-block:: bash

   $ chef-server-ctl user-delete jane_doe


user-edit
-----------------------------------------------------
.. include:: ../../includes_ctl_chef_server/includes_ctl_chef_server_user_edit.rst

**Syntax**

.. include:: ../../includes_ctl_chef_server/includes_ctl_chef_server_user_edit_syntax.rst

**Examples**

.. code-block:: bash

   $ chef-server-ctl user-edit john_smith

.. code-block:: bash

   $ chef-server-ctl user-edit jane_doe


user-list
-----------------------------------------------------
.. include:: ../../includes_ctl_chef_server/includes_ctl_chef_server_user_list.rst

**Syntax**

.. include:: ../../includes_ctl_chef_server/includes_ctl_chef_server_user_list_syntax.rst

**Options**

.. include:: ../../includes_ctl_chef_server/includes_ctl_chef_server_user_list_options.rst


user-show
-----------------------------------------------------
.. include:: ../../includes_ctl_chef_server/includes_ctl_chef_server_user_show.rst

**Syntax**

.. include:: ../../includes_ctl_chef_server/includes_ctl_chef_server_user_show_syntax.rst

**Options**

.. include:: ../../includes_ctl_chef_server/includes_ctl_chef_server_user_show_options.rst


Service Subcommands
=====================================================
.. include:: ../../includes_ctl_common/includes_ctl_common_service_subcommands.rst

.. warning:: The following commands are disabled when an external PostgreSQL database is configured for the Chef server: ``hup``, ``int``, ``kill``, ``once``, ``restart``, ``start``, ``stop``, ``tail``, and ``term``.

hup
-----------------------------------------------------
.. include:: ../../includes_ctl_chef_server/includes_ctl_chef_server_hup.rst

int
-----------------------------------------------------
.. include:: ../../includes_ctl_chef_server/includes_ctl_chef_server_int.rst

kill
-----------------------------------------------------
.. include:: ../../includes_ctl_chef_server/includes_ctl_chef_server_kill.rst

once
-----------------------------------------------------
.. include:: ../../includes_ctl_chef_server/includes_ctl_chef_server_once.rst

restart
-----------------------------------------------------
.. include:: ../../includes_ctl_chef_server/includes_ctl_chef_server_restart.rst

service-list
-----------------------------------------------------
.. include:: ../../includes_ctl_chef_server/includes_ctl_chef_server_service_list.rst

start
-----------------------------------------------------
.. include:: ../../includes_ctl_chef_server/includes_ctl_chef_server_start.rst

status
-----------------------------------------------------
.. include:: ../../includes_ctl_chef_server/includes_ctl_chef_server_status.rst

High Availability
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_ctl_chef_server/includes_ctl_chef_server_status_ha.rst

Log Files
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_ctl_chef_server/includes_ctl_chef_server_status_logs.rst

stop
-----------------------------------------------------
.. include:: ../../includes_ctl_chef_server/includes_ctl_chef_server_stop.rst

tail
-----------------------------------------------------
.. include:: ../../includes_ctl_chef_server/includes_ctl_chef_server_tail.rst

term
-----------------------------------------------------
.. include:: ../../includes_ctl_chef_server/includes_ctl_chef_server_term.rst
