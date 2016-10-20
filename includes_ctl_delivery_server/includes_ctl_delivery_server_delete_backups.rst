.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


The ``delete-backups`` subcommand is used to delete |delivery| backup archives and Elasticseach snapshots. The command matches a given regular expression and prompts the user to confirm deletion of each matched backup or snapshot.

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
