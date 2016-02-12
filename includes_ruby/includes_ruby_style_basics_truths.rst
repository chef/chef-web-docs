.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


Work with basic truths:

.. code-block:: ruby

   true            # => true
   false           # => false
   nil             # => nil
   0               # => true ( the only false values in Ruby are false
                   #    and nil; in other words: if it exists in Ruby,
                   #    even if it exists as zero, then it is true.)
   1 == 1          # => true ( == tests for equality )
   1 == true       # => false ( == tests for equality )
