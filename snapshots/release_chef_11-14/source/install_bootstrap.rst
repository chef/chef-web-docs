

=====================================================
Bootstrap a Node
=====================================================

.. tag chef_client_bootstrap_node

A node is any physical, virtual, or cloud machine that is configured to be maintained by a chef-client. A bootstrap is a process that installs the chef-client on a target system so that it can run as a chef-client and communicate with a Chef server. There are two ways to do this:

* Use the ``knife bootstrap`` subcommand to :doc:`bootstrap a node using the omnibus installer </install_bootstrap>`
* Use an unattended install to bootstrap a node from itself, without using SSH or WinRM

.. end_tag

knife bootstrap
=====================================================
.. tag install_chef_client

The ``knife bootstrap`` command is a common way to install the chef-client on a node. The default for this approach assumes that a node can access the Chef website so that it may download the chef-client package from that location.

The omnibus installer will detect the version of the operating system, and then install the appropriate version of the chef-client using a single command to install the chef-client and all of its dependencies, including an embedded version of Ruby, RubyGems, OpenSSL, key-value stores, parsers, libraries, and command line utilities.

The omnibus installer puts everything into a unique directory (``/opt/chef/``) so that the chef-client will not interfere with other applications that may be running on the target machine. Once installed, the chef-client requires a few more configuration steps before it can perform its first chef-client run on a node.

.. end_tag

**Run the bootstrap command**

.. tag knife_bootstrap_install_chef_client

The ``knife bootstrap`` subcommand is used to run a bootstrap operation that installs the chef-client on the target node. The following steps describe how to bootstrap a node using knife.

#. Identify the FQDN or IP address of the target node. The ``knife bootstrap`` command requires the FQDN or the IP address for the node in order to complete the bootstrap operation.

#. Once the workstation machine is configured, it can be used to install the chef-client on one (or more) nodes across the organization using a knife bootstrap operation. The ``knife bootstrap`` command is used to SSH into the target machine, and then do what is needed to allow the chef-client to run on the node. It will install the chef-client executable (if necessary), generate keys, and register the node with the Chef server. The bootstrap operation requires the IP address or FQDN of the target system, the SSH credentials (username, password or identity file) for an account that has root access to the node, and (if the operating system is not Ubuntu, which is the default distribution used by ``knife bootstrap``) the operating system running on the target system.

   In a command window, enter the following:

   .. code-block:: bash

      $ knife bootstrap 123.45.6.789 -x username -P password --sudo

   where ``123.45.6.789`` is the IP address or the FQDN for the node. Use the ``--distro`` option to specify a non-default distribution. For more information about the options available to the ``knife bootstrap`` command for Ubuntu- and Linux-based platforms, see :doc:`knife bootstrap <knife_bootstrap>`. For Microsoft Windows, the ``knife windows`` plugin is required, see knife windows .

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

#. After the bootstrap operation has finished, verify that the node is recognized by the Chef server. To show only the node that was just bootstrapped, run the following command:

   .. code-block:: bash

      $ knife client show name_of_node

   where ``name_of_node`` is the name of the node that was just bootstrapped. The Chef server will return something similar to:

   .. code-block:: bash

      admin:       false
      chef_type:   client
      json_class:  Chef::ApiClient
      name:        name_of_node
      public_key:

   and to show the full list of nodes (and workstations) that are registered with the Chef server, run the following command:

   .. code-block:: bash

      knife client list

   The Chef server will return something similar to:

   .. code-block:: bash

       workstation
       workstation
       ...
       client
       name_of_node
       ...
       client

.. end_tag

Unattended Installs
=====================================================
.. tag install_chef_client_unattended_bootstrap

The chef-client can be installed using an unattended bootstrap. This allows the chef-client to be installed from itself, without using SSH. For example, machines are often created using environments like AWS Auto Scaling, AWS CloudFormation, Rackspace Auto Scale, and PXE. In this scenario, using tooling for attended, single-machine installs like ``knife bootstrap`` or ``knife CLOUD_PLUGIN create`` is not practical because the machines are created automatically and someone cannot always be on-hand to initiate the bootstrap process.

When the chef-client is installed using an unattended bootstrap, remember that the chef-client:

* Must be able to authenticate to the Chef server
* Must be able to configure a run-list
* May require custom attributes, depending on the cookbooks that are being used
* Must be able to access the chef-validator.pem so that it may create a new identity on the Chef server
* Must have a unique node name; the chef-client will use the FQDN for the host system by default

When the chef-client is installed using an unattended bootstrap, it is typically built into an image that starts the chef-client on boot. The type of image used depends on the platform on which the unattended bootstrap will take place.

Use settings in the :doc:`client.rb file <config_rb_client>`---``chef_server_url``, ``http_proxy``, and so on---to ensure that configuration details are built into the unattended bootstrap process.

.. end_tag

**Setting the initial run-list**

.. tag ctl_chef_client_bootstrap_initial_run_list

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

.. end_tag

