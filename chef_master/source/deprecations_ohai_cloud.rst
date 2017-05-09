===================================================================
Deprecation: Cloud plugin replaced by the Cloud_V2 plugin (OHAI-8)
===================================================================
`[edit on GitHub] <https://github.com/chef/chef-web-docs/blob/master/chef_master/source/deprecations_ohai_cloud_v2.rst>`__

In Ohai/Chef releases 13 we replaced the existing Cloud plugin with the Cloud_v2 plugin. This was done by having the Cloud_v2 plugin populate both node['cloud'] and node['cloud_v2']. The Cloud_v2 plugin includes a different data format that resolves many of the longstanding bugs in the existing Cloud plugin.

Remediation
=============

If you have a cookbook that relies on data from node['cloud'] you will need to update the code to instead use node['cloud_v2']. This data will differ so you will want to run Ohai to see what modifications to your cookbook will be necessary with the new format.
