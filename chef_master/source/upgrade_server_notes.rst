======================================================
Notes for Enterprise Chef Upgrades
======================================================
`[edit on GitHub] <https://github.com/chef/chef-web-docs/blob/master/chef_master/source/upgrade_server_notes.rst>`__

The following sections contain more information about the upgrade process from Enterprise Chef to Chef server version 12. Please consult with Chef support about any of these situations if needed.


Considerations
=====================================================
As part of the Chef server upgrade, all of the data is extracted, converted to a new format and then uploaded. A large amount of data (cookbooks, nodes, etc..) can increase the upgrade process significantly and extend your downtime. Preparing your client-side system will improve your chef server upgrade experience.  Following this list of client-based tasks prior to upgrading will expedite the upgrade process and mitigate many of the common issues: `Upgrading chef-client. </upgrade_client.html>`__

chef-server.rb, Symlinks
=====================================================
The name of the configuration file used by the Chef server has been changed to chef-server.rb from private-chef.rb. A symlink from private-chef.rb to chef-server.rb is created during upgrades from older versions of the Chef server.

If the **template** resource is managing the private-chef.rb file in Enterprise Chef, continuing to use this process will break the symlink that is created during the upgrade. If your organization is managing the private-chef.rb file with the **template** resource, do the following:

#. Remove or disable the management of the private-chef.rb file. For example, by removing that specific resource from a recipe, by removing the recipe it is associated with from the run-list, or by doing some other action that ensures this file isn't managed by Chef until after the upgrade process is complete.
#. Upgrade to Chef server 12.
#. Re-create the management process that was used prior to the upgrade, but make the necessary changes so that Chef is managing the chef-server.rb file.
#. Verify that the chef-server.rb file is being managed and that the symlink from private-chef.rb to chef-server.rb is not broken.

Solr => Solr 4 Changes
=====================================================
.. tag 2_solr_to_solr4

Chef server version 12 is upgraded to Apache Solr 4. If Apache Solr options were added to the private-chef.rb file under ``opscode_solr`` for Enterprise Chef, those configuration options are now stored under ``opscode_solr4`` in the chef-server.rb file for Chef server version 12.

Some ``opscode_solr`` settings are imported automatically, such as heap, new size, and Java options, but many settings are ignored. If your Enterprise Chef configuration is highly tuned for Apache Solr, review `these configuration settings </config_rb_server_optional_settings.html#opscode-solr4>`__ before re-tuning Apache Solr for Chef server version 12.

.. end_tag
