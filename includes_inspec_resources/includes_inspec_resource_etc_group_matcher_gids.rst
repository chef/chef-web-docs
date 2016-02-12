.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

The ``gids`` matcher tests if the named group identifier is present or if it contains duplicates:

.. code-block:: ruby

   its('gids') { should_not contain_duplicates }
