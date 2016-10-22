.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


This subcommand has the following options:

``--force``
   Use ``--force`` to download files even when the file on the hard drive is identical to the object on the server (role, cookbook, etc.). By default, files are compared to see if they have equivalent content, and local files are only overwritten if they are different.

``-n``, ``--dry-run``
   Take no action and only print out results.

``--[no-]recurse``
   Use ``--no-recurse`` to disable downloading a directory recursively. Default: ``--recurse``.

``--purge``
   Use ``--purge`` to delete local files and directories that do not exist on the Chef server. By default, if a role, cookbook, etc. does not exist on the Chef server, the local file for said role is left alone and NOT deleted.



