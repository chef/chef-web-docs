.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


The ``restore-backup`` subcommand is used to restore |delivery| backup archives and Elasticsearch snapshots.

The command is intended to restore an Automate instance completely from backup, however, it does support restoring only specific data types when given compatible backup archives and snapshots.

.. note:: Backups created with the older ``delivery-ctl backup-data`` command are not supported with this command. If you wish to restore an older backup please install the version of |delivery| that took the backup and use ``delivery-ctl restore-data``

**Syntax**

.. code-block:: bash

   $ delivery-ctl restore-backup /path/to/chef-automate-backup.zst [ELASTICSEARCH_SNAPSHOT] [options]
   $ delivery-ctl restore-backup us-east-1:s3_bucket:chef-automate-backup.zst [ELASTICSEARCH_SNAPSHOT] [options]
   $ delivery-ctl restore-backup ELASTICSEARCH_SNAPSHOT [options]
        --force                      Agree to all warnings and prompts
        --no-chef-server-config      Do not restore the Chef Server config if present
        --no-census                  Do not restore Chef Automate's census data
        --no-config                  Do not restore Chef Automate's configuration directory
        --no-db                      Do not restore Chef Automate's database
        --no-git                     Do not restore Chef Automate's git repositories
        --no-license                 Do not restore Chef Automate's license file
        --quiet                      Do not output non-error information
        --no-rabbit                  Do not restore Chef Automate's RabbitMQ data
        --staging-dir [string]       The path to use for temporary files during restore
        --no-wait                    Do not wait for non-blocking restore operations
    -h, --help                       Show the usage message

.. note:: The ``ELASTICSEARCH_SNAPSHOT`` value is optional when given a backup archive path.

**Examples**

Complete restoration of a local backup archive and shared filesystem Elasticsearch snapshot:

  1. Copy the |delivery| backup archive to a directory that is large enough to expand the the archive, e.g.:
       ``scp user@backup-server:2016-10-14-08-38-55-chef-automate-backup.zst /mnt/ephemeral/``
  2. Install the same version of |delivery| that was used to take the backup. If the versions do not match you be prompted with a compatibility warning but can still proceed with the restore if you choose to do so.
       ``dpkg -i delivery.rpm``
  3. Mount the Elasticsearch shared filesystem to the same mount point.
       ``mount backup-server:/export/chef-automate/elasticsearch_backups /var/opt/delivery/elasticsearch_backups``
  4. Restore the backup archive and snapshot:
       ``$ delivery-ctl restore-backup /mnt/ephemeral/2016-10-14-08-38-55-chef-automate-backup.zst 2016-10-14-08-38-55-chef-automate-backup --staging-dir /mnt/ephemeral/restore``

.. note:: Specifying a staging directory is not mandatatory but when given it will clear **all** existing data from it.

Complete restoration with a backup archive and Elasticsearch snapshot in S3:

  1. Install the same version of |delivery| that was used to take the backup. If the versions do not match you can still proceed with the restore but we cannot guarantee compatibility.
       ``dpkg -i delivery.rpm``
  2. Restore the backup archive and snapshot:
       ``$ delivery-ctl restore-backup us-east-1:your-s3-bucket:2016-10-14-08-38-55-chef-automate-backup.zst 2016-10-14-08-38-55-chef-automate-backup``

Restore only an Elasticsearch snapshot:

  1. Determine the snapshot you want to restore
       ``delivery-ctl list-backups --elasticsearch``
  2. Restore it
       ``delivery-ctl restore-backup 2016-10-14-08-38-55-chef-automate-backup``

Restore only database and git repositories from an archive in S3:

  1. Determine the archive you want to restore
       ``delivery-ctl list-backups --automate``
  2. Restore it
       ``$ delivery-ctl restore-backup us-east-1:your-s3-bucket:2016-10-14-08-38-55-chef-automate-backup.zst --no-census --no-license --no-config``
