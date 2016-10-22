.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

The following rule raises an alert when a ``run_control_group`` fails, signifying that one or more controls failed:

.. code-block:: javascript

    rules "throw errors on control group failure"
     rule on run_converge
     when
       true
     then
       alert:info("Run converge detected at {{ message.end_time }} ")
     end
   
     rule on run_control_group
     when
       true
     then
       // the run_control_group name will appear in double quotes
       alert:info("Run control group \"{{ message.name }}\" failed on {{ message.run.node_name }}")
     end
   end
