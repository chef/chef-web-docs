.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


Use the backslash character (``\``) as an escape character when quotes must appear within strings. However, you do not need to escape single quotes inside double quotes. For example:

.. code-block:: ruby

   'It\'s alive!'                        # => "It's alive!"
   "Won\'t you read Grant\'s book?"      # => "Won't you read Grant's book?"
