.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


This argument has the following options:

``-a``, ``--all``
   Delete all cookbooks (and cookbook versions).

``COOKBOOK_VERSION``
   The version of a cookbook to be deleted. If a cookbook has only one version, this option does not need to be specified. If a cookbook has more than one version and this option is not specified, knife  prompts for a version.

``-p``, ``--purge``
   Entirely remove a cookbook (or cookbook version) from the Chef server. Use this action carefully because only one copy of any single file is stored on the Chef server. Consequently, purging a cookbook disables any other cookbook that references one or more files from the cookbook that has been purged.

