=====================================================
automate-ctl (executable)
=====================================================
`[edit on GitHub] <https://github.com/chef/chef-web-docs/blob/master/chef_master/source/ctl_automate_server.rst>`__

.. tag chef_automate_mark

.. image:: ../../images/chef_automate_full.png
   :width: 40px
   :height: 17px

.. end_tag

The Chef Automate server includes a command-line utility named `automate-ctl`. Use this command-line tool to:

* Manage enterprises, users, and projects
* Reconfigure the Chef Automate server
* Start and stop individual services
* Tail Chef Automate server log files

.. note:: All commands must be run as ``sudo``.

.. tag delivery_ctl_note

.. note:: Prior to Chef Automate 0.6.0, this tool was named ``delivery-ctl``. To support backwards compatibility, you can continue to call ``delivery-ctl`` in Chef Automate 0.6.0.

.. end_tag

cleanse
=====================================================
The ``cleanse`` subcommand is used to re-set the Chef Automate server to the state it was in prior to the first time the ``reconfigure`` subcommand is run. This command will:

* Destroy all data and logs
* Create a backup of the system config files and place them in a directory in root, such as ``/root/delivery-cleanse-2015-12-15T15:51``

The software that was put on-disk by the package installation will remain. Re-run ``automate-ctl reconfigure`` to recreate the default data and configuration files.

This subcommand has the following syntax:

.. code-block:: bash

   $ automate-ctl cleanse

create-backup
=====================================================

.. tag automate_ctl_create_backup

The ``create-backup`` subcommand is used to create Chef Automate backups. By default, it creates Automate backup archives and Elasticsearch snapshots.

**Syntax**

.. code-block:: none

   $ automate-ctl create-backup [NAME] [options]
        --chef-server-config         Backup up the Chef Server config if present
        --digest [int]               The SHA digest length to output. 256, 384, and 512 are valid
        --force                      Agree to all warnings and prompts
        --name [string]              The output name of the backup
        --no-census                  Do not back up Chef Automate's census data
        --no-compliance-profiles     Do not back up Chef Automate's compliance profiles
        --no-config                  Do not back up Chef Automate's configuration directory
        --no-db                      Do not back up Chef Automate's database
        --no-elasticsearch           Do not snapshot Chef Automate's Elasticsearch
        --no-git                     Do not back up Chef Automate's git repositories
        --no-license                 Do not back up Chef Automate's license file
        --no-wait                    Do not wait for non-blocking backup operations
        --quiet                      Do not output non-error information
        --rabbit                     Back up Chef Automate's RabbitMQ queues
        --retry-limit                Maximum number of times to retry archive uploads to S3
        --staging-dir [string]       The path to use for temporary files during backup
    -h, --help                       Show the usage message

The ``NAME`` value is optional. If omitted, a default name with the current time will be used.

.. warning:: In rare circumstances, jobs that are running at the time of backup creation may be left in an unrecoverable state. For this reason, it's recommended to take a backup when no critical jobs are running.

.. note:: ``create-backup`` should be run outside of root-only directories like ``/root``, as it tries to chpst to the user chef-pgsql. This user will have problems running with a current working directory owned by root.

**Examples**

Complete backup:
  ``$ automate-ctl create-backup``

Elasticsearch snapshot only:
  ``$ automate-ctl create-backup --no-census --no-config --no-db --no-license --no-git``

Automate archive only
  ``$ automate-ctl create-backup --no-elasticsearch``

.. end_tag

create-enterprise
=====================================================
The ``create-enterprise`` subcommand is used to create a Chef Automate enterprise. A public key is required.

**Syntax**

This subcommand has the following syntax:

.. code-block:: bash

   $ automate-ctl create-enterprise ENT_NAME --ssh-pub-key-file=FILE_NAME

.. note:: The ``ENT_NAME`` value must be alphanumeric.

create-user
=====================================================
The ``create-user`` subcommand is used to create a user. (The validation key for the organization may be returned to ``STDOUT`` when creating a user with this command.)

**Syntax**

This subcommand has the following syntax:

.. code-block:: bash

   $ automate-ctl create-user ENT-NAME USER-NAME [--password PASSWORD] [--password-file FILE] [--roles "COMMA-SEPARATED-LIST"] [--ssh-pub-key-file=PATH-TO-PULIC-KEY-FILE]

**Example**

.. code-block:: bash

   $ automate-ctl create-user enterprise john_smith --password my_password --roles reviewer,committer

delete-backups
=====================================================
The ``delete-backups`` subcommand is used to delete Chef Automate backup archives and Elasticseach snapshots. The command matches a given regular expression and prompts the user to confirm deletion of each matched backup or snapshot.

**Syntax**

.. code-block:: bash

   $ automate-ctl delete-backups REGEX [options]
        --force                      Agree to all warnings and prompts
    -h, --help                       Show the usage message

**Examples**

Deleting a single Automate backup archive:
  ``$ automate-ctl delete-backups 2016-10-14-08-38-55-chef-automate-backup.zst``

Deleting a single Elasticsearch snapshot:
  ``$ automate-ctl delete-backups 2016-10-14-08-38-55-chef-automate-backup$``

Deleting all backup archives and snapshots from October, 2016:
  ``$ automate-ctl delete-backups 2016-10-.+-chef-automate-backup --force``

delete-enterprise
=====================================================
The ``delete-enterprise`` subcommand is used to delete a Chef Automate enterprise.

**Syntax**

This subcommand has the following syntax:

.. code-block:: bash

   $ automate-ctl delete-enterprise ENT_NAME

**Example**

.. code-block:: bash

   $ automate-ctl delete-enterprise pedant-testing-org

delete-project
=====================================================
The ``delete-project`` subcommand is used to delete a Chef Automate project.

**Syntax**

This subcommand has the following syntax:

.. code-block:: bash

   $ automate-ctl delete-project ENT_NAME ORG_NAME PROJECT_NAME

delete-user
=====================================================
The ``delete-user`` subcommand is used to delete a user.

**Syntax**

This subcommand has the following syntax:

.. code-block:: bash

   $ automate-ctl delete-user ENT_NAME USER_NAME

**Example**

.. code-block:: bash

   $ automate-ctl delete-user ENT_NAME john_smith

delete-visibility-node
=====================================================
The ``delete-visibility-node`` subcommand is used to delete a node from the **Node State** dashboard in the Chef Automate UI.

The node (and, if provided, the organization and/or Chef server) must match a single node. If multiple nodes match, a table of nodes that match the provided criteria will be displayed.

**Syntax**

.. code-block:: bash

  $ automate-ctl delete-visibility-node NODE_NAME [options]
          --org ORG                    Organization the node belongs to
          --chef_server CHEF_SERVER    Chef server the node belongs to
      -h, --help                       Show this message

**Examples**

.. code-block:: bash

   $ automate-ctl delete-visibility-node tester1
   Node tester1 (UUID: f470b942-31b6-4665-81df-03013a0b6ef6) has been deleted.

.. code-block:: bash

   $ automate-ctl delete-visibility-node tester2
   Multiple nodes were found matching your request. Please delete by ID using: automate-ctl delete-visibility-node-by-id NODE_UUID

   Node UUID                            Node Name Org Name Chef Server
   ==================================== ========= ======== ===========
   6bbe462c-670e-4ca4-b9f3-e45ed4c78f7c tester2   org1     localhost
   2380c127-7e54-46b3-b4c2-28ae7f2afe10 tester2   org2     localhost

   ERROR: Unable to delete node with name tester2

.. code-block:: bash

   $ automate-ctl delete-visibility-node tester2 --org org2
   Node tester2 (UUID: 2380c127-7e54-46b3-b4c2-28ae7f2afe10) has been deleted.

delete-visibility-node-by-id
=====================================================
The ``delete-visibility-node-by-id`` subcommand is used to delete a node from the **Node State** dashboard in the Chef Automate UI using the node's unique ID.

This is helpful if ``delete-visibility-node`` is unable to delete a node by its node name, org, and/or Chef server.

**Syntax**

.. code-block:: bash

   $ automate-ctl delete-visibility-node-by-id NODE_UUID

**Example**

.. code-block:: bash

   $ automate-ctl delete-visibility-node-by-id e05d6c79-15ab-417e-a54e-4fe28a84c04c
   Node tester3 (UUID: e05d6c79-15ab-417e-a54e-4fe28a84c04c) has been deleted

gather-logs
=====================================================
The ``gather-logs`` command is used to collect the logs from Chef Automate into a compressed file archive. It will create a tbz2 file in the current working directory, with the timestamp as the file name.

By default, it collects the most current log file as well as any others that have been modified in the last 180 minutes. If the ``--all-logs`` option is given, all log files are collected.

**Syntax**

This subcommand has the following syntax:

.. code-block:: bash

   $ automate-ctl gather-logs 
        --all-logs          Gather all of the logs, regardless of size or age.

.. warning:: The ``--all-logs`` option can potentially take up a large amount of disk space. 

generate-password-reset-token
=====================================================
The ``generate-password-reset-token`` command is used to unset the password for an existing Chef Automate user, and generate a token that allows them to set a new password. The command returns a URL pointing to the Chef Automate UI, allowing the user to enter a new password.

The token is embedded in that URL and has an expiry of two hours. This command may be issued again to get a new token. After the command has been run, the previously stored password will no longer work. Issued API tokens (e.g. in existing UI sessions or for use with :doc:`delivery_cli`) will not be revoked.

When a token is consumed (through the web UI), all issued password reset tokens for this user will be revoked.

**Syntax**

This subcommand has the following syntax:

.. code-block:: bash

   $ automate-ctl generate-password-reset-token ENTERPRISE_NAME USER_NAME

**Example**

.. code-block:: bash

   $ automate-ctl generate-password-reset-token Chef admin
   Password reset with token successful. Go to this URL to set a new password:
   URL: https://automate.fqdn/e/Chef/#/reset-password/admin/nzfcEPQULoY0NR-xg7OxxBl5Q3htausWXY92GskR3ZE

help
=====================================================
The ``help`` subcommand is used to print a list of all available ``automate-ctl`` commands.

This subcommand has the following syntax:

.. code-block:: bash

   $ automate-ctl help

.. _install-runner:

install-runner
=====================================================
The ``install-runner`` subcommand configures a remote node as a job runner, which are used by Chef Automate to run phase jobs. For more information on runners, please see :doc:`runners`.

**Syntax**

.. code-block:: none

   $ automate-ctl install-runner FQDN USERNAME [options]

     Arguments:
       FQDN       Fully qualified domain name of the remote host that will be configured into a runner
       USERNAME   The username used for authentication to the remote host that will be configured into a runner

     Options:
      -h, --help                            Show the usage message
      -i, --ssh-identity-file FILE          SSH identity file used for authentication to the remote host
      -I, --installer FILE                  The location of the ChefDK package for the runner.
                                            This option cannot be passed with --chefdk-version as that option specifies remote download.
                                            If neither are passed, the latest ChefDK will be downloaded remotely

      -p, --port PORT                       SSH port to connect to on the remote host (Default: 22)
      -P, --password [PASSWORD]             Pass if you need to set a password for ssh and / or sudo access.
                                            You can pass the password in directly or you will be prompted if you simply pass --password.
                                            If --ssh-identify-file is also passed, will only be used for sudo access

      -v, --chefdk-version VERSION          Custom version of the ChefDK you wish to download and install.
                                            This option cannot be passed with --installer as that option specifies using a package local to this server.
                                            If neither are passed, the latest ChefDK will be downloaded remotely

      -y, --yes                             Skip configuration confirmation and overwrite any existing Chef Server nodes of the same name as FQDN
      -e, --enterprise                      Legacy option, only required if you have more than one enterprise configured. Workflow enterprise to add the runner into
      --fips-custom-cert-filename FILENAME  If you have a self-signed or self-owned Certificate Authority (CA) and wish to operate in FIPS mode, pass this flag the path to a file containing your custom certificate chain on your Automate server. This file will be copied to the runner and used when running jobs in FIPS mode. If you have purchased a certificate from a known CA for Automate server, you can ignore this flag. Please see the Automate FIPS docs for details.


.. note:: The username provided must be a user who has sudo access on the remote node. If the user is a member of a domain, then the username value should be entered as ``user@domain``.
.. note:: At least one of ``--password [PASSWORD]`` or ``--ssh-identity-file FILE`` are necessary for ssh access.
.. note:: ``install-runner`` calls the ``knife bootstrap`` subcommand to configure the runner, so custom configurations can be installed on the runner by using the :doc:`client.d copying feature </knife_bootstrap>`. All config files inside ``~/.chef/client.d`` directory on the Chef Automate server get copied into the ``/etc/chef/client.d`` directory on the runner.

**Example**

.. code-block:: bash

   $ automate-ctl install-runner

Installing the latest ChefDK via download and CLI prompt for SSH / Sudo password.

.. code-block:: bash

   $ automate-ctl install-runner runner-hostname.mydomain.co ubuntu --password

Installing with a ChefDK file local to your Workflow server, an SSH Key, and passwordless sudo.

.. code-block:: bash

   $ automate-ctl install-runner runner-hostname.mydomain.co ubuntu -i ~/.ssh/id_rsa -I ./chefdk.deb

Installing a custom version of ChefDK via download, a identity file for ssh access, and a Sudo password.

.. code-block:: bash

   $ automate-ctl install-runner runner-hostname.mydomain.co ubuntu -v 0.18.30 -p my_password -i ~/.ssh/id_rsa

list-backups
=====================================================
The ``list-backups`` subcommand is used to list Chef Automate backup archives and Elasticseach snapshots.

**Syntax**

.. code-block:: none

   $ automate-ctl list-backups [options]
        --all                        List all backups and snapshots (default)
        --automate                   Only list Chef Automate's backup archives
        --elasticsearch              Only list Chef Automate's Elasticsearch snapshots
        --format [string]            The output format. 'text' or 'json'
    -h, --help                       Show the usage message

**Examples**

Return a list all backups as JSON:
  ``$ automate-ctl list-backups --format json``

list-enterprises
=====================================================
The ``list-enterprises`` subcommand is used to list all of the enterprises currently present on the Chef Automate server.

**Syntax**

This subcommand has the following syntax:

.. code-block:: bash

   $ automate-ctl list-enterprises

list-users
=====================================================
The ``list-users`` subcommand is used to view a list of users.

**Syntax**

This subcommand has the following syntax:

.. code-block:: bash

   $ automate-ctl list-users ENT_NAME

migrate-change-description
=====================================================
The ``migrate-change-description`` subcommand is used to migrate the change description live run.

**Syntax**

This subcommand has the following syntax:

.. code-block:: bash

   $ automate-ctl migrate-change-description ENT_NAME ORG_NAME PROJECT_NAME CHANGE

migrate-change-description-dry-run
=====================================================
The ``migrate-change-description-dry-run`` subcommand is used to execute a dry run migration of the change description.

**Syntax**

This subcommand has the following syntax:

.. code-block:: bash

   $ automate-ctl migrate-change-description-dry-run ENT_NAME ORG_NAME PROJECT_NAME CHANGE

migrate-patchset-diffs
=====================================================
The ``migrate-patchset-diffs`` subcommand is used to update patchset diffs to include numstat.

**Syntax**

This subcommand has the following syntax:

.. code-block:: bash

   $ automate-ctl migrate-patchset-diffs ENT_NAME ORG_NAME PROJECT_NAME PATCHSET_DIFF

migrate-patchset-diffs-dry-run
=====================================================
The ``migrate-patchset-diffs-dry-run`` subcommand is used to execute a dry run update of patchset diffs to include numstat.

**Syntax**

This subcommand has the following syntax:

.. code-block:: bash

   $ automate-ctl migrate-patchset-diffs-dry-run ENT_NAME ORG_NAME PROJECT_NAME PATCHSET_DIFF

node-summary
=====================================================

The ``node-summary`` subcommand produces a summary of the nodes that are known to Chef Automate.

New in Chef Automate 0.5.328.

The default setting for ``node-summary`` is to display the name, status, and the last time the nodes were checked.

**Syntax**

.. code-block:: none

   $ automate-ctl node-summary [option]

     Option:
     --json                    Produce a detailed report in JSON format.


**Examples**

Producing a summary of nodes known to Automate using the ``node-summary`` default behavior.

.. code-block:: none

  $ automate-ctl node-summary
  name, status, last_checkin
  builder-1-acceptance, missing, 2017-02-22T19:41:14.000Z
  builder-1-delivered, success, 2017-02-25T19:54:08.000Z

Producing a summary of nodes known to Automate in JSON.

.. code-block:: bash

  $ automate-ctl node-summary --json
  [
    {
      "chef_version": "12.16.42",
      "checkin": "2017-02-22T19:41:14.000Z",
      "@timestamp": "2017-02-22T19:41:14.000Z",
      "platform_version": "10.12.3",
      "fqdn": "",
      "name": "builder-1-delivered",
      "organization_name": "acme",
      "platform_family": "mac_os_x",
      "platform": "mac_os_x",
      "status": "success",
      "chef_server_status": "present"
    },
    ...
  ]

Explanation of fields:
-----------------------------------------------------
chef_version
   The version of the Chef Client that ran on the node.
checkin
   The last time Chef Client ran on the node.
@timestamp
   The time when the node's information was received by Chef Automate.
platform_version
   Platform version information discovered by ohai on the node.
fqdn
   Fully qualified domain name of the node.
name
   Name of the node in Chef Server.
organization_name
   The name of the Chef Server organization the node belongs to.
platform_family
   Platform family information discovered by ohai on the node.
platform
   Platform information discovered by ohai on the node.
status
   "success" if the last Chef Client run succeeded on the node
   "failure" if the last Chef Client run failed on the node
   "missing" if Chef Client did not run in the expected check-in duration configured in Chef Automate (default is 12 hours).
chef_server_status
   This field is only populated in Opsworks for Chef Automate instances.
   "present": Node is still present on the Chef Server.
   "missing": Node is still present on the Chef Server.
ec2
   EC2 information discovered by ohai on the node. This field is only populated in Chef Automate instances that are running on EC2



preflight-check
=====================================================

 The ``preflight-check`` subcommand is used to check for common problems in your infrastructure environment before setup and configuration of Chef Automate begins.

 New in Chef Automate 0.6.64.

 This subcommand has the following syntax:

 .. code-block:: bash

    $ automate-ctl preflight-check

reconfigure
=====================================================
The ``reconfigure`` subcommand is used to reconfigure the Chef Automate server after changes are made to the delivery configuration file, located at ``/etc/delivery/delivery.rb``. When changes are made to the delivery configuration file, they are not applied to the Chef Automate configuration until after this command is run. This subcommand also restarts any services for which the ``service_name['enabled']`` setting is set to ``true``.

This subcommand has the following syntax:

.. code-block:: bash

   $ automate-ctl reconfigure

rename-enterprise
=====================================================
The ``rename-enterprise`` subcommand is used to rename an existing Chef Automate enterprise.

**Syntax**

This subcommand has the following syntax:

.. code-block:: bash

   $ automate-ctl rename-enterprise CURRENT_ENT_NAME NEW_ENT_NAME

reset-password
=====================================================
The ``reset-password`` command is used to reset the password for an existing Chef Automate user.

**Syntax**

This subcommand has the following syntax:

.. code-block:: bash

   $ automate-ctl reset-password ENTERPRISE_NAME USER_NAME NEW_PASSWORD

restore-backup
=====================================================
The ``restore-backup`` subcommand is used to restore Chef Automate backup archives and Elasticsearch snapshots.

The command is intended to restore an Automate instance completely from backup, however, it does support restoring only specific data types when given compatible backup archives and snapshots.

.. note:: Backups created with the older ``automate-ctl backup-data`` command are not supported with this command. If you wish to restore an older backup please install the version of Chef Automate that took the backup and use ``automate-ctl restore-data``

**Syntax**

.. code-block:: console

   $ automate-ctl restore-backup /path/to/chef-automate-backup.zst [ELASTICSEARCH_SNAPSHOT] [options]
   $ automate-ctl restore-backup us-east-1:s3_bucket:chef-automate-backup.zst [ELASTICSEARCH_SNAPSHOT] [options]
   $ automate-ctl restore-backup ELASTICSEARCH_SNAPSHOT [options]
        --digest [int]               The SHA digest of the backup archive
        --force                      Agree to all warnings and prompts
        --no-chef-server-config      Do not restore the Chef Server config if present
        --no-census                  Do not restore Chef Automate's census data
        --no-compliance-profiles     Do not restore Chef Automate's compliance profiles
        --no-config                  Do not restore Chef Automate's configuration directory
        --no-db                      Do not restore Chef Automate's database
        --no-git                     Do not restore Chef Automate's git repositories
        --no-license                 Do not restore Chef Automate's license file
        --no-rabbit                  Do not restore Chef Automate's RabbitMQ data
        --no-wait                    Do not wait for non-blocking restore operations
        --quiet                      Do not output non-error information
        --retry-limit                Maximum number of times to retry archive downloads from S3
        --staging-dir [string]       The path to use for temporary files during restore
    -h, --help                       Show the usage message

.. note:: The ``ELASTICSEARCH_SNAPSHOT`` value is optional when given a backup archive path.

**Examples**
 ``$ automate-ctl restore-backup us-east-1:your-s3-bucket:2016-10-14-08-38-55-chef-automate-backup.zst 2016-10-14-08-38-55-chef-automate-backup``
 ``$ automate-ctl restore-backup 2016-10-14-08-38-55-chef-automate-backup``
 ``$ automate-ctl restore-backup us-east-1:your-s3-bucket:2016-10-14-08-38-55-chef-automate-backup.zst --no-census --no-license --no-config``

revoke-token
=====================================================
The ``revoke-token`` subcommand is used to revoke a user's token.

**Syntax**

This subcommand has the following syntax:

.. code-block:: bash

   $ automate-ctl revoke-token ENT_NAME USER_NAME

show-config
=====================================================
The ``show-config`` subcommand is used to view the configuration that will be generated by the ``reconfigure`` subcommand. This command is most useful in the early stages of a deployment to ensure that everything is built properly prior to installation.

This subcommand has the following syntax:

.. code-block:: bash

   $ automate-ctl show-config
   
telemetry
=====================================================

The ``telemetry`` subcommand is used in conjunction with additional subcommands to query the ``status`` of, ``enable`` or ``disable`` telemetry server wide. 

This subcommand has the following syntax:

.. code-block:: bash

 $ automate-ctl telemetry status
    
**Examples**

Query current status:
``$ automate-ctl telemetry status``

Enable telemetry:
``$ automate-ctl telemetry enable``

Disable telemetry:
``$ automate-ctl telemetry disable``

uninstall
=====================================================
The ``uninstall`` subcommand is used to remove the Chef Automate application, but without removing any of the data. This subcommand will shut down all services (including the ``runit`` process supervisor).

This subcommand has the following syntax:

.. code-block:: bash

   $ automate-ctl uninstall

.. note:: To revert the ``uninstall`` subcommand, run the ``reconfigure`` subcommand (because the ``start`` subcommand is disabled by the ``uninstall`` command).

update-project-hooks
=====================================================
The ``update-project-hooks`` subcommand is used to update git hooks for all projects.

**Syntax**

This subcommand has the following syntax:

.. code-block:: bash

   $ automate-ctl update-project-hooks ENT_NAME ORG_NAME PROJECT_NAME

Service Subcommands
=====================================================
.. tag ctl_common_service_subcommands

This command has a built in process supervisor that ensures all of the required services are in the appropriate state at any given time. The supervisor starts two processes per service and provides the following subcommands for managing services: ``hup``, ``int``, ``kill``, ``once``, ``restart``, ``service-list``, ``start``, ``status``, ``stop``, ``tail``, and ``term``.

.. end_tag

graceful-kill
-----------------------------------------------------
The ``kill`` subcommand is used to send a ``SIGKILL`` to all services. This command can also be run for an individual service by specifying the name of the service in the command.

This subcommand has the following syntax:

.. code-block:: bash

   $ automate-ctl kill name_of_service

where ``name_of_service`` represents the name of any service that is listed after running the ``service-list`` subcommand.

hup
-----------------------------------------------------
The ``hup`` subcommand is used to send a ``SIGHUP`` to all services. This command can also be run for an individual service by specifying the name of the service in the command.

This subcommand has the following syntax:

.. code-block:: bash

   $ automate-ctl hup name_of_service

where ``name_of_service`` represents the name of any service that is listed after running the ``service-list`` subcommand.

int
-----------------------------------------------------
The ``int`` subcommand is used to send a ``SIGINT`` to all services. This command can also be run for an individual service by specifying the name of the service in the command.

This subcommand has the following syntax:

.. code-block:: bash

   $ automate-ctl int name_of_service

where ``name_of_service`` represents the name of any service that is listed after running the ``service-list`` subcommand.

kill
-----------------------------------------------------
The ``kill`` subcommand is used to send a ``SIGKILL`` to all services. This command can also be run for an individual service by specifying the name of the service in the command.

This subcommand has the following syntax:

.. code-block:: bash

   $ automate-ctl kill name_of_service

where ``name_of_service`` represents the name of any service that is listed after running the ``service-list`` subcommand.

once
-----------------------------------------------------
The supervisor for the Chef Automate server is configured to restart any service that fails, unless that service has been asked to change its state. The ``once`` subcommand is used to tell the supervisor to not attempt to restart any service that fails.

This command is useful when troubleshooting configuration errors that prevent a service from starting. Run the ``once`` subcommand followed by the ``status`` subcommand to look for services in a down state and/or to identify which services are in trouble. This command can also be run for an individual service by specifying the name of the service in the command.

This subcommand has the following syntax:

.. code-block:: bash

   $ automate-ctl once name_of_service

where ``name_of_service`` represents the name of any service that is listed after running the ``service-list`` subcommand.

restart
-----------------------------------------------------
The ``restart`` subcommand is used to restart all services enabled on the Chef Automate server or to restart an individual service by specifying the name of that service in the command.

This subcommand has the following syntax:

.. code-block:: bash

   $ automate-ctl restart name_of_service

where ``name_of_service`` represents the name of any service that is listed after running the ``service-list`` subcommand. When a service is successfully restarted the output should be similar to:

.. code-block:: bash

   $ ok: run: service_name: (pid 12345) 1s

service-list
-----------------------------------------------------
The ``service-list`` subcommand is used to display a list of all available services. A service that is enabled is labeled with an asterisk (*).

This subcommand has the following syntax:

.. code-block:: bash

   $ automate-ctl service-list

start
-----------------------------------------------------
The ``start`` subcommand is used to start all services that are enabled in the Chef Automate server. This command can also be run for an individual service by specifying the name of the service in the command.

This subcommand has the following syntax:

.. code-block:: bash

   $ automate-ctl start name_of_service

where ``name_of_service`` represents the name of any service that is listed after running the ``service-list`` subcommand. When a service is successfully started the output should be similar to:

.. code-block:: bash

   $ ok: run: service_name: (pid 12345) 1s

The supervisor for the Chef Automate server is configured to wait seven seconds for a service to respond to a command from the supervisor. If you see output that references a timeout, it means that a signal has been sent to the process, but that the process has yet to actually comply. In general, processes that have timed out are not a big concern, unless they are failing to respond to the signals at all. If a process is not responding, use a command like the ``kill`` subcommand to stop the process, investigate the cause (if required), and then use the ``start`` subcommand to re-enable it.

status
-----------------------------------------------------
The ``status`` subcommand is used to show the status of all services available to the Chef Automate server. The results will vary based on the configuration of a given server. This subcommand has the following syntax:

.. code-block:: bash

   $ automate-ctl status

and will return the status for all services. Status can be returned for individual services by specifying the name of the service as part of the command:

.. code-block:: bash

   $ automate-ctl status name_of_service

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

Log Files
+++++++++++++++++++++++++++++++++++++++++++++++++++++
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

stop
-----------------------------------------------------
The ``stop`` subcommand is used to stop all services enabled on the Chef Automate server. This command can also be run for an individual service by specifying the name of the service in the command.

This subcommand has the following syntax:

.. code-block:: bash

   $ automate-ctl stop name_of_service

where ``name_of_service`` represents the name of any service that is listed after running the ``service-list`` subcommand. When a service is successfully stopped the output should be similar to:

.. code-block:: bash

   $ ok: diwb: service_name: 0s, normally up

For example:

.. code-block:: bash

   $ automate-ctl stop

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

tail
-----------------------------------------------------
The ``tail`` subcommand is used to follow all of the Chef Automate server logs for all services. This command can also be run for an individual service by specifying the name of the service in the command.

This subcommand has the following syntax:

.. code-block:: bash

   $ automate-ctl tail name_of_service

where ``name_of_service`` represents the name of any service that is listed after running the ``service-list`` subcommand.

term
-----------------------------------------------------
The ``term`` subcommand is used to send a ``SIGTERM`` to all services. This command can also be run for an individual service by specifying the name of the service in the command.

This subcommand has the following syntax:

.. code-block:: bash

   $ automate-ctl term name_of_service

where ``name_of_service`` represents the name of any service that is listed after running the ``service-list`` subcommand.

usr1
-----------------------------------------------------
The ``usr1`` subcommand is used to send the services a USR1.

usr2
-----------------------------------------------------
The ``usr2`` subcommand is used to send the services a USR2.
