.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


This subcommand has the following options:

``-c``, ``--cleanup-only``
   Use to stop the |chef server osc| server. This option does not download data to or start the |chef server osc| server.

``-d DIRECTORY``, ``--chef11-data-dir DIRECTORY``
   The directory in which |chef server osc| 11 data is located. Default value: a temporary directory.

   .. warning:: The short name for this command is a duplicate short name and should not be used. Use the ``--chef11-data-dir`` long name instead.

``-d``, ``--download-only``
   Use to download data to |chef server| 12, and then create the public key file. This option does not start or stop the |chef server osc| server.

``-h``, ``--help``
   Use to show help for the ``chef-server-ctl upgrade`` subcommand.

``-k KEY``, ``--key KEY``
   |file public_key| Default value: ``/etc/chef-server/admin.pem``.

``-s URL``, ``--chef11-server-url URL``
   The URL for the |chef server osc| or |chef server oec| server, version 11. Default value: ``https://localhost``.

``-S``, ``--setup-only``
   Use to stop |chef server| 12, and then start the |chef server osc| server in preparation for downloading data. This option does not download data to or stop the |chef server osc| server.

``-u USER``, ``--user``
   |admin client|
