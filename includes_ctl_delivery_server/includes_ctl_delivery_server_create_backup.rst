.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


The ``create-backup`` subcommand is used to create |delivery| backup archives and Elasticseach snapshots. When used with the default configuration it will create backup archives and Elasticseach snapshots and export them into the ``/var/opt/delivery/backups`` and ``/var/opt/delivery/elasticsearch_backups`` directories.

The storage location of the backup archives and snapshots can be configured by setting ``backup['location']`` and ``backup['elasticsearch']['location']`` in ``delivery.rb``.

.. note:: Under normal operating circumstances the |delivery| RabbitMQ queues are not likely to be lengthy. When factoring that fact with the requirement of shutting down |delivery| services in order to take a backup of RabbitMQ, it was determined that it was not ideal to include RabbitMQ data by default.

**Backing up to S3**

While not enabled by default, the utility supports backing up |delivery| archives and snapshots directly to |amazon aws| S3.

To enable this functionality, first configure the machine with access to the desired S3 bucket using either an instance profile with a valid S3 policy or a standard shared credential file located at ``/root/.aws/credentials``.

Below is an example |amazon aws| instance profile policy with the required permissions:

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

Next, configure |delivery| to use S3. For example:

.. code-block:: ruby

   backup['bucket']                    = 'example-backups'
   backup['region']                    = 'us-west-2'
   backup['type']                      = 's3'
   backup['elasticsearch']['bucket']   = 'example-backups'
   backup['elasticsearch']['region']   = 'us-west-2'
   backup['elasticsearch']['type']     = 's3'

.. note:: Using the same bucket for backup archives and snapshots is supported but both must be configured independently.

See the complete list of |delivery| :doc:`configuration options </config_rb_delivery_optional_settings>` for additional backup configuration.

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
