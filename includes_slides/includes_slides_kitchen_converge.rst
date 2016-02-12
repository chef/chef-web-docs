.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


Run:

.. code-block:: bash

   $ kitchen converge

Returns:

.. code-block:: bash

   ----> Starting Kitchen (v1.2.1)
   -----> Converging <default-centos-64>...
          Preparing files for transfer
          Resolving cookbook dependencies with Berkshelf 3.1.5...
          Removing non-cookbook files before transfer
   -----> Installing Chef Omnibus (true)
          downloading https://www.getchef.com/chef/install.sh
            to file /tmp/install.sh
          trying curl...
