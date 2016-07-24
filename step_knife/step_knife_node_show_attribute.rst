.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


To list a single node attribute:

.. code-block:: bash

   knife node show NODE_NAME -a ATTRIBUTE_NAME

where ``ATTRIBUTE_NAME`` is something like ``kernel`` or ``platform``.

To list a nested attribute:

.. code-block:: bash

   knife node show NODE_NAME -a ATTRIBUTE_NAME.NESTED_ATTRIBUTE_NAME

where ``ATTRIBUTE_NAME`` is something like ``kernel`` and ``NESTED_ATTRIBUTE_NAME`` is something like ``machine``.
