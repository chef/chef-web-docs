=====================================================
Release Notes: |chef client| 12.8
=====================================================

.. include:: ../../includes_chef/includes_chef.rst

What's New
=====================================================
The following items are new for |chef client| 12.8 and/or are changes from previous versions. The short version:

* **Support for OpenSSL validation of FIPS** The |chef client| can be configured to allow |open ssl| to enforce |fips|-validated security during a |chef client| run.
* **New launchd resource** Use the |resource launchd| resource to manage system-wide services (daemons) and per-user services (agents) on the |mac os x| platform.
* **New property for the mdadm resource** Use the ``mdadm_defaults`` property to set the default values for ``chunk`` and ``metadata`` to ``nil``, which allows |mdadm| to apply its own default values.
* **chef-zero support for Chef Server API endpoints** |chef zero| now supports using all |api chef server| version 12 endpoints, with the exception of ``/universe``.
* **Updated support for OpenSSL** |open ssl| is updated to version 1.0.1.
* **Ohai auto-detects hosts for Azure instances** |ohai| will auto-detect hosts for instances that are hosted by |azure|.


launchd
-----------------------------------------------------
.. include:: ../../includes_resources/includes_resource_launchd.rst

Syntax
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_launchd_syntax.rst

Actions
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_launchd_actions.rst

Properties
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_launchd_attributes.rst

Examples
+++++++++++++++++++++++++++++++++++++++++++++++++++++

**Create a Launch Daemon from a cookbook file**

.. include:: ../../step_resource/step_resource_launchd_create_from_cookbook.rst

**Create a Launch Daemon using keys**

.. include:: ../../step_resource/step_resource_launchd_create_using_keys.rst

**Remove a Launch Daemon**

.. include:: ../../step_resource/step_resource_launchd_remove.rst





|fips| Mode
-----------------------------------------------------
|fips_long| is a United States government computer security standard that specifies four levels of security requirements for cryptography. The current version of the standard is |fips_current|. The |chef client| can be configured to allow |open ssl| to enforce |fips|-validated security during a |chef client| run. This will disable cryptography that is explicitly disallowed in |fips|-validated software, including certain ciphers and hashing algorithms. Any attempt to use any disallowed cryptography will cause the |chef client| to throw an exception during a |chef client| run.

.. note:: |chef| uses |md5| hashes to uniquely identify files that are stored on the |chef server|. |md5| is used only to generate a unique hash identifier and is not used for any cryptographic purpose.

Notes about |fips|:

* May be enabled for nodes running on |windows| and enterprise |linux| platforms
* Should should only be enabled for environments that require |fips_current| compliance
* May not be enabled for any version of the |chef client| earlier than 12.8

.. update knife_common_options, chef-client options, chef-client configuration settings, environment variables, knife bootstrap options (enables FIPS as default at `/etc/chef/client.rb` on nodes)
.. for command option and config settings, add this note: 'This option requires |chef client| 12.8 (or higher). Using this option with older versions of the |chef client| will raise an error: "FIPS mode requested, but not supporte by this client."'

Enable FIPS Mode
+++++++++++++++++++++++++++++++++++++++++++++++++++++
Allowing |open ssl| to enforce |fips|-validated security may be enabled by using any of the following ways:

* Set the ``fips`` configuration setting to ``true`` in the |client rb| or |knife rb| files
* Set the ``--fips`` command-line option to ``true`` when running any |knife| command or the |chef client| executable
* Set the ``--fips`` command-line option to ``true`` when bootstrapping a node using the ``knife bootstrap`` command
* Set the ``CHEF_FIPS`` environment varaible to ``1``

Command Option
+++++++++++++++++++++++++++++++++++++++++++++++++++++
The following command-line option may be used to with a |knife| or |chef client| executable command:

``--[no-]fips``
  |chef_client fips|


Configuration Setting
+++++++++++++++++++++++++++++++++++++++++++++++++++++
The following configuration setting may be set in the |knife rb|, |client rb|, or |config rb| files:

``fips``
  |chef_client fips| Default value: ``true``.


Changelog
=====================================================
https://github.com/chef/chef/blob/master/CHANGELOG.md
