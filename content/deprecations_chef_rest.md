+++
title = "Deprecation: Chef REST (CHEF-9)"
draft = false

aliases = "/deprecations_chef_rest.html"


  
    
    
    
    
+++    

[\[edit on
GitHub\]](https://github.com/chef/chef-web-docs/blob/master/chef_master/source/deprecations_chef_rest.rst)

<meta name="robots" content="noindex">

The `Chef::REST` class will be removed.

`Chef::REST` was deprecated in Chef Client 12.7.2, and will be removed
in Chef Client 13.

Remediation
===========

If writing code designed to be run internally to Chef, for example in a
cookbook or a knife plugin, transition to using `Chef::ServerAPI`. In
most cases this is as simple as creating a `Chef::ServerAPI` instance
rather than a `Chef::REST` one.

If writing code to interact with a Chef Infra Server from other code,
move to the [chef-api gem](https://rubygems.org/gems/chef-api).
