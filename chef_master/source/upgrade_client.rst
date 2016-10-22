=====================================================
chef-client Upgrades 
=====================================================

The following sections describe the upgrade process for chef-client 12.

Please `view the notes <https://docs.chef.io/upgrade_client_notes.html>`__ for more background on the upgrade process.

Upgrade via Command Line
=====================================================
To upgrade the chef-client on a node via the command line, run the  following command on each node to be upgraded:

.. code-block:: bash

   curl -L https://chef.io/chef/install.sh | sudo bash

Using the ``knife ssh`` subcommand is one way to do this.

Upgrade via Cookbook
=====================================================
The ``omnibus-updater`` cookbook can be used to install the omnibus chef-client package on a node, and then be used to update the chef-client: https://github.com/hw-cookbooks/omnibus_updater.

