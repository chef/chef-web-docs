.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


The ``remove-partition`` subcommand remove partitions for a specific month and/or year or remove partitions that occur prior to a specified month and year.

This subcommand has the following syntax:

.. code-block:: bash

   $ opscode-reporting-ctl remove-partition

This tool has the following options:

``-b YYYY-MM``, ``--before YYYY-MM``
   Use to remove partitions that exist before the specified month (``MM``) in the specified year (``YYYY``).

``-d``, ``--dryrun``
   Use as part of a command to test partition removal, but without actually removing any partitions.

``-m YYYY-MM``, ``--month YYYY-MM``
   Use to remove partitions for the specified month (``MM``) in the specified year (``YYYY``).

``-y YYYY``, ``--year YYYY``
   Use to remove partitions for the specified year (``YYYY``).
