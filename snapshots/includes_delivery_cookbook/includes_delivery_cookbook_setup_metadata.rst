.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


The metadata.rb for a ``build-cookbook`` is located at ``.delivery/build-cookbook/metadata.rb``. Update it to include:

.. code-block:: none

   depends 'delivery-truck'

This will ensure that the ``build-cookbook`` has a dependency on the ``delivery-truck`` cookbook.
