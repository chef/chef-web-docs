==================================================================
Deprecation: Removal of IpScopes Plugin (OHAI-13)
==================================================================
`[edit on GitHub] <https://github.com/chef/chef-web-docs/blob/master/chef_master/source/deprecations_ohai_ipscopes.rst>`__

.. meta::
    :robots: noindex
    
Chef/Ohai 14 (April 2018) will remove the IpScopes plugin. The data returned by this plugin is nearly identical to information already returned by individual network plugins, and this plugin required the inclusion of an additional gem into the Chef installation. We believe that few users were installing the gem, and users would be better served by the data returned from network plugins.
