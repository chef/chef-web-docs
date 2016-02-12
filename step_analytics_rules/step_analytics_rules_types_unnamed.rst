.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


An unnamed rule:

.. code-block:: ruby

   rule on action
   when
     entity_name = "app1"
   then
     set(#foo, "100")  
   end
