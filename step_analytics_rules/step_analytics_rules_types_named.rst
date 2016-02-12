.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


A named rule:

.. code-block:: ruby

   rule "name" on action
   when
     organization_name = "ponyville"
   then
     set(#foo, "100")  
   end
