.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

The following rule verfies if a specific role appears in a run-list:

.. code-block:: ruby

   rules "Check a converge run_list"
     rule on run_converge
     when
       array:contains(run_list, 'role[opscode-reporting]')
     then
       alert:info("run_list contains role[opscode-reporting]")
     end
   end
