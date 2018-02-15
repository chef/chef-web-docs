=====================================================
Deprecation: Deploy Resource (CHEF-20)
=====================================================
`[edit on GitHub] <https://github.com/chef/chef-web-docs/blob/master/chef_master/source/deprecations_deploy_resource.rst>`__

The ``deploy`` and ``deploy_revision`` resources have been deprecated as of Chef 13.6, and will be removed in Chef 14.

Remediation
=============
For users that require the ``deploy`` or ``deploy_revision`` resources, they are now part of the `deploy_resource <https://supermarket.chef.io/cookbooks/deploy_resource>`__ backwards compatibility cookbook available on the Supermarket.
