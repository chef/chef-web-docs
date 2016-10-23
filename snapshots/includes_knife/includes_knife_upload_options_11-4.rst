.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


This subcommand has the following options:

``--force``
   Use ``--force`` to upload roles, cookbooks, etc. even if the file in the directory is identical (by default, no ``POST`` or ``PUT`` is performed unless an actual change would be made).

``-n``, ``--dry-run``
   Take no action and only print out results.

``--purge``
   Use ``--purge`` to delete roles, cookbooks, etc. from the Chef server if their corresponding files do not exist in the chef-repo. By default, such objects are left alone and NOT purged.

``--recurse``
   Use ``--no-recurse`` to disable uploading a directory recursively. Default: ``--recurse``.

