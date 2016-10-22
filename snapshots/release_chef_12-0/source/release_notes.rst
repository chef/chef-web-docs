=====================================================
Release Notes: chef-client 12.0
=====================================================

.. include:: ../../includes_chef/includes_chef.rst

Please `view the notes <https://docs.chef.io/upgrade_client_notes.html>`__ for more background on the upgrade process from chef-client 11 to chef-client 12.

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
.. include:: ../../includes_node/includes_node_attribute_change.rst

Remove Precedence Level
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_node/includes_node_attribute_change_remove_level.rst

Examples
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
.. include:: ../../includes_node/includes_node_attribute_change_remove_level_examples.rst

Remove All Levels
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_node/includes_node_attribute_change_remove_all.rst

Examples
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
.. include:: ../../includes_node/includes_node_attribute_change_remove_all_examples.rst

Full Assignment
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_node/includes_node_attribute_change_full_assignment.rst

Examples
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
.. include:: ../../includes_node/includes_node_attribute_change_full_assignment_examples.rst

provides Method
-----------------------------------------------------
.. include:: ../../includes_dsl_resource/includes_dsl_resource_method_provides.rst

AIX Platform Support
-----------------------------------------------------
.. include:: ../../includes_ctl_chef_client/includes_ctl_chef_client_aix.rst

**System Requirements**

.. include:: ../../includes_ctl_chef_client/includes_ctl_chef_client_aix_requirements.rst

**Install the chef-client on the AIX platform**

.. include:: ../../includes_ctl_chef_client/includes_ctl_chef_client_aix_setup.rst

**Increase system process limits**

.. include:: ../../includes_ctl_chef_client/includes_ctl_chef_client_aix_system_process_limits.rst

**Install the UTF-8 character set**

.. include:: ../../includes_install/includes_install_chef_client_aix_en_us.rst

**New providers**

.. include:: ../../includes_ctl_chef_client/includes_ctl_chef_client_aix_providers.rst

**Enable a service on AIX using the mkitab command**

.. include:: ../../step_resource/step_resource_service_aix_mkitab.rst

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
.. include:: ../../includes_resources/includes_resource_package_bff.rst

Syntax
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_package_bff_syntax.rst

Actions
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_package_bff_actions.rst

Properties
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_package_bff_attributes_12-5.rst

Providers
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_package_bff_providers.rst

Example
+++++++++++++++++++++++++++++++++++++++++++++++++++++

**Install a package**

.. include:: ../../step_resource/step_resource_bff_package_install.rst


homebrew_package
-----------------------------------------------------
.. include:: ../../includes_resources/includes_resource_package_homebrew.rst

Syntax
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_package_homebrew_syntax.rst

Actions
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_package_homebrew_actions.rst

Properties
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_package_homebrew_attributes_12-5.rst

Providers
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_package_homebrew_providers.rst

Example
+++++++++++++++++++++++++++++++++++++++++++++++++++++

**Install a package**

.. include:: ../../step_resource/step_resource_homebrew_package_install.rst

**Specify the Homebrew user with a UUID**

.. include:: ../../step_resource/step_resource_homebrew_package_homebrew_user_as_uuid.rst

**Specify the Homebrew user with a string**

.. include:: ../../step_resource/step_resource_homebrew_package_homebrew_user_as_string.rst


reboot
-----------------------------------------------------
.. include:: ../../includes_resources/includes_resource_service_reboot.rst

Syntax
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_service_reboot_syntax.rst

Actions
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_service_reboot_actions.rst

Properties
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_service_reboot_attributes_12-5.rst

Providers
+++++++++++++++++++++++++++++++++++++++++++++++++++++
This resource has the following providers:

``Chef::Provider::Reboot``, ``reboot``
   The provider that is used to reboot a node.

Example
+++++++++++++++++++++++++++++++++++++++++++++++++++++

**Reboot a node immediately**

.. include:: ../../step_resource/step_resource_service_reboot_immediately.rst

**Reboot a node at the end of a chef-client run**

.. include:: ../../step_resource/step_resource_service_reboot_request.rst

**Cancel a reboot**

.. include:: ../../step_resource/step_resource_service_reboot_cancel.rst


windows_service
-----------------------------------------------------
.. include:: ../../includes_resources/includes_resource_service_windows.rst

Syntax
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_service_windows_syntax.rst

Actions
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_service_windows_actions.rst

Properties
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_service_windows_attributes_12-5.rst

Providers
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_service_windows_providers.rst

Example
+++++++++++++++++++++++++++++++++++++++++++++++++++++

**Start a service manually**

.. include:: ../../step_resource/step_resource_service_windows_manual_start.rst


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
.. include:: ../../includes_dsl_recipe/includes_dsl_recipe_method_shell_out.rst

shell_out!
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_dsl_recipe/includes_dsl_recipe_method_shell_out_bang.rst

shell_out_with_systems_locale
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_dsl_recipe/includes_dsl_recipe_method_shell_out_with_systems_locale.rst

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

.. include:: ../../step_resource/step_resource_user_password_shadow_hash_salted_sha512.rst

**Use SALTED-SHA512-PBKDF2 passwords**

.. include:: ../../step_resource/step_resource_user_password_shadow_hash_salted_sha512_pbkdf2.rst


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
.. include:: ../../includes_dsl_recipe/includes_dsl_recipe_method_search_filter_result.rst

knife search
+++++++++++++++++++++++++++++++++++++++++++++++++++++
The ``knife search`` subcommand allows filtering search results with a new option:

``-f FILTER``, ``--filter-result FILTER``
   Use to return only attributes that match the specified ``FILTER``. For example: ``\"ServerName=name, Kernel=kernel.version\"``.

**execute** Resource, ``path`` Property
-----------------------------------------------------
.. include:: ../../includes_resources_common/includes_resources_common_resource_execute_attribute_path.rst

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

.. include:: ../../includes_dsl_provider/includes_dsl_provider_method_updated_by_last_action_example.rst

SSL Certificates
-----------------------------------------------------
.. include:: ../../includes_server_security/includes_server_security_ssl_cert_client.rst

See `SSL Certificates <https://docs.chef.io/chef_client_security.html#ssl-certificates>`__ for more information about how knife and the chef-client use SSL certificates generated by the Chef server.

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
