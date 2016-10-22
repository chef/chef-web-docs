.. The contents of this file are included in multiple topics.
.. This file describes a command or a subcommand for Knife.
.. This file should not be changed in a way that hinders its ability to appear in multiple documentation sets.

When chef-shell is configured to access a Chef server, chef-shell can list, show, search for and edit cookbooks, clients, nodes, roles, environments, and data bags.

The syntax for managing objects on the Chef server is as follows:

.. code-block:: bash

   $ chef (named_configuration) > items.command

where:

* ``named_configuration`` is a named configuration, such as ``production``, ``staging``, or ``test``
* ``items`` is the type of item to search for: ``cookbooks``, ``clients``, ``nodes``, ``roles``, ``environments`` or a data bag
* ``command`` is the command: ``list``, ``show``, ``find``, or ``edit``

For example, to list all of the nodes in a configuration named "preprod":

.. code-block:: bash

   $ chef (preprod) > nodes.list

to return something similar to:

.. code-block:: bash

   $ => [node[i-f09a939b], node[i-049a936f], node[i-eaaaa581], node[i-9154b1fb], 
        node[i-6a213101], node[i-c2687aa9], node[i-7abeaa11], node[i-4eb8ac25], 
        node[i-9a2030f1], node[i-a06875cb], node[i-145f457f], node[i-e032398b], 
        node[i-dc8c98b7], node[i-6afdf401], node[i-f49b119c], node[i-5abfab31], 
        node[i-78b8ac13], node[i-d99678b3], node[i-02322269], node[i-feb4a695], 
        node[i-9e2232f5], node[i-6e213105], node[i-cdde3ba7], node[i-e8bfb083], 
        node[i-743c2c1f], node[i-2eaca345], node[i-aa7f74c1], node[i-72fdf419], 
        node[i-140e1e7f], node[i-f9d43193], node[i-bd2dc8d7], node[i-8e7f70e5], 
        node[i-78f2e213], node[i-962232fd], node[i-4c322227], node[i-922232f9], 
        node[i-c02728ab], node[i-f06c7b9b]]

The ``list`` command can take a code block, which will applied (but not saved) to each object that is returned from the server. For example:

.. code-block:: bash

   $ chef (preprod) > nodes.list {|n| puts "#{n.name}: #{n.run_list}" }

to return something similar to:

.. code-block:: bash

   $ => i-f09a939b: role[lb], role[preprod], recipe[aws]
        i-049a936f: role[lb], role[preprod], recipe[aws]
        i-9154b1fb: recipe[erlang], role[base], role[couchdb], role[preprod],
        i-6a213101: role[chef], role[preprod]
        # more...

The ``show`` command can be used to display a specific node. For example:

.. code-block:: bash

   $ chef (preprod) > load_balancer = nodes.show('i-f09a939b')

to return something similar to:

.. code-block:: bash

   $ => node[i-f09a939b]

or:

.. code-block:: bash

   $ chef (preprod) > load_balancer.ec2.public_hostname

to return something similar to:

.. code-block:: bash

   $ => "ec2-111-22-333-44.compute-1.amazonaws.com"

The ``find`` command can be used to search the Chef server from the chef-shell. For example:

.. code-block:: bash

   $ chef (preprod) > pp nodes.find(:ec2_public_hostname => 'ec2*')

A code block can be used to format the results. For example:

.. code-block:: bash

   $ chef (preprod) > pp nodes.find(:ec2_public_hostname => 'ec2*') {|n| n.ec2.ami_id } and nil

to return something similar to:

.. code-block:: bash

   $ => ["ami-f8927a91",
         "ami-f8927a91",
         "ami-a89870c1",
         "ami-a89870c1",
         "ami-a89870c1",
         "ami-a89870c1",
         "ami-a89870c1"
         # and more...

Or:

.. code-block:: bash

   chef (preprod) > amis = nodes.find(:ec2_public_hostname => 'ec2*') {|n| n.ec2.ami_id }
   chef (preprod) > puts amis.uniq.sort

to return something similar to:

.. code-block:: bash

   $ => ami-4b4ba522
        ami-a89870c1
        ami-eef61587
        ami-f8927a91
