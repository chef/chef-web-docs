

=====================================================
delivery-ctl (executable)
=====================================================

.. tag chef_automate_mark

.. image:: ../../images/chef_automate_full.png
   :width: 40px
   :height: 17px

.. end_tag

.. tag ctl_delivery_server_1

The Chef Automate server includes a command-line utility named delivery-ctl. Use this command-line tool to:

* Manage enterprises, users, and projects
* Reconfigure the Chef Automate server
* Start and stop individual services
* Tail Chef Automate server log files

.. note:: All commands must be run as ``sudo``.

.. end_tag

cleanse
=====================================================
.. tag ctl_delivery_server_cleanse

The ``cleanse`` subcommand is used to re-set the Chef Automate server to the state it was in prior to the first time the ``reconfigure`` subcommand is run. This command will:

* Destroy all data and logs
* Create a backup of the system config files and place them in a directory in root, such as ``/root/delivery-cleanse-2015-12-15T15:51``

The software that was put on-disk by the package installation will remain. Re-run ``delivery-ctl reconfigure`` to recreate the default data and configuration files.

This subcommand has the following syntax:

.. code-block:: bash

   $ delivery-ctl cleanse

.. end_tag

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
.. tag ctl_delivery_server_create_enterprise

The ``create-enterprise`` subcommand is used to create a Chef Automate enterprise. A public key is required.

.. end_tag

**Syntax**

.. tag ctl_delivery_server_create_enterprise_syntax

This subcommand has the following syntax:

.. code-block:: bash

   $ delivery-ctl create-enterprise ENT_NAME --ssh-pub-key-file=FILE_NAME

.. note:: The ``ENT_NAME`` value must be alphanumeric.

.. end_tag

create-user
=====================================================
.. tag ctl_delivery_server_create_user

The ``create-user`` subcommand is used to create a user. (The validation key for the organization may be returned to ``STDOUT`` when creating a user with this command.)

.. end_tag

**Syntax**

.. tag ctl_delivery_server_create_user_syntax

This subcommand has the following syntax:

.. code-block:: bash

   $ delivery-ctl create-user ENT_NAME USER_NAME FIRST_NAME [MIDDLE_NAME] LAST_NAME EMAIL PASSWORD SSH_PUBLIC_KEY

.. end_tag

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
.. tag ctl_delivery_server_delete_enterprise

The ``delete-enterprise`` subcommand is used to delete a Chef Automate enterprise.

.. end_tag

**Syntax**

.. tag ctl_delivery_server_delete_enterprise_syntax

This subcommand has the following syntax:

.. code-block:: bash

   $ delivery-ctl delete-enterprise ENT_NAME

.. end_tag

**Example**

.. code-block:: bash

   $ delivery-ctl delete-enterprise pedant-testing-org

delete-project
=====================================================
.. tag ctl_delivery_server_delete_project

The ``delete-project`` subcommand is used to delete a Chef Automate project.

.. end_tag

**Syntax**

.. tag ctl_delivery_server_delete_project_syntax

This subcommand has the following syntax:

.. code-block:: bash

   $ delivery-ctl delete-project ENT_NAME ORG_NAME PROJECT_NAME

.. end_tag

delete-user
=====================================================
.. tag ctl_delivery_server_delete_user

The ``delete-user`` subcommand is used to delete a user.

.. end_tag

**Syntax**

.. tag ctl_delivery_server_delete_user_syntax

This subcommand has the following syntax:

.. code-block:: bash

   $ delivery-ctl delete-user ENT_NAME USER_NAME

.. end_tag

**Example**

.. code-block:: bash

   $ delivery-ctl delete-user ENT_NAME john_smith

help
=====================================================
.. tag ctl_delivery_server_help

The ``help`` subcommand is used to print a list of all available ``delivery-ctl`` commands.

This subcommand has the following syntax:

.. code-block:: bash

   $ delivery-ctl help

.. end_tag

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
.. tag ctl_delivery_server_list_enterprise

The ``list-enterprises`` subcommand is used to list all of the enterprises currently present on the Chef Automate server.

.. end_tag

**Syntax**

.. tag ctl_delivery_server_list_enterprise_syntax

This subcommand has the following syntax:

.. code-block:: bash

   $ delivery-ctl list-enterprises

.. end_tag

list-users
=====================================================
.. tag ctl_delivery_server_list_users

The ``list-users`` subcommand is used to view a list of users.

.. end_tag

**Syntax**

.. tag ctl_delivery_server_list_users_syntax

This subcommand has the following syntax:

.. code-block:: bash

   $ delivery-ctl list-users ENT_NAME

.. end_tag

migrate-change-description
=====================================================
.. tag ctl_delivery_server_migrate_change_description

The ``migrate-change-description`` subcommand is used to migrate the change description live run.

.. end_tag

**Syntax**

.. tag ctl_delivery_server_migrate_change_description_syntax

This subcommand has the following syntax:

.. code-block:: bash

   $ delivery-ctl migrate-change-description ENT_NAME ORG_NAME PROJECT_NAME CHANGE

.. end_tag

migrate-change-description-dry-run
=====================================================
.. tag ctl_delivery_server_migrate_change_description_dry_run

The ``migrate-change-description-dry-run`` subcommand is used to execute a dry run migration of the change description.

.. end_tag

**Syntax**

.. tag ctl_delivery_server_migrate_change_description_dry_run_syntax

This subcommand has the following syntax:

.. code-block:: bash

   $ delivery-ctl migrate-change-description-dry-run ENT_NAME ORG_NAME PROJECT_NAME CHANGE

.. end_tag

migrate-patchset-diffs
=====================================================
.. tag ctl_delivery_server_migrate_patchset_diffs

The ``migrate-patchset-diffs`` subcommand is used to update patchset diffs to include numstat.

.. end_tag

**Syntax**

.. tag ctl_delivery_server_migrate_patchset_diffs_syntax

This subcommand has the following syntax:

.. code-block:: bash

   $ delivery-ctl migrate-patchset-diffs ENT_NAME ORG_NAME PROJECT_NAME PATCHSET_DIFF

.. end_tag

migrate-patchset-diffs-dry-run
=====================================================
.. tag ctl_delivery_server_migrate_patchset_diffs_dry_run

The ``migrate-patchset-diffs-dry-run`` subcommand is used to execute a dry run update of patchset diffs to include numstat.

.. end_tag

**Syntax**

.. tag ctl_delivery_server_migrate_patchset_diffs_dry_run_syntax

This subcommand has the following syntax:

.. code-block:: bash

   $ delivery-ctl migrate-patchset-diffs-dry-run ENT_NAME ORG_NAME PROJECT_NAME PATCHSET_DIFF

.. end_tag

reconfigure
=====================================================
.. tag ctl_delivery_server_reconfigure

The ``reconfigure`` subcommand is used to reconfigure the Chef Automate server after changes are made to the delivery configuration file, located at ``/etc/delivery/delivery.rb``. When changes are made to the delivery configuration file, they are not applied to the Chef Automate configuration until after this command is run. This subcommand also restarts any services for which the ``service_name['enabled']`` setting is set to ``true``.

This subcommand has the following syntax:

.. code-block:: bash

   $ delivery-ctl reconfigure

.. end_tag

rename-enterprise
=====================================================
.. tag ctl_delivery_server_rename_enterprise

The ``rename-enterprise`` subcommand is used to rename an existing Chef Automate enterprise.

.. end_tag

**Syntax**

.. tag ctl_delivery_server_rename_enterprise_syntax

This subcommand has the following syntax:

.. code-block:: bash

   $ delivery-ctl rename-enterprise CURRENT_ENT_NAME NEW_ENT_NAME

.. end_tag

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
.. tag ctl_delivery_server_revoke_token

The ``revoke-token`` subcommand is used to revoke a user's token.

.. end_tag

**Syntax**

.. tag ctl_delivery_server_revoke_token_syntax

This subcommand has the following syntax:

.. code-block:: bash

   $ delivery-ctl revoke-token ENT_NAME USER_NAME

.. end_tag

show-config
=====================================================
.. tag ctl_delivery_server_show_config

The ``show-config`` subcommand is used to view the configuration that will be generated by the ``reconfigure`` subcommand. This command is most useful in the early stages of a deployment to ensure that everything is built properly prior to installation.

This subcommand has the following syntax:

.. code-block:: bash

   $ delivery-ctl show-config

.. end_tag

uninstall
=====================================================
.. tag ctl_delivery_server_uninstall

The ``uninstall`` subcommand is used to remove the Chef Automate application, but without removing any of the data. This subcommand will shut down all services (including the ``runit`` process supervisor).

This subcommand has the following syntax:

.. code-block:: bash

   $ delivery-ctl uninstall

.. note:: To revert the ``uninstall`` subcommand, run the ``reconfigure`` subcommand (because the ``start`` subcommand is disabled by the ``uninstall`` command).

.. end_tag

update-project-hooks
=====================================================
.. tag ctl_delivery_server_update_project_hooks

The ``update-project-hooks`` subcommand is used to update git hooks for all projects.

.. end_tag

**Syntax**

.. tag ctl_delivery_server_update_project_hooks_syntax

This subcommand has the following syntax:

.. code-block:: bash

   $ delivery-ctl update-project-hooks ENT_NAME ORG_NAME PROJECT_NAME

.. end_tag

Service Subcommands
=====================================================
.. tag ctl_common_service_subcommands

This command has a built in process supervisor that ensures all of the required services are in the appropriate state at any given time. The supervisor starts two processes per service and provides the following subcommands for managing services: ``hup``, ``int``, ``kill``, ``once``, ``restart``, ``service-list``, ``start``, ``status``, ``stop``, ``tail``, and ``term``.

.. end_tag

graceful-kill
-----------------------------------------------------
.. tag ctl_delivery_server_kill_graceful

The ``kill`` subcommand is used to send a ``SIGKILL`` to all services. This command can also be run for an individual service by specifying the name of the service in the command.

This subcommand has the following syntax:

.. code-block:: bash

   $ delivery-ctl kill name_of_service

where ``name_of_service`` represents the name of any service that is listed after running the ``service-list`` subcommand.

.. end_tag

hup
-----------------------------------------------------
.. tag ctl_delivery_server_hup

The ``hup`` subcommand is used to send a ``SIGHUP`` to all services. This command can also be run for an individual service by specifying the name of the service in the command.

This subcommand has the following syntax:

.. code-block:: bash

   $ delivery-ctl hup name_of_service

where ``name_of_service`` represents the name of any service that is listed after running the ``service-list`` subcommand.

.. end_tag

int
-----------------------------------------------------
.. tag ctl_delivery_server_int

The ``int`` subcommand is used to send a ``SIGINT`` to all services. This command can also be run for an individual service by specifying the name of the service in the command.

This subcommand has the following syntax:

.. code-block:: bash

   $ delivery-ctl int name_of_service

where ``name_of_service`` represents the name of any service that is listed after running the ``service-list`` subcommand.

.. end_tag

kill
-----------------------------------------------------
.. tag ctl_delivery_server_kill

The ``kill`` subcommand is used to send a ``SIGKILL`` to all services. This command can also be run for an individual service by specifying the name of the service in the command.

This subcommand has the following syntax:

.. code-block:: bash

   $ delivery-ctl kill name_of_service

where ``name_of_service`` represents the name of any service that is listed after running the ``service-list`` subcommand.

.. end_tag

once
-----------------------------------------------------
.. tag ctl_delivery_server_once

The supervisor for the Chef Automate server is configured to restart any service that fails, unless that service has been asked to change its state. The ``once`` subcommand is used to tell the supervisor to not attempt to restart any service that fails.

This command is useful when troubleshooting configuration errors that prevent a service from starting. Run the ``once`` subcommand followed by the ``status`` subcommand to look for services in a down state and/or to identify which services are in trouble. This command can also be run for an individual service by specifying the name of the service in the command.

This subcommand has the following syntax:

.. code-block:: bash

   $ delivery-ctl once name_of_service

where ``name_of_service`` represents the name of any service that is listed after running the ``service-list`` subcommand.

.. end_tag

restart
-----------------------------------------------------
.. tag ctl_delivery_server_restart

The ``restart`` subcommand is used to restart all services enabled on the Chef Automate server or to restart an individual service by specifying the name of that service in the command.

This subcommand has the following syntax:

.. code-block:: bash

   $ delivery-ctl restart name_of_service

where ``name_of_service`` represents the name of any service that is listed after running the ``service-list`` subcommand. When a service is successfully restarted the output should be similar to:

.. code-block:: bash

   $ ok: run: service_name: (pid 12345) 1s

.. end_tag

service-list
-----------------------------------------------------
.. tag ctl_delivery_server_service_list

The ``service-list`` subcommand is used to display a list of all available services. A service that is enabled is labeled with an asterisk (*).

This subcommand has the following syntax:

.. code-block:: bash

   $ delivery-ctl service-list

.. end_tag

start
-----------------------------------------------------
.. tag ctl_delivery_server_start

The ``start`` subcommand is used to start all services that are enabled in the Chef Automate server. This command can also be run for an individual service by specifying the name of the service in the command.

This subcommand has the following syntax:

.. code-block:: bash

   $ delivery-ctl start name_of_service

where ``name_of_service`` represents the name of any service that is listed after running the ``service-list`` subcommand. When a service is successfully started the output should be similar to:

.. code-block:: bash

   $ ok: run: service_name: (pid 12345) 1s

The supervisor for the Chef Automate server is configured to wait seven seconds for a service to respond to a command from the supervisor. If you see output that references a timeout, it means that a signal has been sent to the process, but that the process has yet to actually comply. In general, processes that have timed out are not a big concern, unless they are failing to respond to the signals at all. If a process is not responding, use a command like the ``kill`` subcommand to stop the process, investigate the cause (if required), and then use the ``start`` subcommand to re-enable it.

.. end_tag

status
-----------------------------------------------------
.. tag ctl_delivery_server_status

The ``status`` subcommand is used to show the status of all services available to the Chef Automate server. The results will vary based on the configuration of a given server. This subcommand has the following syntax:

.. code-block:: bash

   $ delivery-ctl status

and will return the status for all services. Status can be returned for individual services by specifying the name of the service as part of the command:

.. code-block:: bash

   $ delivery-ctl status name_of_service

where ``name_of_service`` represents the name of any service that is listed after running the ``service-list`` subcommand.

When service status is requested, the output should be similar to:

.. code-block:: bash

   $ run: service_name: (pid 12345) 12345s; run: log: (pid 1234) 67890s

where

* ``run:`` is the state of the service (``run:`` or ``down:``)
* ``service_name:`` is the name of the service for which status is returned
* ``(pid 12345)`` is the process identifier
* ``12345s`` is the uptime of the service, in seconds

For example:

.. code-block:: bash

   $ down: opscode-erchef: (pid 35546) 10s

By default, runit will restart services automatically when the services fail. Therefore, runit may report the status of a service as ``run:`` even when there is an issue with that service. When investigating why a particular service is not running as it should be, look for the services with the shortest uptimes. For example, the list below indicates that the **opscode-erchef** should be investigated further:

.. code-block:: bash

   run: oc-id
   run: opscode-chef: (pid 4327) 13671s; run: log: (pid 4326) 13671s
   run: opscode-erchef: (pid 5383) 5s; run: log: (pid 4382) 13669s
   run: opscode-expander: (pid 4078) 13694s; run: log: (pid 4077) 13694s
   run: opscode-expander-reindexer: (pid 4130) 13692s; run: log: (pid 4114) 13692s

.. end_tag

Log Files
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. tag ctl_delivery_server_status_logs

A typical status line for a service that is running any of the Chef Automate server front-end services is similar to the following:

.. code-block:: bash

   run: name_of_service: (pid 1486) 7819s; run: log: (pid 1485) 7819s

where:

* ``run`` describes the state in which the supervisor attempts to keep processes. This state is either ``run`` or ``down``. If a service is in a ``down`` state, it should be stopped
* ``name_of_service`` is the service name, for example: ``opscode-solr4``
* ``(pid 1486) 7819s;`` is the process identifier followed by the amount of time (in seconds) the service has been running
* ``run: log: (pid 1485) 7819s`` is the log process. It is typical for a log process to have a longer run time than a service; this is because the supervisor does not need to restart the log process in order to connect the supervised process

If the service is down, the status line will appear similar to the following:

.. code-block:: bash

   down: opscode-solr4: 3s, normally up; run: log: (pid 1485) 8526s

where

* ``down`` indicates that the service is in a down state
* ``3s, normally up;`` indicates that the service is normally in a run state and that the supervisor would attempt to restart this service after a reboot

.. end_tag

stop
-----------------------------------------------------
.. tag ctl_delivery_server_stop

The ``stop`` subcommand is used to stop all services enabled on the Chef Automate server. This command can also be run for an individual service by specifying the name of the service in the command.

This subcommand has the following syntax:

.. code-block:: bash

   $ delivery-ctl stop name_of_service

where ``name_of_service`` represents the name of any service that is listed after running the ``service-list`` subcommand. When a service is successfully stopped the output should be similar to:

.. code-block:: bash

   $ ok: diwb: service_name: 0s, normally up

For example:

.. code-block:: bash

   $ delivery-ctl stop

will return something similar to:

.. code-block:: bash

   ok: down: nginx: 393s, normally up
   ok: down: opscode-chef: 391s, normally up
   ok: down: opscode-erchef: 391s, normally up
   ok: down: opscode-expander: 390s, normally up
   ok: down: opscode-expander-reindexer: 389s, normally up
   ok: down: opscode-solr4: 389s, normally up
   ok: down: postgresql: 388s, normally up
   ok: down: rabbitmq: 388s, normally up
   ok: down: redis_lb: 387s, normally up

.. end_tag

tail
-----------------------------------------------------
.. tag ctl_delivery_server_tail

The ``tail`` subcommand is used to follow all of the Chef Automate server logs for all services. This command can also be run for an individual service by specifying the name of the service in the command.

This subcommand has the following syntax:

.. code-block:: bash

   $ delivery-ctl tail name_of_service

where ``name_of_service`` represents the name of any service that is listed after running the ``service-list`` subcommand.

.. end_tag

term
-----------------------------------------------------
.. tag ctl_delivery_server_term

The ``term`` subcommand is used to send a ``SIGTERM`` to all services. This command can also be run for an individual service by specifying the name of the service in the command.

This subcommand has the following syntax:

.. code-block:: bash

   $ delivery-ctl term name_of_service

where ``name_of_service`` represents the name of any service that is listed after running the ``service-list`` subcommand.

.. end_tag

usr1
-----------------------------------------------------
.. tag ctl_delivery_server_usr1

The ``usr1`` subcommand is used to send the services a USR1.

.. end_tag

usr2
-----------------------------------------------------
.. tag ctl_delivery_server_usr2

The ``usr2`` subcommand is used to send the services a USR2.

.. end_tag

