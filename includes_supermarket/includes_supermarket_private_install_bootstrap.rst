.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


Bootstrap the node on which |supermarket| is to be installed. For example, to bootstrap a node runnnig |ubuntu| on |amazon aws|, the command is similar to:

.. code-block:: bash

   $ knife bootstrap ip_address -N supermarket-node -x ubuntu --sudo

where

* ``-N`` defines the name of the |supermarket| node
* ``-x`` defines the user name: ``supermarket-node``
* ``--sudo`` ensures that |sudo cmd| is used while running commands on the node during the bootstrap operation

When the bootstrap operation is finished, do the following:

#. Edit the node to add the wrapper cookbook's ``/recipes/default.rb`` recipe to the run-list:

   .. code-block:: bash

      $ knife node edit supermarket-node

   where ``supermarket-node`` is the name of the node that was just bootstrapped.

#. Add the recipe to the run-list:

   .. code-block:: ruby

	  "run_list": [
	    "recipe[my_supermarket_wrapper::default]"
	  ]

#. Start the |chef client| on the newly-bootstrapped |supermarket| node. For example, using |ssh|:

   .. code-block:: bash

      $ ssh ubuntu@your-supermarket-node-public-dns

#. After accessing the |supermarket| node, run the |chef client|:

   .. code-block:: bash

      $ sudo chef-client
