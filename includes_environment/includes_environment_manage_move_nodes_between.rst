.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

Nodes can be moved between environments, such as from a "dev" to a "production" environment by using the |subcommand knife exec| sub-command. For example:

.. code-block:: bash

   $ knife exec -E 'nodes.transform("chef_environment:dev") { |n| n.chef_environment("production") }'
