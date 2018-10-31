=====================================================
About Ohai
=====================================================
`[edit on GitHub] <https://github.com/chef/chef-web-docs/blob/master/chef_master/source/ohai.rst>`__

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

Ohai collects data for many platforms, including AIX, Darwin, Linux, FreeBSD, OpenBSD, NetBSD, Solaris, and any Microsoft Windows operating systems.

View the `release notes </release_notes_ohai.html>`__ for the latest information on Ohai.

Automatic Attributes
=====================================================
.. tag ohai_automatic_attribute

An automatic attribute is a specific detail about a node, such as an IP address, a host name, a list of loaded kernel modules, and so on. Automatic attributes are detected by Ohai and are then used by the chef-client to ensure that they are handled properly during every chef-client run. The most commonly accessed automatic attributes are:

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
     - The time at which Ohai was last run. This attribute is not commonly used in recipes, but it is saved to the Chef server and can be accessed using the ``knife status`` subcommand.

.. end_tag

**Get a list of automatic attributes for a node**

.. tag ohai_attribute_list

The list of automatic attributes that are collected by Ohai at the start of each chef-client run vary from organization to organization, and will often vary between the various server types being configured and the platforms on which those servers are run. All attributes collected by Ohai are unmodifiable by the chef-client. To see which automatic attributes are collected by Ohai for a particular node, run the following command:

.. code-block:: bash

   find  /opt/chefdk/embedded/lib/ruby/gems/*/gems/ohai-*/lib -name "*.rb" -print | xargs grep -R "provides" -h |sed 's/^\s*//g'|sed "s/\\\"/\'/g"|sort|uniq|grep "\sprovides"

.. end_tag

.. note:: .. tag notes_see_attributes_overview

          Attributes can be configured in cookbooks (attribute files and recipes), roles, and environments. In addition, Ohai collects attribute data about each node at the start of the chef-client run. See `Attributes </attributes.html>`__ for more information about how all of these attributes fit together.

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

.. code-block:: ruby

   aix
     cpu.rb
     filesystem.rb
     kernel.rb
     memory.rb
     network.rb
     os.rb
     platform.rb
     uptime.rb
     virtualization.rb
   azure.rb
   bsd
    filesystem.rb
    virtualization.rb
   c.rb
   chef.rb
   cloud.rb
   command.rb
   darwin
     cpu.rb
     filesystem.rb
     hardware.rb
     memory.rb
     network.rb
     platform.rb
     system_profiler.rb
     virtualization.rb
   digital_ocean.rb
   dmi.rb
   docker.rb
   dragonflybsd
    cpu.rb
    memory.rb
    network.rb
    os.rb
    platform.rb
   ec2.rb
   elixir.rb
   erlang.rb
   eucalyptus.rb
   freebsd
     cpu.rb
     memory.rb
     network.rb
     os.rb
     platform.rb
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
   lua.rb
   mono.rb
   netbsd
     cpu.rb
     memory.rb
     network.rb
     platform.rb
   network.rb
   nodejs.rb
   ohai.rb
   ohai_time.rb
   openbsd
     cpu.rb
     memory.rb
     network.rb
     platform.rb
   openstack.rb
   os.rb
   packages.rb
   passwd.rb
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
   scsi.rb
   shard.rb
   shells.rb
   softlayer.rb
   solaris2
     cpu.rb
     dmi.rb
     filesystem.rb
     memory.rb
     network.rb
     platform.rb
     virtualization.rb
   ssh_host_key.rb
   sysconf.rb
   timezone.rb
   uptime.rb
   virtualbox.rb
   vmware.rb
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
   zpools.rb

Custom Plugins
=====================================================

Custom Ohai plugins can be written to collect additional information from systems as necessary. See the `Ohai Custom Plugins </ohai_custom.html>`__ docs for more information.

Hints
=====================================================
.. tag ohai_hints

Ohai hints are used to tell Ohai something about the system that it is running on that it would not be able to discover itself. An Ohai hint exists if a JSON file exists in the hint directory with the same name as the hint. For example, calling ``hint?('antarctica')`` in an Ohai plugin would return an empty hash if the file ``antarctica.json`` existed in the hints directory, and return nil if the file does not exist.

.. end_tag

.. tag ohai_hints_json

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

Hint files are located in the ``/etc/chef/ohai/hints/`` directory by default. Use the ``Ohai.config[:hints_path]`` setting in the ``client.rb`` file to customize this location.

.. end_tag

ohai Resource
=====================================================
.. tag resources_common_generic

A `resource </resource.html>`__ defines the desired state for a single configuration item present on a node that is under management by Chef. A resource collection---one (or more) individual resources---defines the desired state for the entire node. During a `chef-client run </chef_client.html#the-chef-client-run.html>`__, the current state of each resource is tested, after which the chef-client will take any steps that are necessary to repair the node and bring it back into the desired state.

.. end_tag

.. tag resource_ohai_summary

Use the **ohai** resource to reload the Ohai configuration on a node. This allows recipes that change system attributes (like a recipe that adds a user) to refer to those attributes later on during the chef-client run.

.. end_tag

Syntax
-----------------------------------------------------
.. tag resource_ohai_syntax

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
* ``action`` identifies the steps the chef-client will take to bring the node into the desired state
* ``name`` and ``plugin`` are properties of this resource, with the Ruby type shown. See "Properties" section below for more information about all of the properties that may be used with this resource.

.. end_tag

Actions
-----------------------------------------------------
.. tag resource_ohai_actions

The ohai resource has the following actions:

``:nothing``
   .. tag resources_common_actions_nothing

   Define this resource block to do nothing until notified by another resource to take action. When this resource is notified, this resource block is either run immediately or it is queued up to be run at the end of the Chef Client run.

   .. end_tag

``:reload``
   Default. Reload the Ohai configuration on a node.

.. end_tag

Properties
-----------------------------------------------------
.. tag resource_ohai_attributes

The ohai resource has the following properties:

``ignore_failure``
   **Ruby Type:** true, false | **Default Value:** ``false``

   Continue running a recipe if a resource fails for any reason.

``notifies``
   **Ruby Type:** Symbol, 'Chef::Resource[String]'

   .. tag resources_common_notification_notifies

   A resource may notify another resource to take action when its state changes. Specify a ``'resource[name]'``, the ``:action`` that resource should take, and then the ``:timer`` for that action. A resource may notify more than one resource; use a ``notifies`` statement for each resource to be notified.

   .. end_tag

   .. tag resources_common_notification_timers

   A timer specifies the point during the Chef Client run at which a notification is run. The following timers are available:

   ``:before``
      Specifies that the action on a notified resource should be run before processing the resource block in which the notification is located.

   ``:delayed``
      Default. Specifies that a notification should be queued up, and then executed at the end of the Chef Client run.

   ``:immediate``, ``:immediately``
      Specifies that a notification should be run immediately, per resource notified.

   .. end_tag

   .. tag resources_common_notification_notifies_syntax

   The syntax for ``notifies`` is:

   .. code-block:: ruby

      notifies :action, 'resource[name]', :timer

   .. end_tag

``plugin``
   **Ruby Type:** String

   The name of an Ohai plugin to be reloaded. If this property is not specified, the chef-client will reload all plugins.

``retries``
   **Ruby Type:** Integer | **Default Value:** ``0``

   The number of times to catch exceptions and retry the resource.

``retry_delay``
   **Ruby Type:** Integer | **Default Value:** ``2``

   The retry delay (in seconds).

``subscribes``
   **Ruby Type:** Symbol, 'Chef::Resource[String]'

   .. tag resources_common_notification_subscribes

   A resource may listen to another resource, and then take action if the state of the resource being listened to changes. Specify a ``'resource[name]'``, the ``:action`` to be taken, and then the ``:timer`` for that action.

   Note that ``subscribes`` does not apply the specified action to the resource that it listens to - for example:

   .. code-block:: ruby

     file '/etc/nginx/ssl/example.crt' do
        mode '0600'
        owner 'root'
     end

     service 'nginx' do
        subscribes :reload, 'file[/etc/nginx/ssl/example.crt]', :immediately
     end

   In this case the ``subscribes`` property reloads the ``nginx`` service whenever its certificate file, located under ``/etc/nginx/ssl/example.crt``, is updated. ``subscribes`` does not make any changes to the certificate file itself, it merely listens for a change to the file, and executes the ``:reload`` action for its resource (in this example ``nginx``) when a change is detected.

   .. end_tag

   .. tag resources_common_notification_timers

   A timer specifies the point during the Chef Client run at which a notification is run. The following timers are available:

   ``:before``
      Specifies that the action on a notified resource should be run before processing the resource block in which the notification is located.

   ``:delayed``
      Default. Specifies that a notification should be queued up, and then executed at the end of the Chef Client run.

   ``:immediate``, ``:immediately``
      Specifies that a notification should be run immediately, per resource notified.

   .. end_tag

   .. tag resources_common_notification_subscribes_syntax

   The syntax for ``subscribes`` is:

   .. code-block:: ruby

      subscribes :action, 'resource[name]', :timer

   .. end_tag

.. end_tag

Providers
-----------------------------------------------------
This resource has the following providers:

``Chef::Provider::Ohai``, ``ohai``
   The default provider for all platforms.

Examples
-----------------------------------------------------
The following examples demonstrate various approaches for using resources in recipes. If you want to see examples of how Chef uses resources in recipes, take a closer look at the cookbooks that Chef authors and maintains: https://github.com/chef-cookbooks.

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

ohai is the command-line interface for Ohai, a tool that is used to detect attributes on a node, and then provide these attributes to the chef-client at the start of every chef-client run.

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
        :MyPlugin,
        :MyPlugin
      ]

   and to disable multiple plugins, including Ohai 6 plugins:

   .. code-block:: ruby

      ohai.disabled_plugins = [
		:MyPlugin,
        :MyPlugin,
        'my_ohai_6_plugin'
      ]

   When a plugin is disabled, the chef-client log file will contain entries similar to:

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

``ohai.version``
   The version of Ohai.

.. note:: The Ohai executable ignores settings in the client.rb file when Ohai is run independently of the chef-client.

.. end_tag
