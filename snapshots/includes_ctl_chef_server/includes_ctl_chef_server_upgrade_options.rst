.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


This subcommand has the following options:

``-d DIRECTORY``, ``--chef11-data-dir DIRECTORY``
   The directory in which Open Source Chef 11 data is located. Default value: a temporary directory.

``-e DIRECTORY``, ``--chef12-data-dir DIRECTORY``
   The directory in which Chef server 12 data is located. Default value: a temporary directory.

``-f FULL_NAME``, ``--full-org-name FULL_NAME``
   The full name of the Chef server organization. The full name must begin with a non-white space character and must be between 1 and 1023 characters. For example: ``Chef Software, Inc.``. If this option is not specified, the ``upgrade`` command will prompt for it.

``-h``, ``--help``
   Use to show help for the ``chef-server-ctl upgrade`` subcommand.

``-k KEY_PATH``, ``--key KEY_PATH``
   The Open Source Chef 11 ``admin.pem`` key for the API client. This is the key used to download Open Source Chef 11 data. Default value: ``/etc/chef-server/admin.pem``.

``-o ORG_NAME``, ``--org-name ORG_NAME``
   The name of the Chef server organization. The name must begin with a lower-case letter or digit, may only contain lower-case letters, digits, hyphens, and underscores, and must be between 1 and 255 characters. For example: ``chef``. If this option is not specified, the ``upgrade`` command will prompt for it.

``-s URL``, ``--chef11-server-url URL``
   The URL for the Open Source Chef or Enterprise Chef server, version 11. Default value: ``https://localhost``.

``-t NUMBER``, ``--upload-threads NUMBER``
   The number of threads to use when migrating cookbooks. Default value: ``10``.

``-u USER``, ``--user``
   Create a client as an admin client. This is required for any user to access Open Source Chef as an administrator.

``-x URL``, ``--chef12-server-url URL``
   The URL for the Chef server, version 12. Default value: ``https://localhost``.

``-y``, ``--yes``
   Use to skip confirmation prompts during the upgrade process.
