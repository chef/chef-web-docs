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

