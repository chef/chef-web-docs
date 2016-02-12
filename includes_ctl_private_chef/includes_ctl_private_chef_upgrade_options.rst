.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


This subcommand has the following options:

``--chef-server-url``
   |url chef_server|

``--full-org-name``
   The full name of the |chef server| organization. For example: ``Chef Software, Inc.``. If this option is not specified, the ``upgrade`` command will prompt for it.

``-h``, ``--help``
   Use to show help for the ``private-chef-ctl upgrade`` subcommand.

``--org-name``
   The name of the |chef server| organization. For example: ``chef``. If this option is not specified, the ``upgrade`` command will prompt for it.

``--upload-threads NUMBER``
   The number of threads to use when migrating cookbooks. 

``-y``, ``--yes``
   Use to skip confirmation prompts during the upgrade process.