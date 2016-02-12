.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


Embed |ruby| in a string:

.. code-block:: ruby

   x = 'Bob'
   "Hi, #{x}"      # => "Hi, Bob"
   'Hello, #{x}'   # => "Hello, \#{x}" Notice that single quotes don't work with #{}
