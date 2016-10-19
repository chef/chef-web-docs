.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

The ``list-backups`` subcommand is used to list |delivery| backup archives and Elasticseach snapshots.

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
