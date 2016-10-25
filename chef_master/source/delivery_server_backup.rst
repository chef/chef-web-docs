=====================================================
Chef Automate Backups
=====================================================

Chef Automate provides tools for creating, managing and restoring backup archives and Elasticsearch snapshots.

``delivery-ctl create-backup`` will create a compressed backup archives of the PostgreSQL database, configuration files, user keys, license file, git repository data and RabbitMQ queues. It will also utilize the snapshot capability of Elasticsearch to create snapshots of your Chef Automate Elasticsearch indexes. The backup archives and Elasticsearch snapshots make it possible to take complete backups of a Chef Automate cluster without disrupting service.

``delivery-ctl list-backups`` will list existing backup archives and snapshots in either human or machine readable format.

``delivery-ctl delete-backups`` will delete specific backups or prune the existing backups to specified limits.

``delivery-ctl restore-backup`` will perform full or partial restorations of a backup archive or elasticsearch snapshot.

Configuration
=====================================================

By default the Chef Automate cluster is configured to store near-complete backup archives and snapshots on the local filesystem. When you create backups they will include all Chef Automate data and configuration except for the RabbitMQ queues. This was determined to be a safe choice as the RabbitMQ queues are commonly quite small and require taking the Chef Automate cluster offline in order to back them up. As they are not required to restore a functional Chef Automate cluster the services disruption is rarely worth the value of the RabbitMQ queues.

All backup commands can be configured by changing the default setting in ``/etc/delivery/delivery.rb``. Several configuration options can also be set at runtime by using the appropriate command line switch to pass the configuration option. Configuration options passed via command line flags will always supersede any default configuration.

The Chef Automate `optional settings <config_rb_delivery_optional_settings.html#backup>`__ page contains a full reference of all backup configuration options that are available.

Local Backups
-----------------------------------------------------

Local storage mode is the default configuration for both backup archives and snapshots. Backups are created and exported into the ``/var/opt/delivery/backups`` and ``/var/opt/delivery/elasticsearch_backups`` directories. You can configure the storage locations by setting the ``backup['location']`` and ``backup['elasticsearch']['location']`` options in ``delivery.rb``.

The staging directory is a local directory that will be cleared during backup and used for temporarily storing the backup archive, database dump, and configuration file. When left unconfigured the Ruby temporary directory will be used. The Ruby temporary directory is usually nested in ``/tmp`` on Linux systems will also honor the value of the ``TMPDIR`` environment variable. You can configure the staging directory by using the ``backup['staging_dir']`` setting in ``delivery.rb``.

S3 Backups
-----------------------------------------------------

Using Amazon Web Services (AWS) S3 as a storage location for both Chef Automate backup archives and the Elasticsearch snapshot repository is also supported.

To enable this functionality, first configure the machine with access to the desired S3 bucket using either an instance profile with a valid S3 policy or a standard `shared credentials file <https://docs.aws.amazon.com/cli/latest/userguide/cli-chap-getting-started.html#cli-config-files>`__ located at ``/root/.aws/credentials``.

Below is an example Amazon Web Services (AWS) instance profile policy with the required permissions to create an S3 bucket called ``example-backups``. A policy with these permissions is sufficient for the backup commands to function as expected.

.. code-block:: json

   {
     "Statement": [
       {
         "Action": [
           "s3:CreateBucket",
           "s3:ListBucket",
           "s3:GetBucketLocation",
           "s3:ListBucketMultipartUploads",
           "s3:ListBucketVersions"
         ],
         "Effect": "Allow",
         "Resource": [
           "arn:aws:s3:::example-backups"
         ]
       },
       {
         "Action": [
           "s3:GetObject",
           "s3:PutObject",
           "s3:DeleteObject",
           "s3:AbortMultipartUpload",
           "s3:ListMultipartUploadParts"
         ],
         "Effect": "Allow",
         "Resource": [
           "arn:aws:s3:::example-backups/\*"
         ]
       }
     ],
     "Version": "2012-10-17"
   }

Next, configure Chef Automate to use S3 for both the backups and snapshots. For example:

.. code-block:: ruby

   backup['bucket']                    = 'example-backups'
   backup['region']                    = 'us-west-2'
   backup['type']                      = 's3'
   backup['elasticsearch']['bucket']   = 'example-backups'
   backup['elasticsearch']['region']   = 'us-west-2'
   backup['elasticsearch']['type']     = 's3'

``$ delivery-ctl reconfigure``

.. note:: Using the same bucket for backup archives and snapshots is supported but both must be configured independently.

Backup Cron
-----------------------------------------------------

To enable the backup cron job that will create new backups and prune older backups and snapshots, configure the the following settings in ``delivery.rb``:

.. code-block:: ruby

   backup['cron']['enabled']       = true
   backup['cron']['max_archives']  = 7
   backup['cron']['max_snapshots'] = 7
   backup['cron']['notation']      = "0 0 \* \* \*"

The default ``max_archives``, ``max_snapshots``, and ``notation`` settings will create daily backups and keep the latest 7. Any standard cron notation is supported. If you wish to keep all backups or snapshots you can set both ``max_snapshots`` and/or ``max_archives`` options to ``nil``.

Create Backups
=====================================================

The `create-backup </ctl_delivery_server#create-backup>`__ command is used to create Chef Automate backup archives and Elasticseach snapshots. When used with the default configuration it will create backup archives and Elasticseach snapshots

List Backups
=====================================================

The `list-backups </ctl_delivery_server#list-backups>`__ command is used to list Chef Automate backup archives and Elasticseach snapshots in either human or machine readable outputs.

Delete Backups
=====================================================

The `delete-backups </ctl_delivery_server#delete-backups>`__ command is used to delete Chef Automate backup archives and Elasticseach snapshots. The command matches a given regular expression and prompts the user to confirm deletion of each matched backup or snapshot. It can also be passed maximum archive and snapshot limits and prune the backup repositories to conform to those limits.

Restore Backups
=====================================================

The `restore-backup </ctl_delivery_server#restore-backup>`__ command is used to fully or partially restore a Chef Automate cluster from backup archives and/or Elasticsearch snapshots.

.. note:: Backups created with the older ``delivery-ctl backup-data`` command are not supported with this command. If you wish to restore an older backup please install the version of Chef Automate that took the backup and use ``delivery-ctl restore-data``

Local Backups
-----------------------------------------------------

Follow the process below for an example of restoring a Chef Automate cluster from a local backup archive and a shared filesystem Elasticsearch snapshot:

  1. Copy the Chef Automate backup archive to a directory that is large enough to expand the the archive, e.g.:
       ``scp user@backup-server:2016-10-14-08-38-55-chef-automate-backup.zst /mnt/ephemeral/``
  2. Install the same version of Chef Automate that was used to take the backup. If the versions do not match you be prompted with a compatibility warning but can still proceed with the restore if you choose to do so.
       ``dpkg -i delivery.rpm``
  3. Mount the Elasticsearch shared filesystem to the same mount point.
       ``mount backup-server:/export/chef-automate/elasticsearch_backups /var/opt/delivery/elasticsearch_backups``
  4. Restore the backup archive and snapshot:
       ``$ delivery-ctl restore-backup /mnt/ephemeral/2016-10-14-08-38-55-chef-automate-backup.zst 2016-10-14-08-38-55-chef-automate-backup --staging-dir /mnt/ephemeral/restore``

.. note:: Specifying a staging directory is not mandatatory but when given it will clear **all** existing data from it.

S3 Backups
-----------------------------------------------------

Follow the process below for an example of restoring a Chef Automate cluster from a backup archive and Elasticsearch snapshot in Amazon Web Services (AWS) S3:

  1. Install the same version of Chef Automate that was used to take the backup. If the versions do not match you can still proceed with the restore but we cannot guarantee compatibility.
       ``dpkg -i delivery.rpm``
  2. Restore the backup archive and snapshot by specifying the region, bucket, backup artifact name and snapshot name:
       ``$ delivery-ctl restore-backup us-east-1:your-s3-bucket:2016-10-14-08-38-55-chef-automate-backup.zst 2016-10-14-08-38-55-chef-automate-backup``

Partial Restoration
-----------------------------------------------------

It is possible to restore only specific data from a Chef Automate backup artifact. Below is an example of restoring only the PostgreSQL database and git repositories from a backup archive in S3:

  1. Determine the archive you want to restore
       ``delivery-ctl list-backups --automate``
  2. Restore it
       ``$ delivery-ctl restore-backup us-east-1:your-s3-bucket:2016-10-14-08-38-55-chef-automate-backup.zst --no-census --no-license --no-config``

It is also possible to restore a functional Chef Automate cluster to a specific Elasticsearch snapshot. Below is an example of restoring only an Elasticsearch snapshot:

  1. Determine the snapshot you want to restore
       ``delivery-ctl list-backups --elasticsearch``
  2. Restore it
       ``delivery-ctl restore-backup 2016-10-14-08-38-55-chef-automate-backup``
