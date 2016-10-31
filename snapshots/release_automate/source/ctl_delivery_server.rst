


=====================================================
delivery-ctl (executable)
=====================================================

.. include:: ../../includes_chef_automate/includes_chef_automate_mark.rst

.. include:: ../../includes_ctl_delivery_server/includes_ctl_delivery_server.rst

cleanse
=====================================================
.. include:: ../../includes_ctl_delivery_server/includes_ctl_delivery_server_cleanse.rst

create-backup
=====================================================
The ``create-backup`` subcommand is used to create Chef Automate backup archives and Elasticseach snapshots. When used with the default configuration it will create backup archives and Elasticseach snapshots and export them into the ``/var/opt/delivery/backups`` and ``/var/opt/delivery/elasticsearch_backups`` directories.

The storage location of the backup archives and snapshots can be configured by setting ``backup['location']`` and ``backup['elasticsearch']['location']`` in ``delivery.rb``.

.. note:: Under normal operating circumstances the Chef Automate RabbitMQ queues are not likely to be lengthy. When factoring that fact with the requirement of shutting down Chef Automate services in order to take a backup of RabbitMQ, it was determined that it was not ideal to include RabbitMQ data by default.

**Backing up to S3**

While not enabled by default, the utility supports backing up Chef Automate archives and snapshots directly to Amazon Web Services (AWS) S3.

To enable this functionality, first configure the machine with access to the desired S3 bucket using either an instance profile with a valid S3 policy or a standard shared credential file located at ``/root/.aws/credentials``.

Below is an example Amazon Web Services (AWS) instance profile policy with the required permissions:

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

Next, configure Chef Automate to use S3. For example:

.. code-block:: ruby

   backup['bucket']                    = 'example-backups'
   backup['region']                    = 'us-west-2'
   backup['type']                      = 's3'
   backup['elasticsearch']['bucket']   = 'example-backups'
   backup['elasticsearch']['region']   = 'us-west-2'
   backup['elasticsearch']['type']     = 's3'

.. note:: Using the same bucket for backup archives and snapshots is supported but both must be configured independently.

See the complete list of Chef Automate :doc:`configuration options </config_rb_delivery_optional_settings>` for additional backup configuration.

**Syntax**

.. code-block:: bash

   $ delivery-ctl create-backup [NAME] [options]
        --chef-server-config         Backup up the Chef Server config if present
        --force                      Agree to all warnings and prompts
        --name [string]              The output name of the backup
        --no-census                  Do not back up Chef Automate's census data
        --no-config                  Do not back up Chef Automate's configuration directory
        --no-db                      Do not back up Chef Automate's database
        --no-elasticsearch           Do not snapshot Chef Automate's Elasticsearch
        --no-git                     Do not back up Chef Automate's git repositories
        --no-license                 Do not back up Chef Automate's license file
        --no-wait                    Do not wait for non-blocking backup operations
        --quiet                      Do not output non-error information
        --rabbit                     Back up Chef Automate's RabbitMQ queues
        --staging-dir [string]       The path to use for temporary files during backup
    -h, --help                       Show the usage message

.. note:: The ``NAME`` value is optional. If omitted, a default name with the current time will be used.

**Examples**

Complete backup:
  ``$ delivery-ctl create-backup``

Elasticsearch snapshot only:
  ``$ delivery-ctl create-backup --no-census --no-config --no-db --no-license --no-git``

Automate archive only
  ``$ delivery-ctl create-backup --no-elasticsearch``

create-enterprise
=====================================================
.. include:: ../../includes_ctl_delivery_server/includes_ctl_delivery_server_create_enterprise.rst

**Syntax**

.. include:: ../../includes_ctl_delivery_server/includes_ctl_delivery_server_create_enterprise_syntax.rst

create-user
=====================================================
.. include:: ../../includes_ctl_delivery_server/includes_ctl_delivery_server_create_user.rst

**Syntax**

.. include:: ../../includes_ctl_delivery_server/includes_ctl_delivery_server_create_user_syntax.rst

**Example**

.. code-block:: bash

   $ delivery-ctl create-user ENT_NAME john_smith


delete-application
=====================================================
The ``delete-application`` subcommand is used to delete OAuth credentials for the named application.



**Syntax**

This subcommand has the following syntax:

.. code-block:: bash

   $ delivery-ctl delete-application APP_NAME

**Example**

.. code-block:: bash

   $ delivery-ctl delete-application github

returns something similar to:

.. code-block:: bash

   You have successfully deleted the OAuth Application: github

.. code-block:: bash

   $ delivery-ctl delete-application bamboo

returns something similar to:

.. code-block:: bash

   Error: OAuth Application bamboo not found.

delete-backups
=====================================================
The ``delete-backups`` subcommand is used to delete Chef Automate backup archives and Elasticseach snapshots. The command matches a given regular expression and prompts the user to confirm deletion of each matched backup or snapshot.

**Syntax**

.. code-block:: bash

   $ delivery-ctl delete-backups REGEX [options]
        --force                      Agree to all warnings and prompts
    -h, --help                       Show the usage message

**Examples**

Deleting a single Automate backup archive:
  ``$ delivery-ctl delete-backups 2016-10-14-08-38-55-chef-automate-backup.zst``

Deleting a single Elasticsearch snapshot:
  ``$ delivery-ctl delete-backups 2016-10-14-08-38-55-chef-automate-backup$``

Deleting all backup archives and snapshots from October, 2016:
  ``$ delivery-ctl delete-backups 2016-10-.+-chef-automate-backup --force``

delete-enterprise
=====================================================
.. include:: ../../includes_ctl_delivery_server/includes_ctl_delivery_server_delete_enterprise.rst

**Syntax**

.. include:: ../../includes_ctl_delivery_server/includes_ctl_delivery_server_delete_enterprise_syntax.rst

**Example**

.. code-block:: bash

   $ delivery-ctl delete-enterprise pedant-testing-org

delete-project
=====================================================
.. include:: ../../includes_ctl_delivery_server/includes_ctl_delivery_server_delete_project.rst

**Syntax**

.. include:: ../../includes_ctl_delivery_server/includes_ctl_delivery_server_delete_project_syntax.rst

delete-user
=====================================================
.. include:: ../../includes_ctl_delivery_server/includes_ctl_delivery_server_delete_user.rst

**Syntax**

.. include:: ../../includes_ctl_delivery_server/includes_ctl_delivery_server_delete_user_syntax.rst

**Example**

.. code-block:: bash

   $ delivery-ctl delete-user ENT_NAME john_smith

help
=====================================================
.. include:: ../../includes_ctl_delivery_server/includes_ctl_delivery_server_help.rst

list-applications
=====================================================
The ``list-applications`` subcommand lists all applications with OAuth credentials.

**Syntax**

This subcommand has the following syntax:

.. code-block:: bash

   $ delivery-ctl list-applications 

**Example**

.. code-block:: bash

   $ delivery-ctl list-applications

returns something similar to:

.. code-block:: bash

   OAuth Applications:
    github
    github-enterprise


list-backups
=====================================================
The ``list-backups`` subcommand is used to list Chef Automate backup archives and Elasticseach snapshots.

**Syntax**

.. code-block:: bash

   $ delivery-ctl list-backups [options]
        --all                        List all backups and snapshots (default)
        --automate                   Only list Chef Automate's backup archives
        --elasticsearch              Only list Chef Automate's Elasticsearch snapshots
        --format [string]            The output format. 'text' or 'json'
    -h, --help                       Show the usage message

**Examples**

Return a list all backups as JSON:
  ``$ delivery-ctl list-backups --format json``

list-enterprises
=====================================================
.. include:: ../../includes_ctl_delivery_server/includes_ctl_delivery_server_list_enterprise.rst

**Syntax**

.. include:: ../../includes_ctl_delivery_server/includes_ctl_delivery_server_list_enterprise_syntax.rst

list-users
=====================================================
.. include:: ../../includes_ctl_delivery_server/includes_ctl_delivery_server_list_users.rst

**Syntax**

.. include:: ../../includes_ctl_delivery_server/includes_ctl_delivery_server_list_users_syntax.rst

migrate-change-description
=====================================================
.. include:: ../../includes_ctl_delivery_server/includes_ctl_delivery_server_migrate_change_description.rst

**Syntax**

.. include:: ../../includes_ctl_delivery_server/includes_ctl_delivery_server_migrate_change_description_syntax.rst

migrate-change-description-dry-run
=====================================================
.. include:: ../../includes_ctl_delivery_server/includes_ctl_delivery_server_migrate_change_description_dry_run.rst

**Syntax**

.. include:: ../../includes_ctl_delivery_server/includes_ctl_delivery_server_migrate_change_description_dry_run_syntax.rst

migrate-patchset-diffs
=====================================================
.. include:: ../../includes_ctl_delivery_server/includes_ctl_delivery_server_migrate_patchset_diffs.rst

**Syntax**

.. include:: ../../includes_ctl_delivery_server/includes_ctl_delivery_server_migrate_patchset_diffs_syntax.rst

migrate-patchset-diffs-dry-run
=====================================================
.. include:: ../../includes_ctl_delivery_server/includes_ctl_delivery_server_migrate_patchset_diffs_dry_run.rst

**Syntax**

.. include:: ../../includes_ctl_delivery_server/includes_ctl_delivery_server_migrate_patchset_diffs_dry_run_syntax.rst

reconfigure
=====================================================
.. include:: ../../includes_ctl_delivery_server/includes_ctl_delivery_server_reconfigure.rst

rename-enterprise
=====================================================
.. include:: ../../includes_ctl_delivery_server/includes_ctl_delivery_server_rename_enterprise.rst

**Syntax**

.. include:: ../../includes_ctl_delivery_server/includes_ctl_delivery_server_rename_enterprise_syntax.rst

restore-backup
=====================================================
The ``restore-backup`` subcommand is used to restore Chef Automate backup archives and Elasticsearch snapshots.

The command is intended to restore an Automate instance completely from backup, however, it does support restoring only specific data types when given compatible backup archives and snapshots.

.. note:: Backups created with the older ``delivery-ctl backup-data`` command are not supported with this command. If you wish to restore an older backup please install the version of Chef Automate that took the backup and use ``delivery-ctl restore-data``

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

  1. Copy the Chef Automate backup archive to a directory that is large enough to expand the the archive, e.g.:
       ``scp user@backup-server:2016-10-14-08-38-55-chef-automate-backup.zst /mnt/ephemeral/``
  2. Install the same version of Chef Automate that was used to take the backup. If the versions do not match you be prompted with a compatibility warning but can still proceed with the restore if you choose to do so.
       ``dpkg -i delivery.rpm``
  3. Mount the Elasticsearch shared filesystem to the same mount point.
       ``mount backup-server:/export/chef-automate/elasticsearch_backups /var/opt/delivery/elasticsearch_backups``
  4. Restore the backup archive and snapshot:
       ``$ delivery-ctl restore-backup /mnt/ephemeral/2016-10-14-08-38-55-chef-automate-backup.zst 2016-10-14-08-38-55-chef-automate-backup --staging-dir /mnt/ephemeral/restore``

.. note:: Specifying a staging directory is not mandatatory but when given it will clear **all** existing data from it.

Complete restoration with a backup archive and Elasticsearch snapshot in S3:

  1. Install the same version of Chef Automate that was used to take the backup. If the versions do not match you can still proceed with the restore but we cannot guarantee compatibility.
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

revoke-token
=====================================================
.. include:: ../../includes_ctl_delivery_server/includes_ctl_delivery_server_revoke_token.rst

**Syntax**

.. include:: ../../includes_ctl_delivery_server/includes_ctl_delivery_server_revoke_token_syntax.rst

show-config
=====================================================
.. include:: ../../includes_ctl_delivery_server/includes_ctl_delivery_server_show_config.rst

uninstall
=====================================================
.. include:: ../../includes_ctl_delivery_server/includes_ctl_delivery_server_uninstall.rst

update-project-hooks
=====================================================
.. include:: ../../includes_ctl_delivery_server/includes_ctl_delivery_server_update_project_hooks.rst

**Syntax**

.. include:: ../../includes_ctl_delivery_server/includes_ctl_delivery_server_update_project_hooks_syntax.rst


Service Subcommands
=====================================================
.. include:: ../../includes_ctl_common/includes_ctl_common_service_subcommands.rst

graceful-kill
-----------------------------------------------------
.. include:: ../../includes_ctl_delivery_server/includes_ctl_delivery_server_kill_graceful.rst

hup
-----------------------------------------------------
.. include:: ../../includes_ctl_delivery_server/includes_ctl_delivery_server_hup.rst

int
-----------------------------------------------------
.. include:: ../../includes_ctl_delivery_server/includes_ctl_delivery_server_int.rst

kill
-----------------------------------------------------
.. include:: ../../includes_ctl_delivery_server/includes_ctl_delivery_server_kill.rst

once
-----------------------------------------------------
.. include:: ../../includes_ctl_delivery_server/includes_ctl_delivery_server_once.rst

restart
-----------------------------------------------------
.. include:: ../../includes_ctl_delivery_server/includes_ctl_delivery_server_restart.rst

service-list
-----------------------------------------------------
.. include:: ../../includes_ctl_delivery_server/includes_ctl_delivery_server_service_list.rst

start
-----------------------------------------------------
.. include:: ../../includes_ctl_delivery_server/includes_ctl_delivery_server_start.rst

status
-----------------------------------------------------
.. include:: ../../includes_ctl_delivery_server/includes_ctl_delivery_server_status.rst

Log Files
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_ctl_delivery_server/includes_ctl_delivery_server_status_logs.rst

stop
-----------------------------------------------------
.. include:: ../../includes_ctl_delivery_server/includes_ctl_delivery_server_stop.rst

tail
-----------------------------------------------------
.. include:: ../../includes_ctl_delivery_server/includes_ctl_delivery_server_tail.rst

term
-----------------------------------------------------
.. include:: ../../includes_ctl_delivery_server/includes_ctl_delivery_server_term.rst

usr1
-----------------------------------------------------
.. include:: ../../includes_ctl_delivery_server/includes_ctl_delivery_server_usr1.rst

usr2
-----------------------------------------------------
.. include:: ../../includes_ctl_delivery_server/includes_ctl_delivery_server_usr2.rst


