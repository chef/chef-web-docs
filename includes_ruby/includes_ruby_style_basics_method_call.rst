.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


Call a method on something with ``.method_name()``:

.. code-block:: ruby

   x = 'My String'
   x.split(' ')            # => ["My", "String"]
   x.split(' ').join(', ') # => "My, String"
