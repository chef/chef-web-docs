.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics. 


This subcommand has the following options:

``--chef-repo-path PATH``
   |path chef_repo| This setting will override the default path to the |chef repo|. Default: same value as specified by ``chef_repo_path`` in |client rb|.

``--concurrency``
   |concurrency| Default: ``10``.

``--[no-]recurse``
   |no_recurse_deps| This option can only be used when ``--tree`` is set to ``true``. Default: ``--no-recurse``.

``--remote``
   |remote deps_on_server| Default: ``false``.

``--repo-mode MODE``
   |repo_mode| Default: ``everything`` / ``hosted_everything``.

``--tree``
   |tree| Default: ``false``.

