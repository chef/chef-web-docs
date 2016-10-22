=====================================================
Release Notes: chef-client 12.7
=====================================================

.. include:: ../../includes_chef/includes_chef.rst

What's New
=====================================================
The following items are new for chef-client 12.7 and/or are changes from previous versions. The short version:

* **Chef::REST => require 'chef/rest'** Internal API calls are moved from ``Chef::REST`` to ``Chef::ServerAPI``. Any code that uses ``Chef::REST`` must use ``require 'chef/rest'``.
* **New chocolatey_package resource** Use the **chocolatey_package** resource to manage packages using Chocolatey for the Microsoft Windows platform.
* **New osx_profile resource** Use the **osx_profile** resource to manage configuration profiles (``.mobileconfig`` files) on the Mac OS X platform.
* **New apt_update resource** Use the **apt_update** resource to manage Apt repository updates on Debian and Ubuntu platforms.
* **Improved support for UTF-8** The chef-client 12.7 release fixes a UTF-8 handling bug present in chef-client versions 12.4, 12.5, and 12.6.
* **New options for the chef-client** The chef-client has a new option: ``--delete-entire-chef-repo``.
* **Multi-package support for Chocolatey and Zypper** A resource may specify multiple packages and/or versions for platforms that use Zypper or Chocolatey package managers (in addition to the existing support for specifying multiple packages for Yum and Apt packages).


Chef::REST => require 'chef/rest'
-----------------------------------------------------
Internal API calls are moved from ``Chef::REST`` to ``Chef::ServerAPI``. As a result of this move, ``Chef::REST`` is no longer globally required. Any code that uses ``Chef::REST`` must be required as follows:

.. code-block:: ruby

   require 'chef/rest'

For code that is run using knife or chef command line interfaces, consider using ``Chef::ServerAPI`` instead.

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




apt_update
-----------------------------------------------------

.. include:: ../../includes_resources/includes_resource_apt_update.rst

Syntax
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_apt_update_syntax.rst

Actions
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_apt_update_actions.rst

Properties
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_apt_update_attributes.rst

Examples
+++++++++++++++++++++++++++++++++++++++++++++++++++++

**Update the Apt repository at a specified interval** 

.. include:: ../../step_resource/step_resource_apt_update_periodic.rst

**Update the Apt repository at the start of a chef-client run** 

.. include:: ../../step_resource/step_resource_apt_update_at_start_of_client_run.rst


New chef-client options
-----------------------------------------------------
The chef-client has the following new options:

``--delete-entire-chef-repo``
   Delete the entire chef-repo. This option may only be used when running the chef-client in local mode (``--local-mode``) mode. This options requires ``--recipe-url`` to be specified.


Changelog
=====================================================
https://github.com/chef/chef/blob/master/CHANGELOG.md
