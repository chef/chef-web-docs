======================================================
Notes for Enterprise Chef Upgrades
======================================================

The following sections contain more information about the upgrade process from Enterprise Chef to Chef server version 12. Please consult with Chef support about any of these situations if needed.

chef-server.rb, Symlinks
=====================================================
The name of the configuration file used by the Chef server has been changed to chef-server.rb from private-chef.rb. A symlink from private-chef.rb to chef-server.rb is created during upgrades from older versions of the Chef server.

If the **template** resource is managing the private-chef.rb file in Enterprise Chef, continuing to use this process will break the symlink that is created during the upgrade. If your organization is managing the private-chef.rb file with the **template** resource, do the following:

#. Remove or disable the management of the private-chef.rb file. For example, by removing that specific resource from a recipe, by removing the recipe it is associated with from the run-list, or by doing some other action that ensures this file isn't managed by Chef until after the upgrade process is complete.
#. Upgrade to Chef server 12.
#. Re-create the management process that was used prior to the upgrade, but make the necessary changes so that Chef is managing the chef-server.rb file.
#. Verify that the chef-server.rb file is being managed and that the symlink from private-chef.rb to chef-server.rb is not broken.

Verify Nodes and Cookbooks 
=====================================================
.. tag upgrade_verify_nodes_and_cookbooks

Install the latest version of the chef-client on a small number of test nodes. Download all cookbooks, and then and check the following:

* Run ``knife cookbook test``. Do they all pass validation with the version of the chef-client you plan on using?
* Run ``egrep -L ^name */metadata.rb``. Do they all have a metadata.rb file? 
* Does the cookbook name in the metadata.rb file match the name in the run-list? (Some older versions of the chef-client used the cookbook name for the run-list based on the directory name of the cookbook and not the value of the ``cookbook_name`` setting in the metadata.rb file.)
* Do all cookbooks have a metadata.rb file or metadata.json file?
* Do all cookbooks used in the organization also exist in source control?
* Do unused cookbooks (or cookbook versions) exist in source control? Run ``knife cookbook list`` to view a list of cookbooks, and then for each cookbook run ``knife cookbook show COOKBOOK_NAME`` to view its versions. Delete unused cookbook versions with ``knife cookbook delete -v VERSION_NAME``.
* How large is a cookbook? Most cookbooks are quite small, under ~200 KB. Sometimes cookbooks need to be larger than that. For larger cookbooks, consider why they are that large. Do they contain unecessary binary files? Do they have a long git history? Mitigate the size of large cookbooks where possible.

Verify the nodes and clients that are in use:

* Are all nodes and/or clients in use? Clean up any extra nodes and clients. Use the ``knife node list``, ``knife client list``, and ``knife_status``` commands to verify nodes and clients that are in use.
* Use the ``knife_client delete`` command to remove unused clients. Use the ``knife_node delete`` command to remove unused nodes.

Run the test nodes against the Chef server. If the server is also being upgraded, first complete that upgrade process (ideally on a fresh operating system), including processes for any highly available, load balanced, or offloaded services, and then verify the test nodes against the upgraded Chef server.

.. end_tag

Solr => Solr 4 Changes
=====================================================
.. tag 2_solr_to_solr4

Chef server version 12 is upgraded to Apache Solr 4. If Apache Solr options were added to the private-chef.rb file under ``opscode_solr`` for Enterprise Chef, those configuration options are now stored under ``opscode_solr4`` in the chef-server.rb file for Chef server version 12.

Some ``opscode_solr`` settings are imported automatically, such as heap, new size, and Java options, but many settings are ignored. If your Enterprise Chef configuration is highly tuned for Apache Solr, review `these configuration settings <https://docs.chef.io/config_rb_server_optional_settings.html#opscode-solr4>`__ before re-tuning Apache Solr for Chef server version 12.

.. end_tag

