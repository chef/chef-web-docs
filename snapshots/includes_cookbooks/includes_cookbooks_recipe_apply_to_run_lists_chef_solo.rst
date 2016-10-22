.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

Use a JSON file to pass run-list details to chef-solo as long as the cookbook in which the recipe is located is available to the system on which chef-solo is running. For example, a file named ``dna.json`` contains the following details:

.. code-block:: none

   {
     "run_list": ["recipe[apache2]"]
   }

To add the run-list to the node, enter the following:

.. code-block:: bash

   $ sudo chef-solo -j /etc/chef/dna.json
