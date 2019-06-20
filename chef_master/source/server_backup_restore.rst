=====================================================
Backup and Restore a Standalone or Frontend install
=====================================================
`[edit on GitHub] <https://github.com/chef/chef-web-docs/blob/master/chef_master/source/server_backup_restore.rst>`__

Periodic backups of Chef Infra Server data are an essential part of managing and maintaining a healthy configuration and ensuring that important data can be restored, if required.

chef-server-ctl
=====================================================
For the majority of use cases, ``chef-server-ctl backup`` is the recommended way to take backups of the Chef Infra Server. Use the following commands for managing backups of Chef Infra Server data, and for restoring those backups.

.. note :: Starting in Chef Server 12.10.0, a bug in the ``backup`` command produced backups that did not include the configuration data in the resulting tarball. This bug is now resolved. We recommend taking a new backup after upgrading to 12.12.0.

backup
-----------------------------------------------------
.. tag ctl_chef_server_backup

The ``backup`` subcommand is used to back up all Chef Infra Server data. This subcommand:

* Requires rsync to be installed on the Chef Infra Server prior to running the command
* Requires a ``chef-server-ctl reconfigure`` prior to running the command
* Should not be run in a Chef Infra Server configuration with an external PostgreSQL database; `use knife ec backup <https://github.com/chef/knife-ec-backup>`__ instead
* Puts the initial backup in the ``/var/opt/chef-backup`` directory as a tar.gz file; move this backup to a new location for safe keeping

.. end_tag

**Options**

.. tag ctl_chef_server_backup_options

This subcommand has the following options:

``-y``, ``--yes``
   Use to specify if the Chef Infra Server can go offline during tar.gz-based backups.

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

The ``restore`` subcommand is used to restore Chef Infra Server data from a backup that was created by the ``backup`` subcommand. This subcommand may also be used to add Chef Infra Server data to a newly-installed server. This subcommand:

* Requires rsync to be installed on the Chef Infra Server prior to running the command
* Requires a ``chef-server-ctl reconfigure`` prior to running the command
* Should not be run in a Chef Infra Server configuration with an external PostgreSQL database; `use knife ec backup <https://github.com/chef/knife-ec-backup>`__ instead

.. note :: The ``restore`` command does not support transferring backups across different versions of Chef Infra Server. Backups taken with the ``backup`` command must restore to the same version of Chef Infra Server that was in use when they were created.

.. end_tag

**Options**

.. tag ctl_chef_server_restore_options

This subcommand has the following options:

``-c``, ``--cleanse``
   Use to remove all existing data on the Chef Infra Server; it will be replaced by the data in the backup archive.

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

Backup and restore a Chef Backend install
=====================================================

In a disaster recovery scenario, the backup and restore processes allow you to restore a data backup
into a newly built cluster. It is not intended for the recovery of an individual machine in the
chef-backend cluster or for a point-in-time rollback of an existing cluster.

Backup
-----------------------------------------------------

Restoring your data in the case of an emergency depends on having previously made backups of:

- the data in your Chef Backend cluster
- the configuration from your Chef server

To make backups for future use in disaster scenarios:

1. On a follower chef-backend node, run ``chef-backend-ctl backup``
2. On a chef-server node run: ``chef-server-ctl backup --config-only``
3. Move the tar archives created in steps (1) and (2) to a long-term storage location.

Restore
-----------------------------------------------------

To restore a Chef Backend-based Chef Infra Server cluster:

1. Restore the node and an IP address that can be used to reach the node on the first machine that you want to use in your new Chef Backend cluster. The argument to the ``--publish_address`` option should be the IP address for reaching the node you are restoring.

   .. code-block:: bash

      chef-backend-ctl restore --publish_address X.Y.Z.W /path/to/backup.tar.gz

2. Join additional nodes to your Chef Backend cluster. (If you are only testing and verifying your restore process you can test against a single Chef Backend node and a single Chef Infra Server node.)

   .. code-block:: bash

      chef-backend-ctl join-cluster IP_OF_FIRST_NODE --publish_address IP_OF_THIS_NODE

3. Restore a chef-server from your backed up chef-server configuration (See step 2 in the backup instructions above). Alternatively, you can generate new configuration for this node and reconfigure it using the steps found in `the installation instructions. </install_server_ha.html#step-5-install-and-configure-first-frontend>`_.

   .. code-block:: bash

      chef-server-ctl restore /path/to/chef-server-backup.tar.gz

4. Run the reindex command to re-populate your search index

   .. code-block:: bash

      chef-server-ctl reindex --all

Verify
-----------------------------------------------------

We recommend periodically verifying your backup by restoring a single Chef Backend node, a single Chef Infra Server node, and ensuring that various knife commands and Chef Infra Client runs can successfully complete against your backup.
