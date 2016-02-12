.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


The |subcommand knife bootstrap| subcommand is used to run a bootstrap operation that installs the |chef client| on the target node. The following steps describe how to bootstrap a node using |knife|.

#. Identify the |fqdn| or IP address of the target node. The ``knife bootstrap`` command requires the |fqdn| or the IP address for the node in order to complete the bootstrap operation.

#. Once the workstation machine is configured, it can be used to install the |chef client| on one (or more) nodes across the organization using a |knife| bootstrap operation. The ``knife bootstrap`` command is used to |ssh| into the target machine, and then do what is needed to allow the |chef client| to run on the node. It will install the |chef client| executable (if necessary), generate keys, and register the node with the |chef server|. The bootstrap operation requires the IP address or |fqdn| of the target system, the |ssh| credentials (username, password or identity file) for an account that has root access to the node, and (if the operating system is not |ubuntu|, which is the default distribution used by ``knife bootstrap``) the operating system running on the target system.

   In a command window, enter the following:

   .. code-block:: bash

      $ knife bootstrap 123.45.6.789 -x username -P password --sudo

   where ``123.45.6.789`` is the IP address or the |fqdn| for the node. Use the ``--distro`` option to specify a non-default distribution. For more information about the options available to the |subcommand knife bootstrap| command for |ubuntu|- and |linux|-based platforms, see `knife bootstrap <https://docs.chef.io/knife_bootstrap.html>`_. For |windows|, the |subcommand knife windows| plugin is required, see `knife windows <https://docs.chef.io/plugin_knife_windows.html>`_.

   And then while the bootstrap operation is running, the command window will show something like the following:

   .. code-block:: bash

      Bootstrapping Chef on 123.45.6.789
      123.45.6.789 knife sudo password: 
      Enter your password: 
      123.45.6.789 
      123.45.6.789 [Fri, 07 Sep 2012 11:05:05 -0700] INFO: *** Chef 10.12.0 ***
      123.45.6.789 
      123.45.6.789 [Fri, 07 Sep 2012 11:05:07 -0700] INFO: Client key /etc/chef/client.pem is not present - registering
      123.45.6.789 
      123.45.6.789 [Fri, 07 Sep 2012 11:05:15 -0700] INFO: Setting the run_list to [] from JSON
      123.45.6.789 
      123.45.6.789 [Fri, 07 Sep 2012 11:05:15 -0700] INFO: Run List is []
      123.45.6.789 
      123.45.6.789 [Fri, 07 Sep 2012 11:05:15 -0700] INFO: Run List expands to []
      123.45.6.789 
      123.45.6.789 [Fri, 07 Sep 2012 11:05:15 -0700] INFO: Starting Chef Run for name_of_node
      123.45.6.789 
      123.45.6.789 [Fri, 07 Sep 2012 11:05:15 -0700] INFO: Running start handlers
      123.45.6.789 
      123.45.6.789 [Fri, 07 Sep 2012 11:05:15 -0700] INFO: Start handlers complete.
      123.45.6.789 
      123.45.6.789 [Fri, 07 Sep 2012 11:05:17 -0700] INFO: Loading cookbooks []
      123.45.6.789 
      123.45.6.789 [Fri, 07 Sep 2012 11:05:17 -0700] WARN: Node name_of_node has an empty run list.
      123.45.6.789 
      123.45.6.789 [Fri, 07 Sep 2012 11:05:19 -0700] INFO: Chef Run complete in 3.986283452 seconds
      123.45.6.789 
      123.45.6.789 [Fri, 07 Sep 2012 11:05:19 -0700] INFO: Running report handlers
      123.45.6.789 
      123.45.6.789 [Fri, 07 Sep 2012 11:05:19 -0700] INFO: Report handlers complete
      123.45.6.789

#. After the bootstrap operation has finished, verify that the node is recognized by the |chef server|. To show only the node that was just bootstrapped, run the following command:

   .. code-block:: bash

      $ knife client show name_of_node
   
   where ``name_of_node`` is the name of the node that was just bootstrapped. The |chef server| will return something similar to:

   .. code-block:: bash
   
      admin:       false
      chef_type:   client
      json_class:  Chef::ApiClient
      name:        name_of_node
      public_key: 

   and to show the full list of nodes (and workstations) that are registered with the |chef server|, run the following command:

   .. code-block:: bash

      knife client list

   The |chef server| will return something similar to:

   .. code-block:: bash

       workstation
       workstation
       ...
       client
       name_of_node
       ...
       client
