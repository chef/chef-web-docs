.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

The following rule verifies if resources have been updated on a ``run_converge``:

.. code-block:: ruby

   rules "Match a run converge"
     rule on run_converge
     when
       total_resource_count > 1 and 
       updated_resource_count > 0
     then
       alert:info("Run converge detected at {{ message.end_time }} ")
     end
   end
