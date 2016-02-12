.. The contents of this file are included in multiple topics.
.. This file describes a command or a sub-command for Knife.
.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics. 


This subcommand has the following options:

``--chef-repo-path PATH``
   |path chef_repo| This setting will override the default path to the |chef repo|. Default: same value as specified by ``chef_repo_path`` in |client rb|.

``--cookbook-version VERSION``
   |version cookbook_download|

``--concurrency``
   |concurrency| Default: ``10``.

``--diff-filter=[(A|D|M|T)...[*]]``
   |diff_filter| Default value: ``nil``.

``--name-only``
   |name only|

``--name-status``
   |name status|

``--no-recurse``
   |no_recurse_diff| Default: ``--recurse``.

``--repo-mode MODE``
   |repo_mode| Default: ``everything`` / ``hosted_everything``.
