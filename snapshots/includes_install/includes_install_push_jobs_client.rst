.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics. 

To set up the Chef push jobs client:

#. Add the **push-jobs** cookbook to the run-list for each of the nodes on which Chef push jobs is to be configured.
#. Add the following default attributes on all nodes that are managed by Chef push jobs:

   .. code-block:: javascript

      "push_jobs": {
        "package_url": "<package_url>",
        "package_checksum": "<checksum>"
      }

#. Run the chef-client to configure Chef push jobs
#. Verify that the Chef push jobs client is running as a daemon or as a service:

   .. code-block:: bash

      $ knife node status node_name

   for a specific node and:

   .. code-block:: bash

      $ knife node status

   for all nodes.
