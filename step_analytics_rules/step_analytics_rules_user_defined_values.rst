.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

The following rule sets, and then uses a user-defined value:

.. code-block:: ruby

   rules "user-agent matching"
     rule on action
     when
       entity_name = "app1"
     then
       set(#foo, requestor_name)
     otherwise
       set(#bar, task)
     end
   
     // ... other rules could go here
   
     rule on action
     when
       // #foo might be undefined, so use get()
       // to supply a default value of false to perform the
       // test
       get(#foo, false) != false
     then
       alert:info(#foo)
     end
   end
