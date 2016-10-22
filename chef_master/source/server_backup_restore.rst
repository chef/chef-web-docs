=====================================================
Backup and Restore
=====================================================

Periodic backups of Chef server data are an essential part of managing and maintaining a healthy configuration and to help ensure that important data can be restored, if required.

High Availability
=====================================================

.. note:: This section only applies to the Enterprise Chef server, version 11.x.

To configure backups on the backend servers in a high availability configuration, set a cron job in ``/etc/cron.d/opc_snapshot`` similar to the following:

.. code-block:: bash

   # Add to /etc/cron.d/opc_snapshot, and then remove comment below MAILTO to activate the cron job
   SHELL=/bin/bash
   HOME=/opt/opscode/bin
   PATH=/usr/bin:/usr/sbin:/bin:/opt/opscode/embedded/bin:/opt/opscode/bin
   MAILTO=SOMEONE@payingattention
   #17 23 * * * root drbd-backups -g opscode -l drbd > /dev/null 2>&1

A cron job similar to the previous example will mount a new snapshot logical volume named::

   /dev/opscode/backup-{+%Y-%m-%d-%H-%M-%S}

where ``{+%Y-%m-%d-%H-%M-%S}`` is a format string for year, month, day, so on.

After the cron job has run successfully, the ``mount`` command will show the new logical volume mounted on the ``/var/opt/opscode/drbd-backups`` mount point. The backup script will create a snapshot logical volume in unused space in the ``/opscode`` volume group. After the snapshot is created, the backup script will attempt to mount the snapshot logical volume, after which the snapshot will stay mounted for 24 hours. Upon the next cron job run, the backup script will attempt to unmount, destroy the snapshot, and then repeat the sequence.

.. note:: The ``drbd-backups`` script with default settings requires at least 40 GB free space in the ``/opscode`` volume group on the backend servers.

Required Directories
=====================================================

Data stored in the following directories should be backed up periodically:

* /etc/opscode 
* /var/opt/opscode

This data is also essential when any type of backup and restore operation is done for the Chef server.

Backup
-----------------------------------------------------
When backing up Chef server data, be sure that the system is shut down (or otherwise quiet) at the time of the backup.
Perform all activities as root unless otherwise directed.

#. Make a postgres export using the following commands:

    .. code-block:: bash

      export THEDATE=`date '+%Y-%m-%d-%H-%M-%S'`
      sudo -E -u opscode-pgsql bash
      /opt/opscode/embedded/bin/pg_dumpall -c | gzip --fast > /tmp/postgresql-dump-$THEDATE.gz
      Ctrl-d

#. Synchronize to make sure that all of the data is present on-disk:

    .. code-block:: bash

      sync

#. Backup the /etc/opscode and /var/opt/opscode directories and include the postgres export file as root

    .. code-block:: bash

      tar cvfzp var-opt-opscode-$THEDATE.tar.gz /etc/opscode /var/opt/opscode /tmp/postgresql-dump-$THEDATE.gz

Restore
-----------------------------------------------------
When restoring Chef server data, the previously backed-up files will be required, along with the Chef server running only the **postgresql** service. Perform all activities as root unless otherwise directed.

#. Stop the Chef server:

   .. code-block:: bash

      $ chef-server-ctl stop

#. Restore the previously backed-up files to the following locations:

   * ``/etc/opscode`` 
   * ``/var/opt/opscode``

   by using the following command, which will exclude PostgreSQL files:

   .. code-block:: bash

      tar xvfzp var-opt-opscode-$THEDATE.tar.gz --exclude='var/opt/opscode/drbd/data/postgresql_9.2' -C /

#. Start the **postgresql** service:

   .. code-block:: bash

      $ chef-server-ctl start postgresql

#. Restore the PostgreSQL database:

    .. code-block:: bash

      su - opscode-pgsql
      gunzip -c postgresql-dump-$THEDATE.gz | /opt/opscode/embedded/bin/psql -U "opscode-pgsql" -d postgres

    Ignore the following error messages:

    * ``ERROR: current user cannot be dropped``
    * ``ERROR: role "opscode-pgsql" already exists``

#. Reconfigure the Chef server:

   .. code-block:: bash

      $ chef-server-ctl reconfigure

#. Start the Chef server:

   .. code-block:: bash

      $ chef-server-ctl start

#. Reconfigure the Chef management console:

   .. code-block:: bash

      $ opscode-manage-ctl reconfigure

chef-server-ctl
=====================================================
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
* May restore backed up data to any version of the Chef server that supports this command, starting with Chef server 12.2 (which is the first version of the Chef server in which the ``chef-server-ctl restore`` command is available)

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

