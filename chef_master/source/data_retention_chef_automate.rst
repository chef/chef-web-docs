=====================================================
Data Retention Management in Chef Automate
=====================================================
`[edit on GitHub] <https://github.com/chef/chef-web-docs/blob/master/chef_master/source/data_retention_chef_automate.rst>`__

.. tag chef_automate_mark

.. image:: ../../images/chef_automate_full.png
   :width: 40px
   :height: 17px

.. end_tag

Chef Automate manages data retention of Elasticsearch indices through a tool called Reaper. Reaper will delete indices that fall outside of the requested retention period. Reaper can be configured to archive the indices scheduled for deletion to an alternate filesystem location or an S3 bucket.

Reaper uses `Elasticsearch Curator <https://github.com/elastic/curator>`__ for indexing archives and deletions. Elasticsearch plugins are used to perform any necessary archival tasks.

Example Configuration (Delete mode)
=====================================================

 We recommend delete mode for most customers as it is the simplest and most reliable. For delete mode, the following is a suitable configuration.

Set the following group of options in ``/etc/delivery/delivery.rb`` on your Automate system and run a ``automate-ctl reconfigure`` to apply the configuration change.

.. code-block:: bash

   reaper['enable'] = true
   reaper['mode'] = "delete"
   reaper['retention_period_in_days'] = 7

Settings
=====================================================
Reaper has a number of configuration parameters you may specify in your ``/etc/delivery/delivery.rb`` configuration file. See the `External Elasticsearch </data_retention_chef_automate.html#external-elasticsearch>`__ section for additional settings that are specific to the process of using an external Elasticsearch cluster.

``reaper['enable']``: boolean
  If ``true`` Reaper will be enabled and run every 15 minutes. Default: ``false``.

``reaper['mode']``: string
  This setting is **required** if ``reaper['enable']`` is set to ``true``. Valid options are ``'delete'`` or ``'archive'``.

``reaper['mode']``: ``'delete'``
  Reaper will delete any indices older than the value specified in ``reaper['retention_period_in_days']``.

``reaper['mode']``: ``'archive'``
  Reaper will take snapshots of any indices older than defined in ``reaper['retention_period_in_days']`` and then delete the indices.

``reaper['archive_destination']``: string
  This setting is **required** if ``reaper['mode']`` is set to ``'archive'``. Valid options are ``'fs'`` or ``'s3'``.

``reaper['retention_period_in_days']``: integer
  Any indices older than this value will reaped by Reaper. Default: ``14``.

``reaper['compliance_retention_period_in_days']``: integer
  Sets a retention period specifically for compliance data. Defaults to the value of ``reaper['retention_period_in_days']``. A retention period specified for this setting becomes the default for ``reaper['insights_retention_period_in_days']``, unless that retention period is also uniquely specified.

  New in Chef Automate 1.7.114.

``reaper['insights_retention_period_in_days']``: integer
  Sets a retention period specifically for node data. Defaults to the value of ``reaper['retention_period_in_days']``. The retention period specified for this setting becomes the default for ``reaper['compliance_retention_period_in_days']``, unless that retention period is also uniquely specified.

  New in Chef Automate 1.7.114.

``reaper['evasive_maneuvers_enabled']``: boolean
    If ``true``, Reaper will perform evasive maneuvers if they are necessary. The default setting depends on the Elasticsearch service in use.
    Default: ``true`` if using Chef Automate's provided Elasticsearch service.
    Default: ``false`` if using an external Elasticsearch service.

``reaper['free_space_threshold_percent']``: integer
  The threshold for free space on any volume on any Elasticsearch node in your cluster. If the free space falls below this threshold, Reaper will perform evasive maneuvers. Default: ``10``.

``reaper[‘repository’]``: string
  The name of the repository set up in Elasticsearch, defaults to ``'reaper[‘archive_destination’]-chef-automate'``

How Reaper Operates
=====================================================

Reaper runs every 15 minutes and performs these operations:

.. image:: ../../images/reaper_process_diagram.svg
   :width: 900px
   :align: center

Evasive Maneuvers
=====================================================

In addition to allowing you to manage your own data retention requirements, Reaper ensures Chef Automate does not degrade or become unavailable because of disk space consumption issues. Retention periods are not foolproof; changes to the infrastructure or operation of Chef Automate, such as adding a large number of nodes or increasing the converge rate, can cause a sudden increase in disk space utilization for which the retention period would not delete enough data.

To address this issue, Reaper includes the ability to more aggressively remove older Chef Automate indices if the available free space on any Elasticsearch nodes falls below a user-configurable threshold. If your Elasticsearch nodes are configured with multiple volumes, Reaper will take action when **any** of the volumes are below the free space threshold.

If ``evasive maneuvers`` is enabled, Reaper performs the following steps in a loop after the normal task:

 * Request disk space utilization information from Elasticsearch's status endpoint
 * Calculate the amount of free space on every node in the Elasticsearch cluster
    * If the free disk space percentage for each node is greater than the ``free_space_threshold_percent``, stop. Evasive maneuvers are complete.
    * If the free disk space percentage for any node is less than ``free_space_threshold_percent``, delete one day's worth of data.
 * Repeat the evasive maneuvers loop

Regardless of the available free space in your Elasticsearch cluster, Reaper will always retain the indices for the current day and one day prior.

External Elasticsearch
=====================================================

Requirements
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
Using your own Elasticsearch cluster provides additional redundancy and performance to your Chef Automate installation. However, if you choose to enable and use Reaper, there are some aspects you need to be aware of:

* **We recommend that your Elasticsearch cluster is dedicated to Chef Automate**. We absolutely support co-existing with other applications on your Elasticsearch cluster. However, if you use Reaper and have enabled evasive maneuvers, Reaper may delete more Visibility data than you wish if another co-existing application suddenly starts consuming large amounts of disk.

* **Filesystem Archiving**: If you choose to enable archiving and choose to archive to the filessytem:

   * The filesystem path must exist on all of your Elasticsearch nodes
   * The filesystem path must be included in your Elasticsearch ``path.repo`` configuration parameter

* **S3 Archiving**: If you choose to enable archiving and choose to archive to S3, you need to install the `Elasticsearch AWS Cloud Plugin <https://www.elastic.co/guide/en/elasticsearch/plugins/current/cloud-aws.html>`__ on all of your Elasticsearch nodes.

Using Reaper and an External Elasticsearch Service
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
``reaper['archive_destination']``: ``'fs'``
  Reaper will take snapshots to a filesystem location on your Elasticsearch nodes.

The following option applies when ``reaper['archive_destination']`` is set to ``'fs'``:

  ``reaper['archive_filesystem_path']``: string
    **Required.** The full path to the directory/filesystem on your Elasticsearch nodes for storing snapshots. This should be a different filesystem/volume than where Elasticsearch stores its running data.

Using Reaper and the Chef Automate AWS S3 Elasticsearch Service
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
``reaper['archive_destination']``: ``'s3'``
  Reaper will take snapshots and store them on an AWS S3 bucket.

The following options apply when ``reaper['archive_destination']`` is set to ``'s3'``:

``reaper['archive_region']``: string
  **Required.** The AWS region in which to store your snapshots. Example: ``'us-east-1'``.

``reaper['s3_bucket_name']``: string
  **Required.** The name of the S3 bucket in which to store your snapshots.

``reaper['aws_access_key_id']``:  string
  **Optional.** The AWS IAM Access Key ID to use when authenticating to S3. If omitted, Reaper will look for default AWS credentials. See the `Authenticating to AWS </data_retention_chef_automate.html#authenticating-to-aws>`__ section for more information.

``reaper['aws_secret_key']``: string
  **Optional.** The AWS IAM Secret Key to use when authenticating to S3. If omitted, Reaper will look for default AWS credentials. See the `Authenticating to AWS </data_retention_chef_automate.html#authenticating-to-aws>`__ section for more information.

Authenticating to AWS
=====================================================

Reaper uses Elasticsearch snapshots to archive your data, if requested. If you choose to archive your data to an AWS S3 bucket, your Chef Automate server (if using Chef Automate's provided Elasticsearch service) or each of your Elasticsearch nodes (if you're providing your own Elasticsearch service must be able to authenticate to S3.

Reaper supports three ways to authenticate:

 * **Option 1**: Assign an EC2 Instance Profile to each node running Elasticsearch that has permissions to read/write to your S3 bucket.
 * **Option 2**: Create an `AWS Security Credentials file <https://docs.aws.amazon.com/cli/latest/userguide/cli-chap-getting-started.html#cli-config-files>`__ on the Chef Automate server in ``.aws/credentials`` inside the ``delivery`` user's home directory.
 * **Option 3**: Specify the AWS Access Key ID and Security Key in the reaper configuration in ``/etc/delivery/delivery.rb``.

**Option 1 is the preferred solution.** This allows you to use AWS IAM best practices to control what nodes can access your S3 buckets and avoid needing to manage AWS credentials across multiple nodes. If EC2 Instance Profiles are not an option for you, Option 2 is the recommended solution.

Manually Invoking Reaper
=====================================================

If you need to free disk space immediately, reaper can be invoked on the command line.

When invoked manually, reaper accepts the following command line options:

``-c CONFIG_FILE``, ``--config CONFIG_FILE``
  Path to the reaper config file.

``-p PIDFILE``, ``--pid-file PIDFILE``
  Path to the pid file to use. Default: ``/var/opt/delivery/reaper/reaper.pid``.

``-l LOGFILE``, ``--log-file LOGFILE``
  Path to the reaper log file.

Reaper also accepts the following environment variables:

* ``REAPER_RETENTION_PERIOD_IN_DAYS``: Number of days of data to keep. Defaults to the value set in the configuration file. Requires Automate 1.7.5 or above.
* ``REAPER_WORKFLOW_API_HOST``: Hostname to use when connecting to the workflow API. Default value: ``localhost``.
* ``REAPER_WORKFLOW_API_PORT``: TCP port number the workflow API is listening on. By default, reaper will attempt to connect to the API via the load balancer on port ``8080``. The load balancer can be bypassed by setting this to ``9611``.
* ``CURATOR_ELASTICSEARCH_HOST``: Hostname to use when connecting to Elasticsearch. Default value: ``elasticsearch``.
* ``CURATOR_ELASTICSEARCH_PORT``: TCP port number Elasticsearch is listening on. Default value: ``9200``.
* ``CURATOR_ELASTICSEARCH_PREFIX``: Prefix to prepend to the path part of the URL for Elasticsearch, if Elasticsearch is accessed via a load balancer.

**Example:**

If both the workflow API and Elasticsearch are running locally, reaper can be invoked as follows:

.. code-block:: bash

  PATH=/opt/delivery/embedded/bin:$PATH \
  REAPER_RETENTION_PERIOD_IN_DAYS=14 \
  REAPER_WORKFLOW_API_PORT=9611 \
  CURATOR_ELASTICSEARCH_HOST='localhost' \
  CURATOR_ELASTICSEARCH_PORT='8080' \
  CURATOR_ELASTICSEARCH_PREFIX='/elasticsearch' \
  ruby /opt/delivery/embedded/service/reaper/bin/reaper \
  --config /var/opt/delivery/reaper/reaper_config.json \
  --log-file /var/log/delivery/reaper/reaper.log
