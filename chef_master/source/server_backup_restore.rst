=====================================================
Backup and Restore
=====================================================

.. include:: ../../includes_server_backup_restore/includes_server_backup_restore.rst

High Availability
=====================================================

.. include:: ../../includes_server_backup_restore/includes_server_backup_restore_ha.rst

Required Directories
=====================================================

.. include:: ../../includes_server_backup_restore/includes_server_backup_restore_locations.rst

Backup
-----------------------------------------------------
.. include:: ../../includes_server_backup_restore/includes_server_backup_restore_locations_backup.rst

Restore
-----------------------------------------------------
.. include:: ../../includes_server_backup_restore/includes_server_backup_restore_locations_restore.rst


chef-server-ctl
=====================================================
Use the following commands to manage backups of |chef server| data, and then to restore those backups.

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

