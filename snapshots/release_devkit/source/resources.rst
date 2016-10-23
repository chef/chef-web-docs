.. THIS PAGE IS IDENTICAL TO docs.chef.io/resources.html BY DESIGN
.. THIS PAGE DOCUMENTS Chef server version 12.0

=====================================================
Resources Reference
=====================================================

.. include:: ../../includes_resources_common/includes_resources_common.rst

.. include:: ../../includes_resources_common/includes_resources_common_provider.rst

.. include:: ../../includes_resources_common/includes_resources_common_provider_platform.rst

This reference describes each of the resources available to the chef-client, including a list of actions, a list of properties, (when applicable) a list of providers, and examples of using each resource.


Common Functionality
=====================================================
The properties and actions in this section apply to all resources.

Actions
-----------------------------------------------------
.. include:: ../../includes_resources_common/includes_resources_common_actions.rst

Examples
+++++++++++++++++++++++++++++++++++++++++++++++++++++
The following examples show how to use common actions in a recipe.

**Use the :nothing action**

.. include:: ../../step_resource/step_resource_service_use_nothing_action.rst

Properties
-----------------------------------------------------
.. include:: ../../includes_resources_common/includes_resources_common_attributes.rst

Provider
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources_common/includes_resources_common_provider_attributes.rst

Examples
+++++++++++++++++++++++++++++++++++++++++++++++++++++
The following examples show how to use common properties in a recipe.

**Use the ignore_failure common property**

.. include:: ../../step_resource/step_resource_package_use_ignore_failure_attribute.rst

**Use the provider common property**

.. include:: ../../step_resource/step_resource_package_use_provider_attribute.rst

**Use the supports common property**

.. include:: ../../step_resource/step_resource_service_use_supports_attribute.rst

**Use the supports and providers common properties**

.. include:: ../../step_resource/step_resource_service_use_provider_and_supports_attributes.rst

Guards
-----------------------------------------------------
.. include:: ../../includes_resources_common/includes_resources_common_guards.rst

Attributes
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources_common/includes_resources_common_guards_attributes.rst

Arguments
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources_common/includes_resources_common_guards_arguments.rst

not_if Examples
+++++++++++++++++++++++++++++++++++++++++++++++++++++
The following examples show how to use ``not_if`` as a condition in a recipe:

**Create a file, but not if an attribute has a specific value**

.. include:: ../../step_resource/step_resource_template_add_file_not_if_attribute_has_value.rst

**Create a file with a Ruby block, but not if "/etc/passwd" exists**

.. include:: ../../step_resource/step_resource_template_add_file_not_if_ruby.rst

**Create a file with Ruby block that has curly braces, but not if "/etc/passwd" exists**

.. include:: ../../step_resource/step_resource_template_add_file_not_if_ruby_with_curly_braces.rst

**Create a file using a string, but not if "/etc/passwd" exists**

.. include:: ../../step_resource/step_resource_template_add_file_not_if_string.rst

**Install a file from a remote location using bash**

.. include:: ../../step_resource/step_resource_remote_file_install_with_bash.rst

only_if Examples
+++++++++++++++++++++++++++++++++++++++++++++++++++++
The following examples show how to use ``only_if`` as a condition in a recipe:

**Create a file, but only if an attribute has a specific value**

.. include:: ../../step_resource/step_resource_template_add_file_only_if_attribute_has_value.rst

**Create a file with a Ruby block, but only if "/etc/passwd" does not exist**

.. include:: ../../step_resource/step_resource_template_add_file_only_if_ruby.rst

**Create a file using a string, but only if "/etc/passwd" exists**

.. include:: ../../step_resource/step_resource_template_add_file_only_if_string.rst

Guard Interpreters
-----------------------------------------------------
.. include:: ../../includes_resources_common/includes_resources_common_guard_interpreter.rst

Attributes
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources_common/includes_resources_common_guard_interpreter_attributes.rst

Inheritance
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources_common/includes_resources_common_guard_interpreter_attributes_inherit.rst

Examples
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources_common/includes_resources_common_guard_interpreter_example_default.rst


Lazy Evaluation
-----------------------------------------------------
.. include:: ../../includes_resources_common/includes_resources_common_lazy_evaluation.rst

Notifications
-----------------------------------------------------
.. include:: ../../includes_resources_common/includes_resources_common_notification.rst

Timers
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources_common/includes_resources_common_notification_timers.rst

Notifies
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources_common/includes_resources_common_notification_notifies.rst

.. include:: ../../includes_resources_common/includes_resources_common_notification_notifies_syntax.rst

Examples
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
The following examples show how to use the ``notifies`` notification in a recipe.

**Delay notifications**

.. include:: ../../step_resource/step_resource_template_notifies_delay.rst

**Notify immediately**

.. include:: ../../step_resource/step_resource_template_notifies_run_immediately.rst

**Notify multiple resources**

.. include:: ../../step_resource/step_resource_template_notifies_multiple_resources.rst

**Notify in a specific order**

.. include:: ../../step_resource/step_resource_execute_notifies_specific_order.rst

**Reload a service**

.. include:: ../../step_resource/step_resource_template_notifies_reload_service.rst

**Restart a service when a template is modified**

.. include:: ../../step_resource/step_resource_template_notifies_restart_service_when_template_modified.rst

**Send notifications to multiple resources**

.. include:: ../../step_resource/step_resource_template_notifies_send_notifications_to_multiple_resources.rst

**Execute a command using a template**

.. include:: ../../step_resource/step_resource_execute_command_from_template.rst

**Restart a service, and then notify a different service**

.. include:: ../../step_resource/step_resource_service_restart_and_notify.rst

**Notify when a remote source changes**

.. include:: ../../step_resource/step_resource_remote_file_transfer_remote_source_changes.rst

Subscribes
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources_common/includes_resources_common_notification_subscribes.rst

.. include:: ../../includes_resources_common/includes_resources_common_notification_subscribes_syntax.rst

Examples
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
The following examples show how to use the ``subscribes`` notification in a recipe.

**Prevent restart and reconfigure if configuration is broken**

.. include:: ../../step_resource/step_resource_execute_subscribes_prevent_restart_and_reconfigure.rst

**Reload a service using a template**

.. include:: ../../step_resource/step_resource_service_subscribes_reload_using_template.rst

**Stash a file in a data bag**

.. include:: ../../step_resource/step_resource_ruby_block_stash_file_in_data_bag.rst


Relative Paths
-----------------------------------------------------
.. include:: ../../includes_resources_common/includes_resources_common_relative_paths.rst

Examples
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../step_resource/step_resource_template_use_relative_paths.rst


Run in Compile Phase
-----------------------------------------------------
.. include:: ../../includes_resources_common/includes_resources_common_compile.rst

run_action
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources_common/includes_resources_common_compile_begin.rst


Atomic File Updates
-----------------------------------------------------
.. include:: ../../includes_resources_common/includes_resources_common_atomic_update.rst

Windows File Security
-----------------------------------------------------
.. include:: ../../includes_resources_common/includes_resources_common_windows_security.rst

**Access Control Lists (ACLs)**

.. include:: ../../includes_resources_common/includes_resources_common_windows_security_acl.rst

**Inheritance**

.. include:: ../../includes_resources_common/includes_resources_common_windows_security_inherits.rst


Resources
=====================================================
The following resources are built-in to the chef-client:

* apt_package (based on the package resource)
* apt_repository
* apt_update
* bash
* batch
* bff_package (based on the package resource)
* breakpoint
* cab_package
* chef_gem (based on the package resource)
* chef_handler (available from the chef_handler cookbook)
* chocolatey_package (based on the package resource)
* cookbook_file
* cron
* csh
* deploy (including git and Subversion)
* directory
* dpkg_package (based on the package resource)
* dsc_resource
* dsc_script
* easy_install_package (based on the package resource)
* env
* erl_call
* execute
* file
* freebsd_package (based on the package resource)
* gem_package (based on the package resource)
* git
* group
* homebrew_package (based on the package resource)
* http_request
* ifconfig
* ips_package (based on the package resource)
* ksh
* link
* log
* macports_package (based on the package resource)
* mdadm
* mount
* ohai
* openbsd_package (based on the package resource)
* osx_profile
* package
* pacman_package (based on the package resource)
* paludis_package (based on the package resource)
* perl
* portage_package (based on the package resource)
* powershell_script
* python
* reboot
* registry_key
* remote_directory
* remote_file
* route
* rpm_package (based on the package resource)
* ruby
* ruby_block
* script
* service
* smartos_package (based on the package resource)
* solaris_package (based on the package resource)
* subversion
* template
* user
* windows_package
* windows_service
* yum (based on the package resource)
* yum_repository

See below for more information about each of these resources, their related actions and properties, and examples of how these resources can be used in recipes.

apt_package
-----------------------------------------------------
.. include:: ../../includes_resources/includes_resource_package_apt.rst

.. note:: .. include:: ../../includes_notes/includes_notes_resource_based_on_package.rst

Syntax
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_package_apt_syntax.rst

Actions
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_package_apt_actions.rst

Properties
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_package_apt_attributes.rst

Providers
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_package_apt_providers.rst

Examples
+++++++++++++++++++++++++++++++++++++++++++++++++++++
The following examples demonstrate various approaches for using resources in recipes. If you want to see examples of how Chef uses resources in recipes, take a closer look at the cookbooks that Chef authors and maintains: https://github.com/chef-cookbooks.

**Install a package using package manager** 

.. include:: ../../step_resource/step_resource_apt_package_install_package.rst

**Install a package using local file** 

.. include:: ../../step_resource/step_resource_apt_package_install_package_using_local_file.rst

**Install without using recommend packages as a dependency**

.. include:: ../../step_resource/step_resource_apt_package_install_without_recommends_suggests.rst


apt_repository
-----------------------------------------------------

Use the **apt_repository** resource to additional APT repositories. Adding a new repository will notify running the ``execute[apt-get-update]`` resource immediately.

New in Chef Client 12.9.

Syntax
+++++++++++++++++++++++++++++++++++++++++++++++++++++
An **apt_repository** resource specifies APT repository information and adds an additional APT repository to the existing list of repositories:

.. code-block:: ruby

   apt_repository 'zenoss' do
     uri        'http://dev.zenoss.org/deb'
     components ['main', 'stable']
   end

where 

* ``apt_repository`` is the resource
* ``name`` is the name of the resource block
* ``uri`` is a base URI for the distribution where the apt packages are located at
* ``components`` is an array of package groupings in the repository

The full syntax for all of the properties that are available to the **apt_repository** resource is:

.. code-block:: ruby

   apt_repository 'name' do
      repo_name             String
      uri                   String
      distribution          String
      components            Array
      arch                  String
      trusted               TrueClass, FalseClass
      deb_src               TrueClass, FalseClass
      keyserver             String
      key                   String
      key_proxy             String
      cookbook              String
      cache_rebuild         TrueClass, FalseClass
      sensitive             TrueClass, FalseClass
   end

where 

* ``apt_repository`` is the resource
* ``name`` is the name of the resource block
* ``repo_name``, ``uri``, ``distribution``, ``components``, ``arch``, ``trusted``, ``deb_src``, ``keyserver``, ``key``, ``key_proxy``, ``cookbook``, ``cache_rebuild``, and ``sensitive`` are properties of this resource, with the Ruby type shown. See “Properties” section below for more information about all of the properties that may be used with this resource.

Actions
+++++++++++++++++++++++++++++++++++++++++++++++++++++
This resource has the following actions:

:add
   Default. Creates a repository file at ``/etc/apt/sources.list.d/`` and builds the repository listing. 

:remove
   Removes the repository listing.

Properties
+++++++++++++++++++++++++++++++++++++++++++++++++++++
This resource has the following properties:
   
repo_name
   **Ruby Type:** String

   The name of the channel to discover.

uri
   **Ruby Type:** String

   The base of the Debian distribution.

distribution
   **Ruby Type:** String

   Usually a codename, such as something like karmic, lucid or maverick.

components
   **Ruby Type:** Array

   Package groupings, such as 'main' and 'stable'. Default value: empty array.

arch
   **Ruby Type:** String

   Constrain packages to a particular CPU architecture such as ``'i386'`` or ``'amd64'``. Default value: ``nil``.

trusted
   **Ruby Type:** TrueClass, FalseClass

   Determines whether you should treat all packages from this repository as authenticated regardless of signature. Default value: ``false``.

deb_src
   **Ruby Type:** TrueClass, FalseClass

   Determines whether or not to add the repository as a source repo as well. Default value: ``false``.

keyserver
   **Ruby Type:** String

   The GPG keyserver where the key for the repo should be retrieved. Default value: "keyserver.ubuntu.com".

key
   **Ruby Type:** String

   If a keyserver is provided, this is assumed to be the fingerprint; otherwise it can be either the URI to the GPG key for the repo, or a cookbook_file. Default value: ``nil``.

key_proxy
   **Ruby Type:** String

   If set, a specified proxy is passed to GPG via ``http-proxy=``. Default value: ``nil``.

cookbook
   **Ruby Type:** String

   If ``key`` should be a cookbook_file, specify a cookbook where the key is located for files/default. Default value is ``nil``, so it will use the cookbook where the resource is used.

cache_rebuild
   **Ruby Type:** TrueClass, FalseClass

   Determines whether to rebuild the apt package cache. Default value: ``true``.

sensitive
   **Ruby Type:** TrueClass, FalseClass

   Determines whether sensitive resource data (such as key information) is not logged by the chef-client. Default value: ``false``.

Providers
+++++++++++++++++++++++++++++++++++++++++++++++++++++

This resource has the following providers:

``Chef::Provider::AptRepository``, ``apt_repository``
   The default provider for all platforms.


Examples
+++++++++++++++++++++++++++++++++++++++++++++++++++++

**Add repository with basic settings**

.. code-block:: ruby

   apt_repository 'zenoss' do
     uri        'http://dev.zenoss.org/deb'
     components ['main', 'stable']
   end

**Enable Ubuntu multiverse repositories**

.. code-block:: ruby

   apt_repository 'security-ubuntu-multiverse' do
     uri          'http://security.ubuntu.com/ubuntu'
     distribution 'trusty-security'
     components   ['multiverse']
     deb_src      true
   end

**Add the Nginx PPA, autodetect the key and repository url**

.. code-block:: ruby

   apt_repository 'nginx-php' do
     uri          'ppa:nginx/stable'
     distribution node['lsb']['codename']
   end
   
**Add the JuJu PPA, grab the key from the keyserver, and add source repo**

.. code-block:: ruby

   apt_repository 'juju' do
     uri 'http://ppa.launchpad.net/juju/stable/ubuntu'
     components ['main']
     distribution 'trusty'
     key 'C8068B11'
     keyserver 'keyserver.ubuntu.com'
     action :add
     deb_src true
   end

**Add the Cloudera Repo of CDH4 packages for Ubuntu 12.04 on AMD64**

.. code-block:: ruby

   apt_repository 'cloudera' do
     uri          'http://archive.cloudera.com/cdh4/ubuntu/precise/amd64/cdh'
     arch         'amd64'
     distribution 'precise-cdh4'
     components   ['contrib']
     key          'http://archive.cloudera.com/debian/archive.key'
   end

**Remove a repository from the list**

.. code-block:: ruby

   apt_repository 'zenoss' do
     action :remove
   end


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

.. 
.. Providers
.. =====================================================
.. .. include:: ../../includes_resources_common/includes_resources_common_provider.rst
.. 
.. .. include:: ../../includes_resources_common/includes_resources_common_provider_attributes.rst
.. 
.. .. include:: ../../includes_resources/includes_resource_apt_update_providers.rst
.. 

Examples
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources_common/includes_resources_common_examples_intro.rst

**Update the Apt repository at a specified interval** 

.. include:: ../../step_resource/step_resource_apt_update_periodic.rst

**Update the Apt repository at the start of a chef-client run** 

.. include:: ../../step_resource/step_resource_apt_update_at_start_of_client_run.rst


bash
-----------------------------------------------------
.. include:: ../../includes_resources/includes_resource_script_bash.rst

Syntax
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_script_bash_syntax.rst

Actions
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_script_bash_actions.rst

Properties
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_script_bash_attributes.rst

Providers
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_script_bash_providers.rst

Examples
+++++++++++++++++++++++++++++++++++++++++++++++++++++
The following examples demonstrate various approaches for using resources in recipes. If you want to see examples of how Chef uses resources in recipes, take a closer look at the cookbooks that Chef authors and maintains: https://github.com/chef-cookbooks.

**Use a named provider to run a script**

.. include:: ../../step_resource/step_resource_script_bash_provider_and_interpreter.rst

**Install a file from a remote location using bash**

.. include:: ../../step_resource/step_resource_remote_file_install_with_bash.rst

**Install an application from git using bash**

.. include:: ../../step_resource/step_resource_scm_use_bash_and_ruby_build.rst

**Store certain settings**

.. include:: ../../step_resource/step_resource_remote_file_store_certain_settings.rst


batch
-----------------------------------------------------

.. include:: ../../includes_resources_common/includes_resources_common_generic.rst

.. include:: ../../includes_resources/includes_resource_batch.rst

Syntax
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_batch_syntax.rst

Actions
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_batch_actions.rst

Properties
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_batch_attributes.rst

Guards
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
.. include:: ../../includes_resources_common/includes_resources_common_guards.rst

**Attributes**

.. include:: ../../includes_resources_common/includes_resources_common_guards_attributes.rst

**Arguments**

.. include:: ../../includes_resources_common/includes_resources_common_guards_arguments.rst

.. 
.. Providers
.. +++++++++++++++++++++++++++++++++++++++++++++++++++++
.. .. include:: ../../includes_resources/includes_resource_batch_providers.rst
.. 

Examples
+++++++++++++++++++++++++++++++++++++++++++++++++++++
The following examples demonstrate various approaches for using resources in recipes. If you want to see examples of how Chef uses resources in recipes, take a closer look at the cookbooks that Chef authors and maintains: https://github.com/chef-cookbooks.

**Unzip a file, and then move it**

.. include:: ../../step_resource/step_resource_batch_unzip_file_and_move.rst


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
.. include:: ../../includes_resources/includes_resource_package_bff_attributes.rst

Providers
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_package_bff_providers.rst

Examples
+++++++++++++++++++++++++++++++++++++++++++++++++++++
The following examples demonstrate various approaches for using resources in recipes. If you want to see examples of how Chef uses resources in recipes, take a closer look at the cookbooks that Chef authors and maintains: https://github.com/chef-cookbooks.

**Install a package**

.. include:: ../../step_resource/step_resource_bff_package_install.rst




breakpoint
-----------------------------------------------------

.. include:: ../../includes_resources_common/includes_resources_common_generic.rst

.. include:: ../../includes_resources/includes_resource_breakpoint.rst

Syntax
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_breakpoint_syntax.rst

Actions
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_breakpoint_actions.rst

Properties
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_breakpoint_attributes.rst

.. 
.. Providers
.. +++++++++++++++++++++++++++++++++++++++++++++++++++++
.. .. include:: ../../includes_resources/includes_resource_breakpoint_providers.rst
.. 

Examples
+++++++++++++++++++++++++++++++++++++++++++++++++++++
The following examples demonstrate various approaches for using resources in recipes. If you want to see examples of how Chef uses resources in recipes, take a closer look at the cookbooks that Chef authors and maintains: https://github.com/chef-cookbooks.

**A recipe without a breakpoint**

.. include:: ../../step_resource/step_resource_breakpoint_no.rst

**The same recipe with breakpoints**

.. include:: ../../step_resource/step_resource_breakpoint_yes.rst

cab_package
-----------------------------------------------------
Use the **cab_package** resource to install or remove Microsoft Windows cabinet (.cab) packages.

New in Chef Client 12.15.

Syntax
+++++++++++++++++++++++++++++++++++++++++++++++++++++
A **cab_package** resource installs or removes a cabinet package from the specified file path.

.. code-block:: ruby

   cab_package 'name' do
     source                  String
   end

where 

* cab_package is the resource
* name is the name of the resource block
* source is the location of the cabinet package

Actions
+++++++++++++++++++++++++++++++++++++++++++++++++++++
This resource has the following actions:

:install
   Installs the cabinet package.

:remove
   Removes the cabinet package.

Properties
+++++++++++++++++++++++++++++++++++++++++++++++++++++
This resource has the following properties:
   
source
   **Ruby Type:** String

   File path where the cabinet file is located. URLs are not supported.

Providers
+++++++++++++++++++++++++++++++++++++++++++++++++++++
This resource has the following provider:

``Chef::Provider::Package::Cab``, ``cab_package``
   The provider for the Microsoft Windows platform.

Examples
+++++++++++++++++++++++++++++++++++++++++++++++++++++

**Installing a cabinet package**

.. code-block:: ruby

   cab_package 'Install .NET 3.5 sp1 via KB958488' do
     source 'C:\Users\xyz\AppData\Local\Temp\Windows6.1-KB958488-x64.cab'
     action :install
   end

**Removing a cabinet package**

.. code-block:: ruby

   cab_package 'Remove .NET 3.5 sp1 via KB958488' do
     source 'C:\Users\xyz\AppData\Local\Temp\Windows6.1-KB958488-x64.cab'
     action :remove
   end

chef_gem
-----------------------------------------------------
.. include:: ../../includes_resources/includes_resource_package_chef_gem.rst

.. warning:: .. include:: ../../includes_notes/includes_notes_chef_gem_vs_gem_package.rst

.. note:: .. include:: ../../includes_notes/includes_notes_resource_based_on_package.rst

Syntax
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_package_chef_gem_syntax.rst

Actions
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_package_chef_gem_actions.rst

Properties
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_package_chef_gem_attributes.rst

Providers
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_package_chef_gem_providers.rst

Examples
+++++++++++++++++++++++++++++++++++++++++++++++++++++
The following examples demonstrate various approaches for using resources in recipes. If you want to see examples of how Chef uses resources in recipes, take a closer look at the cookbooks that Chef authors and maintains: https://github.com/chef-cookbooks.

**Install a gems file for use in recipes**

.. include:: ../../step_resource/step_resource_chef_gem_install_for_use_in_recipes.rst

**Install MySQL for Chef**

.. include:: ../../step_resource/step_resource_chef_gem_install_mysql.rst



chef_handler
-----------------------------------------------------
.. include:: ../../includes_resources/includes_resource_chef_handler.rst

Handler Types
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_handler/includes_handler_types.rst

Exception / Report
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
.. include:: ../../includes_handler/includes_handler_type_exception_report.rst

.. include:: ../../includes_handler/includes_handler_type_exception_report_run_from_recipe.rst

Start
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
.. include:: ../../includes_handler/includes_handler_type_start.rst

.. include:: ../../includes_handler/includes_handler_type_start_run_from_recipe.rst

Syntax
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_chef_handler_syntax.rst

Actions
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_chef_handler_actions.rst

Properties
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_chef_handler_attributes.rst


Custom Handlers
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_handler/includes_handler_custom.rst

Syntax
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
.. include:: ../../includes_handler/includes_handler_custom_syntax.rst

report Interface
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
.. include:: ../../includes_handler/includes_handler_custom_interface_report.rst

Optional Interfaces
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
The following interfaces may be used in a handler in the same way as the ``report`` interface to override the default handler behavior in the chef-client. That said, the following interfaces are not typically used in a handler and, for the most part, are completely unnecessary for a handler to work properly and/or as desired.

**data**

.. include:: ../../includes_handler/includes_handler_custom_interface_data.rst

**run_report_safely**

.. include:: ../../includes_handler/includes_handler_custom_interface_run_report_safely.rst

**run_report_unsafe**

.. include:: ../../includes_handler/includes_handler_custom_interface_run_report_unsafe.rst

run_status Object
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
.. include:: ../../includes_handler/includes_handler_custom_object_run_status.rst

Examples
+++++++++++++++++++++++++++++++++++++++++++++++++++++
The following examples demonstrate various approaches for using resources in recipes. If you want to see examples of how Chef uses resources in recipes, take a closer look at the cookbooks that Chef authors and maintains: https://github.com/chef-cookbooks.

**Enable the CloudkickHandler handler**

.. include:: ../../step_lwrp/step_lwrp_chef_handler_enable_cloudkickhandler.rst

**Enable handlers during the compile phase**

.. include:: ../../step_lwrp/step_lwrp_chef_handler_enable_during_compile.rst

**Handle only exceptions**

.. include:: ../../step_lwrp/step_lwrp_chef_handler_exceptions_only.rst

**Cookbook Versions (a custom handler)**

.. include:: ../../includes_handler/includes_handler_custom_example_cookbook_versions.rst

cookbook_versions.rb:

.. include:: ../../includes_handler/includes_handler_custom_example_cookbook_versions_handler.rst

default.rb:

.. include:: ../../includes_handler/includes_handler_custom_example_cookbook_versions_recipe.rst

**JsonFile Handler**

.. include:: ../../includes_handler/includes_handler_custom_example_json_file.rst

**Register the JsonFile handler**

.. include:: ../../step_lwrp/step_lwrp_chef_handler_register.rst

**ErrorReport Handler**

.. include:: ../../includes_handler/includes_handler_custom_example_error_report.rst



chocolatey_package
-----------------------------------------------------

.. include:: ../../includes_resources/includes_resource_package_chocolatey.rst

.. note:: .. include:: ../../includes_notes/includes_notes_resource_based_on_package.rst

Syntax
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_package_chocolatey_syntax.rst

Actions
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_package_chocolatey_actions.rst

Properties
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_package_chocolatey_attributes.rst

Providers
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources_common/includes_resources_common_provider.rst

.. include:: ../../includes_resources_common/includes_resources_common_provider_attributes.rst

.. include:: ../../includes_resources/includes_resource_package_chocolatey_providers.rst

Examples
+++++++++++++++++++++++++++++++++++++++++++++++++++++
The following examples demonstrate various approaches for using resources in recipes. If you want to see examples of how Chef uses resources in recipes, take a closer look at the cookbooks that Chef authors and maintains: https://github.com/chef-cookbooks.

**Install a package**

.. include:: ../../step_resource/step_resource_chocolatey_package_install.rst



cookbook_file
-----------------------------------------------------
.. include:: ../../includes_resources/includes_resource_cookbook_file.rst

.. include:: ../../includes_resources/includes_resource_cookbook_file_transfers.rst

Syntax
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_cookbook_file_syntax.rst

Actions
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_cookbook_file_actions.rst

Properties
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_cookbook_file_attributes.rst

.. warning:: .. include:: ../../includes_notes/includes_notes_selinux_file_based_resources.rst
.. 
.. Providers
.. +++++++++++++++++++++++++++++++++++++++++++++++++++++
.. .. include:: ../../includes_resources/includes_resource_cookbook_file_providers.rst
.. 

File Specificity
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_file/includes_file_cookbook_specificity.rst

.. include:: ../../includes_file/includes_file_cookbook_specificity_pattern.rst

.. include:: ../../includes_file/includes_file_cookbook_specificity_example.rst

Examples
+++++++++++++++++++++++++++++++++++++++++++++++++++++
The following examples demonstrate various approaches for using resources in recipes. If you want to see examples of how Chef uses resources in recipes, take a closer look at the cookbooks that Chef authors and maintains: https://github.com/chef-cookbooks.

**Transfer a file**

.. include:: ../../step_resource/step_resource_cookbook_file_transfer_a_file.rst

**Handle cookbook_file and yum_package resources in the same recipe**

.. include:: ../../step_resource/step_resource_yum_package_handle_cookbook_file_and_yum_package.rst

**Install repositories from a file, trigger a command, and force the internal cache to reload**

.. include:: ../../step_resource/step_resource_yum_package_install_yum_repo_from_file.rst

**Use a case statement**

.. include:: ../../step_resource/step_resource_cookbook_file_use_case_statement.rst


cron
-----------------------------------------------------
.. include:: ../../includes_resources/includes_resource_cron.rst

Syntax
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_cron_syntax.rst

Actions
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_cron_actions.rst

Properties
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_cron_attributes.rst

.. 
.. Providers
.. +++++++++++++++++++++++++++++++++++++++++++++++++++++
.. .. include:: ../../includes_resources/includes_resource_cron_providers.rst
.. 

Examples
+++++++++++++++++++++++++++++++++++++++++++++++++++++
The following examples demonstrate various approaches for using resources in recipes. If you want to see examples of how Chef uses resources in recipes, take a closer look at the cookbooks that Chef authors and maintains: https://github.com/chef-cookbooks.

**Run a program at a specified interval**

.. include:: ../../step_resource/step_resource_cron_run_program_on_fifth_hour.rst

**Run an entry if a folder exists**

.. include:: ../../step_resource/step_resource_cron_run_entry_when_folder_exists.rst

**Run every Saturday, 8:00 AM**

.. include:: ../../step_resource/step_resource_cron_run_every_saturday.rst

**Run only in November**

.. include:: ../../step_resource/step_resource_cron_run_only_in_november.rst


csh
-----------------------------------------------------
.. include:: ../../includes_resources/includes_resource_script_csh.rst

Syntax
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_script_csh_syntax.rst

Actions
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_script_csh_actions.rst

Properties
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_script_csh_attributes.rst

Providers
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_script_csh_providers.rst

Examples
+++++++++++++++++++++++++++++++++++++++++++++++++++++
None.


deploy
-----------------------------------------------------
.. include:: ../../includes_resources/includes_resource_deploy.rst

.. include:: ../../includes_resources/includes_resource_deploy_capistrano.rst

Syntax
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_deploy_syntax.rst

Deploy Strategies
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_deploy_strategy.rst

**Deploy Cache File**

.. include:: ../../includes_resources/includes_resource_deploy_strategy_start_over.rst

Deploy Phases
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
.. include:: ../../includes_resources/includes_resource_deploy_strategy_phases.rst

Callbacks
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
.. include:: ../../includes_resources/includes_resource_deploy_strategy_callbacks.rst

**Callbacks and Capistrano**

.. include:: ../../includes_resources/includes_resource_deploy_capistrano_callbacks.rst

Layout Modifiers
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
.. include:: ../../includes_resources/includes_resource_deploy_strategy_layouts.rst

Actions
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_deploy_actions.rst

Properties
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_deploy_attributes.rst

Providers
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_deploy_providers.rst

deploy_branch
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
.. include:: ../../includes_resources/includes_resource_deploy_providers_deploy_branch.rst

deploy_revision
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
.. include:: ../../includes_resources/includes_resource_deploy_providers_deploy_revision.rst

timestamped_deploy
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
.. include:: ../../includes_resources/includes_resource_deploy_providers_timestamped_deploy.rst

Examples
+++++++++++++++++++++++++++++++++++++++++++++++++++++
The following examples demonstrate various approaches for using resources in recipes. If you want to see examples of how Chef uses resources in recipes, take a closer look at the cookbooks that Chef authors and maintains: https://github.com/chef-cookbooks.

**Modify the layout of a Ruby on Rails application**

.. include:: ../../step_resource/step_resource_deploy_custom_application_layout.rst

**Use resources within callbacks**

.. include:: ../../step_resource/step_resource_deploy_embedded_recipes_for_callbacks.rst

**Deploy from a private git repository without using the application cookbook**

.. include:: ../../step_resource/step_resource_deploy_private_git_repo_using_application_cookbook.rst

**Use an SSH wrapper**

.. include:: ../../step_resource/step_resource_deploy_recipe_uses_ssh_wrapper.rst

**Use a callback to include a file that will be passed as a code block**

.. include:: ../../step_resource/step_resource_deploy_use_callback_to_include_code_from_file.rst

**Use a callback to pass a code block**

.. include:: ../../step_resource/step_resource_deploy_use_callback_to_pass_python.rst

**Use the same API for all recipes using the same gem**

.. include:: ../../step_resource/step_resource_deploy_use_same_api_as_gitdeploy_gems.rst

**Deploy without creating symbolic links to a shared folder**

.. include:: ../../step_resource/step_resource_deploy_without_symlink_to_shared.rst

**Clear a layout modifier attribute**

.. include:: ../../step_resource/step_resource_deploy_clear_layout_modifiers.rst


directory
-----------------------------------------------------
.. include:: ../../includes_resources/includes_resource_directory.rst

Syntax
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_directory_syntax.rst

Actions
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_directory_actions.rst

Properties
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_directory_attributes.rst

Recursive Directories
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
.. include:: ../../includes_resources/includes_resource_directory_recursive.rst

.. 
.. Providers
.. +++++++++++++++++++++++++++++++++++++++++++++++++++++
.. .. include:: ../../includes_resources/includes_resource_directory_providers.rst
.. 

Examples
+++++++++++++++++++++++++++++++++++++++++++++++++++++
The following examples demonstrate various approaches for using resources in recipes. If you want to see examples of how Chef uses resources in recipes, take a closer look at the cookbooks that Chef authors and maintains: https://github.com/chef-cookbooks.

**Create a directory**

.. include:: ../../step_resource/step_resource_directory_create.rst

**Create a directory in Microsoft Windows**

.. include:: ../../step_resource/step_resource_directory_create_in_windows.rst

**Create a directory recursively**

.. include:: ../../step_resource/step_resource_directory_create_recursively.rst

**Delete a directory**

.. include:: ../../step_resource/step_resource_directory_delete.rst

**Set directory permissions using a variable**

.. include:: ../../step_resource/step_resource_directory_set_permissions_with_variable.rst

**Set directory permissions for a specific type of node**

.. include:: ../../step_resource/step_resource_directory_set_permissions_for_specific_node.rst

**Reload the configuration**

.. include:: ../../step_resource/step_resource_ruby_block_reload_configuration.rst


dpkg_package
-----------------------------------------------------
.. include:: ../../includes_resources/includes_resource_package_dpkg.rst

.. note:: .. include:: ../../includes_notes/includes_notes_resource_based_on_package.rst

Syntax
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_package_dpkg_syntax.rst

Actions
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_package_dpkg_actions.rst

Properties
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_package_dpkg_attributes.rst

Providers
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_package_dpkg_providers.rst

Examples
+++++++++++++++++++++++++++++++++++++++++++++++++++++
The following examples demonstrate various approaches for using resources in recipes. If you want to see examples of how Chef uses resources in recipes, take a closer look at the cookbooks that Chef authors and maintains: https://github.com/chef-cookbooks.

**Install a package**

.. include:: ../../step_resource/step_resource_dpkg_package_install.rst


dsc_resource
-----------------------------------------------------

.. include:: ../../includes_resources_common/includes_resources_common_generic.rst

.. include:: ../../includes_resources_common/includes_resources_common_powershell.rst

.. include:: ../../includes_resources_common/includes_resources_common_powershell_dsc.rst

.. include:: ../../includes_resources/includes_resource_dsc_resource.rst

.. warning:: .. include:: ../../includes_resources/includes_resource_dsc_resource_requirements.rst

Syntax
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_dsc_resource_syntax.rst

Properties
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_dsc_resource_attributes.rst

Examples
+++++++++++++++++++++++++++++++++++++++++++++++++++++
The following examples demonstrate various approaches for using resources in recipes. If you want to see examples of how Chef uses resources in recipes, take a closer look at the cookbooks that Chef authors and maintains: https://github.com/chef-cookbooks.

**Open a Zip file**

.. include:: ../../step_resource/step_resource_dsc_resource_zip_file.rst

**Manage users and groups**

.. include:: ../../step_resource/step_resource_dsc_resource_manage_users.rst

**Create a test message queue**

.. include:: ../../step_resource/step_resource_dsc_resource_manage_msmq.rst


dsc_script
-----------------------------------------------------

.. include:: ../../includes_resources_common/includes_resources_common_generic.rst

.. include:: ../../includes_resources_common/includes_resources_common_powershell.rst

.. include:: ../../includes_resources_common/includes_resources_common_powershell_dsc.rst

.. include:: ../../includes_resources/includes_resource_dsc_script.rst

.. note:: Windows PowerShell 4.0 is required for using the **dsc_script** resource with Chef.

.. note:: The WinRM service must be enabled. (Use ``winrm quickconfig`` to enable the service.)

Syntax
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_dsc_script_syntax.rst

Actions
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_dsc_script_actions.rst

Properties
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_dsc_script_attributes.rst

Examples
+++++++++++++++++++++++++++++++++++++++++++++++++++++
The following examples demonstrate various approaches for using resources in recipes. If you want to see examples of how Chef uses resources in recipes, take a closer look at the cookbooks that Chef authors and maintains: https://github.com/chef-cookbooks.

**Specify DSC code directly**

.. include:: ../../step_resource/step_resource_dsc_script_code.rst

**Specify DSC code using a Windows Powershell data file**

.. include:: ../../step_resource/step_resource_dsc_script_command.rst

**Pass parameters to DSC configurations**

.. include:: ../../step_resource/step_resource_dsc_script_flags.rst

**Use custom configuration data**

Configuration data in DSC scripts may be customized from a recipe. For example, scripts are typically customized to set the behavior for Windows PowerShell credential data types. Configuration data may be specified in one of three ways: by using the ``configuration_data`` or ``configuration_data_script`` attributes or by specifying the path to a valid Windows PowerShell data file. 

.. include:: ../../step_resource/step_resource_dsc_script_configuration_data.rst

.. include:: ../../step_resource/step_resource_dsc_script_configuration_name.rst

**Using DSC with other Chef resources**

.. include:: ../../step_resource/step_resource_dsc_script_remote_files.rst



easy_install_package
-----------------------------------------------------
.. include:: ../../includes_resources/includes_resource_package_easy_install.rst

.. note:: .. include:: ../../includes_notes/includes_notes_resource_based_on_package.rst

Syntax
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_package_easy_install_syntax.rst

Actions
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_package_easy_install_actions.rst

Properties
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_package_easy_install_attributes.rst

Providers
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_package_easy_install_providers.rst

Examples
+++++++++++++++++++++++++++++++++++++++++++++++++++++
The following examples demonstrate various approaches for using resources in recipes. If you want to see examples of how Chef uses resources in recipes, take a closer look at the cookbooks that Chef authors and maintains: https://github.com/chef-cookbooks.

**Install a package**

.. include:: ../../step_resource/step_resource_easy_install_package_install.rst


env
-----------------------------------------------------
.. include:: ../../includes_resources/includes_resource_env.rst

.. note:: .. include:: ../../includes_notes/includes_notes_env_resource_variable_on_unix.rst

Syntax
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_env_syntax.rst

Actions
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_env_actions.rst

Properties
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_env_attributes.rst

.. 
.. Providers
.. +++++++++++++++++++++++++++++++++++++++++++++++++++++
.. .. include:: ../../includes_resources/includes_resource_env_providers.rst
.. 

Examples
+++++++++++++++++++++++++++++++++++++++++++++++++++++
The following examples demonstrate various approaches for using resources in recipes. If you want to see examples of how Chef uses resources in recipes, take a closer look at the cookbooks that Chef authors and maintains: https://github.com/chef-cookbooks.

**Set an environment variable**

.. include:: ../../step_resource/step_resource_environment_set_variable.rst


erl_call
-----------------------------------------------------
.. include:: ../../includes_resources/includes_resource_erlang_call.rst

.. note:: .. include:: ../../includes_notes/includes_notes_erlang_call_resource_must_be_on_path.rst

Syntax
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_erlang_call_syntax.rst

Actions
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_erlang_call_actions.rst

Properties
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_erlang_call_attributes.rst

.. 
.. Providers
.. +++++++++++++++++++++++++++++++++++++++++++++++++++++
.. .. include:: ../../includes_resources/includes_resource_erlang_call_providers.rst
.. 

Examples
+++++++++++++++++++++++++++++++++++++++++++++++++++++
The following examples demonstrate various approaches for using resources in recipes. If you want to see examples of how Chef uses resources in recipes, take a closer look at the cookbooks that Chef authors and maintains: https://github.com/chef-cookbooks.

**Run a command**

.. include:: ../../step_resource/step_resource_erlang_call_run_command_on_node.rst


execute
-----------------------------------------------------
.. include:: ../../includes_resources/includes_resource_execute.rst

.. note:: .. include:: ../../includes_notes/includes_notes_execute_resource_intepreter.rst

Syntax
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_execute_syntax.rst

Actions
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_execute_actions.rst

Properties
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_execute_attributes.rst

.. 
.. Providers
.. +++++++++++++++++++++++++++++++++++++++++++++++++++++
.. .. include:: ../../includes_resources/includes_resource_execute_providers.rst
.. 

Examples
+++++++++++++++++++++++++++++++++++++++++++++++++++++
The following examples demonstrate various approaches for using resources in recipes. If you want to see examples of how Chef uses resources in recipes, take a closer look at the cookbooks that Chef authors and maintains: https://github.com/chef-cookbooks.

**Run a command upon notification**

.. include:: ../../step_resource/step_resource_execute_command_upon_notification.rst

**Run a touch file only once while running a command**

.. include:: ../../step_resource/step_resource_execute_command_with_touch_file.rst

**Run a command which requires an environment variable**

.. include:: ../../step_resource/step_resource_execute_command_with_variable.rst

**Delete a repository using yum to scrub the cache**

.. include:: ../../step_resource/step_resource_yum_package_delete_repo_use_yum_to_scrub_cache.rst

**Install repositories from a file, trigger a command, and force the internal cache to reload**

.. include:: ../../step_resource/step_resource_yum_package_install_yum_repo_from_file.rst

**Prevent restart and reconfigure if configuration is broken**

.. include:: ../../step_resource/step_resource_execute_subscribes_prevent_restart_and_reconfigure.rst

**Notify in a specific order**

.. include:: ../../step_resource/step_resource_execute_notifies_specific_order.rst

**Execute a command using a template**

.. include:: ../../step_resource/step_resource_execute_command_from_template.rst

**Add a rule to an IP table**

.. include:: ../../step_resource/step_resource_execute_add_rule_to_iptable.rst

**Stop a service, do stuff, and then restart it**

.. include:: ../../step_resource/step_resource_service_stop_do_stuff_start.rst

**Use the platform_family? method**

.. include:: ../../step_resource/step_resource_remote_file_use_platform_family.rst

**Control a service using the execute resource**

.. include:: ../../step_resource/step_resource_execute_control_a_service.rst

**Use the search recipe DSL method to find users**

.. include:: ../../step_resource/step_resource_execute_use_search_dsl_method.rst

**Enable remote login for Mac OS X**

.. include:: ../../step_resource/step_resource_execute_enable_remote_login.rst

**Execute code immediately, based on the template resource**

.. include:: ../../step_resource/step_resource_template_notifies_run_immediately.rst

**Run a Knife command**

.. include:: ../../step_resource/step_resource_execute_knife_user_create.rst

**Run install command into virtual environment**

.. include:: ../../step_resource/step_resource_execute_install_q.rst

**Run a command as a named user**

.. include:: ../../step_resource/step_resource_execute_bundle_install.rst


file
-----------------------------------------------------
.. include:: ../../includes_resources/includes_resource_file.rst

.. note:: .. include:: ../../includes_notes/includes_notes_file_resource_use_other_resources.rst

Syntax
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_file_syntax.rst

Actions
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_file_actions.rst

Properties
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_file_attributes.rst

.. 
.. Providers
.. +++++++++++++++++++++++++++++++++++++++++++++++++++++
.. .. include:: ../../includes_resources/includes_resource_file_providers.rst
.. 

Examples
+++++++++++++++++++++++++++++++++++++++++++++++++++++
The following examples demonstrate various approaches for using resources in recipes. If you want to see examples of how Chef uses resources in recipes, take a closer look at the cookbooks that Chef authors and maintains: https://github.com/chef-cookbooks.

**Create a file**

.. include:: ../../step_resource/step_resource_file_create.rst

**Create a file in Microsoft Windows**

.. include:: ../../step_resource/step_resource_file_create_in_windows.rst

**Remove a file**

.. include:: ../../step_resource/step_resource_file_remove.rst

**Set file modes**

.. include:: ../../step_resource/step_resource_file_set_file_mode.rst

**Delete a repository using yum to scrub the cache**

.. include:: ../../step_resource/step_resource_yum_package_delete_repo_use_yum_to_scrub_cache.rst

**Add the value of a data bag item to a file**

.. include:: ../../step_resource/step_resource_file_content_data_bag.rst

**Write a YAML file**

.. include:: ../../step_resource/step_resource_file_content_yaml_config.rst

**Write a string to a file**

.. include:: ../../step_resource/step_resource_file_content_add_string.rst

**Create a file from a copy**

.. include:: ../../step_resource/step_resource_file_copy.rst


freebsd_package
-----------------------------------------------------
.. include:: ../../includes_resources/includes_resource_package_freebsd.rst

.. note:: .. include:: ../../includes_notes/includes_notes_resource_based_on_package.rst

Syntax
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_package_freebsd_syntax.rst

Actions
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_package_freebsd_actions.rst

Properties
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_package_freebsd_attributes.rst

Providers
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_package_freebsd_providers.rst

Examples
+++++++++++++++++++++++++++++++++++++++++++++++++++++
The following examples demonstrate various approaches for using resources in recipes. If you want to see examples of how Chef uses resources in recipes, take a closer look at the cookbooks that Chef authors and maintains: https://github.com/chef-cookbooks.

**Install a package**

.. include:: ../../step_resource/step_resource_freebsd_package_install.rst


gem_package
-----------------------------------------------------
.. include:: ../../includes_resources/includes_resource_package_gem.rst

.. warning:: .. include:: ../../includes_notes/includes_notes_chef_gem_vs_gem_package.rst

.. note:: .. include:: ../../includes_notes/includes_notes_resource_based_on_package.rst

Syntax
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_package_gem_syntax.rst

Gem Package Options
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_package_options.rst

Use a Hash
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
.. include:: ../../includes_resources/includes_resource_package_options_hash.rst

**Example**

.. include:: ../../step_resource/step_resource_package_install_gem_with_hash_options.rst

Use a String
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
.. include:: ../../includes_resources/includes_resource_package_options_string.rst

**Example**

.. include:: ../../step_resource/step_resource_package_install_gem_with_options_string.rst

Use a .gemrc File
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
.. include:: ../../includes_resources/includes_resource_package_options_gemrc.rst

**Example**

.. include:: ../../step_resource/step_resource_package_install_gem_with_gemrc.rst

Actions
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_package_gem_actions.rst

Properties
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_package_gem_attributes.rst

Providers
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_package_gem_providers.rst

Examples
+++++++++++++++++++++++++++++++++++++++++++++++++++++
The following examples demonstrate various approaches for using resources in recipes. If you want to see examples of how Chef uses resources in recipes, take a closer look at the cookbooks that Chef authors and maintains: https://github.com/chef-cookbooks.

**Install a gems file from the local file system**

.. include:: ../../step_resource/step_resource_package_install_gems_from_local.rst

**Use the ignore_failure common attribute**

.. include:: ../../step_resource/step_resource_package_use_ignore_failure_attribute.rst



git
-----------------------------------------------------

.. include:: ../../includes_resources/includes_resource_scm_git.rst

.. note:: .. include:: ../../includes_notes/includes_notes_scm_resource_use_with_resource_deploy.rst

Syntax
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_scm_git_syntax.rst

Actions
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_scm_git_actions.rst

Properties
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_scm_git_attributes.rst

.. 
.. Providers
.. +++++++++++++++++++++++++++++++++++++++++++++++++++++
.. .. include:: ../../includes_resources/includes_resource_scm_git_providers.rst
.. 

Examples
+++++++++++++++++++++++++++++++++++++++++++++++++++++
The following examples demonstrate various approaches for using resources in recipes. If you want to see examples of how Chef uses resources in recipes, take a closer look at the cookbooks that Chef authors and maintains: https://github.com/chef-cookbooks.

**Use the git mirror**

.. include:: ../../step_resource/step_resource_scm_use_git_mirror.rst

**Use different branches**

.. include:: ../../step_resource/step_resource_scm_use_different_branches.rst

**Install an application from git using bash**

.. include:: ../../step_resource/step_resource_scm_use_bash_and_ruby_build.rst

**Upgrade packages from git**

.. include:: ../../step_resource/step_resource_scm_upgrade_packages.rst


group
-----------------------------------------------------
.. include:: ../../includes_resources/includes_resource_group.rst

Syntax
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_group_syntax.rst

Actions
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_group_actions.rst

Properties
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_group_attributes.rst

Providers
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_group_providers.rst

Examples
+++++++++++++++++++++++++++++++++++++++++++++++++++++
The following examples demonstrate various approaches for using resources in recipes. If you want to see examples of how Chef uses resources in recipes, take a closer look at the cookbooks that Chef authors and maintains: https://github.com/chef-cookbooks.

**Append users to groups**

.. include:: ../../step_resource/step_resource_group_append_user.rst



homebrew_package
-----------------------------------------------------
.. include:: ../../includes_resources/includes_resource_package_homebrew.rst

.. note:: .. include:: ../../includes_notes/includes_notes_resource_based_on_package.rst

Syntax
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_package_homebrew_syntax.rst

Actions
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_package_homebrew_actions.rst

Properties
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_package_homebrew_attributes.rst

Providers
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_package_homebrew_providers.rst

Examples
+++++++++++++++++++++++++++++++++++++++++++++++++++++
The following examples demonstrate various approaches for using resources in recipes. If you want to see examples of how Chef uses resources in recipes, take a closer look at the cookbooks that Chef authors and maintains: https://github.com/chef-cookbooks.

**Install a package**

.. include:: ../../step_resource/step_resource_homebrew_package_install.rst

**Specify the Homebrew user with a UUID**

.. include:: ../../step_resource/step_resource_homebrew_package_homebrew_user_as_uuid.rst

**Specify the Homebrew user with a string**

.. include:: ../../step_resource/step_resource_homebrew_package_homebrew_user_as_string.rst




http_request
-----------------------------------------------------
.. include:: ../../includes_resources/includes_resource_http_request.rst

Syntax
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_http_request_syntax.rst

Actions
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_http_request_actions.rst

Properties
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_http_request_attributes.rst

.. 
.. Providers
.. +++++++++++++++++++++++++++++++++++++++++++++++++++++
.. .. include:: ../../includes_resources/includes_resource_http_request_providers.rst
.. 

Examples
+++++++++++++++++++++++++++++++++++++++++++++++++++++
The following examples demonstrate various approaches for using resources in recipes. If you want to see examples of how Chef uses resources in recipes, take a closer look at the cookbooks that Chef authors and maintains: https://github.com/chef-cookbooks.

**Send a GET request**

.. include:: ../../step_resource/step_resource_http_request_send_get.rst

**Send a POST request**

.. include:: ../../step_resource/step_resource_http_request_send_post.rst

**Transfer a file only when the remote source changes**

.. include:: ../../step_resource/step_resource_remote_file_transfer_remote_source_changes.rst

ifconfig
-----------------------------------------------------
.. include:: ../../includes_resources/includes_resource_ifconfig.rst

Syntax
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_ifconfig_syntax.rst

Actions
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_ifconfig_actions.rst

Properties
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_ifconfig_attributes.rst

.. 
.. Providers
.. +++++++++++++++++++++++++++++++++++++++++++++++++++++
.. .. include:: ../../includes_resources/includes_resource_ifconfig_providers.rst
.. 

Examples
+++++++++++++++++++++++++++++++++++++++++++++++++++++
The following examples demonstrate various approaches for using resources in recipes. If you want to see examples of how Chef uses resources in recipes, take a closer look at the cookbooks that Chef authors and maintains: https://github.com/chef-cookbooks.

**Configure a network interface**

.. include:: ../../step_resource/step_resource_ifconfig_configure_network_interface.rst

ips_package
-----------------------------------------------------
.. include:: ../../includes_resources/includes_resource_package_ips.rst

.. note:: .. include:: ../../includes_notes/includes_notes_resource_based_on_package.rst

Syntax
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_package_ips_syntax.rst

Actions
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_package_ips_actions.rst

Properties
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_package_ips_attributes.rst

Providers
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_package_ips_providers.rst

Examples
+++++++++++++++++++++++++++++++++++++++++++++++++++++
The following examples demonstrate various approaches for using resources in recipes. If you want to see examples of how Chef uses resources in recipes, take a closer look at the cookbooks that Chef authors and maintains: https://github.com/chef-cookbooks.

**Install a package**

.. include:: ../../step_resource/step_resource_ips_package_install.rst


link
-----------------------------------------------------
.. include:: ../../includes_resources/includes_resource_link.rst

.. include:: ../../includes_resources/includes_resource_link_about.rst

Syntax
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_link_syntax.rst

Actions
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_link_actions.rst

Properties
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_link_attributes.rst

.. 
.. Providers
.. +++++++++++++++++++++++++++++++++++++++++++++++++++++
.. .. include:: ../../includes_resources/includes_resource_link_providers.rst
.. 

Examples
+++++++++++++++++++++++++++++++++++++++++++++++++++++
The following examples demonstrate various approaches for using resources in recipes. If you want to see examples of how Chef uses resources in recipes, take a closer look at the cookbooks that Chef authors and maintains: https://github.com/chef-cookbooks.

**Create symbolic links**

.. include:: ../../step_resource/step_resource_link_create_symbolic.rst

**Create hard links**

.. include:: ../../step_resource/step_resource_link_create_hard.rst

**Delete links**

.. include:: ../../step_resource/step_resource_link_delete.rst

**Create multiple symbolic links**

.. include:: ../../step_resource/step_resource_link_multiple_links_files.rst

**Create platform-specific symbolic links**

.. include:: ../../step_resource/step_resource_link_multiple_links_redhat.rst


log
-----------------------------------------------------
.. include:: ../../includes_resources/includes_resource_log.rst

Syntax
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_log_syntax.rst

Actions
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_log_actions.rst

Properties
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_log_attributes.rst

.. 
.. Providers
.. +++++++++++++++++++++++++++++++++++++++++++++++++++++
.. .. include:: ../../includes_resources/includes_resource_log_providers.rst
.. 

Chef::Log Entries
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_ruby/includes_ruby_style_basics_chef_log.rst

.. include:: ../../step_ruby/step_ruby_class_chef_log_fatal.rst

.. include:: ../../step_ruby/step_ruby_class_chef_log_multiple.rst

Examples
+++++++++++++++++++++++++++++++++++++++++++++++++++++
The following examples demonstrate various approaches for using resources in recipes. If you want to see examples of how Chef uses resources in recipes, take a closer look at the cookbooks that Chef authors and maintains: https://github.com/chef-cookbooks.

**Set default logging level**

.. include:: ../../step_resource/step_resource_log_set_info.rst

**Set debug logging level**

.. include:: ../../step_resource/step_resource_log_set_debug.rst

**Add a message to a log file**

.. include:: ../../step_resource/step_resource_log_add_message.rst




macports_package
-----------------------------------------------------
.. include:: ../../includes_resources/includes_resource_package_macports.rst

.. note:: .. include:: ../../includes_notes/includes_notes_resource_based_on_package.rst

Syntax
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_package_macports_syntax.rst

Actions
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_package_macports_actions.rst

Properties
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_package_macports_attributes.rst

Providers
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_package_macports_providers.rst

Examples
+++++++++++++++++++++++++++++++++++++++++++++++++++++
The following examples demonstrate various approaches for using resources in recipes. If you want to see examples of how Chef uses resources in recipes, take a closer look at the cookbooks that Chef authors and maintains: https://github.com/chef-cookbooks.

**Install a package**

.. include:: ../../step_resource/step_resource_macports_package_install.rst


mdadm
-----------------------------------------------------
.. include:: ../../includes_resources/includes_resource_mdadm.rst

Syntax
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_mdadm_syntax.rst

Actions
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_mdadm_actions.rst

Properties
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_mdadm_attributes.rst

.. 
.. Providers
.. +++++++++++++++++++++++++++++++++++++++++++++++++++++
.. .. include:: ../../includes_resources/includes_resource_mdadm_providers.rst
.. 

Examples
+++++++++++++++++++++++++++++++++++++++++++++++++++++
The following examples demonstrate various approaches for using resources in recipes. If you want to see examples of how Chef uses resources in recipes, take a closer look at the cookbooks that Chef authors and maintains: https://github.com/chef-cookbooks.

**Create and assemble a RAID 0 array**

.. include:: ../../step_resource/step_resource_mdadm_raid0.rst

**Create and assemble a RAID 1 array**

.. include:: ../../step_resource/step_resource_mdadm_raid1.rst

**Create and assemble a RAID 5 array**

.. include:: ../../step_resource/step_resource_mdadm_raid5.rst


mount
-----------------------------------------------------
.. include:: ../../includes_resources/includes_resource_mount.rst

Syntax
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_mount_syntax.rst

Actions
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_mount_actions.rst

Properties
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_mount_attributes.rst

Providers
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_mount_providers.rst

Examples
+++++++++++++++++++++++++++++++++++++++++++++++++++++
The following examples demonstrate various approaches for using resources in recipes. If you want to see examples of how Chef uses resources in recipes, take a closer look at the cookbooks that Chef authors and maintains: https://github.com/chef-cookbooks.

**Mount a labeled file system**

.. include:: ../../step_resource/step_resource_mount_labeled_file_system.rst

**Mount a local block drive**

.. include:: ../../step_resource/step_resource_mount_local_block_device.rst

**Mount a non-block file system**

.. include:: ../../step_resource/step_resource_mount_nonblock_file_system.rst

**Mount and add to the file systems table**

.. include:: ../../step_resource/step_resource_mount_remote_file_system_add_to_fstab.rst

**Mount a remote file system**

.. include:: ../../step_resource/step_resource_mount_remote_file_system.rst

**Mount a remote folder in Microsoft Windows**

.. include:: ../../step_resource/step_resource_mount_remote_windows_folder.rst

**Unmount a remote folder in Microsoft Windows**

.. include:: ../../step_resource/step_resource_mount_unmount_remote_windows_drive.rst

**Stop a service, do stuff, and then restart it**

.. include:: ../../step_resource/step_resource_service_stop_do_stuff_start.rst


ohai
-----------------------------------------------------
.. include:: ../../includes_resources/includes_resource_ohai.rst

Syntax
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_ohai_syntax.rst

Actions
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_ohai_actions.rst

Properties
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_ohai_attributes.rst

.. 
.. Providers
.. +++++++++++++++++++++++++++++++++++++++++++++++++++++
.. .. include:: ../../includes_resources/includes_resource_ohai_providers.rst
.. 

Examples
+++++++++++++++++++++++++++++++++++++++++++++++++++++
The following examples demonstrate various approaches for using resources in recipes. If you want to see examples of how Chef uses resources in recipes, take a closer look at the cookbooks that Chef authors and maintains: https://github.com/chef-cookbooks.

**Reload Ohai**

.. include:: ../../step_resource/step_resource_ohai_reload.rst

**Reload Ohai after a new user is created**

.. include:: ../../step_resource/step_resource_ohai_reload_after_create_user.rst


openbsd_package
-----------------------------------------------------

.. include:: ../../includes_resources_common/includes_resources_common_generic.rst

.. include:: ../../includes_resources/includes_resource_package_openbsd.rst

.. note:: .. include:: ../../includes_notes/includes_notes_resource_based_on_package.rst

Syntax
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_package_openbsd_syntax.rst

Actions
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_package_openbsd_actions.rst

Properties
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_package_openbsd_attributes.rst

Providers
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources_common/includes_resources_common_provider.rst

.. include:: ../../includes_resources_common/includes_resources_common_provider_attributes.rst

.. include:: ../../includes_resources/includes_resource_package_openbsd_providers.rst

Examples
+++++++++++++++++++++++++++++++++++++++++++++++++++++
The following examples demonstrate various approaches for using resources in recipes. If you want to see examples of how Chef uses resources in recipes, take a closer look at the cookbooks that Chef authors and maintains: https://github.com/chef-cookbooks.

**Install a package**

.. include:: ../../step_resource/step_resource_openbsd_package_install.rst




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

..
.. Providers
.. +++++++++++++++++++++++++++++++++++++++++++++++++++++
.. .. include:: ../../includes_resources_common/includes_resources_common_provider.rst
..
.. .. include:: ../../includes_resources_common/includes_resources_common_provider_attributes.rst
..
.. .. include:: ../../includes_resources/includes_resource_osx_profile_providers.rst
..

Examples
+++++++++++++++++++++++++++++++++++++++++++++++++++++
The following examples demonstrate various approaches for using resources in recipes. If you want to see examples of how Chef uses resources in recipes, take a closer look at the cookbooks that Chef authors and maintains: https://github.com/chef-cookbooks.


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





package
-----------------------------------------------------
.. include:: ../../includes_resources/includes_resource_package.rst

.. note:: There are a number of platform-specific resources available for package management. In general, the **package** resource will use the correct package manager based on the platform-specific details collected by Ohai at the start of the chef-client run, which means that the platform-specific resources are often unnecessary. That said, there are cases when using a platform-specific package-based resource is desired. See the following resources for more information about these platform-specific resources: ``apt_package``, ``chef_gem``, ``dpkg_package``, ``easy_install_package``, ``freebsd_package``, ``gem_package``, ``ips_package``, ``macports_package``, ``openbsd_package``, ``pacman_package``, ``paludis_package``, ``portage_package``, ``rpm_package``, ``smartos_package``, ``solaris_package``, and ``yum_package``.

Syntax
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_package_syntax.rst

Gem Package Options
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_package_options.rst

Specify Options with a Hash
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
.. include:: ../../includes_resources/includes_resource_package_options_hash.rst

**Example**

.. include:: ../../step_resource/step_resource_package_install_gem_with_hash_options.rst

Specify Options with a String
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
.. include:: ../../includes_resources/includes_resource_package_options_string.rst

**Example**

.. include:: ../../step_resource/step_resource_package_install_gem_with_options_string.rst

Specify Options with a .gemrc File
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
.. include:: ../../includes_resources/includes_resource_package_options_gemrc.rst

**Example**

.. include:: ../../step_resource/step_resource_package_install_gem_with_gemrc.rst

Actions
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_package_actions.rst

Properties
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_package_attributes.rst

Multiple Packages
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
.. include:: ../../includes_resources_common/includes_resources_common_multiple_packages.rst

Providers
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_package_providers.rst

Examples
+++++++++++++++++++++++++++++++++++++++++++++++++++++
The following examples demonstrate various approaches for using resources in recipes. If you want to see examples of how Chef uses resources in recipes, take a closer look at the cookbooks that Chef authors and maintains: https://github.com/chef-cookbooks.

**Install a gems file for use in recipes**

.. include:: ../../step_resource/step_resource_package_install_gems_for_chef_recipe.rst

**Install a gems file from the local file system**

.. include:: ../../step_resource/step_resource_package_install_gems_from_local.rst

**Install a package**

.. include:: ../../step_resource/step_resource_package_install.rst

**Install a package version**

.. include:: ../../step_resource/step_resource_package_install_version.rst

**Install a package with options**

.. include:: ../../step_resource/step_resource_package_install_with_options.rst

**Install a package with a response_file**

.. include:: ../../step_resource/step_resource_package_install_with_response_file.rst

**Install a package using a specific provider**

.. include:: ../../step_resource/step_resource_package_install_with_specific_provider.rst

**Install a specified architecture using a named provider**

.. include:: ../../step_resource/step_resource_package_install_with_yum.rst

**Purge a package**

.. include:: ../../step_resource/step_resource_package_purge.rst

**Remove a package**

.. include:: ../../step_resource/step_resource_package_remove.rst

**Upgrade a package**

.. include:: ../../step_resource/step_resource_package_upgrade.rst

**Avoid unnecessary string interpolation**

.. include:: ../../step_resource/step_resource_package_avoid_unnecessary_string_interpolation.rst

**Install a package in a platform**

.. include:: ../../step_resource/step_resource_package_install_package_on_platform.rst

**Install sudo, then configure /etc/sudoers/ file**

.. include:: ../../step_resource/step_resource_package_install_sudo_configure_etc_sudoers.rst

**Use a case statement to specify the platform**

.. include:: ../../step_resource/step_resource_package_use_case_statement.rst

**Use symbols to reference attributes**

.. include:: ../../step_resource/step_resource_package_use_symbols_to_reference_attributes.rst

**Use a whitespace array to simplify a recipe**

.. include:: ../../step_resource/step_resource_package_use_whitespace_array.rst

pacman_package
-----------------------------------------------------
.. include:: ../../includes_resources/includes_resource_package_pacman.rst

.. note:: .. include:: ../../includes_notes/includes_notes_resource_based_on_package.rst

Syntax
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_package_pacman_syntax.rst

Actions
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_package_pacman_actions.rst

Properties
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_package_pacman_attributes.rst

Providers
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_package_pacman_providers.rst

Examples
+++++++++++++++++++++++++++++++++++++++++++++++++++++
The following examples demonstrate various approaches for using resources in recipes. If you want to see examples of how Chef uses resources in recipes, take a closer look at the cookbooks that Chef authors and maintains: https://github.com/chef-cookbooks.

**Install a package**

.. include:: ../../step_resource/step_resource_pacman_package_install.rst



paludis_package
-----------------------------------------------------

.. include:: ../../includes_resources_common/includes_resources_common_generic.rst

.. include:: ../../includes_resources/includes_resource_package_paludis.rst

.. note:: .. include:: ../../includes_notes/includes_notes_resource_based_on_package.rst

Syntax
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_package_paludis_syntax.rst

Actions
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_package_paludis_actions.rst

Properties
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_package_paludis_attributes.rst

Providers
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources_common/includes_resources_common_provider.rst

.. include:: ../../includes_resources_common/includes_resources_common_provider_attributes.rst

.. include:: ../../includes_resources/includes_resource_package_paludis_providers.rst

Examples
+++++++++++++++++++++++++++++++++++++++++++++++++++++
The following examples demonstrate various approaches for using resources in recipes. If you want to see examples of how Chef uses resources in recipes, take a closer look at the cookbooks that Chef authors and maintains: https://github.com/chef-cookbooks.

**Install a package**

.. include:: ../../step_resource/step_resource_paludis_package_install.rst




perl
-----------------------------------------------------
.. include:: ../../includes_resources/includes_resource_script_perl.rst

Syntax
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_script_perl_syntax.rst

Actions
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_script_perl_actions.rst

Properties
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_script_perl_attributes.rst

Providers
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_script_perl_providers.rst

Examples
+++++++++++++++++++++++++++++++++++++++++++++++++++++
None.


portage_package
-----------------------------------------------------
.. include:: ../../includes_resources/includes_resource_package_portage.rst

.. note:: .. include:: ../../includes_notes/includes_notes_resource_based_on_package.rst

Syntax
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_package_portage_syntax.rst

Actions
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_package_portage_actions.rst

Properties
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_package_portage_attributes.rst

Providers
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_package_portage_providers.rst

Examples
+++++++++++++++++++++++++++++++++++++++++++++++++++++
The following examples demonstrate various approaches for using resources in recipes. If you want to see examples of how Chef uses resources in recipes, take a closer look at the cookbooks that Chef authors and maintains: https://github.com/chef-cookbooks.

**Install a package**

.. include:: ../../step_resource/step_resource_portage_package_install.rst


powershell_script
-----------------------------------------------------
.. include:: ../../includes_resources/includes_resource_powershell_script.rst

Syntax
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_powershell_script_syntax.rst

Actions
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_powershell_script_actions.rst

Properties
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_powershell_script_attributes.rst

.. 
.. Providers
.. +++++++++++++++++++++++++++++++++++++++++++++++++++++
.. .. include:: ../../includes_resources/includes_resource_powershell_script_providers.rst
.. 

Examples
+++++++++++++++++++++++++++++++++++++++++++++++++++++
The following examples demonstrate various approaches for using resources in recipes. If you want to see examples of how Chef uses resources in recipes, take a closer look at the cookbooks that Chef authors and maintains: https://github.com/chef-cookbooks.

**Write to an interpolated path**

.. include:: ../../step_resource/step_resource_powershell_write_to_interpolated_path.rst

**Change the working directory**

.. include:: ../../step_resource/step_resource_powershell_cwd.rst

**Change the working directory in Microsoft Windows**

.. include:: ../../step_resource/step_resource_powershell_cwd_microsoft_env.rst

**Pass an environment variable to a script**

.. include:: ../../step_resource/step_resource_powershell_pass_env_to_script.rst

**Rename computer, join domain, reboot**

.. include:: ../../step_resource/step_resource_powershell_rename_join_reboot.rst



python
-----------------------------------------------------
.. include:: ../../includes_resources/includes_resource_script_python.rst

Syntax
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_script_python_syntax.rst

Actions
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_script_python_actions.rst

Properties
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_script_python_attributes.rst

Providers
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_script_python_providers.rst

Examples
+++++++++++++++++++++++++++++++++++++++++++++++++++++
None.




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
.. include:: ../../includes_resources/includes_resource_service_reboot_attributes.rst

.. 
.. Providers
.. +++++++++++++++++++++++++++++++++++++++++++++++++++++
.. .. include:: ../../includes_resources/includes_resource_service_reboot_providers.rst
.. 

Examples
+++++++++++++++++++++++++++++++++++++++++++++++++++++
The following examples demonstrate various approaches for using resources in recipes. If you want to see examples of how Chef uses resources in recipes, take a closer look at the cookbooks that Chef authors and maintains: https://github.com/chef-cookbooks.

**Reboot a node immediately**

.. include:: ../../step_resource/step_resource_service_reboot_immediately.rst

**Reboot a node at the end of a chef-client run**

.. include:: ../../step_resource/step_resource_service_reboot_request.rst

**Cancel a reboot**

.. include:: ../../step_resource/step_resource_service_reboot_cancel.rst

**Rename computer, join domain, reboot**

.. include:: ../../step_resource/step_resource_powershell_rename_join_reboot.rst


registry_key
-----------------------------------------------------

.. include:: ../../includes_resources/includes_resource_registry_key.rst

Syntax
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_registry_key_syntax.rst

**Registry Key Path Separators**

.. include:: ../../includes_windows/includes_windows_registry_key_backslashes.rst

Actions
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_registry_key_actions.rst

Properties
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_registry_key_attributes.rst

.. 
.. Providers
.. +++++++++++++++++++++++++++++++++++++++++++++++++++++
.. .. include:: ../../includes_resources/includes_resource_registry_key_providers.rst
.. 

Examples
+++++++++++++++++++++++++++++++++++++++++++++++++++++
The following examples demonstrate various approaches for using resources in recipes. If you want to see examples of how Chef uses resources in recipes, take a closer look at the cookbooks that Chef authors and maintains: https://github.com/chef-cookbooks.

**Create a registry key**

.. include:: ../../step_resource/step_resource_registry_key_create.rst

**Delete a registry key value**

.. include:: ../../step_resource/step_resource_registry_key_delete_value.rst

**Delete a registry key and its subkeys, recursively**

.. include:: ../../step_resource/step_resource_registry_key_delete_recursively.rst

**Use re-directed keys**

.. include:: ../../step_resource/step_resource_registry_key_redirect.rst

**Set proxy settings to be the same as those used by the chef-client**

.. include:: ../../step_resource/step_resource_registry_key_set_proxy_settings_to_same_as_chef_client.rst

**Set the name of a registry key to "(Default)"**

.. include:: ../../step_resource/step_resource_registry_key_set_default.rst

remote_directory
-----------------------------------------------------
.. include:: ../../includes_resources/includes_resource_remote_directory.rst

Syntax
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_remote_directory_syntax.rst

Actions
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_remote_directory_actions.rst

Properties
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_remote_directory_attributes.rst

Recursive Directories
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
.. include:: ../../includes_resources/includes_resource_remote_directory_recursive.rst

.. 
.. Providers
.. +++++++++++++++++++++++++++++++++++++++++++++++++++++
.. .. include:: ../../includes_resources/includes_resource_remote_directory_providers.rst
.. 

Examples
+++++++++++++++++++++++++++++++++++++++++++++++++++++
The following examples demonstrate various approaches for using resources in recipes. If you want to see examples of how Chef uses resources in recipes, take a closer look at the cookbooks that Chef authors and maintains: https://github.com/chef-cookbooks.

**Recursively transfer a directory from a remote location**

.. include:: ../../step_resource/step_resource_remote_directory_recursive_transfer.rst

**Use with the chef_handler lightweight resource**

.. include:: ../../step_resource/step_resource_remote_directory_report_handler.rst


remote_file
-----------------------------------------------------
.. include:: ../../includes_resources/includes_resource_remote_file.rst

.. note:: .. include:: ../../includes_notes/includes_notes_remote_file_resource_fetch_from_files_directory.rst

Syntax
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_remote_file_syntax.rst

Actions
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_remote_file_actions.rst

Properties
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_remote_file_attributes.rst

.. 
.. Providers
.. +++++++++++++++++++++++++++++++++++++++++++++++++++++
.. .. include:: ../../includes_resources/includes_resource_remote_file_providers.rst
.. 

Examples
+++++++++++++++++++++++++++++++++++++++++++++++++++++
The following examples demonstrate various approaches for using resources in recipes. If you want to see examples of how Chef uses resources in recipes, take a closer look at the cookbooks that Chef authors and maintains: https://github.com/chef-cookbooks.

**Transfer a file from a URL**

.. include:: ../../step_resource/step_resource_remote_file_transfer_from_url.rst

**Transfer a file only when the source has changed**

.. include:: ../../step_resource/step_resource_remote_file_transfer_remote_source_changes.rst

**Install a file from a remote location using bash**

.. include:: ../../step_resource/step_resource_remote_file_install_with_bash.rst

**Store certain settings**

.. include:: ../../step_resource/step_resource_remote_file_store_certain_settings.rst

**Use the platform_family? method**

.. include:: ../../step_resource/step_resource_remote_file_use_platform_family.rst

**Specify local Windows file path as a valid URI**

.. include:: ../../step_resource/step_resource_remote_file_local_windows_path.rst

route
-----------------------------------------------------
.. include:: ../../includes_resources/includes_resource_route.rst

Syntax
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_route_syntax.rst

Actions
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_route_actions.rst

Properties
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_route_attributes.rst

.. 
.. Providers
.. +++++++++++++++++++++++++++++++++++++++++++++++++++++
.. .. include:: ../../includes_resources/includes_resource_route_providers.rst
.. 

Examples
+++++++++++++++++++++++++++++++++++++++++++++++++++++
The following examples demonstrate various approaches for using resources in recipes. If you want to see examples of how Chef uses resources in recipes, take a closer look at the cookbooks that Chef authors and maintains: https://github.com/chef-cookbooks.

**Add a host route**

.. include:: ../../step_resource/step_resource_route_add_host.rst

**Delete a network route**

.. include:: ../../step_resource/step_resource_route_delete_network.rst

rpm_package
-----------------------------------------------------
.. include:: ../../includes_resources/includes_resource_package_rpm.rst

.. note:: .. include:: ../../includes_notes/includes_notes_resource_based_on_package.rst

Syntax
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_package_rpm_syntax.rst

Actions
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_package_rpm_actions.rst

Properties
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_package_rpm_attributes.rst

Providers
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_package_rpm_providers.rst

Examples
+++++++++++++++++++++++++++++++++++++++++++++++++++++
The following examples demonstrate various approaches for using resources in recipes. If you want to see examples of how Chef uses resources in recipes, take a closer look at the cookbooks that Chef authors and maintains: https://github.com/chef-cookbooks.

**Install a package**

.. include:: ../../step_resource/step_resource_rpm_package_install.rst

ruby
-----------------------------------------------------
.. include:: ../../includes_resources/includes_resource_script_ruby.rst

Syntax
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_script_ruby_syntax.rst

Actions
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_script_ruby_actions.rst

Properties
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_script_ruby_attributes.rst

Providers
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_script_ruby_providers.rst

Examples
+++++++++++++++++++++++++++++++++++++++++++++++++++++
None.


ruby_block
-----------------------------------------------------
.. include:: ../../includes_resources/includes_resource_ruby_block.rst

Syntax
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_ruby_block_syntax.rst

Actions
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_ruby_block_actions.rst

Properties
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_ruby_block_attributes.rst

.. 
.. Providers
.. +++++++++++++++++++++++++++++++++++++++++++++++++++++
.. .. include:: ../../includes_resources/includes_resource_ruby_block_providers.rst
.. 

Examples
+++++++++++++++++++++++++++++++++++++++++++++++++++++
The following examples demonstrate various approaches for using resources in recipes. If you want to see examples of how Chef uses resources in recipes, take a closer look at the cookbooks that Chef authors and maintains: https://github.com/chef-cookbooks.

**Re-read configuration data**

.. include:: ../../step_resource/step_resource_ruby_block_reread_chef_client.rst

**Install repositories from a file, trigger a command, and force the internal cache to reload**

.. include:: ../../step_resource/step_resource_yum_package_install_yum_repo_from_file.rst

**Use an if statement with the platform recipe DSL method**

.. include:: ../../step_resource/step_resource_ruby_block_if_statement_use_with_platform.rst

**Stash a file in a data bag**

.. include:: ../../step_resource/step_resource_ruby_block_stash_file_in_data_bag.rst

**Update the /etc/hosts file**

.. include:: ../../step_resource/step_resource_ruby_block_update_etc_host.rst

**Set environment variables**

.. include:: ../../step_resource/step_resource_ruby_block_use_variables_to_set_env_variables.rst

**Set JAVA_HOME**

.. include:: ../../step_resource/step_resource_ruby_block_use_variables_to_set_java_home.rst

**Run specific blocks of Ruby code on specific platforms**

.. include:: ../../step_resource/step_resource_ruby_block_run_specific_ruby_blocks_on_specific_platforms.rst

**Reload the configuration**

.. include:: ../../step_resource/step_resource_ruby_block_reload_configuration.rst


script
-----------------------------------------------------
.. include:: ../../includes_resources/includes_resource_script.rst

Syntax
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_script_syntax.rst

Actions
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_script_actions.rst

Properties
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_script_attributes.rst

Providers
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_script_providers.rst

Examples
+++++++++++++++++++++++++++++++++++++++++++++++++++++
The following examples demonstrate various approaches for using resources in recipes. If you want to see examples of how Chef uses resources in recipes, take a closer look at the cookbooks that Chef authors and maintains: https://github.com/chef-cookbooks.

**Use a named provider to run a script**

.. include:: ../../step_resource/step_resource_script_bash_provider_and_interpreter.rst

**Run a script**

.. include:: ../../step_resource/step_resource_script_bash_script.rst

**Install a file from a remote location using bash**

.. include:: ../../step_resource/step_resource_remote_file_install_with_bash.rst

**Install an application from git using bash**

.. include:: ../../step_resource/step_resource_scm_use_bash_and_ruby_build.rst

**Store certain settings**

.. include:: ../../step_resource/step_resource_remote_file_store_certain_settings.rst



service
-----------------------------------------------------
.. include:: ../../includes_resources/includes_resource_service.rst

Syntax
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_service_syntax.rst

Actions
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_service_actions.rst

Properties
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_service_attributes.rst

Providers
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_service_providers.rst

Examples
+++++++++++++++++++++++++++++++++++++++++++++++++++++
The following examples demonstrate various approaches for using resources in recipes. If you want to see examples of how Chef uses resources in recipes, take a closer look at the cookbooks that Chef authors and maintains: https://github.com/chef-cookbooks.

**Start a service**

.. include:: ../../step_resource/step_resource_service_start_service.rst

**Start a service, enable it**

.. include:: ../../step_resource/step_resource_service_start_service_and_enable_at_boot.rst

**Use a pattern**

.. include:: ../../step_resource/step_resource_service_process_table_has_different_value.rst

**Manage a service, depending on the node platform**

.. include:: ../../step_resource/step_resource_service_manage_ssh_based_on_node_platform.rst

**Change a service provider, depending on the node platform**

.. include:: ../../step_resource/step_resource_service_change_service_provider_based_on_node.rst

**Set an IP address using variables and a template**

.. include:: ../../step_resource/step_resource_template_set_ip_address_with_variables_and_template.rst

**Use a cron timer to manage a service**

.. include:: ../../step_resource/step_resource_service_use_variable.rst

**Restart a service, and then notify a different service**

.. include:: ../../step_resource/step_resource_service_restart_and_notify.rst

**Stop a service, do stuff, and then restart it**

.. include:: ../../step_resource/step_resource_service_stop_do_stuff_start.rst

**Control a service using the execute resource**

.. include:: ../../step_resource/step_resource_execute_control_a_service.rst


smartos_package
-----------------------------------------------------
.. include:: ../../includes_resources/includes_resource_package_smartos.rst

.. note:: .. include:: ../../includes_notes/includes_notes_resource_based_on_package.rst

Syntax
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_package_smartos_syntax.rst

Actions
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_package_smartos_actions.rst

Properties
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_package_smartos_attributes.rst

Providers
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_package_smartos_providers.rst

Examples
+++++++++++++++++++++++++++++++++++++++++++++++++++++
The following examples demonstrate various approaches for using resources in recipes. If you want to see examples of how Chef uses resources in recipes, take a closer look at the cookbooks that Chef authors and maintains: https://github.com/chef-cookbooks.

**Install a package**

.. include:: ../../step_resource/step_resource_smartos_package_install.rst


solaris_package
-----------------------------------------------------
.. include:: ../../includes_resources/includes_resource_package_solaris.rst

.. note:: .. include:: ../../includes_notes/includes_notes_resource_based_on_package.rst

Syntax
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_package_solaris_syntax.rst

Actions
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_package_solaris_actions.rst

Properties
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_package_solaris_attributes.rst

Providers
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_package_solaris_providers.rst

Examples
+++++++++++++++++++++++++++++++++++++++++++++++++++++
The following examples demonstrate various approaches for using resources in recipes. If you want to see examples of how Chef uses resources in recipes, take a closer look at the cookbooks that Chef authors and maintains: https://github.com/chef-cookbooks.

**Install a package**

.. include:: ../../step_resource/step_resource_solaris_package_install.rst



subversion
-----------------------------------------------------
.. include:: ../../includes_resources/includes_resource_scm_subversion.rst

.. note:: .. include:: ../../includes_notes/includes_notes_scm_resource_use_with_resource_deploy.rst

Syntax
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_scm_subversion_syntax.rst

Actions
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_scm_subversion_actions.rst

Properties
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_scm_subversion_attributes.rst

.. 
.. Providers
.. +++++++++++++++++++++++++++++++++++++++++++++++++++++
.. .. include:: ../../includes_resources/includes_resource_scm_subversion_providers.rst
.. 

Examples
+++++++++++++++++++++++++++++++++++++++++++++++++++++
The following examples demonstrate various approaches for using resources in recipes. If you want to see examples of how Chef uses resources in recipes, take a closer look at the cookbooks that Chef authors and maintains: https://github.com/chef-cookbooks.

**Get the latest version of an application**

.. include:: ../../step_resource/step_resource_scm_get_latest_version.rst

systemd_unit
----------------------------------------------------

.. include:: ../../includes_resources/includes_resource_systemd_unit.rst

Syntax
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_systemd_unit_syntax.rst

Actions
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_systemd_unit_actions.rst

Properties
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_systemd_unit_attributes.rst

Providers
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources_common/includes_resources_common_provider.rst

.. include:: ../../includes_resources_common/includes_resources_common_provider_attributes.rst

.. include:: ../../includes_resources/includes_resource_systemd_unit_providers.rst

template
-----------------------------------------------------
.. include:: ../../includes_template/includes_template.rst

.. include:: ../../includes_resources/includes_resource_template.rst

Syntax
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_template_syntax.rst

Actions
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_template_actions.rst

Properties
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_template_attributes.rst

.. 
.. Providers
.. +++++++++++++++++++++++++++++++++++++++++++++++++++++
.. .. include:: ../../includes_resources/includes_resource_template_providers.rst
.. 

Using Templates
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_template/includes_template_requirements.rst

File Specificity
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_template/includes_template_specificity.rst

**Pattern**

.. include:: ../../includes_template/includes_template_specificity_pattern.rst

**Example**

.. include:: ../../includes_template/includes_template_specificity_example.rst

Helpers
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_template_helper.rst

**Inline Methods**

.. include:: ../../step_resource/step_resource_template_inline_method.rst

**Inline Modules**

.. include:: ../../step_resource/step_resource_template_inline_module.rst

**Library Modules**

.. include:: ../../step_resource/step_resource_template_library_module.rst

Host Notation
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_template/includes_template_host_notation.rst

Partial Templates
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_template/includes_template_partials.rst

**render Method**

.. include:: ../../includes_template/includes_template_partials_render_method.rst

Transfer Frequency
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_template/includes_template_transfer_frequency.rst

Variables
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_template/includes_template_variables.rst

Examples
+++++++++++++++++++++++++++++++++++++++++++++++++++++
The following examples demonstrate various approaches for using resources in recipes. If you want to see examples of how Chef uses resources in recipes, take a closer look at the cookbooks that Chef authors and maintains: https://github.com/chef-cookbooks.

**Configure a file from a template**

.. include:: ../../step_resource/step_resource_template_configure_file.rst

**Configure a file from a local template**

.. include:: ../../step_resource/step_resource_template_configure_file_from_local.rst

**Configure a file using a variable map**

.. include:: ../../step_resource/step_resource_template_configure_file_with_variable_map.rst

**Use the not_if condition**

.. include:: ../../step_resource/step_resource_template_add_file_not_if_attribute_has_value.rst

.. include:: ../../step_resource/step_resource_template_add_file_not_if_ruby.rst

.. include:: ../../step_resource/step_resource_template_add_file_not_if_ruby_with_curly_braces.rst

.. include:: ../../step_resource/step_resource_template_add_file_not_if_string.rst

**Use the only_if condition**

.. include:: ../../step_resource/step_resource_template_add_file_only_if_attribute_has_value.rst

.. include:: ../../step_resource/step_resource_template_add_file_only_if_ruby.rst

.. include:: ../../step_resource/step_resource_template_add_file_only_if_string.rst

**Use a whitespace array (%w)**

.. include:: ../../step_resource/step_resource_template_use_whitespace_array.rst

**Use a relative path**

.. include:: ../../step_resource/step_resource_template_use_relative_paths.rst

**Delay notifications**

.. include:: ../../step_resource/step_resource_template_notifies_delay.rst

**Notify immediately**

.. include:: ../../step_resource/step_resource_template_notifies_run_immediately.rst

**Notify multiple resources**

.. include:: ../../step_resource/step_resource_template_notifies_multiple_resources.rst

**Reload a service**

.. include:: ../../step_resource/step_resource_template_notifies_reload_service.rst

**Restart a service when a template is modified**

.. include:: ../../step_resource/step_resource_template_notifies_restart_service_when_template_modified.rst

**Send notifications to multiple resources**

.. include:: ../../step_resource/step_resource_template_notifies_send_notifications_to_multiple_resources.rst

**Execute a command using a template**

.. include:: ../../step_resource/step_resource_execute_command_from_template.rst

**Set an IP address using variables and a template**

.. include:: ../../step_resource/step_resource_template_set_ip_address_with_variables_and_template.rst

**Add a rule to an IP table**

.. include:: ../../step_resource/step_resource_execute_add_rule_to_iptable.rst

**Apply proxy settings consistently across a Chef organization**

.. include:: ../../step_resource/step_resource_template_consistent_proxy_settings.rst

**Get template settings from a local file**

.. include:: ../../step_resource/step_resource_template_get_settings_from_local_file.rst

**Pass values from recipe to template**

.. include:: ../../step_resource/step_resource_template_pass_values_to_template_from_recipe.rst




user
-----------------------------------------------------
.. include:: ../../includes_resources/includes_resource_user.rst

Syntax
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_user_syntax.rst

Actions
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_user_actions.rst

Properties
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_user_attributes.rst

Password Shadow Hash
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_user_password_shadow_hash.rst

Providers
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_user_providers.rst

Examples
+++++++++++++++++++++++++++++++++++++++++++++++++++++
The following examples demonstrate various approaches for using resources in recipes. If you want to see examples of how Chef uses resources in recipes, take a closer look at the cookbooks that Chef authors and maintains: https://github.com/chef-cookbooks.

**Create a user named "random"**

.. include:: ../../step_resource/step_resource_user_create_random.rst

**Create a system user**

.. include:: ../../step_resource/step_resource_user_create_system.rst

**Create a system user with a variable**

.. include:: ../../step_resource/step_resource_user_create_system_user_with_variable.rst


windows_package
-----------------------------------------------------
.. include:: ../../includes_resources/includes_resource_package_windows.rst

.. note:: .. include:: ../../includes_notes/includes_notes_resource_based_on_package.rst

Syntax
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_package_windows_syntax.rst

Actions
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_package_windows_actions.rst

Properties
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_package_windows_attributes.rst

Providers
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_package_windows_providers.rst

Examples
+++++++++++++++++++++++++++++++++++++++++++++++++++++
The following examples demonstrate various approaches for using resources in recipes. If you want to see examples of how Chef uses resources in recipes, take a closer look at the cookbooks that Chef authors and maintains: https://github.com/chef-cookbooks.

**Install a package**

.. include:: ../../step_resource/step_resource_windows_package_install.rst



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
.. include:: ../../includes_resources/includes_resource_service_windows_attributes.rst

.. 
.. Providers
.. +++++++++++++++++++++++++++++++++++++++++++++++++++++
.. .. include:: ../../includes_resources/includes_resource_service_windows_providers.rst
.. 

Examples
+++++++++++++++++++++++++++++++++++++++++++++++++++++
The following examples demonstrate various approaches for using resources in recipes. If you want to see examples of how Chef uses resources in recipes, take a closer look at the cookbooks that Chef authors and maintains: https://github.com/chef-cookbooks.

**Start a service manually**

.. include:: ../../step_resource/step_resource_service_windows_manual_start.rst


yum_package
-----------------------------------------------------
.. include:: ../../includes_resources/includes_resource_package_yum.rst

.. note:: .. include:: ../../includes_notes/includes_notes_yum_resource_using_file_names.rst

.. note:: .. include:: ../../includes_notes/includes_notes_resource_based_on_package.rst

Syntax
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_package_yum_syntax.rst

Actions
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_package_yum_actions.rst

Properties
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_package_yum_attributes.rst

Providers
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_package_yum_providers.rst

Examples
+++++++++++++++++++++++++++++++++++++++++++++++++++++
The following examples demonstrate various approaches for using resources in recipes. If you want to see examples of how Chef uses resources in recipes, take a closer look at the cookbooks that Chef authors and maintains: https://github.com/chef-cookbooks.

**Install an exact version**

.. include:: ../../step_resource/step_resource_yum_package_install_exact_version.rst

**Install a minimum version**

.. include:: ../../step_resource/step_resource_yum_package_install_minimum_version.rst

**Install a minimum version using the default action**

.. include:: ../../step_resource/step_resource_yum_package_install_package_using_default_action.rst

**To install a package**

.. include:: ../../step_resource/step_resource_yum_package_install_package.rst

**To install a partial minimum version**

.. include:: ../../step_resource/step_resource_yum_package_install_partial_minimum_version.rst

**To install a specific architecture**

.. include:: ../../step_resource/step_resource_yum_package_install_specific_architecture.rst

**To install a specific version-release**

.. include:: ../../step_resource/step_resource_yum_package_install_specific_version_release.rst

**To install a specific version (even when older than the current)**

.. include:: ../../step_resource/step_resource_yum_package_install_specific_version.rst

**Handle cookbook_file and yum_package resources in the same recipe**

.. include:: ../../step_resource/step_resource_yum_package_handle_cookbook_file_and_yum_package.rst


yum_repository
-----------------------------------------------------

Use the **yum_repository** resource to manage a Yum repository configuration file located at ``/etc/yum.repos.d/repositoryid.repo`` on the local machine. This configuration file specifies which repositories to reference, how to handle cached data, etc.

New in Chef client 12.14.

Syntax
+++++++++++++++++++++++++++++++++++++++++++++++++++++
A **yum_repository** resource creates a Yum repository configuration file to make individual Yum repositories available for use. The **yum_repository** resource can be as simple as the following:

.. code-block:: ruby

   yum_repository 'zenoss' do
     description "Zenoss Stable repo"
     baseurl "http://dev.zenoss.com/yum/stable/"
     gpgkey 'http://dev.zenoss.com/yum/RPM-GPG-KEY-zenoss'
     action :create
   end

where 

* ``'baseurl'`` is the URL to the directory where the Yum repository's 'repodata' directory lives
* ``'gpgkey'`` is the GPG key for the repository

The full syntax for all of the properties that are available to the **yum_repository** resource is:

.. code-block:: ruby

   yum_repository 'name' do
      baseurl                 String
      cost                    String
      clean_headers           TrueClass, FalseClass 
      clean_metadata          TrueClass, FalseClass 
      description             String 
      enabled                 TrueClass, FalseClass
      enablegroups            TrueClass, FalseClass
      exclude                 String
      failovermethod          String
      fastestmirror_enabled   TrueClass, FalseClass
      gpgcheck                TrueClass, FalseClass
      gpgkey                  String, Array 
      http_caching            String 
      include_config          String 
      includepkgs             String 
      keepalive               TrueClass, FalseClass 
      make_cache              TrueClass, FalseClass 
      max_retries             String, Integer 
      metadata_expire         String 
      mirrorexpire            String 
      mirrorlist              String 
      mirror_expire           String 
      mirrorlist_expire       String
      options                 Hash 
      priority                String 
      proxy                   String 
      proxy_username          String 
      proxy_password          String 
      username                String 
      password                String 
      repo_gpgcheck           TrueClass, FalseClass 
      report_instanceid       TrueClass, FalseClass 
      repositoryid            String 
      sensitive               TrueClass, FalseClass 
      skip_if_unavailable     TrueClass, FalseClass 
      source                  String 
      sslcacert               String 
      sslclientcert           String 
      sslclientkey            String 
      sslverify               TrueClass, FalseClass 
      timeout                 String 
      action                  Symbol # default is :create if not specified
   end

where 

* ``yum_repository`` is the resource 
* ``name`` is the name of the resource block
* ``:action`` identifies which steps the chef-client will take to bring the node into the desired state
*  ``baseurl``, ``cost``, ``clean_headers``, ``clean_metadata``, ``description``, ``enabled``, ``enablegroups``, ``exclude``, ``failovermethod``, ``fastestmirror_enabled``, ``gpgcheck``, ``gpgkey``, ``http_caching``, ``include_config``, ``includepkgs``, ``keepalive``, ``make_cache``, ``max_retries``, ``metadata_expire``, ``mirrorexpire``, ``mirrorlist``, ``mirror_expire``, ``mirrorlist_expire``, ``options``, ``priority``, ``proxy``, ``proxy_username``, ``proxy_password``, ``username``, ``password``, ``repo_gpgcheck``, ``report_instanceid``, ``repositoryid``, ``sensitive``, ``skip_if_unavailable``, ``source``, ``sslcacert``, ``sslclientcert``, ``sslclientkey``, ``sslverify``, ``timeout`` are properties of this resource, with the Ruby type shown. See "Properties" section below for more information about all of the properties that may be used with this resource.

Actions
+++++++++++++++++++++++++++++++++++++++++++++++++++++
This resource has the following actions:

:add
   Alias for ``:create``. 
   
   .. note:: This action will be deprecated in the future.

:create
   Creates a repository file and builds the repository listing.

:delete
   Deletes the repository file.

:makecache
   Updates the yum cache.

:remove
   Alias for ``delete``. 

   .. note:: This action will be deprecated in the future.

Properties
+++++++++++++++++++++++++++++++++++++++++++++++++++++
This resource has the following properties:

.. Refer to http://linux.die.net/man/5/yum.conf as the source for these descriptions.
   
baseurl
   **Ruby Type:** String

   URL to the directory where the Yum repository's 'repodata' directory lives. Can be an http://, https:// or ftp:// URL. You can specify multiple URLs in one baseurl statement.

cost
   **Ruby Type:** String

   Relative cost of accessing this repository. Useful for weighing one repo's packages as greater/less than any other. Default is '1000'. 

clean_headers
   **Ruby Type:** TrueClass, FalseClass

   Specifies whether you want to purge the package data files that are downloaded from a Yum repository and held in a cache directory.  Default is ``false``. (Deprecated) 

clean_metadata
   **Ruby Type:** TrueClass, FalseClass

   Specifies whether you want to purge all of the packages downloaded from a Yum repository and held in a cache directory. Default is ``true``.
   
description
   **Ruby Type:** String

   Descriptive name for the repository channel and maps to the 'name' parameter in a repository .conf. This value must be specified.

enabled
   **Ruby Type:** TrueClass, FalseClass

   Specifies whether or not Yum should use this repository. 

enablegroups
   **Ruby Type:** TrueClass, FalseClass

   Specifies whether Yum will allow the use of package groups for this repository. Default is ``true``.  

exclude
   **Ruby Type:** String

   List of packages to exclude from updates or installs. This should be a space separated list. Shell globs using wildcards (eg. * and ?) are allowed.

failovermethod
   **Ruby Type:** String

   Method to determine how to switch to a new server if the current one fails, which can either be ``roundrobin`` or ``priority``. ``roundrobin`` randomly selects a URL out of the list of URLs to start with and proceeds through each of them as it encounters a failure contacting the host. ``priority`` starts from the first ``baseurl`` listed and reads through them sequentially.

fastestmirror_enabled
   **Ruby Type:** TrueClass, FalseClass

   Specifies whether to use the fastest mirror from a repository configuration when more than one mirror is listed in that configuration.

gpgcheck
   **Ruby Type:** TrueClass, FalseClass

   Specifies whether or not Yum should perform a GPG signature check on the packages received from a repository. Default is ``true`` in Chef client 12.15.

gpgkey
   **Ruby Type:** String, Array

   URL pointing to the ASCII-armored GPG key file for the repository. This is used if Yum needs a public key to verify a package and the required key hasn't been imported into the RPM database. If this option is set, Yum will automatically import the key from the specified URL. 

   Multiple URLs may be specified in the same manner as the baseurl option. If a GPG key is required to install a package from a repository, all keys specified for that repository will be installed.

http_caching
   **Ruby Type:** String

   Determines how upstream HTTP caches are instructed to handle any HTTP downloads that Yum does. This option can take the following values:

   * ``all`` means that all HTTP downloads should be cached.

   * ``packages`` means that only RPM package downloads should be cached, but not repository metadata downloads.

   * ``none`` means that no HTTP downloads should be cached.

   The default is ``all``. This is recommended unless you are experiencing caching related issues.

include_config
   **Ruby Type:** String

   An external configuration file using the format ``url://to/some/location``.

includepkgs
   **Ruby Type:** String

   Inverse of exclude property. This is a list of packages you want to use from a repository. If this option lists only one package then that is all Yum will ever see from the repository. Default is an empty list.

keepalive
   **Ruby Type:** TrueClass, FalseClass

   Determines whether or not HTTP/1.1 ``keep-alive`` should be used with this repository. 

make_cache
   **Ruby Type:** TrueClass, FalseClass

   Determines whether package files downloaded by Yum stay in cache directories. By using cached data, you can carry out certain operations without a network connection. Default is ``true``.

max_retries
   **Ruby Type:** String, Integer

   Number of times any attempt to retrieve a file should retry before returning an error. Setting this to '0' makes Yum try forever. Default is '10'.

metadata_expire
   **Ruby Type:** String

   Time (in seconds) after which the metadata will expire. If the current metadata downloaded is less than the value specified, then Yum will not update the metadata against the repository. If you find that Yum is not downloading information on updates as often as you would like lower the value of this option. You can also change from the default of using seconds to using days, hours or minutes by appending a 'd', 'h' or 'm' respectively. The default is six hours to compliment yum-updates running once per hour. It is also possible to use the word ``never``, meaning that the metadata will never expire.

   .. note:: When using a metalink file, the metalink must always be newer than the metadata for the repository due to the validation, so this timeout also applies to the metalink file.

mirrorexpire
   **Ruby Type:** String


mirrorlist
   **Ruby Type:** String

   URL to a file containing a list of baseurls. This can be used instead of or with the baseurl option. Substitution variables, described below, can be used with this option.

mirror_expire
   **Ruby Type:** String

   Time (in seconds) after which the mirrorlist locally cached will expire. If the current mirrorlist is less than this many seconds old then Yum will not download another copy of the mirrorlist, it has the same extra format as metadata_expire. If you find that Yum is not downloading the mirrorlists as often as you would like lower the value of this option.

mirrorlist_expire
   **Ruby Type:** String

   Specifies the time (in seconds) after which the mirrorlist locally cached will expire. If the current mirrorlist is less than the value specified, then Yum will not download another copy of the mirrorlist.

mode
   **Ruby Type:** String, Array

   Permissions mode of .repo file on disk. This is useful for scenarios where secrets are in the repo file. If this value is set to '600', normal users will not be able to use Yum search, Yum info, etc. Default is ``0644``. 

options
   **Ruby Type:** Hash

   Specifies the repository options.

priority
   **Ruby Type:** String

   Assigns a priority to a repository where the priority value is between '1' and '99' inclusive. Priorities are used to enforce ordered protection of repositories. Packages from repositories with a lower priority (higher numerical value) will never be used to upgrade packages that were installed from a repository with a higher priority (lower numerical value). The repositories with the lowest numerical priority number have the highest priority. The default priority for repositories is 99.

proxy
   **Ruby Type:** String

   URL to the proxy server that Yum should use.

proxy_username
   **Ruby Type:** String

   Username to use for proxy.

proxy_password
   **Ruby Type:** String

   Password for this proxy.

username
   **Ruby Type:** String

   Username to use for basic authentication to a repository.

password
   **Ruby Type:** String

   Password to use with the username for basic authentication.

repo_gpgcheck
   **Ruby Type:** TrueClass, FalseClass

  Determines whether or not Yum should perform a GPG signature check on the repodata from this repository.

report_instanceid
   **Ruby Type:** TrueClass, FalseClass

   Determines whether to report the instance ID when using Amazon Linux AMIs and repositories.

repositoryid
   **Ruby Type:** TrueClass, FalseClass

   Specifies a unique name for each repository, one word. Defaults to name attribute.

sensitive
   **Ruby Type:** TrueClass, FalseClass

   Determines whether the content of repository file is hidden from chef run output. Default is ``false``. 

skip_if_unavailable
   **Ruby Type:** TrueClass, FalseClass

   Determines whether Yum will continue running if this repository cannot be contacted for any reason. This should be set carefully as all repos are consulted for any given command. Default is ``false``.

source
   **Ruby Type:** String

   Use a custom template source instead of the default one.

sslcacert
   **Ruby Type:** String

   Path to the directory containing the databases of the certificate authorities Yum should use to verify SSL certificates. Defaults to 'none', which uses the system default.

sslclientcert
   **Ruby Type:** String

   Path to the SSL client certificate Yum should use to connect to repos/remote sites. Defaults to 'none'.

sslclientkey
   **Ruby Type:** String

   Path to the SSL client key Yum should use to connect to repos/remote sites. Defaults to 'none'.

sslverify
   **Ruby Type:** TrueClass, FalseClass

   Determines whether Yum will verify SSL certificates/hosts. Defaults to ``true``.

timeout
   **Ruby Type:** String

   Number of seconds to wait for a connection before timing out. Defaults to 30 seconds. This may be too short of a time for extremely overloaded sites.

Examples
+++++++++++++++++++++++++++++++++++++++++++++++++++++
The following examples demonstrate various approaches for using resources in recipes. If you want to see examples of how Chef uses resources in recipes, take a closer look at the cookbooks that Chef authors and maintains: https://github.com/chef-cookbooks.

**Add internal company repository**

.. code-block:: ruby

   yum_repository 'OurCo' do
     description 'OurCo yum repository'
     mirrorlist 'http://artifacts.ourco.org/mirrorlist?repo=ourco-6&arch=$basearch'
     gpgkey 'http://artifacts.ourco.org/pub/yum/RPM-GPG-KEY-OURCO-6'
     action :create
   end

**Delete a repository**

.. code-block:: ruby

   yum_repository 'CentOS-Media' do
     action :delete
   end
