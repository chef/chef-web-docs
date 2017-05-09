=============================================================================
Deprecation: Filesystem plugin replaced by the Filesystem V2 plugin. (OHAI-9)
=============================================================================
`[edit on GitHub] <https://github.com/chef/chef-web-docs/blob/master/chef_master/source/deprecations_ohai_filesystem.rst>`__

In Ohai/Chef 13 we replaced the existing Filesystem plugin with the Filesystem2 plugin. This was done by having the Filesystem2 plugin populate both node['fileystem2'] and node['filesystem']. The Filesystem2 plugin includes a different data format that resolves many of the longstanding bugs in the Filesystem plugin.

Remediation
=============

If you have a cookbook that relies on data from node['filesystem'] you will need to update the code to instead use node['fileystem2']. This data will differ so you will want to run Ohai to see what modifications to your cookbook will be necessary with the new format.
