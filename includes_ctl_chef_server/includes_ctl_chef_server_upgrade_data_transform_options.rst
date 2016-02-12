.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


This subcommand has the following options:

``-d DIRECTORY``, ``--chef11-data-dir DIRECTORY``
   The directory in which |chef server osc| server 11 data is located. Default value: a temporary directory.

``-e DIRECTORY``, ``--chef12-data-dir DIRECTORY``
   The directory in which |chef server| 12 data is located. Default value: a temporary directory.

``-f FULL_NAME``, ``--full-org-name FULL_NAME``
   The full name of the |chef server| organization. |name_rules org_full| For example: ``Chef Software, Inc.``. If this option is not specified, the ``upgrade`` command will prompt for it.

``-h``, ``--help``
   Use to show help for the ``chef-server-ctl upgrade`` subcommand.

``-o ORG_NAME``, ``--org-name ORG_NAME``
   The name of the |chef server| organization. |name_rules org| For example: ``chef``. If this option is not specified, the ``upgrade`` command will prompt for it.
