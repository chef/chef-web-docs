.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

Use ``multiple_values`` if the source file uses the same key multiple times. All values will be aggregated in an array:

.. code-block:: ruby

   # # file structure:
   # key = a
   # key = b
   # key2 = c
   params['key'] = ['a', 'b']
   params['key2'] = ['c']

To use plain key value mapping, use ``multiple_values: false``:

.. code-block:: ruby

   # # file structure:
   # key = a
   # key = b
   # key2 = c
   params['key'] = 'b'
   params['key2'] = 'c'
