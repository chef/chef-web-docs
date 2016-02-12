.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


Use the |subcommand knife serve| subcommand to run a persistent |chef zero| against the local |chef repo|. (|chef zero| is a lightweight |chef server| that runs in-memory on the local machine.) This is the same as running the |chef client| executable with the ``--local-mode`` option. The ``chef_repo_path`` is located automatically and the |chef server| will bind to the first available port between ``8889`` and ``9999``. |subcommand knife serve| will print the URL for the local |chef server|, so that it may be added to the |knife rb| file.
