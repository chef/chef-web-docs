.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

Use ``key_vals`` to test how many values a key contains:

.. code-block:: ruby

   key = a b c

contains three values. To test that value to ensure it only contains one, use:

.. code-block:: ruby

   key_vals: 1
