.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

The ``gids`` matcher tests if the group indentifiers in the test match group identifiers in ``/etc/passwd``:

.. code-block:: ruby

   its('gids') { should eq 1234 }
