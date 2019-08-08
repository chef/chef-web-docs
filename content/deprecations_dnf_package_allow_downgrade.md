+++
title = "Deprecation: DNF Package allow_downgrade Property (CHEF-10)"
description = "DESCRIPTION"
draft = false

aliases = "/deprecations_dnf_package_allow_downgrade.html"


  
    
    
    
    
+++    

[\[edit on
GitHub\]](https://github.com/chef/chef-web-docs/blob/master/chef_master/source/deprecations_dnf_package_allow_downgrade.rst)

<meta name="robots" content="noindex">

The DNF package provider in the O/S does not require `--allow-downgrade`
like yum did, and neither does the Chef `dnf_package` resource. This
property has no effect on the `dnf_resource` property.

Remediation
===========

Remove the `allow_downgrade` property on the `dnf_package` resource.
