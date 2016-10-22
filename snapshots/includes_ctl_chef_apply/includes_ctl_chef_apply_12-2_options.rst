.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


This command has the following syntax:

.. code-block:: bash

   $ chef-apply name_of_recipe.rb

This tool has the following options:

``-e RECIPE_TEXT``, ``--execute RECIPE_TEXT``
   Execute a resource using a string.

``-l LEVEL``, ``--log_level LEVEL``
   The level of logging to be stored in a log file.

``-s``, ``--stdin``
   Execute a resource using standard input.

``-v``, ``--version``
   The version of the chef-client.

``-W``, ``--why-run``
   Run the executable in why-run mode, which is a type of chef-client run that does everything except modify the system. Use why-run mode to understand why the chef-client makes the decisions that it makes and to learn more about the current and proposed state of the system.

``-h``, ``--help``
   Show help for the command.

