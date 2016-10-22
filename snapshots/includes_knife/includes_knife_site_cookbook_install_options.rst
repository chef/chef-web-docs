.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


This argument has the following options:

``-b``, ``--use-current-branch``
   Ensure that the current branch is used.

``-B BRANCH``, ``--branch BRANCH``
   The name of the default branch. This defaults to the master branch.

``COOKBOOK_VERSION``
   The version of the cookbook to be installed. If a version is not specified, the most recent version of the cookbook is installed.

``-D``, ``--skip-dependencies``
   Ensure that all cookbooks to which the installed cookbook has a dependency are not installed.

``-o PATH:PATH``, ``--cookbook-path PATH:PATH``
   The directory in which cookbooks are created. This can be a colon-separated path.

