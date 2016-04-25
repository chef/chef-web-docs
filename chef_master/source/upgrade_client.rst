=====================================================
|chef client| Upgrades 
=====================================================

The following sections describe the upgrade process for |chef client| 12.

Please `view the notes <https://docs.chef.io/upgrade_client_notes.html>`__ for more background on the upgrade process.

Upgrade via Command Line
=====================================================
To upgrade the |chef client| on a node via the command line, run the  following command on each node to be upgraded:

.. code-block:: bash

   curl -L https://chef.io/chef/install.sh | sudo bash

Using the ``knife ssh`` subcommand is one way to do this.

Upgrade via Cookbook
=====================================================
The ``omnibus-updater`` cookbook can be used to install the omnibus |chef client| package on a node, and then be used to update the |chef client|: https://github.com/hw-cookbooks/omnibus_updater.


.. 
.. Considerations
.. =====================================================
.. Install the latest version of the |chef client| on a small number of test nodes. Download all cookbooks, and then and check the following:
.. 
.. * Run ``knife cookcookbook test``. Do they all pass validation with the |chef client|?
.. * Run ``egrep -L ^name */metadata.rb``. Do they all have a |metadata rb| file? 
.. * Does the cookbook name in the |metadata rb| file match the name of the run-list? (Some older versions of the |chef client| used the cookbook name for the run-list based on the directory name of the cookbook and not the name of the cookbook in the |metadata rb| file.)
.. * Do all cookbooks have a |metadata rb| file or |metadata json| file?
.. * Do all cookbooks used by your organization exist in source control?
.. * Do unused cookbooks (or cookbook versions) exist in source control? Run ``knife cookbook list`` to view a list of cookbooks, and then for each cookbook run ``knife cookbook show COOKBOOK_NAME`` to view its versions. Delete unused cookbook versions with ``knife cookbook delete -v VERSION_NAME``.
.. * How large is a cookbook? Most cookbooks are quite small, under ~200 KB. Sometimes cookbooks need to be larger than that. For larger cookbooks, consider why they are that large. Are there binary files? Does it have a long |git| history? Mitigate the size of large cookbooks where possible.
.. 
.. Verify the nodes and clients that are in use:
.. 
.. * Are all nodes and/or clients in use? Clean up any extra nodes and clients. Use the ``knife node list``, ``knife client list``, and :doc:`knife status </knife_statys>` commands to verify nodes and clients.
.. * Use the :doc:`knife client </knife_client>` command to remove unused clients. Use the :doc:`knife node </knife_node>` command to remove unused nodes.
.. 
.. Run the test nodes against the |chef server|. If the server is also being upgraded, first complete that upgrade process, and then verify the test nodes against the upgraded |chef server|.
.. 