=====================================================
Release Notes: chef-client 12.2
=====================================================

.. include:: ../../includes_chef/includes_chef.rst

What's New
=====================================================
The following items are new for chef-client 12.2 and/or are changes from previous versions. The short version:

* **New dsc_resource** Use the **dsc_resource** resource to use any DSC resource in a Chef recipe.
* **New --exit-on-error option for knife-ssh** Use the ``--exit-on-error`` option to have the ``knife ssh`` subcommand exit on any error.

dsc_resource
-----------------------------------------------------

.. include:: ../../includes_resources_common/includes_resources_common_powershell.rst

.. include:: ../../includes_resources_common/includes_resources_common_powershell_dsc.rst

.. include:: ../../includes_resources/includes_resource_dsc_resource.rst

.. warning:: .. include:: ../../includes_resources/includes_resource_dsc_resource_requirements.rst

Syntax
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_dsc_resource_syntax.rst

Attributes
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_dsc_resource_attributes_12-5.rst

Examples
+++++++++++++++++++++++++++++++++++++++++++++++++++++

**Open a Zip file**

.. include:: ../../step_resource/step_resource_dsc_resource_zip_file.rst

**Manage users and groups**

.. include:: ../../step_resource/step_resource_dsc_resource_manage_users.rst

Changelog
=====================================================
https://github.com/chef/chef/blob/12.2.1/CHANGELOG.md

