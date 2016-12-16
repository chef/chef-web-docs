=====================================================
Release Notes: Chef Compliance
=====================================================
`[edit on GitHub] <https://github.com/chef/chef-web-docs/blob/master/chef_master/source/release_notes_compliance.rst>`__

.. tag compliance_2

Chef Compliance allows you to assess your infrastructure's adherence to compliance requirements and to monitor that infrastructure on an ongoing basis. It includes:

* The Chef Compliance server
* Prebuilt compliance profiles to help you get started quickly
* A language for writing audit controls, which includes audit resources that you can invoke

.. end_tag

What's New (1.1)
=====================================================
The following items are new for Chef Compliance 1.1:

* **Chef MLSA** .. tag chef_license_reconfigure_compliance

                Starting with Chef Compliance 1.1.9, the :doc:`Chef MLSA </chef_license>` must be accepted when reconfiguring the product. If the Chef MLSA has not already been accepted, the reconfigure process will prompt for a ``yes`` to accept it. Or run ``chef-compliance-ctl reconfigure --accept-license`` to automatically accept the license.

                .. end_tag

