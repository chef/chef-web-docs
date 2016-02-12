=====================================================
Release Notes: |chef client| 12.7
=====================================================

.. include:: ../../includes_chef/includes_chef.rst

What's New
=====================================================
The following items are new for |chef client| 12.7 and/or are changes from previous versions. The short version:

* **New chocolatey_package resource** Use the |resource package_chocolatey| resource to manage packages using |chocolatey| for the |windows| platform.
* **New osx_profile resource** Use the |resource osx_profile| resource to manage configuration profiles (``.profile`` files) on the |mac os x| platform.
* **xxxxx** xxxxx


chocolatey_package
-----------------------------------------------------
.. include:: ../../includes_resources/includes_resource_package_chocolatey.rst

Syntax
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_package_chocolatey_syntax.rst

Actions
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_package_chocolatey_actions.rst

Properties
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_package_chocolatey_attributes.rst

Examples
+++++++++++++++++++++++++++++++++++++++++++++++++++++

**Install a package**

.. include:: ../../step_resource/step_resource_chocolatey_package_install.rst


osx_profile
-----------------------------------------------------
.. include:: ../../includes_resources/includes_resource_osx_profile.rst

Syntax
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_osx_profile_syntax.rst

Actions
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_osx_profile_actions.rst

Properties
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_osx_profile_attributes.rst

Examples
+++++++++++++++++++++++++++++++++++++++++++++++++++++

**One liner to install profile from cookbook file**

.. include:: ../../step_resource/step_resource_osx_profile_install_file_oneline.rst

**Install profile from cookbook file**

.. include:: ../../step_resource/step_resource_osx_profile_install_file.rst

**Install profile from a hash**

.. include:: ../../step_resource/step_resource_osx_profile_install_hash.rst

**Remove profile using identifier in resource name**

.. include:: ../../step_resource/step_resource_osx_profile_remove_by_name.rst

**Remove profile by identifier and user friendly resource name**

.. include:: ../../step_resource/step_resource_osx_profile_remove_by_identifier.rst




xxxxx
-----------------------------------------------------
xxxxx

xxxxxx
+++++++++++++++++++++++++++++++++++++++++++++++++++++
xxxxx


Changelog
=====================================================
https://github.com/chef/chef/blob/master/CHANGELOG.md
