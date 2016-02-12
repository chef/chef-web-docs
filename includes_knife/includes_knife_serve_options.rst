.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


This subcommand has the following options:

``--chef-repo-path PATH``
   |path chef_repo| Default value: same as ``chef_repo_path`` in the |client rb| file.

``--chef-zero-host IP``
   |host chef_zero| Default value: ``127.0.0.1``.

``--chef-zero-port PORT``
   |port chef_zero| The default behavior will bind to the first available port between ``8889`` and ``9999``.

``--repo-mode MODE``
   Use to specify the local |chef repo| layout. Possible values: ``static`` (for environments, roles, data bags, and cookbooks), ``everything`` (same as static, plus nodes, clients, and users), ``hosted_everything`` (for ACLs, groups). Default value: ``everything/hosted_everything``.

