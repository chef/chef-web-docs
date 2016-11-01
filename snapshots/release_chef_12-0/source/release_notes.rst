=====================================================
Release Notes: chef-client 12.0
=====================================================

.. tag chef

Chef is a powerful automation platform that transforms infrastructure into code. Whether you’re operating in the cloud, on-premises, or in a hybrid environment, Chef automates how infrastructure is configured, deployed, and managed across your network, no matter its size.

This diagram shows how you develop, test, and deploy your Chef code.

.. image:: ../../images/start_chef.svg
   :width: 700px
   :align: center

.. end_tag

Please view the notes for more background on the upgrade process from chef-client 11 to chef-client 12.

What's New
=====================================================
The following items are new for chef-client 12.0 and/or are changes from previous versions. The short version:

* **Changing attributes** Attributes may be modified for named precedence levels, all precedence levels, and be fully assigned. These changes were `based on RFC-23 <https://github.com/chef/chef-rfc/blob/master/rfc023-chef-12-attributes-changes.md>`_.
* **Ruby 2.0 (or higher) for Windows; and Ruby 2.1 (or higher) for Unix/Linux** Ruby versions 1.8.7, 1.9.1, 1.9.2, and 1.9.3 are no longer supported. See `this blog post <https://www.chef.io/blog/2014/11/25/ruby-1-9-3-eol-and-chef-12/>`_ for more info.
* **The number of changes between Ruby 1.9 and 2.0 is small** Please review the `Ruby 2.0 release notes <https://github.com/ruby/ruby/blob/v2_0_0_0/NEWS>`_ or `Ruby 2.1 release notes <https://github.com/ruby/ruby/blob/v2_1_0/NEWS>`_ for the full list of changes.
* **provides method for building custom resources** Use the ``provides`` method to associate a custom resource with a built-in chef-client resource and to specify platforms on which the custom resource may be used.
* **The chef-client supports the AIX platform** The chef-client may now be used to configure nodes that are running on the AIX platform, versions 6.1 (TL6 or higher, recommended) and 7.1 (TL0 SP3 or higher, recommended). The **service** resource supports starting, stopping, and restarting services that are managed by System Resource Controller (SRC), as well as managing all service states with BSD-based init systems. 
* **New bff_package resource** Use the **bff_package** resource to install packages on the AIX platform.
* **New homebrew_package resource** Use the **homebrew_package** resource to install packages on the Mac OS X platform. The **homebrew_package** resource also replaces the **macports_package** resource as the default package installer on the Mac OS X platform.
* **New reboot resource** Use the **reboot** resource to reboot a node during or at the end of a chef-client run.
* **New windows_service resource** Use the **windows_service** resource to manage services on the Microsoft Windows platform.
* **New --bootstrap-template option** Use the ``--bootstrap-template`` option to install the chef-client with a bootstrap template. Specify the name of a template, such as ``chef-full``, or specify the path to a custom bootstrap template. This option deprecates the ``--distro`` and ``--template-file`` options.
* **New SSL options for bootstrap operations** The ``knife bootstrap`` subcommand has new options that support SSL with bootstrap operations. Use the ``--[no-]node-verify-api-cert`` option to to perform SSL validation of the connection to the Chef server. Use the ``--node-ssl-verify-mode`` option to validate SSL certificates.
* **New format options for knife status** Use the ``--medium`` and ``--long`` options to include attributes in the output and to format that output as JSON.
* **New fsck_device property for mount resource** The **mount** resource supports fsck devices for the Solaris platform with the ``fsck_device`` property.
* **New settings for metadata.rb** The metadata.rb file has two new settings: ``issues_url`` and ``source_url``. These settings are used to capture the source location and issues tracking location for a cookbook. These settings are also used with Chef Supermarket. In addition, the ``name`` setting is now **required**.
* **The http_request GET and HEAD requests drop the hard-coded query string** The ``:get`` and ``:head`` actions appended a hard-coded query string---``?message=resource_name``---that cannot be overridden. This hard-coded string is deprecated in the chef-client 12.0 release. Cookbooks that rely on this string need to be updated to manually add it to the URL as it is passed to the resource.
* **New Recipe DSL methods** The Recipe DSL has three new methods: ``shell_out``, ``shell_out!``, and ``shell_out_with_systems_locale``.
* **File specificity updates** File specificity for the **template** and **cookbook_file** resources now supports using the ``source`` attribute to define an explicit lookup path as an array.
* **Improved user password security for the user resource, Mac OS X platform** The **user** resource now supports salted password hashes for Mac OS X 10.7 (and higher). Use the ``iterations`` and ``salt`` attributes to calculate SALTED-SHA512 password shadow hashes for Mac OS X version 10.7 and SALTED-SHA512-PBKDF2 password shadow hashes for version 10.8 (and higher).
* **data_bag_item method in the Recipe DSL supports encrypted data bag items** Use ``data_bag_item(bag_name, item, secret)`` to specify the secret to use for an encrypted data bag item. If ``secret`` is not specified, the chef-client looks for a secret at the path specified by the ``encrypted_data_bag_secret`` setting in the client.rb file.
* **value_for_platform method in the Recipe DSL supports version constraints** Version constraints---``>``, ``<``, ``>=``, ``<=``, ``~>``---may be used when specifying a version. An exception is raised if two version constraints match. An exact match will always take precedence over a match made from a version constraint.
* **knife cookbook site share supports --dry-run** Use the ``--dry-run`` option with the ``knife cookbook site`` to take no action and only print out results.
* **chef-client configuration setting updates** The chef-client now supports running an override run-list (via the ``--override-runlist`` option) without clearing the cookbook cache on the node. In addition, the ``--chef-zero-port`` option allows specifying a range of ports.
* **Unforked interval runs are no longer allowed** The ``--[no-]fork`` option may no longer be used in the same command with the ``--daemonize`` and ``--interval`` options.
* **Splay and interval values are applied before the chef-client run** The ``--interval`` and ``--splay`` values are applied before the chef-client run when using the chef-client and chef-solo executables.
* **All files and templates in a cookbook are synchronized at the start of the chef-client run** The ``no_lazy_load`` configuration setting in the client.rb file now defaults to ``true``. This avoids issues where time-sensitive URLs in a cookbook manifest timeout before the **cookbook_file** or **template** resources converged.
* **File staging now defaults to the destination directory by default** Staging into a system's temporary directory---typically ``/tmp`` or ``/var/tmp``---as opposed to the destination directory may cause issues with permissions, available space, or cross-device renames. Files are now staged to the destination directory by default.
* **Partial search updates** Use ``:filter_result`` to build search results into a Hash. This replaces the previous functionality that was provided by the ``partial_search`` cookbook, albeit with a different API. Use the ``--filter-result`` option to return only attributes that match the specified filter. For example: ``\"ServerName=name, Kernel=kernel.version\"``.
* **Client-side key generation is enabled by default** When a new chef-client is created using the validation client account, the Chef server allows the chef-client to generate a key-pair locally, and then send the public key to the Chef server. This behavior is controlled by the ``local_key_generation`` attribute in the client.rb file and now defaults to ``true``. 
* **New guard_interpreter property defaults** The ``guard_interpreter`` property now defaults to ``:batch`` for the **batch** resource and ``:powershell_script`` for the **powershell_script** resource.
* **Events are sent to the Application event log on the Windows platform by default** Events are sent to the Microsoft Windows "Application" event log at the start and end of a chef-client run, and also if a chef-client run fails. Set the ``disable_event_logger`` configuration setting in the client.rb file to ``true`` to disable event logging.
* **The installer_type property for the windows_package resource uses a symbol instead of a string** Previous versions of the chef-client (starting with version 11.8) used a string.
* **The path property is deprecated for the execute resource** Use the ``environment`` property instead.
* **SSL certificate validation improvements** The default settings for SSL certificate validation now default in favor of validation. In addition, using the ``knife ssl fetch`` subcommand is now an important part of setting up your workstation.
* **New property for git resource** The **git** resource has a new property: ``environment``, which takes a Hash of environment variables in the form of ``{"ENV_VARIABLE" => "VALUE"}``.

Change Attributes
-----------------------------------------------------
.. tag node_attribute_change

Starting with chef-client 12.0, attribute precedence levels may be

* Removed for a specific, named attribute precedence level
* Removed for all attribute precedence levels
* Fully assigned attributes

.. end_tag

Remove Precedence Level
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. tag node_attribute_change_remove_level

A specific attribute precedence level for default, normal, and override attributes may be removed by using one of the following syntax patterns.

For default attributes:

* ``node.rm_default('foo', 'bar')``

For normal attributes:

* ``node.rm_normal('foo', 'bar')``

For override attributes:

* ``node.rm_override('foo', 'bar')``

These patterns return the computed value of the key being deleted for the specified precedence level.

.. end_tag

Examples
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
.. tag node_attribute_change_remove_level_examples

The following examples show how to remove a specific, named attribute precedence level.

**Delete a default value when only default values exist**

Given the following code structure under ``'foo'``:

.. code-block:: ruby

   node.default['foo'] = {
     'bar' => {
       'baz' => 52,
       'thing' => 'stuff',
     },
     'bat' => {
       'things' => [5, 6],
     },
   }

And some role attributes:

.. code-block:: ruby

   # Please don't ever do this in real code :)
   node.role_default['foo']['bar']['thing'] = 'otherstuff'

And a force attribute:

.. code-block:: ruby

   node.force_default['foo']['bar']['thing'] = 'allthestuff'

When the default attribute precedence ``node['foo']['bar']`` is removed:

.. code-block:: ruby

   node.rm_default('foo', 'bar') #=> {'baz' => 52, 'thing' => 'allthestuff'}

What is left under ``'foo'`` is only ``'bat'``:

.. code-block:: ruby

   node.attributes.combined_default['foo'] #=> {'bat' => { 'things' => [5,6] } }

**Delete default without touching higher precedence attributes**

Given the following code structure:

.. code-block:: ruby

   node.default['foo'] = {
     'bar' => {
       'baz' => 52,
       'thing' => 'stuff',
     },
     'bat' => {
       'things' => [5, 6],
     },
   }

And some role attributes:

.. code-block:: ruby

   # Please don't ever do this in real code :)
   node.role_default['foo']['bar']['thing'] = 'otherstuff'

And a force attribute:

.. code-block:: ruby

   node.force_default['foo']['bar']['thing'] = 'allthestuff'

And also some override attributes:

.. code-block:: ruby

   node.override['foo']['bar']['baz'] = 99

Same delete as before:

.. code-block:: ruby

   node.rm_default('foo', 'bar') #=> { 'baz' => 52, 'thing' => 'allthestuff' }

The other attribute precedence levels are unaffected:

.. code-block:: ruby

   node.attributes.combined_override['foo'] #=> { 'bar' => {'baz' => 99} }
   node['foo'] #=> { 'bar' => {'baz' => 99}, 'bat' => { 'things' => [5,6] }

**Delete override without touching lower precedence attributes**

Given the following code structure, which has an override attribute:

.. code-block:: ruby

   node.override['foo'] = {
     'bar' => {
       'baz' => 52,
       'thing' => 'stuff',
     },
     'bat' => {
       'things' => [5, 6],
     },
   }

with a single default value:

.. code-block:: ruby

   node.default['foo']['bar']['baz'] = 11

and a force at each attribute precedence:

.. code-block:: ruby

   node.force_default['foo']['bar']['baz'] = 55
   node.force_override['foo']['bar']['baz'] = 99

Delete the override:

.. code-block:: ruby

   node.rm_override('foo', 'bar') #=> { 'baz' => 99, 'thing' => 'stuff' }

The other attribute precedence levels are unaffected:

.. code-block:: ruby

   node.attributes.combined_default['foo'] #=> { 'bar' => {'baz' => 55} }

**Non-existent key deletes return nil**

.. code-block:: ruby

   node.rm_default("no", "such", "thing") #=> nil

.. end_tag

Remove All Levels
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. tag node_attribute_change_remove_all

All attribute precedence levels may be removed by using the following syntax pattern:

* ``node.rm('foo', 'bar')``

.. note:: Using ``node['foo'].delete('bar')`` will throw an exception that points to the new API.

.. end_tag

Examples
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
.. tag node_attribute_change_remove_all_examples

The following examples show how to remove all attribute precedence levels.

**Delete all attribute precedence levels**

Given the following code structure:

.. code-block:: ruby

   node.default['foo'] = {
     'bar' => {
       'baz' => 52,
       'thing' => 'stuff',
     },
     'bat' => {
       'things' => [5, 6],
     },
   }

With override attributes:

.. code-block:: ruby

   node.override['foo']['bar']['baz'] = 999

Removing the ``'bar'`` key returns the computed value:

.. code-block:: ruby

   node.rm('foo', 'bar') #=> {'baz' => 999, 'thing' => 'stuff'}

Looking at ``'foo'``, all that's left is the ``'bat'`` entry:

.. code-block:: ruby

   node['foo'] #=> {'bat' => { 'things' => [5,6] } }

**Non-existent key deletes return nil**

.. code-block:: ruby

   node.rm_default("no", "such", "thing") #=> nil

.. end_tag

Full Assignment
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. tag node_attribute_change_full_assignment

Use ``!`` to clear out the key for the named attribute precedence level, and then complete the write by using one of the following syntax patterns:

* ``node.default!['foo']['bar'] = {...}``
* ``node.force_default!['foo']['bar'] = {...}``
* ``node.normal!['foo']['bar'] = {...}``
* ``node.override!['foo']['bar'] = {...}``
* ``node.force_override!['foo']['bar'] = {...}``

.. end_tag

Examples
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
.. tag node_attribute_change_full_assignment_examples

The following examples show how to remove all attribute precedence levels.

**Just one component**

Given the following code structure:

.. code-block:: ruby

   node.default['foo']['bar'] = {'a' => 'b'}
   node.default!['foo']['bar'] = {'c' => 'd'}

The ``'!'`` caused the entire 'bar' key to be overwritten:
.. code-block:: ruby

   node['foo'] #=> {'bar' => {'c' => 'd'}

**Multiple components; one "after"**

Given the following code structure:

.. code-block:: ruby

   node.default['foo']['bar'] = {'a' => 'b'}
   # Please don't ever do this in real code :)
   node.role_default['foo']['bar'] = {'c' => 'd'}
   node.default!['foo']['bar'] = {'d' => 'e'}

The ``'!'`` write overwrote the "cookbook-default" value of ``'bar'``, but since role data is later in the resolution list, it was unaffected:

.. code-block:: ruby

   node['foo'] #=> {'bar' => {'c' => 'd', 'd' => 'e'}

**Multiple components; all "before"**

Given the following code structure:

.. code-block:: ruby

   node.default['foo']['bar'] = {'a' => 'b'}
   # Please don't ever do this in real code :)
   node.role_default['foo']['bar'] = {'c' => 'd'}
   node.force_default!['foo']['bar'] = {'d' => 'e'}

With ``force_default!`` there is no other data under ``'bar'``:

.. code-block:: ruby

   node['foo'] #=> {'bar' => {'d' => 'e'}

**Multiple precedence levels**

Given the following code structure:

.. code-block:: ruby

   node.default['foo'] = {
     'bar' => {
       'baz' => 52,
       'thing' => 'stuff',
     },
     'bat' => {
      'things' => [5, 6],
     },
   }

And some attributes:

.. code-block:: ruby

   # Please don't ever do this in real code :)
   node.role_default['foo']['bar']['baz'] = 55
   node.force_default['foo']['bar']['baz'] = 66

And other precedence levels:

.. code-block:: ruby

   node.normal['foo']['bar']['baz'] = 88
   node.override['foo']['bar']['baz'] = 99

With a full assignment:

.. code-block:: ruby

   node.default!['foo']['bar'] = {}

Role default and force default are left in default, plus other precedence levels:

.. code-block:: ruby

   node.attributes.combined_default['foo'] #=> {'bar' => {'baz' => 66}, 'bat'=>{'things'=>[5, 6]}}
   node.attributes.normal['foo'] #=> {'bar' => {'baz' => 88}}
   node.attributes.combined_override['foo'] #=> {'bar' => {'baz' => 99}}
   node['foo']['bar'] #=> {'baz' => 99}

If ``force_default!`` is written:

.. code-block:: ruby

   node.force_default!['foo']['bar'] = {}

the difference is:

.. code-block:: ruby

   node.attributes.combined_default['foo'] #=> {'bat'=>{'things'=>[5, 6]}, 'bar' => {}}
   node.attributes.normal['foo'] #=> {'bar' => {'baz' => 88}}
   node.attributes.combined_override['foo'] #=> {'bar' => {'baz' => 99}}
   node['foo']['bar'] #=> {'baz' => 99}

.. end_tag

provides Method
-----------------------------------------------------
.. tag dsl_resource_method_provides

Use the ``provides`` method to map a custom resource/provider to an existing resource/provider, and then to also specify the platform(s) on which the behavior of the custom resource/provider will be applied. This method enables scenarios like:

* Building a custom resource that is based on an existing resource
* Defining platform mapping specific to a custom resource
* Handling situations where a resource on a particular platform may have more than one provider, such as the behavior on the Ubuntu platform where both SysVInit and systemd are present
* Allowing the custom resource to declare what platforms are supported, enabling the creator of the custom resource to use arbitrary criteria if desired
* Not using the previous naming convention---``#{cookbook_name}_#{provider_filename}``

.. warning:: The ``provides`` method must be defined in both the custom resource and custom provider files and both files must have identical ``provides`` statement(s).

The syntax for the ``provides`` method is as follows:

.. code-block:: ruby

   provides :resource_name, os: [ 'platform', 'platform', ...], platform_family: 'family'

where:

* ``:resource_name`` is a chef-client resource: ``:cookbook_file``, ``:package``, ``:rpm_package``, and so on
* ``'platform'`` is a comma-separated list of platforms: ``'windows'``, ``'solaris2'``, ``'linux'``, and so on
* ``platform_family`` is optional and may specify the same parameters as the ``platform_family?`` method in the Recipe DSL; ``platform`` is optional and also supported (and is the same as the ``platform?`` method in the Recipe DSL)

A custom resource/provider may be mapped to more than one existing resource/provider. Multiple platform associations may be made. For example, to completely map a custom resource/provider to an existing custom resource/provider, only specificy the resource name:

.. code-block:: ruby

   provides :cookbook_file

The same mapping, but only for the Linux platform:

.. code-block:: ruby

   provides :cookbook_file, os: 'linux'

A similar mapping, but also for packages on the Microsoft Windows platform:

.. code-block:: ruby

   provides :cookbook_file
   provides :package, os: 'windows'

Use multiple ``provides`` statements to define multiple conditions: Use an array to match any of the platforms within the array:

.. code-block:: ruby

   provides :cookbook_file
   provides :package, os: 'windows'
   provides :rpm_package, os: [ 'linux', 'aix' ]

Use an array to match any of the platforms within the array:

.. code-block:: ruby

   provides :package, os: 'solaris2', platform_family: 'solaris2' do |node|
     node[:platform_version].to_f <= 5.10
   end

.. end_tag

AIX Platform Support
-----------------------------------------------------
.. tag ctl_chef_client_aix

The chef-client may now be used to configure nodes that are running on the AIX platform, versions 6.1 (TL6 or higher, recommended) and 7.1 (TL0 SP3 or higher, recommended). The **service** resource supports starting, stopping, and restarting services that are managed by System Resource Controller (SRC), as well as managing all service states with BSD-based init systems.

.. end_tag

**System Requirements**

.. tag ctl_chef_client_aix_requirements

The chef-client has the same system requirements on the AIX platform as any other platform, with the following notes:

* Expand the file system on the AIX platform using ``chfs`` or by passing the ``-X`` flag to ``installp`` to automatically expand the logical partition (LPAR)
* The EN_US (UTF-8) character set should be installed on the logical partition prior to installing the chef-client

.. end_tag

**Install the chef-client on the AIX platform**

.. tag ctl_chef_client_aix_setup

The chef-client is distributed as a Backup File Format (BFF) binary and is installed on the AIX platform using the following command run as a root user:

.. code-block:: text

   # installp -aYgd chef-12.0.0-1.powerpc.bff all

.. end_tag

**Increase system process limits**

.. tag ctl_chef_client_aix_system_process_limits

The out-of-the-box system process limits for maximum process memory size (RSS) and number of open files are typically too low to run the chef-client on a logical partition (LPAR). When the system process limits are too low, the chef-client will not be able to create threads. To increase the system process limits:

#. Validate that the system process limits have not already been increased.
#. If they have not been increased, run the following commands as a root user:

   .. code-block:: bash

      $ chsec -f /etc/security/limits -s default -a "rss=-1"

   and then:

   .. code-block:: bash

      $ chsec -f /etc/security/limits -s default -a "data=-1"

   and then:

   .. code-block:: bash

      $ chsec -f /etc/security/limits -s default -a "nofiles=50000"

   .. note:: The previous commands may be run against the root user, instead of default. For example:

      .. code-block:: bash

         $ chsec -f /etc/security/limits -s root_user -a "rss=-1"

#. Reboot the logical partition (LPAR) to apply the updated system process limits.

When the system process limits are too low, an error is returned similar to:

.. code-block:: none

   Error Syncing Cookbooks:
   ==================================================================

   Unexpected Error:
   -----------------
   ThreadError: can't create Thread: Resource temporarily unavailable

.. end_tag

**Install the UTF-8 character set**

.. tag install_chef_client_aix_en_us

The chef-client uses the EN_US (UTF-8) character set. By default, the AIX base operating system does not include the EN_US (UTF-8) character set and it must be installed prior to installing the chef-client. The EN_US (UTF-8) character set may be installed from the first disc in the AIX media or may be copied from ``/installp/ppc/*EN_US*`` to a location on the logical partition (LPAR). This topic assumes this location to be ``/tmp/rte``.

Use ``smit`` to install the EN_US (UTF-8) character set. This ensures that any workload partitions (WPARs) also have UTF-8 applied.

Remember to point ``INPUT device/directory`` to ``/tmp/rte`` when not installing from CD.

#. From a root shell type:

   .. code-block:: text

      # smit lang

   A screen similar to the following is returned:

   .. code-block:: bash

                             Manage Language Environment

      Move cursor to desired item and press Enter.

        Change/Show Primary Language Environment
        Add Additional Language Environments
        Remove Language Environments
        Change/Show Language Hierarchy
        Set User Languages
        Change/Show Applications for a Language
        Convert System Messages and Flat Files

      F1=Help             F2=Refresh          F3=Cancel           F8=Image
      F9=Shell            F10=Exit            Enter=Do

#. Select ``Add Additional Language Environments`` and press ``Enter``. A screen similar to the following is returned:

   .. code-block:: bash

                         Add Additional Language Environments

      Type or select values in entry fields.
      Press Enter AFTER making all desired changes.

                                                              [Entry Fields]
        CULTURAL convention to install                                             +
        LANGUAGE translation to install                                            +
      * INPUT device/directory for software                [/dev/cd0]              +
        EXTEND file systems if space needed?                yes                    +

        WPAR Management
            Perform Operation in Global Environment         yes                    +
            Perform Operation on Detached WPARs             no                     +
                Detached WPAR Names                        [_all_wpars]            +
            Remount Installation Device in WPARs            yes                    +
            Alternate WPAR Installation Device             []

      F1=Help             F2=Refresh          F3=Cancel           F4=List
      F5=Reset            F6=Command          F7=Edit             F8=Image
      F9=Shell            F10=Exit            Enter=Do

#. Cursor over the first two entries---``CULTURAL convention to install`` and ``LANGUAGE translation to install``---and use ``F4`` to navigate through the list until ``UTF-8 English (United States) [EN_US]`` is selected. (EN_US is in capital letters!)

#. Press ``Enter`` to apply and install the language set.

.. end_tag

**New providers**

.. tag ctl_chef_client_aix_providers

The **service** resource has the following providers to support the AIX platform:

.. list-table::
   :widths: 150 80 320
   :header-rows: 1

   * - Long name
     - Short name
     - Notes
   * - ``Chef::Provider::Service::Aix``
     - ``service``
     - The provider that is used with the AIX platforms. Use the ``service`` short name to start, stop, and restart services with System Resource Controller (SRC).
   * - ``Chef::Provider::Service::AixInit``
     - ``service``
     -  The provider that is used to manage BSD-based init services on AIX.

.. end_tag

**Enable a service on AIX using the mkitab command**

.. tag resource_service_aix_mkitab

The **service** resource does not support using the ``:enable`` and ``:disable`` actions with resources that are managed using System Resource Controller (SRC). This is because System Resource Controller (SRC) does not have a standard mechanism for enabling and disabling services on system boot.

One approach for enabling or disabling services that are managed by System Resource Controller (SRC) is to use the **execute** resource to invoke ``mkitab``, and then use that command to enable or disable the service.

The following example shows how to install a service:

.. code-block:: ruby

   execute "install #{node['chef_client']['svc_name']} in SRC" do
     command "mkssys -s #{node['chef_client']['svc_name']} 
                     -p #{node['chef_client']['bin']} 
                     -u root 
                     -S 
                     -n 15 
                     -f 9 
                     -o #{node['chef_client']['log_dir']}/client.log 
                     -e #{node['chef_client']['log_dir']}/client.log -a '
                     -i #{node['chef_client']['interval']} 
                     -s #{node['chef_client']['splay']}'"
     not_if "lssrc -s #{node['chef_client']['svc_name']}"
     action :run
   end

and then enable it using the ``mkitab`` command:

.. code-block:: ruby

   execute "enable #{node['chef_client']['svc_name']}" do
     command "mkitab '#{node['chef_client']['svc_name']}:2:once:/usr/bin/startsrc 
                     -s #{node['chef_client']['svc_name']} > /dev/console 2>&1'"
     not_if "lsitab #{node['chef_client']['svc_name']}"
   end

.. end_tag

Recipe DSL, Encrypted Data Bags
-----------------------------------------------------
The Recipe DSL provides access to data bags and data bag items (including encrypted data bag items) with the following methods:

* ``data_bag(bag)``, where ``bag`` is the name of the data bag.
* ``data_bag_item('bag_name', 'item', 'secret')``, where ``bag`` is the name of the data bag and ``item`` is the name of the data bag item. If ``'secret'`` is not specified, the chef-client will look for a secret at the path specified by the ``encrypted_data_bag_secret`` setting in the client.rb file.

The ``data_bag`` method returns an array with a key for each of the data bag items that are found in the data bag.

Some examples:

To load the secret from a file:

.. code-block:: ruby

   data_bag_item('bag', 'item', IO.read('secret_file'))

To load a single data bag item named ``justin``:

.. code-block:: ruby

   data_bag('admins')

The contents of a data bag item named ``justin``:

.. code-block:: ruby

   data_bag_item('admins', 'justin')

will return something similar to:

.. code-block:: ruby

   # => {'comment'=>'Justin Currie', 'gid'=>1005, 'id'=>'justin', 'uid'=>1005, 'shell'=>'/bin/zsh'}

If ``item`` is encrypted, ``data_bag_item`` will automatically decrypt it using the key specified above, or (if none is specified) by the ``Chef::Config[:encrypted_data_bag_secret]`` method, which defaults to ``/etc/chef/encrypted_data_bag_secret``.

bff_package
-----------------------------------------------------
.. tag resource_package_bff

Use the **bff_package** resource to manage packages for the AIX platform using the installp utility. When a package is installed from a local file, it must be added to the node using the **remote_file** or **cookbook_file** resources.

.. note:: A Backup File Format (BFF) package may not have a ``.bff`` file extension. The chef-client will still identify the correct provider to use based on the platform, regardless of the file extension.

.. end_tag

Syntax
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. tag resource_package_bff_syntax

A **bff_package** resource block manages a package on a node, typically by installing it. The simplest use of the **bff_package** resource is:

.. code-block:: ruby

   bff_package 'package_name'

which will install the named package using all of the default options and the default action (``:install``).

The full syntax for all of the properties that are available to the **bff_package** resource is:

.. code-block:: ruby

   bff_package 'name' do
     notifies                   # see description
     options                    String
     package_name               String, Array # defaults to 'name' if not specified
     provider                   Chef::Provider::Package::Aix
     source                     String
     subscribes                 # see description
     timeout                    String, Integer
     version                    String, Array
     action                     Symbol # defaults to :install if not specified
   end

where

* ``bff_package`` tells the chef-client to manage a package
* ``'name'`` is the name of the package
* ``:action`` identifies which steps the chef-client will take to bring the node into the desired state
* ``options``, ``package_name``, ``provider``, ``source``, ``timeout``, and ``version`` are properties of this resource, with the Ruby type shown. See "Properties" section below for more information about all of the properties that may be used with this resource.

.. end_tag

Actions
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. tag resource_package_bff_actions

This resource has the following actions:

``:install``
   Default. Install a package. If a version is specified, install the specified version of the package.

``:nothing``
   .. tag resources_common_actions_nothing

   Define this resource block to do nothing until notified by another resource to take action. When this resource is notified, this resource block is either run immediately or it is queued up to be run at the end of the chef-client run.

   .. end_tag

``:purge``
   Purge a package. This action typically removes the configuration files as well as the package.

``:remove``
   Remove a package.

.. end_tag

Properties
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. tag 5_27

This resource has the following properties:

``ignore_failure``
   **Ruby Types:** TrueClass, FalseClass

   Continue running a recipe if a resource fails for any reason. Default value: ``false``.

``notifies``
   **Ruby Type:** Symbol, 'Chef::Resource[String]'

   .. tag resources_common_notification_notifies

   A resource may notify another resource to take action when its state changes. Specify a ``'resource[name]'``, the ``:action`` that resource should take, and then the ``:timer`` for that action. A resource may notifiy more than one resource; use a ``notifies`` statement for each resource to be notified.

   .. end_tag

   .. tag 5_3

   A timer specifies the point during the chef-client run at which a notification is run. The following timers are available:

   ``:delayed``
      Default. Specifies that a notification should be queued up, and then executed at the very end of the chef-client run.

   ``:immediate``, ``:immediately``
      Specifies that a notification should be run immediately, per resource notified.

   .. end_tag

   .. tag resources_common_notification_notifies_syntax

   The syntax for ``notifies`` is:

   .. code-block:: ruby

      notifies :action, 'resource[name]', :timer

   .. end_tag

``options``
   **Ruby Type:** String

   One (or more) additional options that are passed to the command.

``package_name``
   **Ruby Types:** String, Array

   The name of the package. Default value: the ``name`` of the resource block See "Syntax" section above for more information.

``provider``
   **Ruby Type:** Chef Class

   Optional. Explicitly specifies a provider. See "Providers" section below for more information.

``retries``
   **Ruby Type:** Integer

   The number of times to catch exceptions and retry the resource. Default value: ``0``.

``retry_delay``
   **Ruby Type:** Integer

   The retry delay (in seconds). Default value: ``2``.

``source``
   **Ruby Type:** String

   Required. The path to a package in the local file system. The AIX platform requires ``source`` to be a local file system path because ``installp`` does not retrieve packages using HTTP or FTP.

``subscribes``
   **Ruby Type:** Symbol, 'Chef::Resource[String]'

   .. tag resources_common_notification_subscribes

   A resource may listen to another resource, and then take action if the state of the resource being listened to changes. Specify a ``'resource[name]'``, the ``:action`` to be taken, and then the ``:timer`` for that action.

   .. end_tag

   .. tag 5_3

   A timer specifies the point during the chef-client run at which a notification is run. The following timers are available:

   ``:delayed``
      Default. Specifies that a notification should be queued up, and then executed at the very end of the chef-client run.

   ``:immediate``, ``:immediately``
      Specifies that a notification should be run immediately, per resource notified.

   .. end_tag

   .. tag resources_common_notification_subscribes_syntax

   The syntax for ``subscribes`` is:

   .. code-block:: ruby

      subscribes :action, 'resource[name]', :timer

   .. end_tag

``timeout``
   **Ruby Types:** String, Integer

   The amount of time (in seconds) to wait before timing out.

``version``
   **Ruby Types:** String, Array

   The version of a package to be installed or upgraded.

.. end_tag

Providers
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. tag resource_package_bff_providers

This resource has the following providers:

``Chef::Provider::Package``, ``package``
   When this short name is used, the chef-client will attempt to determine the correct provider during the chef-client run.

``Chef::Provider::Package::Aix``, ``bff_package``
   The provider for the AIX platform. Can be used with the ``options`` attribute.

.. end_tag

Example
+++++++++++++++++++++++++++++++++++++++++++++++++++++

**Install a package**

.. tag resource_bff_package_install

.. To install a package:

The **bff_package** resource is the default package provider on the AIX platform. The base **package** resource may be used, and then when the platform is AIX, the chef-client will identify the correct package provider. The following examples show how to install part of the IBM XL C/C++ compiler.

Using the base **package** resource:

.. code-block:: ruby

   package 'xlccmp.13.1.0' do
     source '/var/tmp/IBM_XL_C_13.1.0/usr/sys/inst.images/xlccmp.13.1.0'
     action :install
   end

Using the **bff_package** resource:

.. code-block:: ruby

   bff_package 'xlccmp.13.1.0' do
     source '/var/tmp/IBM_XL_C_13.1.0/usr/sys/inst.images/xlccmp.13.1.0'
     action :install
   end

.. end_tag

homebrew_package
-----------------------------------------------------
.. tag resource_package_homebrew

Use the **homebrew_package** resource to manage packages for the Mac OS X platform.

.. end_tag

Syntax
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. tag resource_package_homebrew_syntax

A **homebrew_package** resource block manages a package on a node, typically by installing it. The simplest use of the **homebrew_package** resource is:

.. code-block:: ruby

   homebrew_package 'package_name'

which will install the named package using all of the default options and the default action (``:install``).

The full syntax for all of the properties that are available to the **homebrew_package** resource is:

.. code-block:: ruby

   homebrew_package 'name' do
     homebrew_user              String, Integer
     notifies                   # see description
     options                    String
     package_name               String, Array # defaults to 'name' if not specified
     provider                   Chef::Provider::Package::Homebrew
     source                     String
     subscribes                 # see description
     timeout                    String, Integer
     version                    String, Array
     action                     Symbol # defaults to :install if not specified
   end

where

* ``homebrew_package`` tells the chef-client to manage a package
* ``'name'`` is the name of the package
* ``:action`` identifies which steps the chef-client will take to bring the node into the desired state
* ``homebrew_user``, ``options``, ``package_name``, ``provider``, ``source``, ``timeout``, and ``version`` are properties of this resource, with the Ruby type shown. See "Properties" section below for more information about all of the properties that may be used with this resource.

.. end_tag

Actions
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. tag resource_package_homebrew_actions

This resource has the following actions:

``:install``
   Default. Install a package. If a version is specified, install the specified version of the package.

``:nothing``
   .. tag resources_common_actions_nothing

   Define this resource block to do nothing until notified by another resource to take action. When this resource is notified, this resource block is either run immediately or it is queued up to be run at the end of the chef-client run.

   .. end_tag

``:purge``
   Purge a package. This action typically removes the configuration files as well as the package.

``:remove``
   Remove a package.

``:upgrade``
   Install a package and/or ensure that a package is the latest version.

.. end_tag

Properties
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. tag 5_34

This resource has the following properties:

``homebrew_user``
   **Ruby Types:** String, Integer

   The name of the Homebrew owner to be used by the chef-client when executing a command.

   .. tag resource_package_homebrew_user

   The chef-client, by default, will attempt to execute a Homebrew command as the owner of ``/usr/local/bin/brew``. If that executable does not exist, the chef-client will attempt to find the user by executing ``which brew``. If that executable cannot be found, the chef-client will print an error message: ``Could not find the "brew" executable in /usr/local/bin or anywhere on the path.``. Use the ``homebrew_user`` attribute to specify the Homebrew owner for situations where the chef-client cannot automatically detect the correct owner.

   .. end_tag

``ignore_failure``
   **Ruby Types:** TrueClass, FalseClass

   Continue running a recipe if a resource fails for any reason. Default value: ``false``.

``notifies``
   **Ruby Type:** Symbol, 'Chef::Resource[String]'

   .. tag resources_common_notification_notifies

   A resource may notify another resource to take action when its state changes. Specify a ``'resource[name]'``, the ``:action`` that resource should take, and then the ``:timer`` for that action. A resource may notifiy more than one resource; use a ``notifies`` statement for each resource to be notified.

   .. end_tag

   .. tag 5_3

   A timer specifies the point during the chef-client run at which a notification is run. The following timers are available:

   ``:delayed``
      Default. Specifies that a notification should be queued up, and then executed at the very end of the chef-client run.

   ``:immediate``, ``:immediately``
      Specifies that a notification should be run immediately, per resource notified.

   .. end_tag

   .. tag resources_common_notification_notifies_syntax

   The syntax for ``notifies`` is:

   .. code-block:: ruby

      notifies :action, 'resource[name]', :timer

   .. end_tag

``options``
   **Ruby Type:** String

   One (or more) additional options that are passed to the command.

``package_name``
   **Ruby Types:** String, Array

   The name of the package. Default value: the ``name`` of the resource block See "Syntax" section above for more information.

``provider``
   **Ruby Type:** Chef Class

   Optional. Explicitly specifies a provider. See "Providers" section below for more information.

``retries``
   **Ruby Type:** Integer

   The number of times to catch exceptions and retry the resource. Default value: ``0``.

``retry_delay``
   **Ruby Type:** Integer

   The retry delay (in seconds). Default value: ``2``.

``source``
   **Ruby Type:** String

   Optional. The path to a package in the local file system.

``subscribes``
   **Ruby Type:** Symbol, 'Chef::Resource[String]'

   .. tag resources_common_notification_subscribes

   A resource may listen to another resource, and then take action if the state of the resource being listened to changes. Specify a ``'resource[name]'``, the ``:action`` to be taken, and then the ``:timer`` for that action.

   .. end_tag

   .. tag 5_3

   A timer specifies the point during the chef-client run at which a notification is run. The following timers are available:

   ``:delayed``
      Default. Specifies that a notification should be queued up, and then executed at the very end of the chef-client run.

   ``:immediate``, ``:immediately``
      Specifies that a notification should be run immediately, per resource notified.

   .. end_tag

   .. tag resources_common_notification_subscribes_syntax

   The syntax for ``subscribes`` is:

   .. code-block:: ruby

      subscribes :action, 'resource[name]', :timer

   .. end_tag

``timeout``
   **Ruby Types:** String, Integer

   The amount of time (in seconds) to wait before timing out.

``version``
   **Ruby Types:** String, Array

   The version of a package to be installed or upgraded.

.. end_tag

Providers
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. tag resource_package_homebrew_providers

This resource has the following providers:

``Chef::Provider::Package``, ``package``
   When this short name is used, the chef-client will attempt to determine the correct provider during the chef-client run.

``Chef::Provider::Package::Homebrew``, ``homebrew_package``
   The provider for the Mac OS X platform.

.. end_tag

Example
+++++++++++++++++++++++++++++++++++++++++++++++++++++

**Install a package**

.. tag resource_homebrew_package_install

.. To install a package:

.. code-block:: ruby

   homebrew_package 'name of package' do
     action :install
   end

.. end_tag

**Specify the Homebrew user with a UUID**

.. tag resource_homebrew_package_homebrew_user_as_uuid

.. To specify the Homebrew user as a UUID:

.. code-block:: ruby

   homebrew_package 'emacs' do
     homebrew_user 1001
   end

.. end_tag

**Specify the Homebrew user with a string**

.. tag resource_homebrew_package_homebrew_user_as_string

.. To specify the Homebrew user as a string:

.. code-block:: ruby

   homebrew_package 'vim' do
     homebrew_user 'user1'
   end

.. end_tag

reboot
-----------------------------------------------------
.. tag resource_service_reboot

Use the **reboot** resource to reboot a node, a necessary step with some installations on certain platforms. This resource is supported for use on the Microsoft Windows, Mac OS X, and Linux platforms.

.. end_tag

Syntax
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. tag resource_service_reboot_syntax

A **reboot** resource block reboots a node:

.. code-block:: ruby

   reboot 'app_requires_reboot' do
     action :request_reboot
     reason 'Need to reboot when the run completes successfully.'
     delay_mins 5
   end

The full syntax for all of the properties that are available to the **reboot** resource is:

.. code-block:: ruby

   reboot 'name' do
     delay_mins                 Fixnum
     notifies                   # see description
     reason                     String
     subscribes                 # see description
     action                     Symbol
   end

where

* ``reboot`` is the resource
* ``name`` is the name of the resource block
* ``:action`` identifies the steps the chef-client will take to bring the node into the desired state
* ``delay_mins`` and ``reason`` are properties of this resource, with the Ruby type shown. See "Properties" section below for more information about all of the properties that may be used with this resource.

.. end_tag

Actions
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. tag resource_service_reboot_actions

This resource has the following actions:

``:cancel``
   Cancel a reboot request.

``:nothing``
   .. tag resources_common_actions_nothing

   Define this resource block to do nothing until notified by another resource to take action. When this resource is notified, this resource block is either run immediately or it is queued up to be run at the end of the chef-client run.

   .. end_tag

``:reboot_now``
   Reboot a node so that the chef-client may continue the installation process.

``:request_reboot``
   Reboot a node at the end of a chef-client run.

.. end_tag

Properties
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. tag 5_62

This resource has the following properties:

``delay_mins``
   **Ruby Type:** Fixnum

   The amount of time (in minutes) to delay a reboot request.

``ignore_failure``
   **Ruby Types:** TrueClass, FalseClass

   Continue running a recipe if a resource fails for any reason. Default value: ``false``.

``notifies``
   **Ruby Type:** Symbol, 'Chef::Resource[String]'

   .. tag resources_common_notification_notifies

   A resource may notify another resource to take action when its state changes. Specify a ``'resource[name]'``, the ``:action`` that resource should take, and then the ``:timer`` for that action. A resource may notifiy more than one resource; use a ``notifies`` statement for each resource to be notified.

   .. end_tag

   .. tag resources_common_notification_timers_reboot

   A timer specifies the point during the chef-client run at which a notification is run. The following timer is available:

   ``:immediate``, ``:immediately``
      Specifies that a notification should be run immediately, per resource notified.

   .. end_tag

``reason``
   **Ruby Type:** String

   A string that describes the reboot action.

``retries``
   **Ruby Type:** Integer

   The number of times to catch exceptions and retry the resource. Default value: ``0``.

``retry_delay``
   **Ruby Type:** Integer

   The retry delay (in seconds). Default value: ``2``.

``subscribes``
   **Ruby Type:** Symbol, 'Chef::Resource[String]'

   .. tag resources_common_notification_subscribes

   A resource may listen to another resource, and then take action if the state of the resource being listened to changes. Specify a ``'resource[name]'``, the ``:action`` to be taken, and then the ``:timer`` for that action.

   .. end_tag

   .. tag resources_common_notification_timers_reboot

   A timer specifies the point during the chef-client run at which a notification is run. The following timer is available:

   ``:immediate``, ``:immediately``
      Specifies that a notification should be run immediately, per resource notified.

   .. end_tag

.. end_tag

Providers
+++++++++++++++++++++++++++++++++++++++++++++++++++++
This resource has the following providers:

``Chef::Provider::Reboot``, ``reboot``
   The provider that is used to reboot a node.

Example
+++++++++++++++++++++++++++++++++++++++++++++++++++++

**Reboot a node immediately**

.. tag resource_service_reboot_immediately

.. To reboot immediately:

.. code-block:: ruby

   reboot 'now' do
     action :nothing
     reason 'Cannot continue Chef run without a reboot.'
     delay_mins 2
   end

   execute 'foo' do
     command '...'
     notifies :reboot_now, 'reboot[now]', :immediately
   end

.. end_tag

**Reboot a node at the end of a chef-client run**

.. tag resource_service_reboot_request

.. To reboot a node at the end of the chef-client run:

.. code-block:: ruby

   reboot 'app_requires_reboot' do
     action :request_reboot
     reason 'Need to reboot when the run completes successfully.'
     delay_mins 5
   end

.. end_tag

**Cancel a reboot**

.. tag resource_service_reboot_cancel

.. To cancel a reboot request:

.. code-block:: ruby

   reboot 'cancel_reboot_request' do
     action :cancel
     reason 'Cancel a previous end-of-run reboot request.'
   end

.. end_tag

windows_service
-----------------------------------------------------
.. tag resource_service_windows

Use the **windows_service** resource to manage a service on the Microsoft Windows platform.

.. end_tag

Syntax
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. tag resource_service_windows_syntax

A **windows_service** resource block manages the state of a service on a machine that is running Microsoft Windows. For example:

.. code-block:: ruby

   windows_service 'BITS' do
     action :configure_startup
     startup_type :manual
   end

The full syntax for all of the properties that are available to the **windows_service** resource is:

.. code-block:: ruby

   windows_service 'name' do
     init_command               String
     notifies                   # see description
     pattern                    String
     provider                   Chef::Provider::Service::Windows
     reload_command             String
     restart_command            String
     run_as_password            String
     run_as_user                String
     service_name               String # defaults to 'name' if not specified
     start_command              String
     startup_type               Symbol
     status_command             String
     stop_command               String
     subscribes                 # see description
     supports                   Hash
     timeout                    Integer
     action                     Symbol # defaults to :nothing if not specified
   end

where

* ``windows_service`` is the resource
* ``name`` is the name of the resource block
* ``:action`` identifies the steps the chef-client will take to bring the node into the desired state
* ``init_command``, ``pattern``, ``provider``, ``reload_command``, ``restart_command``, ``run_as_password``, ``run_as_user``, ``service_name``, ``start_command``, ``startup_type``, ``status_command``, ``stop_command``, ``supports``, and ``timeout`` are properties of this resource, with the Ruby type shown. See "Properties" section below for more information about all of the properties that may be used with this resource.

.. end_tag

Actions
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. tag resource_service_windows_actions

This resource has the following actions:

``:configure_startup``
   Configure a service based on the value of the ``startup_type`` property.

``:disable``
   Disable a service. This action is equivalent to a ``Disabled`` startup type on the Microsoft Windows platform.

``:enable``
   Enable a service at boot. This action is equivalent to an ``Automatic`` startup type on the Microsoft Windows platform.

``:nothing``
   Default. Do nothing with a service.

``:reload``
   Reload the configuration for this service.

``:restart``
   Restart a service.

``:start``
   Start a service, and keep it running until stopped or disabled.

``:stop``
   Stop a service.

.. end_tag

Properties
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. tag 5_63

This resource has the following properties:

``ignore_failure``
   **Ruby Types:** TrueClass, FalseClass

   Continue running a recipe if a resource fails for any reason. Default value: ``false``.

``init_command``
   **Ruby Type:** String

   The path to the init script that is associated with the service. This is typically ``/etc/init.d/SERVICE_NAME``. The ``init_command`` property can be used to prevent the need to specify  overrides for the ``start_command``, ``stop_command``, and ``restart_command`` attributes. Default value: ``nil``.

``notifies``
   **Ruby Type:** Symbol, 'Chef::Resource[String]'

   .. tag resources_common_notification_notifies

   A resource may notify another resource to take action when its state changes. Specify a ``'resource[name]'``, the ``:action`` that resource should take, and then the ``:timer`` for that action. A resource may notifiy more than one resource; use a ``notifies`` statement for each resource to be notified.

   .. end_tag

   .. tag 5_3

   A timer specifies the point during the chef-client run at which a notification is run. The following timers are available:

   ``:delayed``
      Default. Specifies that a notification should be queued up, and then executed at the very end of the chef-client run.

   ``:immediate``, ``:immediately``
      Specifies that a notification should be run immediately, per resource notified.

   .. end_tag

   .. tag resources_common_notification_notifies_syntax

   The syntax for ``notifies`` is:

   .. code-block:: ruby

      notifies :action, 'resource[name]', :timer

   .. end_tag

``pattern``
   **Ruby Type:** String

   The pattern to look for in the process table. Default value: ``service_name``.

``provider``
   **Ruby Type:** Chef Class

   Optional. Explicitly specifies a provider.

``reload_command``
   **Ruby Type:** String

   The command used to tell a service to reload its configuration.

``restart_command``
   **Ruby Type:** String

   The command used to restart a service.

``retries``
   **Ruby Type:** Integer

   The number of times to catch exceptions and retry the resource. Default value: ``0``.

``retry_delay``
   **Ruby Type:** Integer

   The retry delay (in seconds). Default value: ``2``.

``run_as_password``
   **Ruby Type:** String

   The password for the user specified by ``run_as_user``.

``run_as_user``
   **Ruby Type:** String

   The user under which a Microsoft Windows service runs.

``service_name``
   **Ruby Type:** String

   The name of the service. Default value: the ``name`` of the resource block See "Syntax" section above for more information.

``start_command``
   **Ruby Type:** String

   The command used to start a service.

``startup_type``
   **Ruby Type:** Symbol

   Use to specify the startup type for a Microsoft Windows service. Possible values: ``:automatic``, ``:disabled``, or ``:manual``. Default value: ``:automatic``.

``status_command``
   **Ruby Type:** String

   The command used to check the run status for a service.

``stop_command``
   **Ruby Type:** String

   The command used to stop a service.

``subscribes``
   **Ruby Type:** Symbol, 'Chef::Resource[String]'

   .. tag resources_common_notification_subscribes

   A resource may listen to another resource, and then take action if the state of the resource being listened to changes. Specify a ``'resource[name]'``, the ``:action`` to be taken, and then the ``:timer`` for that action.

   .. end_tag

   .. tag 5_3

   A timer specifies the point during the chef-client run at which a notification is run. The following timers are available:

   ``:delayed``
      Default. Specifies that a notification should be queued up, and then executed at the very end of the chef-client run.

   ``:immediate``, ``:immediately``
      Specifies that a notification should be run immediately, per resource notified.

   .. end_tag

   .. tag resources_common_notification_subscribes_syntax

   The syntax for ``subscribes`` is:

   .. code-block:: ruby

      subscribes :action, 'resource[name]', :timer

   .. end_tag

``supports``
   **Ruby Type:** Hash

   A list of properties that controls how the chef-client is to attempt to manage a service: ``:restart``, ``:reload``, ``:status``. For ``:restart``, the init script or other service provider can use a restart command; if ``:restart`` is not specified, the chef-client attempts to stop and then start a service. For ``:reload``, the init script or other service provider can use a reload command. For ``:status``, the init script or other service provider can use a status command to determine if the service is running; if ``:status`` is not specified, the chef-client attempts to match the ``service_name`` against the process table as a regular expression, unless a pattern is specified as a parameter property. Default value: ``{ :restart => false, :reload => false, :status => false }`` for all platforms (except for the Red Hat platform family, which defaults to ``{ :restart => false, :reload => false, :status => true }``.)

``timeout``
   **Ruby Type:** Integer

   The amount of time (in seconds) to wait before timing out. Default value: ``60``.

.. end_tag

Providers
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. tag resource_service_windows_providers

The **windows_service** resource does not have service-specific short names. This is because the chef-client identifies the platform at the start of every chef-client run based on data collected by Ohai. The chef-client looks up the platform, and then determines the correct provider for that platform. In certain situations, such as when more than one init system is available on a node, a specific provider may need to be identified by using the ``provider`` attribute and the long name for that provider.

This resource has the following providers:

``Chef::Provider::Service::Windows``, ``windows_service``
   The provider that is used with the Microsoft Windows platform.

.. end_tag

Example
+++++++++++++++++++++++++++++++++++++++++++++++++++++

**Start a service manually**

.. tag resource_service_windows_manual_start

.. To install a package:

.. code-block:: ruby

   windows_service 'BITS' do
     action :configure_startup
     startup_type :manual
   end

.. end_tag

knife bootstrap Settings
-----------------------------------------------------
The following options are new:

``--[no-]node-verify-api-cert``
   Verify the SSL certificate on the Chef server. When ``true``, the chef-client always verifies the SSL certificate. When ``false``, the chef-client uses the value of ``ssl_verify_mode`` to determine if the SSL certificate requires verification. If this option is not specified, the setting for ``verify_api_cert`` in the configuration file is applied.

``--node-ssl-verify-mode PEER_OR_NONE``
   Set the verify mode for HTTPS requests.

   Use ``none`` to do no validation of SSL certificates.

   Use ``peer`` to do validation of all SSL certificates, including the Chef server connections, S3 connections, and any HTTPS **remote_file** resource URLs used in the chef-client run. This is the recommended setting.

``-t TEMPLATE``, ``--bootstrap-template TEMPLATE``
   The bootstrap template to use. This may be the name of a bootstrap template---``chef-full``, for example---or it may be the full path to an Embedded Ruby (ERB) template that defines a custom bootstrap. Default value: ``chef-full``, which installs the chef-client using the omnibus installer on all supported platforms.

   .. note:: The ``--distro`` and ``--template-file`` options are deprecated.

knife status Settings
-----------------------------------------------------
The following options are new:

``-l``, ``--long``
   Display all attributes in the output and show the output as JSON.

``-m``, ``--medium``
   Display normal attributes in the output and to show the output as JSON.

fsck_device Property
-----------------------------------------------------
The following property is new for the **mount** resource:

.. list-table::
   :widths: 150 450
   :header-rows: 1

   * - Property
     - Description
   * - ``fsck_device``
     - The fsck device on the Solaris platform. Default value: ``-``.

metadata.rb Settings
-----------------------------------------------------
The following settings are new:

.. list-table::
   :widths: 200 300
   :header-rows: 1

   * - Setting
     - Description
   * - ``issues_url``
     - The URL for the location in which a cookbook's issue tracking is maintained. This setting is also used by Chef Supermarket. For example:

       .. code-block:: ruby

          source_url "https://github.com/chef-cookbooks/chef-client/issues"

   * - ``source_url``
     - The URL for the location in which a cookbook's source code is maintained. This setting is also used by Chef Supermarket. For example:

       .. code-block:: ruby

          source_url "https://github.com/chef-cookbooks/chef-client"

.. warning:: The ``name`` attribute is now a required setting in the metadata.rb file.

http_request Actions
-----------------------------------------------------
The ``:get`` and ``:head`` actions appended a hard-coded query string---``?message=resource_name``---that cannot be overridden. This hard-coded string is deprecated in the chef-client 12.0 release. Cookbooks that rely on this string need to be updated to manually add it to the URL as it is passed to the resource.

Recipe DSL
-----------------------------------------------------
The following methods have been added to the Recipe DSL: ``shell_out``, ``shell_out!``, and ``shell_out_with_systems_locale``.

shell_out
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. tag dsl_recipe_method_shell_out

The ``shell_out`` method can be used to run a command against the node, and then display the output to the console when the log level is set to ``debug``.

The syntax for the ``shell_out`` method is as follows:

.. code-block:: ruby

   shell_out(command_args)

where ``command_args`` is the command that is run against the node.

.. end_tag

shell_out!
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. tag dsl_recipe_method_shell_out_bang

The ``shell_out!`` method can be used to run a command against the node, display the output to the console when the log level is set to ``debug``, and then raise an error when the method returns ``false``.

The syntax for the ``shell_out!`` method is as follows:

.. code-block:: ruby

   shell_out!(command_args)

where ``command_args`` is the command that is run against the node. This method will return ``true`` or ``false``.

.. end_tag

shell_out_with_systems_locale
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. tag dsl_recipe_method_shell_out_with_systems_locale

The ``shell_out_with_systems_locale`` method can be used to run a command against the node (via the ``shell_out`` method), but using the ``LC_ALL`` environment variable.

The syntax for the ``shell_out_with_systems_locale`` method is as follows:

.. code-block:: ruby

   shell_out_with_systems_locale(command_args)

where ``command_args`` is the command that is run against the node.

.. end_tag

value_for_platform
+++++++++++++++++++++++++++++++++++++++++++++++++++++
The ``value_for_platform`` helper may use version constraints, such as ``>=`` and ``~>`` to help resolve situations where version numbers look like ``7.0.<buildnumber>``. For example:

.. code-block:: ruby

   value_for_platform(
     "redhat" => {
       "~> 7.0" => "version 7.x.y"
       ">= 8.0" => "version 8.0.0 and greater"
     }
   }

.. note:: When two version constraints match it is considered ambiguous and will raise an exception. An exact match, however, will always take precedence over a version constraint.

File Specificity
-----------------------------------------------------
The pattern for file specificity depends on two things: the lookup path and the source attribute. The first pattern that matches is used:

#. /host-$fqdn/$source
#. /$platform-$platform_version/$source
#. /$platform/$source
#. /default/$source
#. /$source

Use an array with the ``source`` attribute to define an explicit lookup path. For example:

.. code-block:: ruby

   file '/conf.py' do
     source ["#{node.chef_environment}.py", 'conf.py']
   end

or:

.. code-block:: ruby

   template '/test' do
     source ["#{node.chef_environment}.erb", 'default.erb']
   end

Mac OS X, Passwords
-----------------------------------------------------
The following properties are new for the **user** resource:

.. list-table::
   :widths: 150 450
   :header-rows: 1

   * - Property
     - Description
   * - ``iterations``
     - The number of iterations for a password with a SALTED-SHA512-PBKDF2 shadow hash.
   * - ``salt``
     - The salt value for a password shadow hash. Mac OS X version 10.7 uses SALTED-SHA512 and version 10.8 (and higher) uses SALTED-SHA512-PBKDF2 to calculate password shadow hashes.

**Use SALTED-SHA512 passwords**

.. tag resource_user_password_shadow_hash_salted_sha512

Mac OS X 10.7 calculates the password shadow hash using SALTED-SHA512. The length of the shadow hash value is 68 bytes, the salt value is the first 4 bytes, with the remaining 64 being the shadow hash itself. The following code will calculate password shadow hashes for Mac OS X 10.7:

.. code-block:: ruby

   password = 'my_awesome_password'
   salt = OpenSSL::Random.random_bytes(4)
   encoded_password = OpenSSL::Digest::SHA512.hexdigest(salt + password)
   shadow_hash = salt.unpack('H*').first + encoded_password

Use the calculated password shadow hash with the **user** resource:

.. code-block:: ruby

   user 'my_awesome_user' do
     password 'c9b3bd....d843'  # Length: 136
   end

.. end_tag

**Use SALTED-SHA512-PBKDF2 passwords**

.. tag resource_user_password_shadow_hash_salted_sha512_pbkdf2

Mac OS X 10.8 (and higher) calculates the password shadow hash using SALTED-SHA512-PBKDF2. The length of the shadow hash value is 128 bytes, the salt value is 32 bytes, and an integer specifies the number of iterations. The following code will calculate password shadow hashes for Mac OS X 10.8 (and higher):

.. code-block:: ruby

   password = 'my_awesome_password'
   salt = OpenSSL::Random.random_bytes(32)
   iterations = 25000 # Any value above 20k should be fine.

   shadow_hash = OpenSSL::PKCS5::pbkdf2_hmac(
     password,
     salt,
     iterations,
     128,
     OpenSSL::Digest::SHA512.new
   ).unpack('H*').first
   salt_value = salt.unpack('H*').first

Use the calculated password shadow hash with the **user** resource:

.. code-block:: ruby

   user 'my_awesome_user' do
     password 'cbd1a....fc843'  # Length: 256
     salt 'bd1a....fc83'        # Length: 64
     iterations 25000
   end

.. end_tag

chef-client Options
-----------------------------------------------------
The following options are updated for the chef-client executable:

``--chef-zero-port PORT``
   The port on which chef-zero listens. If a port is not specified---individually or as range of ports from within the command---the chef-client will scan for ports between 8889-9999 and will pick the first port that is available. This port or port range may also be specified using the ``chef_zero.port`` setting in the client.rb file.

``-o RUN_LIST_ITEM``, ``--override-runlist RUN_LIST_ITEM``
   Replace the current run-list with the specified items. This option will not clear the list of cookbooks (and related files) that is cached on the node.

The following configuration settings are updated for the client.rb file and now default to ``true``:

.. list-table::
   :widths: 200 300
   :header-rows: 1

   * - Setting
     - Description
   * - ``disable_event_logger``
     - Enable or disable sending events to the Microsoft Windows "Application" event log. When ``false``, events are sent to the Microsoft Windows "Application" event log at the start and end of a chef-client run, and also if a chef-client run fails. Set to ``true`` to disable event logging. Default value: ``true``.
   * - ``no_lazy_load``
     - Download all cookbook files and templates at the beginning of the chef-client run. Default value: ``true``.
   * - ``file_staging_uses_destdir``
     - How file staging (via temporary files) is done. When ``true``, temporary files are created in the directory in which files will reside. When ``false``, temporary files are created under ``ENV['TMP']``. Default value: ``true``.
   * - ``local_key_generation``
     - Use to specify whether the Chef server or chef-client will generate the private/public key pair. When ``true``, the chef-client will generate the key pair, and then send the public key to the Chef server. Default value: ``true``.

Filter Search Results
-----------------------------------------------------
.. tag dsl_recipe_method_search_filter_result

Use ``:filter_result`` as part of a search query to filter the search output based on the pattern specified by a Hash. Only attributes in the Hash will be returned.

.. note:: .. tag notes_filter_search_vs_partial_search

          Prior to chef-client 12.0, this functionality was available from the ``partial_search`` cookbook and was referred to as "partial search".

          .. end_tag

The syntax for the ``search`` method that uses ``:filter_result`` is as follows:

.. code-block:: ruby

   search(:index, 'query',
     :filter_result => { 'foo' => [ 'abc' ],
                         'bar' => [ '123' ],
                         'baz' => [ 'sea', 'power' ]
                       }
         ).each do |result|
     puts result['foo']
     puts result['bar']
     puts result['baz']
   end

where:

* ``:index`` is of name of the index on the Chef server against which the search query will run: ``:client``, ``:data_bag_name``, ``:environment``, ``:node``, and ``:role``
* ``'query'`` is a valid search query against an object on the Chef server
* ``:filter_result`` defines a Hash of values to be returned

For example:

.. code-block:: ruby

   search(:node, 'role:web',
     :filter_result => { 'name' => [ 'name' ],
                         'ip' => [ 'ipaddress' ],
                         'kernel_version' => [ 'kernel', 'version' ]
                       }
         ).each do |result|
     puts result['name']
     puts result['ip']
     puts result['kernel_version']
   end

.. end_tag

knife search
+++++++++++++++++++++++++++++++++++++++++++++++++++++
The ``knife search`` subcommand allows filtering search results with a new option:

``-f FILTER``, ``--filter-result FILTER``
   Use to return only attributes that match the specified ``FILTER``. For example: ``\"ServerName=name, Kernel=kernel.version\"``.

**execute** Resource, ``path`` Property
-----------------------------------------------------
.. tag resources_common_resource_execute_attribute_path

The ``path`` property is not implemented by any provider in any version of the chef-client. Starting with chef-client 12, using the ``path`` property will return a warning. Starting with chef-client 13, the ``path`` property is deprecated and using it will return an exception. Cookbooks that currently use the ``path`` property should be updated to use the ``environment`` property instead.

.. end_tag

**git** Property
-----------------------------------------------------
The following property is new for the **git** resource:

.. list-table::
   :widths: 200 300
   :header-rows: 1

   * - Property
     - Description
   * - ``environment``
     - A Hash of environment variables in the form of ``({"ENV_VARIABLE" => "VALUE"})``. (These variables must exist for a command to be run successfully.)

       .. note:: The **git** provider automatically sets the ``ENV['HOME']`` and ``ENV['GIT_SSH']`` environment variables. To override this behavior and provide different values, add ``ENV['HOME']`` and/or ``ENV['GIT_SSH']`` to the ``environment`` Hash.

Chef::Provider, Custom Resources
-----------------------------------------------------
If a custom resource was created in the ``/libraries`` directory of a cookbook that also uses a core resource from the chef-client within the custom resource, the base class that is associated with that custom resource must be updated. In previous versions of the chef-client, the ``Chef::Provider`` class was all that was necessary because the Recipe DSL was included in the ``Chef::Provider`` base class.

For example, the ``lvm_logical_volume`` custom resource from the `lvm cookbook <https://github.com/chef-cookbooks/lvm/blob/master/libraries/provider_lvm_logical_volume.rb>`_ uses the **directory** and **mount** resources:

.. code-block:: ruby

   class Chef
     class Provider
       class LvmLogicalVolume < Chef::Provider
         include Chef::Mixin::ShellOut

         ...
         if new_resource.mount_point
           if new_resource.mount_point.is_a?(String)
             mount_spec = { :location => new_resource.mount_point }
           else
             mount_spec = new_resource.mount_point
           end

           dir_resource = directory mount_spec[:location] do
             mode '0755'
             owner 'root'
             group 'root'
             recursive true
             action :nothing
             not_if { Pathname.new(mount_spec[:location]).mountpoint? }
           end
           dir_resource.run_action(:create)
           updates << dir_resource.updated?

           mount_resource = mount mount_spec[:location] do
             options mount_spec[:options]
             dump mount_spec[:dump]
             pass mount_spec[:pass]
             device device_name
             fstype fs_type
             action :nothing
           end
           mount_resource.run_action(:mount)
           mount_resource.run_action(:enable)
           updates << mount_resource.updated?
         end
         new_resource.updated_by_last_action(updates.any?)
       end

Starting with chef-client 12, the Recipe DSL is removed from the ``Chef::Provider`` base class and is only available by using ``LWRPBase``. Cookbooks that contain custom resources authored for the chef-client 11 version should be inspected and updated.

.. tag dsl_provider_method_updated_by_last_action_example

Cookbooks that contain custom resources in the ``/libraries`` directory of a cookbook should:

* Be inspected for instances of a) the ``Chef::Provider`` base class, and then b) for the presence of any core resources from the chef-client
* Be updated to use the ``LWRPBase`` base class

For example:

.. code-block:: ruby

   class Chef
     class Provider
       class LvmLogicalVolume < Chef::Provider::LWRPBase
         include Chef::Mixin::ShellOut

         ...
         if new_resource.mount_point
           if new_resource.mount_point.is_a?(String)
             mount_spec = { :location => new_resource.mount_point }
           else
             mount_spec = new_resource.mount_point
           end

           dir_resource = directory mount_spec[:location] do
             mode 0755
             owner 'root'
             group 'root'
             recursive true
             action :nothing
             not_if { Pathname.new(mount_spec[:location]).mountpoint? }
           end
           dir_resource.run_action(:create)
           updates << dir_resource.updated?

           mount_resource = mount mount_spec[:location] do
             options mount_spec[:options]
             dump mount_spec[:dump]
             pass mount_spec[:pass]
             device device_name
             fstype fs_type
             action :nothing
           end
           mount_resource.run_action(:mount)
           mount_resource.run_action(:enable)
           updates << mount_resource.updated?
         end
         new_resource.updated_by_last_action(updates.any?)
       end

.. end_tag

SSL Certificates
-----------------------------------------------------
.. tag server_security_ssl_cert_client

Chef server 12 enables SSL verification by default for all requests made to the server, such as those made by knife and the chef-client. The certificate that is generated during the installation of the Chef server is self-signed, which means the certificate is not signed by a trusted certificate authority (CA) that ships with the chef-client. The certificate generated by the Chef server must be downloaded to any machine from which knife and/or the chef-client will make requests to the Chef server.

For example, without downloading the SSL certificate, the following knife command:

.. code-block:: bash

   $ knife client list

responds with an error similar to:

.. code-block:: bash

   ERROR: SSL Validation failure connecting to host: chef-server.example.com ...
   ERROR: OpenSSL::SSL::SSLError: SSL_connect returned=1 errno=0 state=SSLv3 ...

This is by design and will occur until a verifiable certificate is added to the machine from which the request is sent.

.. end_tag

See SSL Certificates for more information about how knife and the chef-client use SSL certificates generated by the Chef server.

Changelog
=====================================================
https://github.com/chef/chef/blob/12.0.3/CHANGELOG.md

.. What's Fixed
.. =====================================================
.. The following bugs were fixed:
.. 
.. * `CHEF-xxxxx <http://tickets.opscode.com/browse/CHEF-xxxxx>`_  --- xxxxx
.. * `CHEF-xxxxx <http://tickets.opscode.com/browse/CHEF-xxxxx>`_  --- xxxxx
.. 
.. What's Improved
.. =====================================================
.. The following improvements were made:
.. 
.. * `CHEF-xxxxx <http://tickets.opscode.com/browse/CHEF-xxxxx>`_  --- xxxxx
.. * `CHEF-xxxxx <http://tickets.opscode.com/browse/CHEF-xxxxx>`_  --- xxxxx
.. 
.. New Features
.. =====================================================
.. The following features were added:
.. 
.. * `CHEF-xxxxx <http://tickets.opscode.com/browse/CHEF-xxxxx>`_  --- xxxxx
.. * `CHEF-xxxxx <http://tickets.opscode.com/browse/CHEF-xxxxx>`_  --- xxxxx
