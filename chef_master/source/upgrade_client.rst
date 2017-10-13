=====================================================
Upgrading chef-client
=====================================================
`[edit on GitHub] <https://github.com/chef/chef-web-docs/blob/master/chef_master/source/upgrade_client.rst>`__

The following sections describe the upgrade process for chef-client 12.

Please `view the notes </upgrade_client_notes.html>`__ for more background on the upgrade process.

Upgrade via Command Line
=====================================================
To upgrade the chef-client on a node via the command line, run the  following command on each node to be upgraded:

.. code-block:: bash

   curl -L https://chef.io/chef/install.sh | sudo bash

Using the ``knife ssh`` subcommand is one way to do this.

Upgrade via Cookbook
=====================================================

The `chef_client_updater <https://supermarket.chef.io/cookbooks/chef_client_updater>`__ cookbook can be used to install or upgrade the chef-client package on a node.

Considerations
=====================================================

Preparing your chef-client system before upgrading to Chef server will enhance your Chef experience.  During a Chef server upgrade, all of the data is extracted, converted to a new format, and then uploaded. A large amount of data (cookbooks, nodes, etc.,) can increase the upgrade process significantly and extend your downtime.

Managing your data prior to upgrading will improve experience upgrading and using Chef server and client. Following this list of client-based tasks prior to upgrading will expedite the upgrade process and mitigate many common issues.  For more information on upgrading to Chef server, see `Enterprise Chef to Chef 12 Upgrades. </upgrade_server_notes.html>`__

Install the version of chef client you plan on using after the upgrade on a small number of test nodes and verify:
 * All nodes can authenticate and converge successfully.
 * Custom Ohai plugins still work as expected.
 * Custom Handlers still work as expected.

Ensure that all of the cookbooks used by your organization are correctly located and identified:
 * Do all cookbooks used by your organization exist in source control? Upload any missing cookbooks and dependencies.
 * Do all cookbooks have a ``metadata.rb`` or ``metadata.json`` file?
 * Delete unused cookbook versions. First, run ``knife cookbook list`` to view a list of cookbooks. Next, for each cookbook, run ``knife cookbook show COOKBOOK_NAME`` to view its versions. Then, delete each unused version with ``knife cookbook delete -v VERSION_NAME``.

Download all cookbooks and validate the following against each cookbook:
 * Run ``egrep -L ^name */metadata.rb``. Does each have a ``metadata.rb`` file?
 * Does the cookbook name in the ``metadata.rb`` file match the name in the run-list? (Some older versions of the Chef client used the cookbook name for the run-list based on the directory name of the cookbook and not the cookbook_name in the ``metadata.rb`` file.)

Cook as lean as possible:
 * Verify cookbook size and mitigate the size of large cookbooks where possible. Most cookbooks are quite small, under ~200 KB. For any cookbook over 200 KB, consider why they are that large. Are there binary files?
 * Clean up ``git`` history for any cookbook found to be excessively large.

Verify nodes and clients that are in use:
 * Are all nodes and/or clients in use? Clean up any extra nodes and clients. Use the ``knife node list``, ``knife client list``, and `knife status </knife_status.html>`__ commands to verify nodes and clients in use.
 * Use the ``knife client delete` command to remove unused clients. Use the ``knife node delete`` command to remove unused nodes.

Run the test nodes against the Chef server. If the server is also being upgraded, **first** complete the Chef server upgrade process, and **then** verify the test nodes against the upgraded Chef server.
