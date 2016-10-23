.. THIS PAGE DOCUMENTS Enterprise Chef server version 11.0

=====================================================
Backup and Restore
=====================================================

Periodic backups of Enterprise Chef data are an essential part of managing and maintaining a healthy configuration and to help ensure that important data can be restored, if required.

High Availability
=====================================================
To configure backups on the backend servers in a high availability configuration, set a cron job in ``/etc/cron.d/opc_snapshot`` similar to the following:

.. code-block:: bash

   # rendered by private-chef-ctl reconfigure, do not modify
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

This data is also essential when any type of backup and restore operation is done for the Enterprise Chef server.

Backup
-----------------------------------------------------
When backing up Enterprise Chef data, be sure that the system is shut down (or otherwise quiet) at the time of the backup. As the ``opscode-pgsql`` user, run the following command:

.. code-block:: bash

   $ /opt/opscode/embedded/bin/pg_dumpall | gzip --fast > postgresql-dump.tgz

and then synchronize to make sure that all of the data is present on-disk:

.. code-block:: bash

   $ sync

Restore
-----------------------------------------------------
When restoring Enterprise Chef  data, the previously backed-up files will be required, along with the Enterprise Chef running only the **postgresql** service. To restore the database, as the ``opscode-pgsql`` user, run the following command:

.. code-block:: bash

   $ gunzip -c postgresql-dump.tgz | tar -xf
      /opt/opscode/embedded/bin/psql -U "opscode-pgsql" -d postgres -f postgresql-dump

and then restore the previously backed-up files to the following locations:

* /etc/opscode 
* /var/opt/opscode
