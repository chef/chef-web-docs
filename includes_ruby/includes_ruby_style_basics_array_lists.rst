.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


Create lists using arrays:

.. code-block:: ruby

   x = ['a', 'b', 'c']   # => ["a", "b", "c"]
   x[0]                  # => "a" (zero is the first index)
   x.first               # => "a" (see?)
   x.last                # => "c"
   x + ['d']             # => ["a", "b", "c", "d"]
   x                     # => ["a", "b", "c"] ( x is unchanged)
   x = x + ['d']         # => ["a", "b", "c", "d"]
   x                     # => ["a", "b", "c", "d"]
