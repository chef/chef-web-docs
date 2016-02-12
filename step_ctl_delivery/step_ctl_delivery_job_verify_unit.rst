.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

To run your unit tests on your local machine the same way they'd be run on |chef delivery|, run the following command:

.. code-block:: bash

   $ delivery job verify unit --local

which will return output similar to:

.. code-block:: bash

   Chef Delivery
   Loading configuration from /Users/adam/src/opscode/delivery/opscode/delivery-cli
   Starting job for verify unit
   Creating workspace
   Cloning repository, and merging adam/job to master
   Configuring the job
   Running the job
   Starting Chef Client, version 11.18.0.rc.1
   resolving cookbooks for run list: ["delivery_rust::unit"]
   Synchronizing Cookbooks:
     - delivery_rust
     - build-essential
   Compiling Cookbooks...
   Converging 2 resources
   Recipe: delivery_rust::unit
     * execute[cargo clean] action run
       - execute cargo clean
     * execute[cargo test] action run
       - execute cargo test
   
   Running handlers:
   Running handlers complete
   Chef Client finished, 2/2 resources updated in 32.770955 seconds
