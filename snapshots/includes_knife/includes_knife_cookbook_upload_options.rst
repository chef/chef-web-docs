.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


This argument has the following options:

``-a``, ``--all``
   Upload all cookbooks.

``--concurrency``
   The number of allowed concurrent connections. Default: ``10``.

``-d``, ``--include-dependencies``
   Ensure that when a cookbook has a dependency on one (or more) cookbooks, those cookbooks are also uploaded.

``-E ENVIRONMENT``, ``--environment ENVIRONMENT``
   Use to set the environment version dependency to the cookbook version being uploaded.

``--force``
   Update a cookbook even if the ``--freeze`` flag has been set.

``--freeze``
   Require changes to a cookbook be included as a new version. Only the ``--force`` option can override this setting.

``-o PATH:PATH``, ``--cookbook-path PATH:PATH``
   The directory in which cookbooks are created. This can be a colon-separated path.
