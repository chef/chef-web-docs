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
.. As part of chef server upgrade, all of the data is extracted, converted to new format and then uploaded. A large amount of data (cookbooks, nodes, etc..) can increate the upgrade process significantly, extending downtime. Below tasks should be done prior to upgrade to expedite the upgrade process and mitigate a lot of the common issues.

.. Install the version of |chef client| you plan on using after the upgrade on a small number of test nodes, and verify:
.. * All nodes can authenticate and converge successfully.
.. * Custom Ohai plugins still work as expected.
.. * Custom Handlers still work as expected.

Download all cookbooks, and validate the following against each cookbook:
.. 
.. * Run ``knife cookcookbook test``. Do they all pass validation with the version of |chef client| you plan on using?
.. * Run ``egrep -L ^name */metadata.rb``. Do they all have a |metadata rb| file? 
.. * Does the cookbook name in the |metadata rb| file match the name in the run-list? (Some older versions of the |chef client| used the cookbook name for the run-list based on the directory name of the cookbook and not the cookbook_name in the |metadata rb| file.)
.. * Do all cookbooks have a |metadata rb| file or |metadata json| file?
.. * Do all cookbooks used by your organization exist in source control? (upload any missing cookbooks and dependencies)
.. * Delete unused cookbook versions. Run ``knife cookbook list`` to view a list of cookbooks. Then, for each cookbook, run ``knife cookbook show COOKBOOK_NAME`` to view its versions. Delete all unused versions with ``knife cookbook delete -v VERSION_NAME``.
.. * Verify cookbook size. Most cookbooks are quite small, under ~200 KB. For any cookbook over 200 KB, consider why they are that large. Are there binary files? Mitigate the size of large cookbooks where possible.
.. * Clean up |git| history for any cookbook found to be excessively large.
.. 
.. Verify nodes and clients that are in use:
.. 
.. * Are all nodes and/or clients in use? Clean up any extra nodes and clients. Use the ``knife node list``, ``knife client list``, and :doc:`knife status </knife_statys>` commands to verify nodes and clients in use.
.. * Use the ``knife client delete` command to remove unused clients. Use the ``knife node delete`` command to remove unused nodes.
.. 
.. Run the test nodes against the |chef server|. If the server is also being upgraded, first complete that upgrade process, and then verify the test nodes against the upgraded |chef server|.
.. 
