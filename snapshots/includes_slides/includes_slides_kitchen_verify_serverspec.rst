.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


Run:

.. code-block:: bash

   $ kitchen verify

Returns:

.. code-block:: none

   -----> Running serverspec test suite
          /opt/chef/embedded/bin/ruby -I/tmp/busser/suites/serverspec 
         -I/tmp/busser/gems/gems/rspec-support-3.1.2/lib:/tmp/busser/gems/gems/rspec-core-3.1.7/lib    
         /opt/chef/embedded/bin/rspec --pattern /tmp/busser/suites/serverspec/\*\*/\*_spec.rb --color 
         --format documentation --default-path /tmp/busser/suites/serverspec
   
     apache
       is awesome
   
     Finished in 0.02823 seconds (files took 0.99875 seconds to load)
     1 example, 0 failures
     Finished verifying <default-centos-64> (0m5.03s).
