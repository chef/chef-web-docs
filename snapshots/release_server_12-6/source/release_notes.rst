=====================================================
Release Notes: Chef Server 12.6
=====================================================

.. tag chef_index

Chef is a systems and cloud infrastructure automation framework that makes it easy to deploy servers and applications to any physical, virtual, or cloud location, no matter the size of the infrastructure. Each organization is comprised of one (or more) workstations, a single server, and every node that will be configured and maintained by the chef-client. Cookbooks (and recipes) are used to tell the chef-client how each node in your organization should be configured. The chef-client (which is installed on every node) does the actual configuration.

.. end_tag

What's New
=====================================================
The following items are new for Chef server 12.6:

* **Chef licenses** All Chef products have a license that governs the entire product and includes links to license files for any third-party software included in Chef packages. This release updates the Chef server for the Chef license.

About Chef Licenses
=====================================================
All Chef products have a license that governs the entire product and includes links to license files for any third-party software included in Chef packages. The ``/opt/<PRODUCT-NAME>/LICENSES`` directory contains individual copies of all referenced licenses.

.. warning:: .. tag chef_license_note_current

             The ``chef-server-ctl install`` command no longer works in the 12.5 (and earlier) versions of the Chef server due to a change in how packages are downloaded from Chef.

             .. end_tag

Apache 2.0
-----------------------------------------------------
.. no swaps used for the "such as ..." section to ensure the correct legal name and not the names for these products as otherwise used globally in the documentation.

All open source Chef products---such as the Chef client, the Chef server, or InSpec---are governed by the Apache 2.0 license.

What's Fixed
=====================================================
For the list of issues that were addressed for this release, please see the changelog on GitHub: https://github.com/chef/chef-server/blob/master/CHANGELOG.md
