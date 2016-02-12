.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics. 


This subcommand has the following options:

``--chef-repo-path PATH``
   |path chef_repo| This setting will override the default path to the |chef repo|. Default: same value as specified by ``chef_repo_path`` in |client rb|.

``--concurrency``
   |concurrency| Default: ``10``.

``--cookbook-version VERSION``
   |version cookbook_download|

``-n``, ``--dry-run``
   |dry_run| Default: ``false``.

``--[no-]diff``
   |diff_download| Set to ``false`` to download all files. Default: ``--diff``.

``--[no-]force``
   |force knife download| Default: ``--no-force``.

``--[no-]purge``
   |purge knife download| Default: ``--no-purge``.

``--[no-]recurse``
   |no_recurse_download| Default: ``--recurse``.

``--repo-mode MODE``
   |repo_mode| Default: ``everything`` / ``hosted_everything``.

