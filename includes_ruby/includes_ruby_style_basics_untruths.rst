.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


Work with basic untruths (``!`` means not!):

.. code-block:: ruby

   !true           # => false
   !false          # => true
   !nil            # => true
   1 != 2          # => true (1 is not equal to 2)
   1 != 1          # => false (1 is not not equal to itself)
