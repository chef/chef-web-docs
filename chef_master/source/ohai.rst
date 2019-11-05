=====================================================
About Ohai
=====================================================
`[edit on GitHub] <https://github.com/chef/chef-web-docs/blob/master/chef_master/source/ohai.rst>`__

.. tag ohai_summary

Ohai is a tool that is used to collect system configuration data, which is provided to Chef Infra Client for use within cookbooks. Ohai is run by Chef Infra Client at the beginning of every Chef run to determine system state. Ohai includes many built-in plugins to detect common configuration details as well as a plugin model for writing custom plugins.

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

Attributes that are collected by Ohai are automatic level attributes, in that these attributes are used by Chef Infra Client to ensure that these attributes remain unchanged after Chef Infra Client is done configuring the node.

.. end_tag

Ohai collects data for many platforms, including AIX, Darwin, Linux, FreeBSD, OpenBSD, NetBSD, Solaris, and any Microsoft Windows operating systems.

View the `release notes </release_notes_ohai.html>`__ for the latest information on Ohai.

Automatic Attributes
=====================================================
.. tag ohai_automatic_attribute

An automatic attribute is a specific detail about a node, such as an IP address, a host name, a list of loaded kernel modules, and so on. Automatic attributes are detected by Ohai and are then used by Chef Infra Client to ensure that they are handled properly during every Chef Infra Client run. The most commonly accessed automatic attributes are:

.. list-table::
   :widths: 60 420
   :header-rows: 1

   * - Attribute
     - Description
   * - ``node['platform']``
     - The platform on which a node is running. This attribute helps determine which providers will be used.
   * - ``node['platform_version']``
     - The version of the platform. This attribute helps determine which providers will be used.
   * - ``node['ipaddress']``
     - The IP address for a node. If the node has a default route, this is the IPV4 address for the interface. If the node does not have a default route, the value for this attribute should be ``nil``. The IP address for default route is the recommended default value.
   * - ``node['macaddress']``
     - The MAC address for a node, determined by the same interface that detects the ``node['ipaddress']``.
   * - ``node['fqdn']``
     - The fully qualified domain name for a node. This is used as the name of a node unless otherwise set.
   * - ``node['hostname']``
     - The host name for the node.
   * - ``node['domain']``
     - The domain for the node.
   * - ``node['recipes']``
     - A list of recipes associated with a node (and part of that node's run-list).
   * - ``node['roles']``
     - A list of roles associated with a node (and part of that node's run-list).
   * - ``node['ohai_time']``
     - The time at which Ohai was last run. This attribute is not commonly used in recipes, but it is saved to the Chef Infra Server and can be accessed using the ``knife status`` subcommand.

.. end_tag

**Get a list of automatic attributes for a node**

.. tag ohai_attribute_list

Ohai collects a list of automatic attributes at the start of each Chef Infra Client run. This list will vary from organization to organization, by server type, and by the platform that runs those servers. All the attributes collected by Ohai are unmodifiable by Chef Infra Client. Run the ``ohai`` command on a system to see which automatic attributes Ohai has collected for a particular node.

.. end_tag

.. note:: .. tag notes_see_attributes_overview

          Attributes can be configured in cookbooks (attribute files and recipes), roles, and environments. In addition, Ohai collects attribute data about each node at the start of a Chef Infra Client run. See `Attributes </attributes.html>`__ for more information about how all of these attributes fit together.

          .. end_tag

Blacklist Attributes
-----------------------------------------------------
.. tag node_attribute_blacklist

.. warning:: When attribute blacklist settings are used, any attribute defined in a blacklist will not be saved and any attribute that is not defined in a blacklist will be saved. Each attribute type is blacklisted independently of the other attribute types. For example, if ``automatic_attribute_blacklist`` defines attributes that will not be saved, but ``normal_attribute_blacklist``, ``default_attribute_blacklist``, and ``override_attribute_blacklist`` are not defined, then all normal attributes, default attributes, and override attributes will be saved, as well as the automatic attributes that were not specifically excluded through blacklisting.

Attributes that should not be saved by a node may be blacklisted in the client.rb file. The blacklist is a Hash of keys that specify each attribute to be filtered out.

Attributes are blacklisted by attribute type, with each attribute type being blacklisted independently. Each attribute type---``automatic``, ``default``, ``normal``, and ``override``---may define blacklists by using the following settings in the client.rb file:

.. list-table::
   :widths: 200 300
   :header-rows: 1


   * - Setting
     - Description
   * - ``automatic_attribute_blacklist``
     - A hash that blacklists ``automatic`` attributes, preventing blacklisted attributes from being saved. For example: ``['network/interfaces/eth0']``. Default value: ``nil``, all attributes are saved. If the array is empty, all attributes are saved.
   * - ``default_attribute_blacklist``
     - A hash that blacklists ``default`` attributes, preventing blacklisted attributes from being saved. For example: ``['filesystem/dev/disk0s2/size']``. Default value: ``nil``, all attributes are saved. If the array is empty, all attributes are saved.
   * - ``normal_attribute_blacklist``
     - A hash that blacklists ``normal`` attributes, preventing blacklisted attributes from being saved. For example: ``['filesystem/dev/disk0s2/size']``. Default value: ``nil``, all attributes are saved. If the array is empty, all attributes are saved.
   * - ``override_attribute_blacklist``
     - A hash that blacklists ``override`` attributes, preventing blacklisted attributes from being saved. For example: ``['map - autohome/size']``. Default value: ``nil``, all attributes are saved. If the array is empty, all attributes are saved.

.. warning:: The recommended practice is to use only ``automatic_attribute_blacklist`` for blacklisting attributes. This is primarily because automatic attributes generate the most data, but also that normal, default, and override attributes are typically much more important attributes and are more likely to cause issues if they are blacklisted incorrectly.

For example, automatic attribute data similar to:

.. code-block:: javascript

   {
     "filesystem" => {
       "/dev/disk0s2" => {
         "size" => "10mb"
       },
       "map - autohome" => {
         "size" => "10mb"
       }
     },
     "network" => {
       "interfaces" => {
         "eth0" => {...},
         "eth1" => {...},
       }
     }
   }

To blacklist the ``filesystem`` attributes and allow the other attributes to be saved, update the client.rb file:

.. code-block:: ruby

   automatic_attribute_blacklist ['filesystem']

When a blacklist is defined, any attribute of that type that is not specified in that attribute blacklist **will** be saved. So based on the previous blacklist for automatic attributes, the ``filesystem`` and ``map - autohome`` attributes will not be saved, but the ``network`` attributes will.

For attributes that contain slashes (``/``) within the attribute value, such as the ``filesystem`` attribute ``'/dev/diskos2'``, use an array. For example:

.. code-block:: ruby

   automatic_attribute_blacklist [['filesystem','/dev/diskos2']]

.. end_tag

Whitelist Attributes
-----------------------------------------------------
.. tag node_attribute_whitelist

.. warning:: When attribute whitelist settings are used, only the attributes defined in a whitelist will be saved and any attribute that is not defined in a whitelist will not be saved. Each attribute type is whitelisted independently of the other attribute types. For example, if ``automatic_attribute_whitelist`` defines attributes to be saved, but ``normal_attribute_whitelist``, ``default_attribute_whitelist``, and ``override_attribute_whitelist`` are not defined, then all normal attributes, default attributes, and override attributes are saved, as well as the automatic attributes that were specifically included through whitelisting.

Attributes that should be saved by a node may be whitelisted in the client.rb file. The whitelist is a hash of keys that specifies each attribute to be saved.

Attributes are whitelisted by attribute type, with each attribute type being whitelisted independently. Each attribute type---``automatic``, ``default``, ``normal``, and ``override``---may define whitelists by using the following settings in the client.rb file:

.. list-table::
   :widths: 200 300
   :header-rows: 1

   * - Setting
     - Description
   * - ``automatic_attribute_whitelist``
     - A hash that whitelists ``automatic`` attributes, preventing non-whitelisted attributes from being saved. For example: ``['network/interfaces/eth0']``. Default value: ``nil``, all attributes are saved. If the hash is empty, no attributes are saved.
   * - ``default_attribute_whitelist``
     - A hash that whitelists ``default`` attributes, preventing non-whitelisted attributes from being saved. For example: ``['filesystem/dev/disk0s2/size']``. Default value: ``nil``, all attributes are saved. If the hash is empty, no attributes are saved.
   * - ``normal_attribute_whitelist``
     - A hash that whitelists ``normal`` attributes, preventing non-whitelisted attributes from being saved. For example: ``['filesystem/dev/disk0s2/size']``. Default value: ``nil``, all attributes are saved. If the hash is empty, no attributes are saved.
   * - ``override_attribute_whitelist``
     - A hash that whitelists ``override`` attributes, preventing non-whitelisted attributes from being saved. For example: ``['map - autohome/size']``. Default value: ``nil``, all attributes are saved. If the hash is empty, no attributes are saved.

.. warning:: The recommended practice is to only use ``automatic_attribute_whitelist`` to whitelist attributes. This is primarily because automatic attributes generate the most data, but also that normal, default, and override attributes are typically much more important attributes and are more likely to cause issues if they are whitelisted incorrectly.

For example, automatic attribute data similar to:

.. code-block:: javascript

   {
     "filesystem" => {
       "/dev/disk0s2" => {
         "size" => "10mb"
       },
       "map - autohome" => {
         "size" => "10mb"
       }
     },
     "network" => {
       "interfaces" => {
         "eth0" => {...},
         "eth1" => {...},
       }
     }
   }

To whitelist the ``network`` attributes and prevent the other attributes from being saved, update the client.rb file:

.. code-block:: ruby

   automatic_attribute_whitelist ['network/interfaces/']

When a whitelist is defined, any attribute of that type that is not specified in that attribute whitelist **will not** be saved. So based on the previous whitelist for automatic attributes, the ``filesystem`` and ``map - autohome`` attributes will not be saved, but the ``network`` attributes will.

Leave the value empty to prevent all attributes of that attribute type from being saved:

.. code-block:: ruby

   automatic_attribute_whitelist []

For attributes that contain slashes (``/``) within the attribute value, such as the ``filesystem`` attribute ``'/dev/diskos2'``, use an array. For example:

.. code-block:: ruby

   automatic_attribute_whitelist [['filesystem','/dev/diskos2']]

.. end_tag

Default Plugins
=====================================================
The following list shows the type of plugins that are included with Ohai. See the ``ohai/lib/ohai/plugins`` directory in the version of Ohai installed on your system for the full list:

General Purpose Plugins
-----------------------

.. code-block:: ruby

    azure.rb
    c.rb
    chef.rb
    cloud.rb
    command.rb
    cpu.rb
    digital_ocean.rb
    dmi.rb
    docker.rb
    ec2.rb
    elixir.rb
    erlang.rb
    eucalyptus.rb
    filesystem.rb
    freebsd
    gce.rb
    go.rb
    groovy.rb
    haskell.rb
    hostname.rb
    init_package.rb
    java.rb
    joyent.rb
    kernel.rb
    keys.rb
    languages.rb
    libvirt.rb
    linode.rb
    lua.rb
    mono.rb
    network.rb
    nodejs.rb
    ohai_time.rb
    ohai.rb
    memory.rb
    network.rb
    platform.rb
    openstack.rb
    os.rb
    packages.rb
    perl.rb
    php.rb
    platform.rb
    powershell.rb
    ps.rb
    python.rb
    rackspace.rb
    root_group.rb
    ruby.rb
    rust.rb
    scala.rb
    scaleway.rb
    shard.rb
    shells.rb
    softlayer.rb
    ssh_host_key.rb
    timezone.rb
    uptime.rb
    virtualbox.rb
    vmware.rb
    zpools.rb

Platform Specific Plugins
-------------------------

.. code-block:: ruby

   aix
     kernel.rb
     memory.rb
     network.rb
     platform.rb
     uptime.rb
     virtualization.rb
   bsd
    virtualization.rb
   darwin
     cpu.rb
     filesystem.rb
     hardware.rb
     memory.rb
     network.rb
     platform.rb
     system_profiler.rb
     virtualization.rb
   dragonflybsd
    cpu.rb
    memory.rb
    network.rb
    os.rb
    platform.rb
   freebsd
     cpu.rb
     memory.rb
     network.rb
     os.rb
     platform.rb
   linux
     block_device.rb
     cpu.rb
     filesystem.rb
     fips.rb
     hostnamectl.rb
     lsb.rb
     machineid.rb
     mdadm.rb
     memory.rb
     network.rb
     platform.rb
     sessons.rb
     virtualization.rb
   netbsd
     cpu.rb
     memory.rb
     network.rb
     platform.rb
   openbsd
     cpu.rb
     memory.rb
     network.rb
     platform.rb
   solaris2
     cpu.rb
     dmi.rb
     filesystem.rb
     memory.rb
     network.rb
     platform.rb
     virtualization.rb
   windows
     cpu.rb
     drivers.rb
     filesystem.rb
     fips.rb
     memory.rb
     network.rb
     platform.rb
     system_enclosure.rb
     virtualization.rb

Optional Plugins
=====================================================

Ohai ships several plugins that are considered optional and can be enabled in the `client.rb configuration file </config_rb_client.html>`__.

- `Lspci` - PCI device information on Linux hosts.
- `Lsscsi` - SCSI device information on Linux hosts.
- `Passwd` - User and Group information on non-Windows hosts. This plugin can result in very large node sizes if a system connects to Active Directory or LDAP.
- `Sessions` - Sessions data from loginctl on Linux hosts.
- `Sysctl` - All sysctl values on Linux hosts.

Enabling Optional Plugins
-------------------------

Optional plugins can be enabled in the `client.rb configuration file </config_rb_client.html>`__:

.. code-block:: ruby

   ohai.optional_plugins = [
     :Sessions,
     :Lspci
   ]

Custom Plugins
=====================================================

Custom Ohai plugins can be written to collect additional information from systems as necessary. See the `Ohai Custom Plugins </ohai_custom.html>`__ docs for more information.

Hints
=====================================================

Ohai hints are used to tell Ohai something about the system that it is running on that it would not be able to discover itself. An Ohai hint exists if a JSON file exists in the hint directory with the same name as the hint. For example, calling ``hint?('antarctica')`` in an Ohai plugin would return an empty hash if the file ``antarctica.json`` existed in the hints directory, and return nil if the file does not exist.

If the hint file contains JSON content, it will be returned as a hash from the call to ``hint?``.

.. code-block:: javascript

   {
     "snow": true,
     "penguins": "many"
   }

.. code-block:: ruby

   antarctica_hint = hint?('antarctica')
   if antarctica_hint['snow']
     "There are #{antarctica_hint['penguins']} penguins here."
   else
     'There is no snow here, and penguins like snow.'
   end

Hint files are located in the ``/etc/chef/ohai/hints/`` directory by default. Use the ``Ohai.config[:hints_path]`` setting in the `client.rb configuration file </config_rb_client.html>`__ to customize this location.


ohai Resource
=====================================================
.. tag resources_common_generic

A `resource </resource.html>`__ defines the desired state for a single configuration item present on a node that is under management by Chef Infra. A resource collection---one (or more) individual resources---defines the desired state for the entire node. During a `Chef Infra Client run </chef_client.html#the-chef-client-run.html>`__, the current state of each resource is tested, after which Chef Infra Client will take any steps that are necessary to repair the node and bring it back into the desired state.

.. end_tag

.. tag resource_ohai_summary

Use the **ohai** resource to reload the Ohai configuration on a node. This allows recipes that change system attributes (like a recipe that adds a user) to refer to those attributes later on during a Chef Infra Client run.

.. end_tag

Syntax
----------------------------------------------------
A **ohai** resource block reloads the Ohai configuration on a node:

.. code-block:: ruby

   ohai 'reload' do
     action :reload
   end

The full syntax for all of the properties that are available to the **ohai** resource is:

.. code-block:: ruby

   ohai 'name' do
     name                       String
     notifies                   # see description
     plugin                     String
     subscribes                 # see description
     action                     Symbol # defaults to :reload if not specified
   end

where

* ``ohai`` is the resource
* ``name`` is the name of the resource block
* ``action`` identifies the steps Chef Infra Client will take to bring the node into the desired state
* ``name`` and ``plugin`` are properties of this resource, with the Ruby type shown. See "Properties" section below for more information about all of the properties that may be used with this resource.



Actions
-----------------------------------------------------
.. tag resource_ohai_actions

The ohai resource has the following actions:

``:nothing``
   .. tag resources_common_actions_nothing

   This resource block does not act unless notified by another resource to take action. Once notified, this resource block either runs immediately or is queued up to run at the end of a Chef Infra Client run.

   .. end_tag

``:reload``
   Default. Reload the Ohai configuration on a node.

.. end_tag

Properties
-----------------------------------------------------
.. tag resource_ohai_properties

The ohai resource has the following properties:

``plugin``
   **Ruby Type:** String

   The name of an Ohai plugin to be reloaded. If this property is not specified, Chef Infra Client will reload all plugins.

.. end_tag

Examples
-----------------------------------------------------
The following examples demonstrate various approaches for using resources in recipes:

**Reload Ohai**

.. tag resource_ohai_reload

.. To reload Ohai:

.. code-block:: ruby

   ohai 'reload' do
     action :reload
   end

.. end_tag

**Reload Ohai after a new user is created**

.. tag resource_ohai_reload_after_create_user

.. To reload Ohai configuration after a new user is created:

.. code-block:: ruby

   ohai 'reload_passwd' do
     action :nothing
     plugin 'etc'
   end

   user 'daemonuser' do
     home '/dev/null'
     shell '/sbin/nologin'
     system true
     notifies :reload, 'ohai[reload_passwd]', :immediately
   end

   ruby_block 'just an example' do
     block do
       # These variables will now have the new values
       puts node['etc']['passwd']['daemonuser']['uid']
       puts node['etc']['passwd']['daemonuser']['gid']
     end
   end

.. end_tag

ohai Command Line Tool
=====================================================
.. tag ctl_ohai_summary

ohai is the command-line interface for Ohai, a tool that is used to detect attributes on a node, and then provide these attributes to Chef Infra Client at the start of every Chef Infra Client run.

.. end_tag

Options
-----------------------------------------------------
.. tag ctl_ohai_options

This command has the following syntax:

.. code-block:: bash

   $ ohai OPTION

This tool has the following options:

``ATTRIBUTE_NAME ATTRIBUTE NAME ...``
   Use to have Ohai show only output for named attributes.

``-c CONFIG``, ``--config CONFIG``
   The path to a configuration file to use For example: ``/etc/ohai/config.rb``.

``-d DIRECTORY``, ``--directory DIRECTORY``
   The directory in which additional Ohai plugins are located. For example: ``/my/extra/plugins``.

``-h``, ``--help``
   Show help for the command.

``-l LEVEL``, ``--log_level LEVEL``
   The level of logging to be stored in a log file.

``-L LOGLOCATION``, ``--logfile LOGLOCATION``
   The location of the log file.

``-v``, ``--version``
   The version of Ohai.

.. end_tag

Ohai Settings in client.rb
=====================================================

.. tag config_rb_ohai

Ohai configuration settings can be added to the client.rb file.

.. end_tag

.. tag config_rb_ohai_settings

``ohai.directory``
   The directory in which Ohai plugins are located.

``ohai.disabled_plugins``
   An array of Ohai plugins to be disabled on a node. The list of plugins included in Ohai can be found in the ``ohai/lib/ohai/plugins`` directory. For example, disabling a single plugin:

   .. code-block:: ruby

      ohai.disabled_plugins = [
        :MyPlugin
      ]

   or disabling multiple plugins:

   .. code-block:: ruby

      ohai.disabled_plugins = [
        :MyPlugin,
        :MyPlugin2,
        :MyPlugin3
      ]

   When a plugin is disabled, the Chef Infra Client log file will contain entries similar to:

   .. code-block:: ruby

      [2014-06-13T23:49:12+00:00] DEBUG: Skipping disabled plugin MyPlugin

``ohai.hints_path``
   The path to the file that contains hints for Ohai.

``ohai.log_level``
   The level of logging to be stored in a log file.

``ohai.log_location``
   The location of the log file.

``ohai.plugin_path``
   An array of paths at which Ohai plugins are located. Default value: ``[<CHEF_GEM_PATH>/ohai-9.9.9/lib/ohai/plugins]``. When custom Ohai plugins are added, the paths must be added to the array. For example, a single plugin:

   .. code-block:: ruby

      ohai.plugin_path << '/etc/chef/ohai_plugins'

   and for multiple plugins:

   .. code-block:: ruby

      ohai.plugin_path += [
        '/etc/chef/ohai_plugins',
        '/path/to/other/plugins'
        ]

.. note:: The Ohai executable ignores settings in the client.rb file when Ohai is run independently of Chef Infra Client.

.. end_tag
