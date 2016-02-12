.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


Run:

.. code-block:: bash

   $ kitchen converge

Returns:

.. code-block:: bash

   -----> Converging <default-centos-64>...
          Preparing files for transfer
          Resolving cookbook dependencies with Berkshelf 3.1.5...
          Removing non-cookbook files before transfer
          Transfering files to <default-centos-64>
          [2014-11-10T09:20:26+00:00] INFO: Starting chef-zero on host localhost
            port 8889 with repository at repository at /tmp/kitchen
            One version per cookbook
   
          [2014-11-10T09:20:26+00:00] INFO: Forking chef instance to converge...
          Starting Chef Client, version 11.16.4
          [2014-11-10T09:20:27+00:00] INFO: *** Chef 11.16.4 ***
          [2014-11-10T09:20:27+00:00] INFO: Chef-client pid: 571
    ...
