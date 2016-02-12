.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


The following diagram shows the stages of the bootstrap operation, and then the list below the diagram describes in greater detail each of those stages.

.. image:: ../../images/chef_bootstrap.png

During a ``knife bootstrap`` bootstrap operation, the following happens:

.. list-table::
   :widths: 150 450
   :header-rows: 1

   * - Stages
     - Description
   * - **$ knife bootstrap**
     - On |unix|- and |linux|-based machines: The ``knife bootstrap`` command is issued from a workstation. The hostname, IP address, or |fqdn| of the target node is issued as part of this command. An |ssh| connection is established with the target node using port 22. A shell script is assembled using the |erb chef_full| (the default bootstrap template), and is then executed on the target node.

       On |windows| machines: The ``knife bootstrap windows winrm`` command is issued from a workstation. (This command is part of the `knife windows plugin <https://docs.chef.io/plugin_knife_windows.html>`_.) The hostname, IP address, or |fqdn| of the target node is issued as part of this command. A connection is established with the target node using |windows remote management| over port 5985. (|windows remote management| must be enabled with the corresponding firewall rules in place.)
   * - **Get the install script from Chef**
     - On |unix|- and |linux|-based machines: The shell script that is derived from the |erb chef_full| bootstrap template will make a request to the |company_name| website to get the most recent version of a second shell script (``install.sh``).

       On |windows| machines: The batch file that is derived from the |erb chef_windows| bootstrap template will make a request to the |company_name| website to get the .msi installer.
   * - **Get the chef-client package from Chef**
     - The second shell script (or batch file) then gathers system-specific information and determines the correct package for the |chef client|. The second shell script (or batch file) makes a request to the |company_name| website, and then downloads the appropriate package from |url bootstrap_s3|.
   * - **Install the chef-client**
     - The |chef client| is installed on the target node.
   * - **Start the chef-client run**
     - On |unix|- and |linux|-based machines: The second shell script executes the ``chef-client`` binary with a set of initial settings stored within ``first-boot.json`` on the node. ``first-boot.json`` is generated from the workstation as part of the initial ``knife bootstrap`` command.

       On |windows| machines: The batch file that is derived from the |erb chef_windows| bootstrap template executes the ``chef-client`` binary with a set of initial settings stored within ``first-boot.json`` on the node. ``first-boot.json`` is generated from the workstation as part of the initial ``knife bootstrap`` command.
   * - **Complete the chef-client run**
     - The |chef client| run proceeds, using HTTPS (port 443), and registers the node with the |chef server|.
       
       The first |chef client| run, by default, contains an empty run-list. A `run-list can be specified <https://docs.chef.io/knife_bootstrap.html>`_ as part of the initial bootstrap operation using the ``--run-list`` option as part of the ``knife bootstrap`` command.

