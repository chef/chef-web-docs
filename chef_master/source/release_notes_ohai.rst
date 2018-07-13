=====================================================
Release Notes: Ohai 7 - 13.2
=====================================================
`[edit on GitHub] <https://github.com/chef/chef-web-docs/blob/master/chef_master/source/release_notes_ohai.rst>`__

.. tag ohai_summary

Ohai is a tool that is used to collect system configuration data, which is provided to the chef-client for use within cookbooks. Ohai is run by the chef-client at the beginning of every Chef run to determine system state. Ohai includes many built-in plugins to detect common configuration details as well as a plugin model for writing custom plugins.

The types of attributes Ohai collects include but are not limited to:

* Operating System
* Network
* Memory
* Disk
* CPU
* Kernel
* Host names
* Fully qualified domain names
* Virtualization
* Cloud provider metadata

Attributes that are collected by Ohai are automatic level attributes, in that these attributes are used by the chef-client to ensure that these attributes remain unchanged after the chef-client is done configuring the node.

.. end_tag

What's New in 14.1.3
=====================================================

* Properly detects FIPS environments
* ``shard`` plugin works in FIPS compliant environments
* ``filesystem`` plugin now handles BSD platforms


What's New in 13.2
=====================================================

* **Systemd Paths Plugin** A new plugin has been added to expose system and user paths from ``systemd-path`` (see https://www.freedesktop.org/software/systemd/man/systemd-path.html for details).
* **Linux Network, Filesystem, and Mdadm Plugin Resilience** The Network, Filesystem, and Mdadm plugins have been improved to greatly reduce data collection failures. The Network plugin has become better at finding the binaries it requires for shelling out, the filesystem plugin utilizes data from multiple sources, and the mdadm plugin handles arrays in bad states.
* **Zpool Plugin Platform Expansion** The Zpool plugin has been updated to support BSD and Linux in addition to Solaris.
* **RPM version parsing on AIX** The packages plugin now correctly parses RPM package name / version information on AIX systems.
* **Additional Platform Support** Ohai now properly detects the Clear and ClearOS Linux distributions:

    * **Clear Linux**

      platform: clearlinux

      platform_family: clearlinux
      
    * **ClearOS**

      platform: clearos

      platform_family: rhel

New deprecations introduced in this release:
-----------------------------------------------------

Removal of IpScopes plugin
+++++++++++++++++++++++++++++++++++++++++++++++++++++
* **Deprecation ID**: OHAI-13
* **Remediation Docs**: `OHAI-13 </deprecations_ohai_ipscopes.html>`__
* **Expected Removal**: Ohai 14 (April 2018)

What's New in 13.1
=====================================================
Ohai 13.1 introduces the following changes:

* **Socketless local mode by default** For security reasons, Local Mode now uses socketless connections by default. This prevents potential attacks where an unprivileged user or process connects to the internal Zero server for the converge and changes data.

    If you use Chef Provisioning with Local Mode, you may need to pass ``--listen`` to chef-client.

New deprecations introduced in this release:
-----------------------------------------------------

Removal of support for Ohai version 6 plugins
+++++++++++++++++++++++++++++++++++++++++++++++++++++
* **Deprecation ID**: OHAI-10
* **Remediation Docs**: `OHAI-10 </deprecations_ohai_v6_plugins.html>`__
* **Expected Removal**: Ohai 14 (April 2018)

What's New in 13.0
=====================================================
Ohai 13.0 introduces the following changes:

* **New Secondary Plugin Path** By default Ohai will now look for additional plugins within ``/etc/chef/ohai/plugins`` or ```C:\\chef\\ohai\\plugins``. This makes it easy to drop off additional plugins during bootstrap or using the ohai cookbook without the need to edit client.rb or reload Ohai.
* **Version Matching With Chef** Ohai has been bumped from version 8.23 to version 13.0 to match the chef-client. We'll be keeping versions in sync between ohai and chef-client so you always know what version of ohai shipped with chef-client.
* **Lua and Scala Detection** Lua and Scala version detection has been improved to work in more situations.
* **AWS Metadata Detection** We now detect ``availability_zone`` and ``region`` information for EC2.
* **DMI Detection** We now detect DMI types 40-41: ``additional_information``, ``onboard_devices_extended_information``, and ``management_controller_host_interfaces``.

Backwards Incompatible Changes:
-----------------------------------------------------

* **Amazon Linux is now 'platform_family' of amazon** As time has gone on, Amazon Linux has become less like other RHEL derivatives. We're now detecting amazon as its own ``platform_family`` to make writing Amazon Linux compatible cookbooks easier.
* **Cloud plugin replaced with Cloud V2** The legacy cloud plugin that provided ``node['cloud']`` has been replaced with the Cloud V2 plugin. If you previously used data from the Cloud plugin you will see a new, more robust, data struct at ``node['cloud']``.
* **Filesystems plugin replaced with Filesystem V2** The legacy filesystem plugin that provided ``node['fileystem']`` has been replaced with the Filesystem V2 plugin. If you previously used data from the Filesystem plugin you will see a new, more robust, data struct at ``node['filesystem']``.
* **Freezing Ohai Strings** All Ohai strings are now frozen to prevent modification within cookbooks and to save memory.
* **Removal of SBT Detection** The latest versions of ``sbt`` no longer include a ``sbt --version`` command. Other methods of version detection require setting up a project in the working directory. Until a better version detection method can be determined, we've removed ``sbt`` detection.
* **Ruby 2.3+** Ohai now requires Ruby 2.3 instead of 2.1. This change aligns the Ruby requirements of Ohai with that of chef-client.
* **Legacy Config Removal (OHAI-1)** The legacy Ohai config format used in the Chef ``client.rb`` config has been removed. See `OHAI-1 </deprecations_ohai_legacy_config.html>`__ for details.
* **Sigar gem based plugins removal (OHAI-2)** Sigar gem based plugins have been removed from Ohai. See `OHAI-2 </deprecations_ohai_sigar_plugins.html>`__ for details.
* **``run_command`` and ``popen4`` helper method removal (OHAI-3)** The legacy ``run_command`` and ``popen4`` helper methods have been removed. See `OHAI-3 </deprecations_ohai_run_command_helpers.html>`__ for details.
* **Windows CPU plugin attribute changes. (OHAI-5)** The windows cpu ``model_name`` attribute has been updated to return the correct value. See `OHAI-5 </deprecations_ohai_windows_cpu.html>`__ for details.
* **DigitalOcean plugin attribute changes (OHAI-6)** The DigitalOcean plugin has been completely rewritten to pull data from the DigitalOcean metadata endpoint, giving us more detailed droplet information. This changed the format of the data returned by Ohai. See `OHAI-6 </deprecations_ohai_digitalocean.html>`__ for details.

What's New in 8.23
=====================================================
Ohai 8.23 introduces the following changes:

* **Cumulus Linux Platform** Cumulus Linux will now be detected as platform ``cumulus`` instead of ``debian`` and the ``platform_version`` will be properly set to the Cumulus Linux release.
* **Virtualization Detection** Windows / Linux / BSD guests running on the Veertu hypervisors will now be detected. Windows guests running on Xen and Hyper-V hypervisors will now be detected.
* **New Sysconf Plugin** A new plugin parses the output of the sysconf command to provide information on the underlying system.
* **AWS Account ID** The EC2 plugin now fetches the AWS Account ID in addition to previous instance metadata.
* **GCC Detection** GCC detection has been improved to collect additional information, and to not prompt for the installation of Xcode on macOS systems.

New deprecations introduced in this release:
-----------------------------------------------------

Ohai::Config removed
+++++++++++++++++++++++++++++++++++++++++++++++++++++
* **Deprecation ID**: OHAI-1
* **Remediation Docs**: `OHAI-1 </deprecations_ohai_legacy_config.html>`__
* **Expected Removal**: Ohai 13 (April 2017)

sigar gem based plugins removed
+++++++++++++++++++++++++++++++++++++++++++++++++++++
* **Deprecation ID**: OHAI-2
* **Remediation Docs**: `OHAI-2 </deprecations_ohai_sigar_plugins.html>`__
* **Expected Removal**: Ohai 13 (April 2017)

run_command and popen4 helper methods removed
+++++++++++++++++++++++++++++++++++++++++++++++++++++
* **Deprecation ID**: OHAI-3
* **Remediation Docs**: `OHAI-3 </deprecations_ohai_run_command_helpers.html>`__
* **Expected Removal**: Ohai 13 (April 2017)

libvirt plugin attributes moved
+++++++++++++++++++++++++++++++++++++++++++++++++++++
* **Deprecation ID**: OHAI-4
* **Remediation Docs**: `OHAI-4 </deprecations_ohai_libvirt_plugin.html>`__
* **Expected Removal**: Ohai 13 (April 2017)

Windows CPU plugin attribute changes
+++++++++++++++++++++++++++++++++++++++++++++++++++++
* **Deprecation ID**: OHAI-5
* **Remediation Docs**: `OHAI-5 </deprecations_ohai_windows_cpu.html>`__
* **Expected Removal**: Ohai 13 (April 2017)

DigitalOcean plugin attribute changes
+++++++++++++++++++++++++++++++++++++++++++++++++++++
* **Deprecation ID**: OHAI-6
* **Remediation Docs**: `OHAI-6 </deprecations_ohai_digitalocean.html>`__
* **Expected Removal**: Ohai 13 (April 2017)

What's New in 8.22
=====================================================
Ohai 8.22 introduces the following changes:

* **LSB Release Detection** The ``lsb_release`` command line tool is now preferred to the contents of ``/etc/lsb-release``. This resolves an issue where a distro can be upgraded, but ``/etc/lsb-release`` is not upgraded to reflect the change.
* **Haskell Language plugin** Haskell is now detected in a new haskell language plugin.

What's New in 8.21
=====================================================
Ohai 8.21 introduces the following changes:

* **Shard Plugin** Adds a new plugin to provide seed data for sharding. The seed is generated using fqdn, hostname, machine_id, and machinename data and is supported on macOS and Linux systems.

What's New in 8.20
=====================================================
Ohai 8.20 introduces the following changes:

* **LXD Detect** The Virtualization plugin now detect LXD.
* **Windows Nano Networking** Network configuration on Windows Nano is now detected.
* **Hostnamectl plugin** Adds a new plugin to pool data from hostnamectl on systemd based systems.

What's New in 8.19
=====================================================
Ohai 8.19 introduces the following changes:

* **Arista EOS** Added detection of Arista EOS.

What's New in 8.18
=====================================================
Ohai 8.18 introduces the following changes:

* **Shells Plugin** Added a new plugin to detect installed shells.
* **PHP 7** Detect PHP version 7.
* **OS X Virtualization** Detect VirtualBox and VMware on macOS.
* **OS X Hardware Plugin** Added a Hardware plugin for macOS.
* **Linux Block Devices** Detect physical and logic block size.

What's New in 8
=====================================================
Ohai 8 introduces the following change:

* **Minimum supported version of Ruby** The version of Ruby supported by Ohai 8 is Ruby version 2.0.

What's New in 7
=====================================================
Ohai 7 collects all of the same information that Ohai 6 collected and Ohai 7 introduces two major changes. The short version:

* **New DSL** New features like ``collect_data()`` blocks and ``depends`` / ``provides`` statements make it easier to build plugins for platform-specific situations.
* **Attribute name-based user interaction** Only specify the name of the attribute; Ohai 7 will figure out which plugins are required to collect that data.

Ohai 6 vs. Ohai 7 Plugins
-----------------------------------------------------
.. tag ohai_migrate_plugins_6_to_7

Ohai 7 is backwards compatible with existing Ohai 6 plugins; however, none of the new (or future) functionality will be made available to Ohai 6 plugins. It is recommended that all Ohai 6 plugins be updated for new DSL behavior in Ohai 7 as soon as possible. When migrating Ohai 6 plugins to Ohai 7, consider the following:

* Pick a name for the existing plugin, and then define it as an Ohai 7 plugin
* Convert the ``required_plugin()`` calls to ``depends`` statements
* Move the Ohai 6 plugin logic into a ``collect_data()`` block

For example, Ohai 6:

.. code-block:: ruby

   provides 'my_app'

   require_plugin('kernel')

   my_app Mash.new
   my_app[:version] = shell_out('my_app -v').stdout
   my_app[:message] = 'Using #{kernel[:version]}'

and then Ohai 7:

.. code-block:: ruby

   Ohai.plugin(:MyAPP) do
     provides 'my_app'
     depends 'kernel'

     collect_data do
       my_app Mash.new
       my_app[:version] = shell_out('my_app -v').stdout
       my_app[:message] = 'Using #{kernel[:version]}'
     end
   end

Another example, for Ohai 6:

.. code-block:: ruby

   provide 'ipaddress'
   require_plugin '#{os}::network'
   require_plugin '#{os}::virtualization'
   require_plugin 'passwd'

   if virtualization['system'] == 'vbox'
     if etc['passwd'].any? { |k,v| k == 'vagrant'}
       if network['interfaces']['eth1']
         network['interfaces']['eth1']['addresses'].each do |ip, params|
           if params['family'] == ('inet')
             ipaddress ip
           end
         end
       end
     end
   end

and then Ohai 7:

.. code-block:: ruby

   Ohai.plugin(:Vboxipaddress) do
     provides 'ipaddress'
     depends 'ipaddress', 'network/interfaces', 'virtualization/system', 'etc/passwd'
     collect_data(:default) do
       if virtualization['system'] == 'vbox'
         if etc['passwd'].any? { |k,v| k == 'vagrant'}
           if network['interfaces']['eth1']
             network['interfaces']['eth1']['addresses'].each do |ip, params|
               if params['family'] == ('inet')
                 ipaddress ip
               end
             end
           end
         end
       end
     end
   end

.. end_tag

The Ohai 7 DSL
-----------------------------------------------------
Ohai 6 had a key architectural limitation that treated a plugin as a monolithic block of code. This blocked the ability to implement improvements, such as differentiating data that was collected by Ohai as critical or optional. Ohai 7 introduces a new DSL that makes it easier to write custom plugins with better code organization.

Two important pieces of this DSL:

* ``collect_data()`` blocks enable better organization for platform-specific situations
* ``depends`` and ``provides`` statements enable easier dependency management among plugins

Attribute name-based user interaction
-----------------------------------------------------
Ohai 6 required users to know the file path for each plugin in order to use it. Ohai 7 only requires users to know the attribute for which Ohai should collect data. Ohai 7 will figure out where the required plugins are located.

Disable plugins
-----------------------------------------------------
.. tag config_rb_ohai

Ohai configuration settings can be added to the client.rb file.

.. end_tag

Use the following setting to disable plugins:

.. list-table::
   :widths: 200 300
   :header-rows: 1

   * - Setting
     - Description
   * - ``Ohai::Config[:disabled_plugins]``
     - An array of Ohai plugins to be disabled on a node. For example:

       .. code-block:: ruby

          Ohai::Config[:disabled_plugins] = [:MyPlugin]

       or:

       .. code-block:: ruby

          Ohai::Config[:disabled_plugins] = [:MyPlugin, :MyPlugin, :MyPlugin]

       or to disable both Ohai 6 and Ohai 7 versions:

       .. code-block:: ruby

          Ohai::Config[:disabled_plugins] = [:MyPlugin, :MyPlugin, "my_ohai_6_plugin"]
