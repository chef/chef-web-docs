.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


In certain situations Chef provisioning will run multiple **machine** processes in-parallel, as long as each of the individual **machine** resources have the same declared action. The **machine_batch** resource is used to run in-parallel processes. 

Chef provisioning will processes resources in-parallel automatically, unless:

* The recipe contains complex scripts, such as when a **file** resource sits in-between two **machine** resources in a single recipe. In this situation, the resources will be run sequentially
* The actions specified for each individual **machine** resource are not identical; for example, if resource A is set to ``:converge`` and resource B is set to ``:destroy``, then they may not be processed in-parallel

To disable in-parallel processing, add the ``auto_machine_batch`` setting to the client.rb file, and then set it to ``false``.

For example, a recipe that looks like:

.. code-block:: ruby

   machine 'a'
   machine 'b'
   machine 'c'

will show output similar to:

.. code-block:: bash

   $ CHEF_DRIVER=fog:AWS chef-apply cluster.rb
   ...
   Converging 1 resources
   Recipe: @recipe_files::/Users/jkeiser/oc/environments/metal-test-local/cluster.rb
     * machine_batch[default] action converge
       - [a] creating machine a on fog:AWS:862552916454
       - [a]   key_name: "metal_default"
       - [a]   tags: {"Name"=>"a", ...}
       - [a]   name: "a"
       - [b] creating machine b on fog:AWS:862552916454
       - [b]   key_name: "metal_default"
       - [b]   tags: {"Name"=>"b", ...}
       - [b]   name: "b"
       - [c] creating machine c on fog:AWS:862552916454
       - [c]   key_name: "metal_default"
       - [c]   tags: {"Name"=>"c", ...}
       - [c]   name: "c"
       - [b] machine b created as i-eb778fb9 on fog:AWS:862552916454
       - create node b at http://localhost:8889
       -   add normal.tags = nil
       -   add normal.metal = {"location"=>{"driver_url"=>"fog:AWS:862552916454", ...}}
       - [a] machine a created as i-e9778fbb on fog:AWS:862552916454
       - create node a at http://localhost:8889
       -   add normal.tags = nil
       -   add normal.metal = {"location"=>{"driver_url"=>"fog:AWS:862552916454", ...}}
       - [c] machine c created as i-816d95d3 on fog:AWS:862552916454
       - create node c at http://localhost:8889
       -   add normal.tags = nil
       -   add normal.metal = {"location"=>{"driver_url"=>"fog:AWS:862552916454", ...}}
       - [b] waiting for b (i-eb778fb9 on fog:AWS:862552916454) to be ready ...
       - [c] waiting for c (i-816d95d3 on fog:AWS:862552916454) to be ready ...
       - [a] waiting for a (i-e9778fbb on fog:AWS:862552916454) to be ready ...
   ...
           Running handlers:
           Running handlers complete
   
           Chef Client finished, 0/0 resources updated in 4.053363945 seconds
       - [c] run 'chef-client -l auto' on c
   
   Running handlers:
   Running handlers complete
   Chef Client finished, 1/1 resources updated in 59.64014 seconds

At the end, it shows ``1/1 resources updated``. The three **machine** resources are replaced with a single **machine_batch** resource, which then runs each of the individual **machine** processes in-parallel.
