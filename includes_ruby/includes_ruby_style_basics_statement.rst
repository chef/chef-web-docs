.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


Use conditions! For example, an ``if`` statement

.. code-block:: ruby

   if false
     # this won't happen
   elsif nil
     # this won't either
   else
     # code here will run though
   end

or a ``case`` statement:

.. code-block:: ruby

   x = 'dog'
   case x
   when 'fish'
    # this won't happen
   when 'dog', 'cat', 'monkey'
     # this will run
   else
     # the else is an optional catch-all
   end
