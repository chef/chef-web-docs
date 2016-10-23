.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


A node's initial run-list is specified using a JSON file on the host system. When running the chef-client as an executable, use the ``-j`` option to tell the chef-client which JSON file to use. For example:

.. code-block:: bash

   $ chef-client -j /etc/chef/file.json --environment _default

where ``file.json`` is similar to:

.. code-block:: javascript

   {
     "resolver": {
       "nameservers": [ "10.0.0.1" ],
       "search":"int.example.com"
     },
     "run_list": [ "recipe[resolver]" ]
   }

and where ``_default`` is the name of the environment that is assigned to the node.

.. warning:: This approach may be used to update ``normal`` attributes, but should never be used to update any other attribute type, as all attributes updated using this option are treated as ``normal`` attributes.
