.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


This subcommand has the following options:

``QUERY``
   The search query used to identify a list of items on a Chef server. This option uses the same syntax as the ``search`` subcommand.

``-H``, ``--hide-healthy``
   Hide nodes on which a chef-client run has occurred within the previous hour.

``-r RUN_LIST``, ``--run-list RUN_LIST``
   A comma-separated list of roles and/or recipes to be applied.

``-s``, ``--sort-reverse``
   Sort a list by last run time, descending.
