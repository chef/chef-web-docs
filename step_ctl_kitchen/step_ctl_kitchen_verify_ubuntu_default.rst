.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


To verify the default |ubuntu| instance, run the following:

.. code-block:: bash

   $ kitchen verify default-ubuntu-10.04

to return something similar to:

.. code-block:: bash

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

or:

.. code-block:: bash

   -----> Starting Kitchen (v1.0.0)
   -----> Setting up <default-ubuntu-10.04>
   Fetching: <name of test tool> (100%)
   Successfully installed <name of test tool>
   # gems installed
   -----> Setting up <name of test tool>
   ...
   -----> Running <name of test tool> test suite
    - <test result>

   2 tests, 1 failures
   ... exit code was 1
   >>>>>> description of failure
   ...
   >>>>>> ----------------------
   $ echo $?
   10
