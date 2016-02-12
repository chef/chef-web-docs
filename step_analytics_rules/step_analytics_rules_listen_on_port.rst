.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


The following rule shows how to define a rule that sends a notification when a machine is listening for connections on port 23:

.. code-block:: ruby

   rules "pci check telnet port"
     rule on run_control
     when
       name = "should be listening" and
       resource_type = "port" and
       resource_name = 23 and
       status != "success"
     then
       alert:error("Encrypt all non-console administrative access such as browser/Web-based management tools.")
       notify("some_alias", "A machine is listening for connections on port 23!")
     end
   end