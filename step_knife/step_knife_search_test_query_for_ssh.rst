.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


To test a search query that will be used in a ``knife ssh`` subcommand:

.. code-block:: bash

   $ knife search node "role:web NOT name:web03"

where the query in the previous example will search all servers that have the ``web`` role, but not on the server named ``web03``.


