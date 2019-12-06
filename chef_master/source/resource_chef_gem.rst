=====================================================
chef_gem resource
=====================================================
`[edit on GitHub] <https://github.com/chef/chef-web-docs/blob/master/chef_master/source/resource_chef_gem.rst>`__

.. warning:: .. tag notes_chef_gem_vs_gem_package

             The **chef_gem** and **gem_package** resources are both used to install Ruby gems. For any machine on which Chef Infra Client is installed, there are two instances of Ruby. One is the standard, system-wide instance of Ruby and the other is a dedicated instance that is available only to Chef Infra Client. Use the **chef_gem** resource to install gems into the instance of Ruby that is dedicated to Chef Infra Client. Use the **gem_package** resource to install all other gems (i.e. install gems system-wide).

             .. end_tag

.. tag resource_package_chef_gem

Use the **chef_gem** resource to install a gem only for the instance of Ruby that is dedicated to Chef Infra Client. When a gem is installed from a local file, it must be added to the node using the **remote_file** or **cookbook_file** resources.

The **chef_gem** resource works with all of the same properties and options as the **gem_package** resource, but does not accept the ``gem_binary`` property because it always uses the ``CurrentGemEnvironment`` under which Chef Infra Client is running. In addition to performing actions similar to the **gem_package** resource, the **chef_gem** resource does the following:

* Runs its actions immediately, before convergence, allowing a gem to be used in a recipe immediately after it is installed
* Runs ``Gem.clear_paths`` after the action, ensuring that gem is aware of changes so that it can be required immediately after it is installed

.. end_tag

Syntax
=====================================================
A **chef_gem** resource block manages a package on a node, typically by installing it. The simplest use of the **chef_gem** resource is:

.. code-block:: ruby

   chef_gem 'package_name'

which will install the named gem using all of the default options and the default action (``:install``).

The full syntax for all of the properties that are available to the **chef_gem** resource is:

.. code-block:: ruby

   chef_gem 'name' do
     clear_sources              true, false
     compile_time               true, false
     gem_binary                 String
     include_default_source     true, false
     options                    String
     package_name               String
     source                     String, Array
     timeout                    String, Integer
     version                    String
     action                     Symbol # defaults to :install if not specified
   end

where:

* ``chef_gem`` is the resource.
* ``name`` is the name given to the resource block.
* ``action`` identifies which steps Chef Infra Client will take to bring the node into the desired state.
* ``clear_sources``, ``compile_time``, ``gem_binary``, ``include_default_source``, ``options``, ``package_name``, ``source``, ``timeout``, and ``version`` are the properties available to this resource.

Actions
=====================================================

The chef_gem resource has the following actions:

``:install``
   Default. Install a gem. If a version is specified, install the specified version of the gem.

``:nothing``
   .. tag resources_common_actions_nothing

   This resource block does not act unless notified by another resource to take action. Once notified, this resource block either runs immediately or is queued up to run at the end of a Chef Infra Client run.

   .. end_tag

``:purge``
   Purge a gem. This action typically removes the configuration files as well as the gem.

``:reconfig``
   Reconfigure a gem. This action requires a response file.

``:remove``
   Remove a gem.

``:upgrade``
   Install a gem and/or ensure that a gem is the latest version.

Properties
=====================================================

The chef_gem resource has the following properties:

``clear_sources``
   **Ruby Type:** true, false | **Default Value:** ``false``

   Set to ``true`` to download a gem from the path specified by the ``source`` property (and not from RubyGems).

   .. note:: Another approach is to use the **gem_package** resource, and then specify the ``gem_binary`` location to the RubyGems directory that is used by Chef. For example:

             .. code-block:: ruby

                gem_package 'gem_name' do
                  gem_binary Chef::Util::PathHelper.join(Chef::Config.embedded_dir,'bin','gem')
                  action :install
                end

``compile_time``
   **Ruby Type:** true, false | **Default Value:** ``false``

   Controls the phase during which a gem is installed on a node. Set to ``true`` to install a gem while the resource collection is being built (the "compile phase"). Set to ``false`` to install a gem while Chef Infra Client is configuring the node (the "converge phase"). Possible values: ``nil`` (for verbose warnings), ``true`` (to warn once per chef-client run), or ``false`` (to remove all warnings). Recommended value: ``false``.

``gem_binary``
   **Ruby Type:** String | **Default Value:** ``Chef's built-in gem binary``

   The path of a gem binary to use for the installation. By default, the same version of Ruby that is used by Chef Infra Client will be installed.

``include_default_source``
   **Ruby Type:** true, false | **Default Value:** ``true``

   Set to ``false`` to not include ``Chef::Config[:rubygems_url]`` in the sources.

   *New in Chef Client 13.0.*

``options``
   **Ruby Type:** String, Hash, Array,

   Options for the gem install, either a Hash or a String. When a hash is given, the options are passed to Gem::DependencyInstaller.new, and the gem will be installed via the gems API. When a String is given, the gem will be installed by shelling out to the gem command. Using a Hash of options with an explicit gem_binary will result in undefined behavior.

``package_name``
   **Ruby Type:** String

   An optional property to set the gem name if it differs from the resource block's name.

``source``
   **Ruby Type:** String, Array

   Optional. The URL, or list of URLs, at which the gem package is located. This list is added to the source configured in ``Chef::Config[:rubygems_url]`` (see also include_default_source) to construct the complete list of rubygems sources. Users in an 'airgapped' environment should set ``Chef::Config[:rubygems_url]`` to their local RubyGems mirror.

``timeout``
   **Ruby Type:** String, Integer

   The amount of time (in seconds) to wait before timing out.

``version``
   **Ruby Type:** String

   The version of a gem to be installed or upgraded.

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

  Ensure that sensitive resource data is not logged by Chef Infra Client.

.. end_tag

Notifications
-----------------------------------------------------
``notifies``
  **Ruby Type:** Symbol, 'Chef::Resource[String]'

  .. tag resources_common_notification_notifies

  A resource may notify another resource to take action when its state changes. Specify a ``'resource[name]'``, the ``:action`` that resource should take, and then the ``:timer`` for that action. A resource may notify more than one resource; use a ``notifies`` statement for each resource to be notified.

  .. end_tag

.. tag resources_common_notification_timers

A timer specifies the point during a Chef Infra Client run at which a notification is run. The following timers are available:

``:before``
   Specifies that the action on a notified resource should be run before processing the resource block in which the notification is located.

``:delayed``
   Default. Specifies that a notification should be queued up, and then executed at the end of a Chef Infra Client run.

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

A timer specifies the point during a Chef Infra Client run at which a notification is run. The following timers are available:

``:before``
   Specifies that the action on a notified resource should be run before processing the resource block in which the notification is located.

``:delayed``
   Default. Specifies that a notification should be queued up, and then executed at the end of a Chef Infra Client run.

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

A guard property can be used to evaluate the state of a node during the execution phase of a Chef Infra Client run. Based on the results of this evaluation, a guard property is then used to tell Chef Infra Client if it should continue executing a resource. A guard property accepts either a string value or a Ruby block value:

* A string is executed as a shell command. If the command returns ``0``, the guard is applied. If the command returns any other value, then the guard property is not applied. String guards in a **powershell_script** run Windows PowerShell commands and may return ``true`` in addition to ``0``.
* A block is executed as Ruby code that must return either ``true`` or ``false``. If the block returns ``true``, the guard property is applied. If the block returns ``false``, the guard property is not applied.

A guard property is useful for ensuring that a resource is idempotent by allowing that resource to test for the desired state as it is being executed, and then if the desired state is present, for Chef Infra Client to do nothing.

.. end_tag

**Properties**

.. tag resources_common_guards_properties

The following properties can be used to define a guard that is evaluated during the execution phase of a Chef Infra Client run:

``not_if``
  Prevent a resource from executing when the condition returns ``true``.

``only_if``
  Allow a resource to execute only if the condition returns ``true``.

.. end_tag

Examples
=====================================================

The following examples demonstrate various approaches for using resources in recipes:

**Compile time vs. converge time installation of gems**

.. tag resource_chef_gem_install_for_use_in_recipes

.. To install a gems file for use in a recipe:

To install a gem while Chef Infra Client is configuring the node (the “converge phase”), set the ``compile_time`` property to ``false``:

.. code-block:: ruby

   chef_gem 'right_aws' do
     compile_time false
     action :install
   end

To install a gem while the resource collection is being built (the “compile phase”), set the ``compile_time`` property to ``true``:

.. code-block:: ruby

   chef_gem 'right_aws' do
     compile_time true
     action :install
   end

.. end_tag

**Install MySQL for Chef**

.. tag resource_chef_gem_install_mysql

.. To install MySQL:

.. code-block:: ruby

   apt_update

   build_essential 'install compilation tools' do
     compile_time true
   end

   chef_gem 'mysql'

.. end_tag
