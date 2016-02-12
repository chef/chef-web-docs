.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


This subcommand has the following options:

``-c CONFIG_FILE``, ``--config CONFIG_FILE``
   The path to the |knife| configuration file.

``-D``, ``--debug``
   Use to enable stack traces and other debug output. Default value: ``false``.

``-g GIT_REF``, ``--git GIT_REF``
   Use to compare the specified |git| reference against the current revision of a |policylock| file or against another |git| reference. 

``-h``, ``--help``
   |help subcommand|

``--head``
   Use as a shortcut for ``chef diff --git HEAD``. When a |git|-specific flag is not provided, the on-disk |policylock| file is compared to one on the |chef server| or (if a |policylock| file is not present on-disk) two |policylock| files in the specified policy group on the |chef server| are compared.

``--[no-]pager``
   Use ``--pager`` to enable paged output for a |policylock| file. Default value: ``--pager``.

``-v``, ``--version``
   |version chef|
