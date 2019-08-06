+++
title = "Deprecation: :uninstall Resource for chocolatey_package (CHEF-21)"
description = "DESCRIPTION"
draft = false




  
    
    
    
    
+++    

[\[edit on
GitHub\]](https://github.com/chef/chef-web-docs/blob/master/chef_master/source/deprecations_chocolatey_uninstall.rst)

<meta name="robots" content="noindex">

The Chocolatey cookbook’s `chocolatey_package` resource originally
contained an `:uninstall` action. When
[chocolatey_package](/resource_chocolatey_package/) was moved into
core Chef, we made `:uninstall` an alias for `:remove`. In Chef Client
14, `:uninstall` will no longer be a valid action. Foodcritic rule
[FC103](http://www.foodcritic.io/#FC103) has been introduced to detect
usage of the `:uninstall` action.

Remediation
===========

The `:uninstall` action must be replaced with the `:remove` action when
using the `chocolatey_package` resource in recipes that you intend to
use with Chef Client 14. For example, where you might previously have
used the following code to uninstall `nginx`:

``` ruby
chocolatey_package 'nginx' do
  action :uninstall
end
```

You would instead use:

``` ruby
chocolatey_package 'nginx' do
  action :remove
end
```
