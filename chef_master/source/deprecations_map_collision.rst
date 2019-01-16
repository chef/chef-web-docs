=======================================================
Deprecation: Map Collision (OHAI-25)
=======================================================
`[edit on GitHub] <https://github.com/chef/chef-web-docs/blob/master/chef_master/source/deprecations_map_collision.rst>`__

Resource homebrew_cask has been loaded from a cookbook. The resource homebrew_cask is now included in Chef and will take precedence over the existing cookbook resource in the next major release of Chef (15.0, April 2019). You may be able to remove this cookbook dependency from your runlist if you do not use other recipes/resources/libraries from the cookbook. Alternatively there may be a newer version of this cookbook without the homebrew_cask resource.

Remediation
=============