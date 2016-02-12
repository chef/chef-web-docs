.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


To test the default |ubuntu| instance, run the following:

.. code-block:: bash

   $ kitchen test default-ubuntu-10.04

to return something similar to:

.. code-block:: bash

   -----> Starting Kitchen (v1.0.0)
   -----> Cleaning up any prior instances of <default-ubuntu-10.04>
   -----> Destroying <default-ubuntu-10.04>...
   ...
   Finished destroying <default-ubuntu-10.04> (0m3.06s).
   -----> Testing <default-ubuntu-10.04>
   -----> Creating <default-ubuntu-10.04>...
   Bringing machine 'default' up with 'virtualbox' provider...
   ...
   Vagrant instance <default-ubuntu-10.04> created.
   Finished creating <default-ubuntu-10.04> (0m46.22s).
   -----> Converging <default-ubuntu-10.04>...
   ...
   -----> Installing Chef Omnibus (true)
   downloading https://www.chef.io/chef/install.sh
   ...
   Installing Chef
   ...
   Setting up chef (11.12.0-1.ubuntu.12.04) ...
   Thank you for installing Chef!
   ...
   Starting Chef Client, version 11.12.0
   ...
   Converging 2 resources
   Recipe: git::default
     * package[git] action install[date/time] INFO: Processing package[git] action install (git::default line 10)
   
       - install version 1:2.3.4.5-6 of package git
   
     * log[log_description] action write[date/time] INFO: Processing log[log_description] action write (git::default line 5)
   ...
   Chef Client finished, 2 resources updated
   Finished converging <default-ubuntu-10.04> (0m45.17s).
   -----> Starting Kitchen (v1.0.0)
   -----> Setting up <default-ubuntu-10.04>
   Fetching: <name of test tool> (100%)
   Successfully installed <name of test tool>
   # gems installed
   -----> Setting up <name of test tool>
   ...
   -----> Running <name of test tool> test suite
    ✓ <test result>

   2 tests, 0 failures
        Finished verifying <default-ubuntu-10.04> (2m1.12s).
   -----> Kitchen is finished. (2m3.45s)
   $ echo $?
   0
