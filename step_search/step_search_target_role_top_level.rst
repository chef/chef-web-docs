.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

To search a top-level run-list for a role named ``load_balancer`` use the ``knife search`` subcommand from the command line or the ``search`` method in a recipe. For example:

.. code-block:: bash

   $ knife search node role:load_balancer

and from within a recipe:

.. code-block:: ruby

   search(:node, 'role:load_balancer')
  