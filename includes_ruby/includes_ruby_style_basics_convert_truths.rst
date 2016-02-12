.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


Convert something to either true or false (``!!`` means not not!!):

.. code-block:: ruby

   !!true          # => true
   !!false         # => false
   !!nil           # => false (when pressed, nil is false)
   !!0             # => true (zero is NOT false).
