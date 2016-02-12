.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

.. note:: This section only applies to the |chef server oec| server, version 11.x.

To configure backups on the backend servers in a |ha| configuration, set a |cron| job in ``/etc/cron.d/opc_snapshot`` similar to the following:

.. code-block:: bash

   # Add to /etc/cron.d/opc_snapshot, and then remove comment below MAILTO to activate the cron job
   SHELL=/bin/bash
   HOME=/opt/opscode/bin
   PATH=/usr/bin:/usr/sbin:/bin:/opt/opscode/embedded/bin:/opt/opscode/bin
   MAILTO=SOMEONE@payingattention
   #17 23 * * * root drbd-backups -g opscode -l drbd > /dev/null 2>&1 

A |cron| job similar to the previous example will mount a new snapshot logical volume named::

   /dev/opscode/backup-{+%Y-%m-%d-%H-%M-%S}

where ``{+%Y-%m-%d-%H-%M-%S}`` is a format string for year, month, day, so on.

After the |cron| job has run successfully, the ``mount`` command will show the new logical volume mounted on the ``/var/opt/opscode/drbd-backups`` mount point. The backup script will create a snapshot logical volume in unused space in the ``/opscode`` volume group. After the snapshot is created, the backup script will attempt to mount the snapshot logical volume, after which the snapshot will stay mounted for 24 hours. Upon the next |cron| job run, the backup script will attempt to unmount, destroy the snapshot, and then repeat the sequence.

.. note:: The ``drbd-backups`` script with default settings requires at least 40 GB free space in the ``/opscode`` volume group on the backend servers.
