.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

The ``foodcritic`` command is used to run |foodcritic| against one (or more) cookbooks.

This command has the following syntax:

.. code-block:: bash

   $ foodcritic COOKBOOK_PATH

This command has the following options:

``-C``, ``--[no-]context``
   Use to show lines matched against |foodcritic| rules, rather than the default summary.

``-f TAGS``, ``--epic-fail TAGS``
   Use to trigger a build failure if any of the specified tags are matched.

``-I PATH``, ``--include PATH``
   Use to specify the path to a file that contains additional |foodcritic| rules.

``-r``, ``--[no-]repl``
   Use to drop into a REPL for interactive rule editing.

``-S PATH``, ``--search-grammar PATH``
   Use to specify the path to a file that contains additional grammar used when validating search syntax.

``-t TAGS``, ``--tags TAGS``
   Use to only the specified tags when checking against |foodcritic| rules.

``-V``, ``--version``
   Use to display the version of |foodcritic|.
