.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


Use the ``--opt`` option to pass arbitrary command-line options. For example:

.. code-block:: bash

   $ chef provision (other options) --opt foo=bar

Use the ``--opt`` option more than once to pass more than one option. For example:

.. code-block:: bash

   $ chef provision (other options) --opt foo=bar --opt baz=qux