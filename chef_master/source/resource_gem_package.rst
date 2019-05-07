=====================================================
gem_package resource
=====================================================
`[edit on GitHub] <https://github.com/chef/chef-web-docs/blob/master/chef_master/source/resource_gem_package.rst>`__

.. warning:: .. tag notes_chef_gem_vs_gem_package

             The **chef_gem** and **gem_package** resources are both used to install Ruby gems. For any machine on which the chef-client is installed, there are two instances of Ruby. One is the standard, system-wide instance of Ruby and the other is a dedicated instance that is available only to the chef-client. Use the **chef_gem** resource to install gems into the instance of Ruby that is dedicated to the chef-client. Use the **gem_package** resource to install all other gems (i.e. install gems system-wide).

             .. end_tag

.. tag resource_package_gem

Use the **gem_package** resource to manage gem packages that are only included in recipes. When a package is installed from a local file, it must be added to the node using the **remote_file** or **cookbook_file** resources.

.. end_tag

.. note:: .. tag notes_resource_gem_package

          The **gem_package** resource must be specified as ``gem_package`` and cannot be shortened to ``package`` in a recipe.

          .. end_tag

Syntax
=====================================================
A **gem_package** resource block manages a package on a node, typically by installing it. The simplest use of the **gem_package** resource is:

.. code-block:: ruby

   gem_package 'package_name'

which will install the named package using all of the default options and the default action (``:install``).

The full syntax for all of the properties that are available to the **gem_package** resource is:

.. code-block:: ruby

   gem_package 'name' do
     clear_sources              true, false
     gem_binary                 String
     include_default_source     true, false
     options                    String
     package_name               String, Array # defaults to 'name' if not specified
     source                     String, Array
     timeout                    String, Integer
     version                    String, Array
     action                     Symbol # defaults to :install if not specified
   end

where:

* ``gem_package`` is the resource.
* ``name`` is the name given to the resource block.
* ``action`` identifies which steps the chef-client will take to bring the node into the desired state.
* ``clear_sources``, ``gem_binary``, ``include_default_source``, ``options``, ``package_name``, ``source``, ``timeout``, and ``version`` are the properties available to this resource.

Gem Package Options
=====================================================
.. tag resource_package_options

The RubyGems package provider attempts to use the RubyGems API to install gems without spawning a new process, whenever possible. A gems command to install will be spawned under the following conditions:

* When a ``gem_binary`` property is specified (as a hash, a string, or by a .gemrc file), the chef-client will run that command to examine its environment settings and then again to install the gem.
* When install options are specified as a string, the chef-client will span a gems command with those options when installing the gem.
* The Chef installer will search the ``PATH`` for a gem command rather than defaulting to the current gem environment. As part of ``enforce_path_sanity``, the ``bin`` directories area added to the ``PATH``, which means when there are no other proceeding RubyGems, the installation will still be operated against it.

.. end_tag

Specify with Hash
-----------------------------------------------------

.. tag resource_package_options_hash

If an explicit ``gem_binary`` parameter is not being used with the ``gem_package`` resource, it is preferable to provide the install options as a hash. This approach allows the provider to install the gem without needing to spawn an external gem process.

The following RubyGems options are available for inclusion within a hash and are passed to the RubyGems DependencyInstaller:

* ``:env_shebang``
* ``:force``
* ``:format_executable``
* ``:ignore_dependencies``
* ``:prerelease``
* ``:security_policy``
* ``:wrappers``

For more information about these options, see the RubyGems documentation: http://rubygems.rubyforge.org/rubygems-update/Gem/DependencyInstaller.html.

.. end_tag

**Example**

.. tag resource_package_install_gem_with_hash_options

.. To install a gem with a |hash| of options:

.. code-block:: ruby

   gem_package 'bundler' do
     options(:prerelease => true, :format_executable => false)
   end

.. end_tag

Specify with String
-----------------------------------------------------

.. tag resource_package_options_string

When using an explicit ``gem_binary``, options must be passed as a string. When not using an explicit ``gem_binary``, the chef-client is forced to spawn a gems process to install the gems (which uses more system resources) when options are passed as a string. String options are passed verbatim to the gems command and should be specified just as if they were passed on a command line. For example, ``--prerelease`` for a pre-release gem.

.. end_tag

**Example**

.. tag resource_package_install_gem_with_options_string

.. To install a gem with an options string:

.. code-block:: ruby

   gem_package 'nokogiri' do
     gem_binary('/opt/ree/bin/gem')
     options('--prerelease --no-format-executable')
   end

.. end_tag

Specify with .gemrc File
-----------------------------------------------------

.. tag resource_package_options_gemrc

Options can be specified in a .gemrc file. By default the ``gem_package`` resource will use the Ruby interface to install gems which will ignore the .gemrc file. The ``gem_package`` resource can be forced to use the gems command instead (and to read the .gemrc file) by adding the ``gem_binary`` attribute to a code block.

.. end_tag

**Example**

.. tag resource_package_install_gem_with_gemrc

A template named ``gemrc.erb`` is located in a cookbook's ``/templates`` directory:

.. code-block:: ruby

   :sources:
   - http://<%= node['gem_file']['host'] %>:<%= node['gem_file']['port'] %>/

A recipe can be built that does the following:

* Builds a ``.gemrc`` file based on a ``gemrc.erb`` template
* Runs a ``Gem.configuration`` command
* Installs a package using the ``.gemrc`` file

.. code-block:: ruby

   template '/root/.gemrc' do
     source 'gemrc.erb'
     action :create
     notifies :run, 'ruby_block[refresh_gemrc]', :immediately
   end

   ruby_block 'refresh_gemrc' do
     action :nothing
     block do
       Gem.configuration = Gem::ConfigFile.new []
     end
   end

   gem_package 'di-ruby-lvm' do
     gem_binary '/opt/chef/embedded/bin/gem'
     action :install
   end

.. end_tag

Actions
=====================================================

The gem_package resource has the following actions:

``:install``
   Default. Install a package. If a version is specified, install the specified version of the package.

``:nothing``
   .. tag resources_common_actions_nothing

   This resource block does not act unless notified by another resource to take action. Once notified, this resource block either runs immediately or is queued up to run at the end of the Chef Client run.

   .. end_tag

``:purge``
   Purge a package. This action typically removes the configuration files as well as the package.

``:reconfig``
   Reconfigure a package. This action requires a response file.

``:remove``
   Remove a package.

``:upgrade``
   Install a package and/or ensure that a package is the latest version.

Properties
=====================================================

The gem_package resource has the following properties:

``clear_sources``
   **Ruby Type:** true, false | **Default Value:** ``false``

   Set to ``true`` to download a gem from the path specified by the ``source`` property (and not from RubyGems).

``include_default_source``
   **Ruby Type:** true, false | **Default Value:** ``true``

   Set to ``false`` to not include ``Chef::Config[:rubygems_url]`` in the sources.

   *New in Chef Client 13.0.*

``gem_binary``
   **Ruby Type:** String

   A property for the ``gem_package`` provider that is used to specify a gems binary. By default, the same version of Ruby that is used by the chef-client will be installed.


``include_default_source``
   **Ruby Type:** true, false | **Default Value:** ``true``

   Set to 'false' to not include ``Chef::Config[:rubygems_url]`` in the sources.

   *New in Chef Client 13.0.*

``options``
   **Ruby Type:** String

   One (or more) additional options that are passed to the command.

``package_name``
   **Ruby Type:** String, Array

   The name of the package. Default value: the ``name`` of the resource block. See "Syntax" section above for more information.

``source``
   **Ruby Type:** String, Array

   Optional. The URL, or list of URLs, at which the gem package is located. This list is added to the source configured in ``Chef::Config[:rubygems_url]`` (see also ``include_default_source``) to construct the complete list of rubygems sources. Users in an "airgapped" environment should set ``Chef::Config[:rubygems_url]`` to their local RubyGems mirror.

``timeout``
   **Ruby Type:** String, Integer

   The amount of time (in seconds) to wait before timing out.

``version``
   **Ruby Type:** String, Array

   The version of a package to be installed or upgraded.

Common Resource Functionality
=====================================================

Chef resources include common properties, notifications, and resource guards.

Common Properties
-----------------------------------------------------

.. tag resources_common_properties

The following properties are common to every resource:

``ignore_failure``
  **Ruby Type:** true, false | **Default Value:** ``false``

  Continue running a recipe if a resource fails for any reason.

``retries``
  **Ruby Type:** Integer | **Default Value:** ``0``

  The number of attempts to catch exceptions and retry the resource.

``retry_delay``
  **Ruby Type:** Integer | **Default Value:** ``2``

  The retry delay (in seconds).

``sensitive``
  **Ruby Type:** true, false | **Default Value:** ``false``

  Ensure that sensitive resource data is not logged by the chef-client.

.. end_tag

Notifications
-----------------------------------------------------
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

Guards
-----------------------------------------------------

.. tag resources_common_guards

A guard property can be used to evaluate the state of a node during the execution phase of the chef-client run. Based on the results of this evaluation, a guard property is then used to tell the chef-client if it should continue executing a resource. A guard property accepts either a string value or a Ruby block value:

* A string is executed as a shell command. If the command returns ``0``, the guard is applied. If the command returns any other value, then the guard property is not applied. String guards in a **powershell_script** run Windows PowerShell commands and may return ``true`` in addition to ``0``.
* A block is executed as Ruby code that must return either ``true`` or ``false``. If the block returns ``true``, the guard property is applied. If the block returns ``false``, the guard property is not applied.

A guard property is useful for ensuring that a resource is idempotent by allowing that resource to test for the desired state as it is being executed, and then if the desired state is present, for the chef-client to do nothing.

.. end_tag
.. tag resources_common_guards_properties

The following properties can be used to define a guard that is evaluated during the execution phase of the chef-client run:

``not_if``
  Prevent a resource from executing when the condition returns ``true``.

``only_if``
  Allow a resource to execute only if the condition returns ``true``.

.. end_tag

Examples
=====================================================

The following examples demonstrate various approaches for using resources in recipes:

**Install a gems file from the local file system**

.. tag resource_package_install_gems_from_local

.. To install a gem from the local file system:

.. code-block:: ruby

   gem_package 'right_aws' do
     source '/tmp/right_aws-1.11.0.gem'
     action :install
   end

.. end_tag

**Use the ignore_failure common attribute**

.. tag resource_package_use_ignore_failure_attribute

.. To use the ``ignore_failure`` common attribute in a recipe:

.. code-block:: ruby

   gem_package 'syntax' do
     action :install
     ignore_failure true
   end

.. end_tag
