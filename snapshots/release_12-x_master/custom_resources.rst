=====================================================
About Custom Resources
=====================================================

.. note:: A "custom resource" is the new way to refer to any style of custom resources, including lightweight resources (LWRPs), heavyweight resources (HWRPs), definitions, or any other implementation of a custom resource. This change was made in the chef-client 12.5 release, but applied retroactively. A new and improved approach for building custom resources was added in chef-client 12.5 and the term "custom resource" now refers to any method of building a custom resource for releases of Chef prior to 12.5, and then only the new method starting with 12.5.

.. tag lwrp

A LWRP is a part of a cookbook that is used to extend the chef-client in a way that allows custom actions to be defined, and then used in recipes in much the same way as any platform resource. In other words: a LWRP is a custom resource. A custom resource has two principal components:

* A custom resource that defines a set of actions and attributes that is located in a cookbook's ``/resources`` directory
* A custom provider that tells the chef-client how to handle each action, what to do if certain conditions are met, and so on that is located in a cookbook's ``/providers`` directory

A custom provider is typically built in a way that leverages the core resources that are built into Chef, but they may also be built using Ruby.

Once created, a custom resource becomes a Ruby class. During each chef-client run, the chef-client will read the custom resource from a recipe and will process it alongside all other resources. When it is time to configure the node, the chef-client will use the custom provider to determine the steps required to bring the system into the desired state.

.. end_tag

File Locations
=====================================================
.. tag lwrp_custom_file_locations

Custom resources and providers are loaded from files that are saved in the following cookbook sub-directories:

.. list-table::
   :widths: 60 420
   :header-rows: 1

   * - Directory
     - Description
   * - ``providers/``
     - The sub-directory in which custom providers are located.
   * - ``resources/``
     - The sub-directory in which custom resources are located.

.. end_tag

Resource Names
=====================================================
.. tag lwrp_custom_names

The naming patterns of custom resources and providers are determined by the name of the cookbook and by the name of the files in the ``resources/`` and ``providers/`` sub-directories. For example, if a cookbook named ``example`` was downloaded to the chef-repo, it would be located at ``/cookbooks/example/``. If that cookbook contained two resources and two providers, the following files would be part of the ``resources/`` directory:

.. list-table::
   :widths: 120 120 120
   :header-rows: 1

   * - Files
     - Resource Name
     - Generated Class
   * - ``default.rb``
     - example
     - Chef::Resource::Example
   * - ``custom.rb``
     - example_custom
     - Chef::Resource::ExampleCustom

And the following files would be part of the ``providers/`` directory:

.. list-table::
   :widths: 120 120 120
   :header-rows: 1

   * - Files
     - Provider Name
     - Generated Class
   * - ``default.rb``
     - example
     - Chef::Provider::Example
   * - ``custom.rb``
     - example_custom
     - Chef::Provider::ExampleCustom

.. end_tag

Platform vs. Lightweight
=====================================================
.. tag lwrp_custom_compare_to_platform_resource

The following example uses the **file** resource to show the difference between it and what it would look like if it were a custom resource.

.. code-block:: ruby

   require 'chef/resource'

   class Chef
     class Resource
       class File < Chef::Resource

         def initialize(name, collection=nil, node=nil)
           super(name, collection, node)
           @resource_name = :file
           @path = name
           @backup = 5
           @action = 'create'
           @allowed_actions.push(:create, :delete, :touch, :create_if_missing)
         end

         def backup(arg=nil)
           set_or_return(
             :backup,
             arg,
             :kind_of => [ Integer, FalseClass ]
           )
         end

         def checksum(arg=nil)
           set_or_return(
             :checksum,
             arg,
             :regex => /^[a-zA-Z0-9]{64}$/
           )
         end

         def group(arg=nil)
           set_or_return(
             :group,
             arg,
             :regex => [ /^([a-z]|[A-Z]|[0-9]|_|-)+$/, /^\d+$/ ]
           )
         end

         def mode(arg=nil)
           set_or_return(
             :mode,
             arg,
             :regex => /^0?\d{3,4}$/
           )
         end

         def owner(arg=nil)
           set_or_return(
             :owner,
             arg,
             :regex => [ /^([a-z]|[A-Z]|[0-9]|_|-)+$/, /^\d+$/ ]
           )
         end

         def path(arg=nil)
           set_or_return(
             :path,
             arg,
             :kind_of => String
           )
         end

       end
     end
   end

The preceding code is simple, traditional Ruby. A number of getter/setter methods are created and inputs are validated against criteria, like regular expressions, strings, true/false, and so on. The custom resource looks like this:

.. code-block:: ruby

   actions :create, :delete, :touch, :create_if_missing

   attribute :backup,   :kind_of => [ Integer, FalseClass ]
   attribute :group,    :regex => [ /^([a-z]|[A-Z]|[0-9]|_|-)+$/, /^\d+$/ ]
   attribute :mode,     :regex => /^0?\d{3,4}$/
   attribute :owner,    :regex => [ /^([a-z]|[A-Z]|[0-9]|_|-)+$/, /^\d+$/ ]
   attribute :path,     :kind_of => String
   attribute :checksum, :regex => /^[a-zA-Z0-9]{64}$/

What this shows are the similarities and differences between resources and custom resources. The custom resources are easier to write and understand, plus they can offer much the same (if not identical) functionality as the more complex platform resources.

.. end_tag

Chef-maintained
=====================================================
.. tag lwrp_chef_maintained

Chef maintains a collection of cookbooks that define some common scenarios and provides resources to support them. These cookbooks are located at https://github.com/chef-cookbooks. To use these resources within recipes, first download the cookbook. Then add those resources to recipes.

Some of the most popular Chef-maintained cookbooks are listed below:

.. list-table::
   :widths: 150 450
   :header-rows: 1

   * - Cookbook
     - Description
   * - `apt <https://github.com/chef-cookbooks/apt>`_
     - The ``apt`` cookbook is used to configure Apt and Apt services, for managing Apt repositories and preferences.
   * - `aws <https://github.com/chef-cookbooks/aws>`_
     - The ``aws`` cookbook is used to manage resources that are running in Amazon Web Services (AWS).
   * - `bluepill <https://github.com/chef-cookbooks/bluepill>`_
     - The ``bluepill`` cookbook is used to install Blue Pill, and then use it to manage services.
   * - :doc:`chef_handler <resource_chef_handler>`
     - The **chef_handler** cookbook is used to distribute and enable exception and report handlers. This cookbook also exposes the **chef_handler** resource, which allows exception and report handlers to be exposed from within recipes, as opposed to having them hard-coded within the client.rb file.
   * - `cron <https://github.com/chef-cookbooks/cron>`_
     - Use to install cron and start the crond service.
   * - `dmg <https://github.com/chef-cookbooks/dmg>`_
     - The ``dmg`` cookbook is used to create a DMG package for use with Mac OS X.
   * - `dynect <https://github.com/chef-cookbooks/dynect>`_
     - The ``dynect`` cookbook is used to manage DNS records using the DynECT REST API.
   * - `firewall <https://github.com/chef-cookbooks/firewall>`_
     - The ``firewall`` cookbook is used to manage firewalls and their associated firewall rulesets.
   * - `freebsd <https://github.com/chef-cookbooks/freebsd>`_
     - The ``freebsd`` cookbook is used to manage port options for FreeBSD.
   * - `gunicorn <https://github.com/chef-cookbooks/gunicorn>`_
     - Gunicorn is a web service gateway interface server for UNIX that is a pre-fork worker model from the Ruby Unicorn project. The ``gunicorn`` cookbook is used to install and configure Gunicorn.
   * - `homebrew <https://github.com/chef-cookbooks/homebrew>`_
     - The ``homebrew`` cookbook is used to install and configure Homebrew for use as the package manager for Mac OS X.
   * - `iis <https://github.com/chef-cookbooks/iis>`_
     - The ``iis`` cookbook is used to install and configure Internet Information Services (IIS).
   * - `lvm <https://github.com/chef-cookbooks/lvm>`_
     - Use to install the ``lvm2`` package, and then manage logical volume manager (LVM).
   * - `maven <https://github.com/chef-cookbooks/maven>`_
     - The ``maven`` cookbook is used to install and configure Apache Maven.
   * - `openssh <https://github.com/chef-cookbooks/openssh>`_
     - The ``openssh`` cookbook is used to install OpenSSH.
   * - `omnibus <https://github.com/chef-cookbooks/omnibus>`_
     - Use to prepare a machine to be an Omnibus builder.
   * - `php <https://github.com/chef-cookbooks/php>`_
     - The ``php`` cookbook is used to install and configure PHP and PHP modules.
   * - `postfix <https://github.com/chef-cookbooks/postfix>`_
     - Use to install and configure postfix for client or outbound relayhost.
   * - `powershell <https://github.com/chef-cookbooks/powershell>`_
     - Use to run Windows PowerShell. See the :doc:`powershell_script resource <resource_powershell_script>` (built into the chef-client) for more information about improved ways to run Windows PowerShell when using Chef.
   * - `squid <https://github.com/chef-cookbooks/squid>`_
     - Use to configure squid as a caching proxy.
   * - `sudo <https://github.com/chef-cookbooks/sudo>`_
     - The ``sudo`` cookbook is used to install sudo and configure ``/etc/sudoers``.
   * - `transmission <https://github.com/chef-cookbooks/transmission>`_
     - The ``transmission`` cookbook is used to install and configure the Transmission BitTorrent client.
   * - `webpi <https://github.com/chef-cookbooks/webpi>`_
     - The ``webpi`` cookbook is used to run the Microsoft Web Platform Installer (WebPI).
   * - `windows <https://github.com/chef-cookbooks/windows>`_
     - The ``windows`` cookbook is used to configure auto run, batch, reboot, enable built-in operating system packages, configure Microsoft Windows packages, reboot machines, and more.
   * - `yum <https://github.com/chef-cookbooks/yum>`_
     - The ``yum`` cookbook is used to manage the contents of the ``yum.conf`` configuration file for global Yum configurations and for individual Yum repositories.

.. end_tag

Custom Resources
=====================================================

.. tag resources_common

A resource is a statement of configuration policy that:

* Describes the desired state for a configuration item
* Declares the steps needed to bring that item to the desired state
* Specifies a resource type---such as ``package``, ``template``, or ``service`` 
* Lists additional details (also known as resource properties), as necessary
* Are grouped into recipes, which describe working configurations

.. end_tag

.. tag lwrp_custom_resource

A custom resource is a custom resource that defines an action to be completed, which are then processed by a custom provider during the chef-client run. A custom provider and custom resource work together, each being defined in the same cookbook (the ``/providers`` and ``/resources`` subdirectories, respectively); together, they are referred as a LWRP (or "custom resource/provider"). A custom resource is always authored using Ruby. Anything that can be done using Ruby can be done in a custom resource. In addition to using Ruby, the Resource DSL provides additional methods that are specific to the chef-client.

.. end_tag

Syntax
-----------------------------------------------------
.. tag lwrp_custom_resource_syntax

The syntax for a custom resource is as follows:

.. code-block:: ruby

   require 'required_item'

   actions :action_name1, :action_name2, :action_name...
   default_action :action_name1

   attribute :attribute_name, :kind_of => 'value', :name_attribute => true
   attribute :attribute_name, :kind_of => 'value', :validation_parameter => 'value'
   ...
   attribute :attribute_name, :kind_of => 'value', :validation_parameter => 'value'

   attr_accessor :attribute, :attribute

where

* ``require`` lists any external entities that may be required by the custom resources, such as a library; a custom resource is Ruby and anything that can be done in Ruby can be done in a custom resource
* ``:action_name1``, ``:action_name2``, and ``:action_name...`` represents a comma-delimited list of ``actions`` that are available to this custom resource; there must be at least one action
* ``action_name1`` is set to be the ``default_action``
* ``:attribute_name`` is the name of the property; a custom resource may define as many properties as necessary
* ``:kind_of => value`` specifies the Ruby class (or an array of Ruby classes) that are used to define this property's value
* ``:name_attribute`` is associated with one ``attribute`` to indicate which property's value will be defined by the name of the resource as it is defined in the recipe (i.e. the string that appears in front of the ``do`` block in the recipe and after the resource: ``resource_name "name_attribute" do``)
* ``:validation_parameter`` represents a comma-delimited list of validation parameters for each property
* ``attr_accessor`` allows the custom resource to use the ``Module`` Ruby class to check for one (or more) named properties, such as ``:exists`` or ``:running``

For example, the ``cron_d`` custom resource (found in the ``cron`` cookbook) can be used to manage files located in ``/etc/cron.d``:

.. code-block:: ruby

   actions :create, :delete
   default_action :create

   attribute :name, :kind_of => String, :name_attribute => true
   attribute :cookbook, :kind_of => String, :default => 'cron'
   attribute :minute, :kind_of => [Integer, String], :default => '*'
   attribute :hour, :kind_of => [Integer, String], :default => '*'
   attribute :day, :kind_of => [Integer, String], :default => '*'
   attribute :month, :kind_of => [Integer, String], :default => '*'
   attribute :weekday, :kind_of => [Integer, String], :default => '*'
   attribute :command, :kind_of => String, :required => true
   attribute :user, :kind_of => String, :default => 'root'
   attribute :mailto, :kind_of => [String, NilClass]
   attribute :path, :kind_of => [String, NilClass]
   attribute :home, :kind_of => [String, NilClass]
   attribute :shell, :kind_of => [String, NilClass]

where

* the ``actions`` allow a recipe to manage entries in a crontab file (create entry, delete entry)
* ``:create`` is the default action
* ``:minute``, ``:hour``, ``:day``, ``:month``, and ``:weekday`` are the collection of properties used to schedule a cron job, assigned a default value of ``'*'``
* ``:command`` is the command that will be run (and also required)
* ``:user`` is the user by which the command is run
* ``:mailto``, ``:path``, ``:home``, and ``:shell`` are optional environment variables that do not have default value, which each being defined as an array that supports the ``String`` and ``NilClass`` Ruby classes

.. end_tag

Resource DSL Methods
-----------------------------------------------------
.. tag dsl_resource

The Resource DSL is a Ruby DSL that is used to help define a lightweight resource and to ensure that a lightweight resource provides the correct information to a lightweight provider. The Resource DSL is a small DSL with just three methods. Because the Resource DSL is a Ruby DSL, anything that can be done using Ruby can also be done as part of defining a lightweight resource.

.. end_tag

actions
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. tag dsl_resource_method_action

The ``actions`` method is used to define a list of actions that are available to be used in a recipe. Each action must have a corresponding section in a lightweight provider that tells the chef-client what to do when this action is specified in a recipe. The syntax for the ``actions`` method is as follows:

.. code-block:: ruby

   actions :action_name, :action_name

where ``actions`` is a comma-delimited list of individual actions.

.. end_tag

attribute
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. tag dsl_resource_method_attribute

The ``attribute`` method is used to define a list of properties and any of those property's associated validation parameters. The syntax for the ``attribute`` method is as follows:

.. code-block:: ruby

   attribute :property_name :validation_parameter => value, :validation_parameter => value

where ``attribute`` must have an property name and zero (or more) validation parameters.

.. end_tag

attr_accessor
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. tag dsl_resource_method_attr_accessor

The ``attr_accessor`` method is used to define custom properties for a lightweight resource that can be accessed by a lightweight provider. The syntax for the ``attr_accessor`` method is as follows:

.. code-block:: ruby

   attr_accessor :accessor_name, :accessor_name

where ``accessor_name`` is a comma-delimited list of custom properties.

.. end_tag

default_action
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. tag dsl_resource_method_default_action

The ``default_action`` method is used to set the default action for a lightweight resource. The syntax for the ``default_action`` method is as follows:

.. code-block:: ruby

   default_action :action_name

where ``action_name`` is the default action.

.. end_tag

provides
+++++++++++++++++++++++++++++++++++++++++++++++++++++
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

state_attrs
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. tag dsl_resource_method_state_attrs

The ``state_attrs`` method is used to define the properties that will be tracked by the Reporting server. In general, this should be a list of properties that describe the desired state of the system, such as file permissions, cloud provider data (like snapshots, volumes, identifiers, sizes, and access keys), and so on.

The syntax for the ``state_attrs`` method is as follows:

.. code-block:: ruby

   state_attrs :property, 
               :property, 
               :property

where ``:property`` is a comma-delimited list of properties. For example, the ``ebs_volume`` resource (available from the `aws <https://github.com/chef-cookbooks/aws>`_ cookbook) uses the ``state_attrs`` method to tell the Reporting server to track the following properties:

.. code-block:: ruby

   state_attrs :availability_zone,
               :aws_access_key,
               :description,
               :device,
               :most_recent_snapshot,
               :piops,
               :size,
               :snapshot_id,
               :snapshots_to_keep,
               :timeout,
               :volume_id,
               :volume_type

.. end_tag

Validation Parameters
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. tag dsl_resource_method_attribute_validation_parameter

A validation parameter is used to add zero (or more) validation parameters to an property.

.. list-table::
   :widths: 150 450
   :header-rows: 1

   * - Parameter
     - Description
   * - ``:callbacks``
     - Use to define a collection of unique keys and values (a Hash) for which the key is the error message and the value is a lambda to validate the parameter. For example: ``"Option #{key}'s value #{value} #{message}!"``, which will insert a key into an error message if the Proc object does not return true. For example:

       .. code-block:: ruby

          :callbacks => {
		    'should be a valid non-system port' => lambda { 
		      |p| p > 1024 && p < 65535 
		      }
		    }

   * - ``:default``
     - Use to specify the default value for an property. For example:

       .. code-block:: ruby

          :default => 'a_string_value'

       .. code-block:: ruby

          :default => 123456789

       .. code-block:: ruby

          :default => []

       .. code-block:: ruby

          :default => ()

       .. code-block:: ruby

          :default => {}
   * - ``:equal_to``
     - Use to match a value with ``==``. Use an array of values to match any of those values with ``==``. For example:
       .. code-block:: ruby

          :equal_to => [true, false]

       .. code-block:: ruby

          :equal_to => ['php', 'perl']

   * - ``:kind_of``
     - Use to ensure a value is of a particular Ruby class, such as ``TrueClass``, ``FalseClass``, ``NilClass``, ``String``, ``Array``, ``Hash``, and so on. Use an array of Ruby classes to allow a value to be of more than one type. For example: ``:kind_of => String``, ``:kind_of => Array``, ``:kind_of => [TrueClass, FalseClass]`` and ``:kind_of => [Array, Hash]``. For example:

       .. code-block:: ruby

          :kind_of => String

       .. code-block:: ruby

          :kind_of => Fixnum

       .. code-block:: ruby

          :kind_of => Hash

       .. code-block:: ruby

          :kind_of => [TrueClass, FalseClass]

       .. code-block:: ruby

          :kind_of => [String, NilClass]

       .. code-block:: ruby

          :kind_of => [Class, String, Symbol]

       .. code-block:: ruby

          :kind_of => [Array, Hash]
   * - ``:name_attribute``
     - Use to set the default name of a lightweight resource. If the name isn't specified in the recipe, this is the value that will be used. For example:

       .. code-block:: ruby

          :name_attribute => true
   * - ``:regex``
     - Use to match a value to a regular expression. For example:

       .. code-block:: ruby

          :regex => [ /^([a-z]|[A-Z]|[0-9]|_|-)+$/, /^\d+$/ ]
   * - ``:required``
     - Indicates that an property is required. For example:

       .. code-block:: ruby

          :required => true
   * - ``:respond_to``
     - Use to ensure that a value has a given method. This can be a single method name or an array of method names. For example:

       .. code-block:: ruby

          :respond_to => valid_encoding?

Some examples of combining validation parameters:

.. code-block:: ruby

   attribute :spool_name, :kind_of => String, :name_attribute => true

.. code-block:: ruby

   attribute :enabled, :equal_to => [true, false, 'true', 'false'], :default => true

.. end_tag

Guards
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. tag resources_common_guards

A guard property can be used to evaluate the state of a node during the execution phase of the chef-client run. Based on the results of this evaluation, a guard property is then used to tell the chef-client if it should continue executing a resource. A guard property accepts either a string value or a Ruby block value:

* A string is executed as a shell command. If the command returns ``0``, the guard is applied. If the command returns any other value, then the guard property is not applied. String guards in a **powershell_script** run Windows PowerShell commands and may return ``true`` in addition to ``0``.
* A block is executed as Ruby code that must return either ``true`` or ``false``. If the block returns ``true``, the guard property is applied. If the block returns ``false``, the guard property is not applied.

A guard property is useful for ensuring that a resource is idempotent by allowing that resource to test for the desired state as it is being executed, and then if the desired state is present, for the chef-client to do nothing.

.. end_tag

Guard Attributes
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
.. tag resources_common_guards_attributes

The following properties can be used to define a guard that is evaluated during the execution phase of the chef-client run:

``not_if``
   Prevent a resource from executing when the condition returns ``true``.

``only_if``
   Allow a resource to execute only if the condition returns ``true``.

.. end_tag

Guard Arguments
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
.. tag resources_common_guards_arguments

The following arguments can be used with the ``not_if`` or ``only_if`` guard properties:

``:user``
   Specify the user that a command will run as. For example:

   .. code-block:: ruby

      not_if 'grep adam /etc/passwd', :user => 'adam'

``:group``
   Specify the group that a command will run as. For example:

   .. code-block:: ruby

      not_if 'grep adam /etc/passwd', :group => 'adam'

``:environment``
   Specify a Hash of environment variables to be set. For example:

   .. code-block:: ruby

      not_if 'grep adam /etc/passwd', :environment => { 
        'HOME' => '/home/adam' 
      }

``:cwd``
   Set the current working directory before running a command. For example:

   .. code-block:: ruby

      not_if 'grep adam passwd', :cwd => '/etc'

``:timeout``
   Set a timeout for a command. For example:

   .. code-block:: ruby

      not_if 'sleep 10000', :timeout => 10

.. end_tag

Notifications
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. tag resources_common_notification

A notification is a property on a resource that listens to other resources in the resource collection and then takes actions based on the notification type (``notifies`` or ``subscribes``).

.. end_tag

.. tag 5_3

A timer specifies the point during the chef-client run at which a notification is run. The following timers are available:

``:delayed``
   Default. Specifies that a notification should be queued up, and then executed at the very end of the chef-client run.

``:immediate``, ``:immediately``
   Specifies that a notification should be run immediately, per resource notified.

.. end_tag

notifies
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
.. tag resources_common_notification_notifies

A resource may notify another resource to take action when its state changes. Specify a ``'resource[name]'``, the ``:action`` that resource should take, and then the ``:timer`` for that action. A resource may notifiy more than one resource; use a ``notifies`` statement for each resource to be notified.

.. end_tag

.. tag resources_common_notification_notifies_syntax

The syntax for ``notifies`` is:

.. code-block:: ruby

   notifies :action, 'resource[name]', :timer

.. end_tag

subscribes
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
.. tag resources_common_notification_subscribes

A resource may listen to another resource, and then take action if the state of the resource being listened to changes. Specify a ``'resource[name]'``, the ``:action`` to be taken, and then the ``:timer`` for that action.

.. end_tag

.. tag resources_common_notification_subscribes_syntax

The syntax for ``subscribes`` is:

.. code-block:: ruby

   subscribes :action, 'resource[name]', :timer

.. end_tag

Examples
-----------------------------------------------------
The following examples show various lightweight providers that use platform resources or how to use certain parts of the Resource DSL.

:callbacks
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. tag lwrp_custom_resource_example_callbacks

An example of using the ``:callbacks`` validation parameter from the ``gunicorn`` cookbook (formatted for better readability):

.. code-block:: ruby

   attribute :server_hooks, :kind_of => Hash, :default => {}, \
     :callbacks =>
       {'should contain a valid gunicorn server hook name' => lambda 
           { 
             |hooks| Chef::Resource::GunicornConfig.validate_server_hook_hash_keys(hooks)
           }
         }
   ...

   VALID_SERVER_HOOK_NAMES = 
     [
       :on_starting, 
       :on_reload, 
       :when_ready, 
       :pre_fork, 
       :post_fork,
       :pre_exec, 
       :pre_request, 
       :post_request, 
       :worker_exit
     ]

   private
     def self.validate_server_hook_hash_keys(server_hooks)
       server_hooks.keys.reject{|key| VALID_SERVER_HOOK_NAMES.include?(key.to_sym)}.empty?
     end

where

* the ``:server_hooks`` attribute requires the value to be a valid Gunicorn server hook name
* the ``VALID_SERVER_HOOK_NAMES`` array defines the list of valid server hooks
* the ``private def`` block ensures the ``:callback`` validation parameter has the list of valid server hooks

.. end_tag

Custom Providers w/Platform Resources
=====================================================

.. tag resources_common_provider

Where a resource represents a piece of the system (and its desired state), a provider defines the steps that are needed to bring that piece of the system from its current state into the desired state.

.. end_tag

.. tag lwrp_custom_provider

A custom provider is a custom provider that defines the steps that are required to complete one (or more) actions defined by a custom resource. A custom provider and custom resource work together, each being defined in the same cookbook (the ``/providers`` and ``/resources`` subdirectories, respectively); together, they are referred as a LWRP (or "custom resource/provider"). A custom provider is always authored using Ruby. Anything that can be done using Ruby can be done in a custom provider. In addition to using Ruby, the Provider DSL provides additional methods that are specific to the chef-client.

.. end_tag

Syntax
-----------------------------------------------------
.. tag lwrp_custom_provider_syntax

This section shows some of the common structural elements that appear in a custom provider that is built in a way that leverages platform resources (such as **file**, **template**, or **package**). Remember:

* A custom provider tells the chef-client how to complete a task
* The structure of a custom provider will vary, depending on the complexity of the tasks required to complete an action
* At its platform, a custom provider is just Ruby code, which means that anything that can be done in Ruby can be done in a custom provider

The basic syntax for a custom provider that is built to leverage platform resources is as follows:

.. code-block:: ruby

   def whyrun_supported?
     true
   end

   use_inline_resources

   action :action_name do
     condition test
       resource 'resource_name' do
         Chef::Log.log_type 'log_message'
         # a Chef recipe
       end
     end
   end

   def test()
     # some Ruby code
   end

where:

* ``whyrun_supported?`` indicates whether a custom provider can be run in why-run mode
* ``use_inline_resources`` is used to tell the chef-client to execute ``action`` blocks as part of a self-contained chef-client run. Using this method ensures that the chef-client can notify parent custom resources after embedded resources have finished processing
* ``action`` is the code block that tells the chef-client what to do when the ``:action_name`` is used in a recipe
* ``condition`` is a Ruby condition statement (``if``, ``else``, ``elseif``, ``unless``, ``while``, ``until``, ``case``, or ``for``)
* ``test`` is used to test for idempotence; ``test`` can be defined inline (within the ``action`` block), defined as a method using a definition block elsewhere in the custom provider (shown as ``def test()``), or defined using any other pattern that is available in Ruby
* ``resource`` is a resource written as a recipe
* ``Chef::Log.log_type`` is used to tell the chef-client to create a log entry, where ``log_type`` is one of the following types: ``debug``, ``info``, ``warn``, ``error``, or ``fatal``

For example:

.. code-block:: ruby

   def whyrun_supported?
     true
   end

   use_inline_resources

   action :delete do
     if user_exists?(new_resource.user)
       cmdStr = 'rabbitmqctl delete_user #{new_resource.user}'
       execute cmdStr do
         Chef::Log.debug 'rabbitmq_user_delete: #{cmdStr}'
         Chef::Log.info "Deleting RabbitMQ user '#{new_resource.user}'."
         new_resource.updated_by_last_action(true)
       end
     end
   end

   def user_exists?(name)
     cmdStr = "rabbitmqctl -q list_users |grep '^#{name}\\b'"
     cmd = Mixlib::ShellOut.new(cmdStr)
     cmd.environment['HOME'] = ENV.fetch('HOME', '/root')
     cmd.run_command
     Chef::Log.debug 'rabbitmq_user_exists?: #{cmdStr}'
     Chef::Log.debug 'rabbitmq_user_exists?: #{cmd.stdout}'
     begin
       cmd.error!
       true
     rescue
       false
     end
   end

.. end_tag

Provider DSL Methods
-----------------------------------------------------
.. tag dsl_provider

The Provider DSL is a Ruby DSL that is used to help define a custom provider and to ensure that a custom provider takes the correct actions when it is called from a recipe. The Provider DSL is a small DSL with just a few methods that are specific to the chef-client. Because the Provider DSL is a Ruby DSL, anything that can be done using Ruby can also be done when defining a custom provider.

.. end_tag

action
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. tag dsl_provider_method_action

The ``action`` method is used to define the steps that will be taken for each of the possible actions defined by the custom resource. Each action must be defined in separate ``action`` blocks within the same file. The syntax for the ``action`` method is as follows:

.. code-block:: ruby

   action :action_name do
     if @current_resource.exists
       Chef::Log.info '#{ @new_resource } already exists - nothing to do.'
     else
       resource 'resource_name' do
         Chef::Log.info '#{ @new_resource } created.'
       end
     end
     new_resource.updated_by_last_action(true)
   end

where:

* ``:action_name`` corresponds to an action defined by a custom resource
* ``if @current_resource.exists`` is a condition test that is using an instance variable to see if the object already exists on the node; this is an example of a test for idempotence
* If the object already exists, a ``#{ @new_resource } already exists - nothing to do.`` log entry is created
* If the object does not already exists, the ``resource`` block is run. This block is a recipe that tells the chef-client what to do. A ``#{ @new_resource } created.`` log entry is created

.. end_tag

.. note:: The ``converge_by`` method is not included in the previous syntax example because when why-run mode is enabled in a lightweight provider that leverages platform resources, the ``converge_by`` blocks are already defined by the platform resources.

current_resource
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. tag dsl_provider_method_current_resource

The ``current_resource`` method is used to represent a resource as it exists on the node at the beginning of the chef-client run. In other words: what the resource is currently. The custom provider should compare the resource as it exists on the node to the ``new_resource`` that is created during the chef-client run, and then determine what steps should be taken to bring the resource into the desired state.

For example:

.. code-block:: ruby

   action :add do
     unless current_resource.exists
       cmd = "#{appcmd} add app /site.name:\'#{new_resource.app_name}\'"
       cmd << " /path:\'#{new_resource.path}\'"
       cmd << " /applicationPool:\'#{new_resource.application_pool}\'" if new_resource.application_pool
       cmd << " /physicalPath:\'#{new_resource.physical_path}\'" if new_resource.physical_path
       converge_by("creating App") do
         Chef::Log.debug(cmd)
         shell_out!(cmd)
         Chef::Log.debug('App created')
       end
     else
       Chef::Log.debug('#{new_resource} app already exists - nothing to do')
     end
   end

where the ``unless`` conditional statement checks to make sure the resource doesn't already exist on a node, and then runs a series of commands when it doesn't. If the resource already exists, the log entry would be ``Foo app already exists - nothing to do``.

.. end_tag

load_current_resource
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. tag dsl_provider_method_load_current_resource

The ``load_current_resource`` method is used to construct the curent state of the resource on the node. This is in contrast to the ``new_resource`` method which represents the desired state of the resource on the node. Both methods are constructed the same way. Properties should be loaded from the node's state.

For example:

.. code-block:: ruby

   def load_current_resource

     @current_resource = Chef::Resource::MyResource.new(new_resource.name)

     current_resource.path(new_resource.path)
     # Most other current_resource properites will be found by inspecting the system (e.g. Wwhat is
     # the current version of the installed package?  What are the existing file modes?)
     current_resource.mode(File.stat(new_resource.path).mode)
     current_resource
   end

where:

* ``load_current_resource`` returns the ``current_resource`` (and builds the instance variable)
* ``@current_resource`` is an instance variable that creates a ``current_resource`` with the same name as ``new_resource``
* ``current_resource.path(new_resource.path)`` sets the new resource paths to be the same as the current resource paths
* ``current_resource.mode(File.stat(new_resource.path).mode)`` inspects the system for properties of the current resource
* ``current_resource`` returns the current resource and allows the ``new_resource`` to be compared to check for idempotentcy

.. end_tag

new_resource
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. tag dsl_provider_method_new_resource

The ``new_resource`` method is used to represent a resource as loaded by the chef-client during the chef-client run. In other words: what the resource should be. The custom provider should compare the resource as it exists on the node to the resource that is created during the chef-client run to determine what steps need to be taken to bring the resource into the desired state.

For example:

.. code-block:: ruby

   action :delete do
     if ::File.exists?(new_resource.path)
       converge_by("deleting #{new_resource.path}) do
         if ::File.writable?(new_resource.path)
           Chef::Log.info("Deleting #{new_resource} at #{new_resource.path}")
           ::File.delete(new_resource.path)
         else
           raise "Cannot delete #{new_resource} at #{new_resource.path}!"
         end
       end
     end
   end

where

* The chef-client checks to see if the file exists, then if the file is writable, and then attempts to delete the resource
* ``path`` is an attribute of the new resource that is defined by the custom resource

.. end_tag

provides
+++++++++++++++++++++++++++++++++++++++++++++++++++++
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

updated_by_last_action
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. tag dsl_provider_method_updated_by_last_action

The ``updated_by_last_action`` method is used to notify a custom resource that a node was updated successfully. For example, the ``cron_d`` custom resource in the ``cron`` cookbook:

.. code-block:: ruby

   action :create do
     t = template '/etc/cron.d/#{new_resource.name}' do
       cookbook new_resource.cookbook
       source 'cron.d.erb'
       mode '0644'
       variables({
           :name => 'new_resource.name',
           :minute => 'new_resource.minute',
           :hour => 'new_resource.hour',
           :day => 'new_resource.day',
           :month => 'new_resource.month',
           :weekday => 'new_resource.weekday',
           :command => 'new_resource.command',
           :user => 'new_resource.user',
           :mailto => 'new_resource.mailto',
           :path => 'new_resource.path',
           :home => 'new_resource.home',
           :shell => 'new_resource.shell'
         })
       action :create
     end
     new_resource.updated_by_last_action(t.updated_by_last_action?)
   end

where ``t.updated_by_last_action?`` uses a variable to check whether a new crontab entry was created.

.. end_tag

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

use_inline_resources
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. tag dsl_provider_method_use_inline_resources_about

A custom resource is created by the ``action`` block of a custom provider. When the resource collection is compiled, a custom resource is inserted into the top-level resource collection after the point at which the custom provider is associated. For example, if a resource collection looks like::

   top_level_resource_one
     lwrp_resource
   top_level_resource_two

then when ``lwrp_resource`` is executed, the resource collection will be modified as follows::

   top_level_resource_one           # already processed
     lwrp_resource                  # already processed
       embedded_resource_one        # created by the custom provider
       embedded_resource_two        # created by the custom provider
   top_level_resource_two

In this situation, embedded custom resources cannot notify the top-level resource because the top-level resource has finished processing. This has the same effect as if the top-level resource collection were invisible to the embedded custom resources.

.. end_tag

.. tag dsl_provider_method_use_inline_resources

To ensure that an embedded custom resource can notify the top-level resource add ``use_inline_resources`` to the top of the file that defines the custom provider that is associated with that custom resource. When ``use_inline_resources`` is added to the file, the code in the custom provider's ``action`` block will execute as part of a self-contained chef-client run. If any embedded custom resources are updated, the top-level custom resource is marked as updated and notifications set for the top-level resource will be triggered normally. This ensures that notifications work properly across the resource collection.

For example:

.. code-block:: ruby

   use_inline_resources

   action :run do
     # Ruby code that implements the provider
   end

.. warning:: The ``use_inline_resources`` method was added to the chef-client starting in version 11.0 to address the behavior described below. The ``use_inline_resources`` method should be considered a requirement for any custom resource authored against the 11.0+ versions of the chef-client. This behavior will become the default behavior in an upcoming version of the chef-client.

.. end_tag

Background
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
.. tag dsl_provider_method_use_inline_resources_background

The reason why the ``use_inline_resources`` method exists at all is due to how the chef-client processes resources. Currently, the default behavior of the chef-client processes a single collection of resources, converged on the node in order.

A custom resource is often implemented using the core chef-client resources---**file**, **template**, **package**, and so on---as building blocks. A custom resource is then added to a recipe using the short name of the custom resource in the recipe (and not by using any of the building block resource components).

This situation can create problems with notifications because the chef-client includes embedded resources in the "single collection of resources" *after* the parent resource has been fully evaluated.

For example:

.. code-block:: ruby

   custom_resource 'something' do
     action :run
     notifies :restart, 'service[whatever]', :immediately
   end

   service 'whatever' do
     action :nothing
   end

If the ``custom_resource`` is built using the **file** resource, what happens during the chef-client run is::

   custom_resource (not updated)
     file (updated)
   service (skipped, due to ``:nothing``)

The ``custom_resource`` is converged completely, its state set to not updated before the **file** resource is evaluated. The ``notifies :restart`` is ignored and the service is not restarted.

If the author of the custom resource knows in advance what notification is required, then the **file** resource can be configured for the notification in the provider. For example:

.. code-block:: ruby

   action :run do
     file '/tmp/foo' do
       owner 'root'
       group 'root'
       mode '0644'
       notifies :restart, 'service[whatever]', :immediately
     end
   end

And then in the recipe:

.. code-block:: ruby

   service 'whatever' do
     action :nothing
   end

This approach works, but only when the author of the custom resource knows what should be notified in advance of the chef-client run. Consequently, this is less-than-ideal for most situations.

Using the ``use_inline_resources`` method will ensure that the chef-client processes a custom resource as if it were its own resource collection---a "mini chef-client run", effectively---that is converged *before* the chef-client finishes evaluating the parent custom resource. This ensures that any notifications that may exist in the embedded resources are processed as if they were notifications on the parent custom resource. For example:

.. code-block:: ruby

   custom_resource 'something' do
     action :run
     notifies :restart, 'service[whatever]', :immediately
   end

   service 'whatever' do
     action :nothing
   end

If the ``custom_resource`` is built using the **file** resource, what happens during the chef-client run is::

   custom_resource (starts converging)
     file (updated)
   custom_resource (updated, because ``file`` updated)
   service (updates, because ``:immediately`` is set in the custom resource)

.. end_tag

Disable
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
.. tag dsl_provider_method_use_inline_resources_default_behavior

The ``use_inline_resources`` method should be considered a default method for any provider that defines a custom resource. It's the correct behavior. And it will soon become the default behavior in a future version of the chef-client.

Because inline compile mode makes it impossible for embedded resources to notify resources in the parent resource collection, inline compile mode may cause issues with some provider implementations. In these cases, use a definition to work around inline compile mode. See this example for how to use a definition in this situation.

.. end_tag

whyrun_supported?
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. tag chef_client_whyrun_mode

why-run mode is a way to see what the chef-client would have configured, had an actual chef-client run occurred. This approach is similar to the concept of "no-operation" (or "no-op"): decide what should be done, but then don't actually do anything until it's done right. This approach to configuration management can help identify where complexity exists in the system, where inter-dependencies may be located, and to verify that everything will be configured in the desired manner.

When why-run mode is enabled, a chef-client run will occur that does everything up to the point at which configuration would normally occur. This includes getting the configuration data, authenticating to the Chef server, rebuilding the node object, expanding the run-list, getting the necessary cookbook files, resetting node attributes, identifying the resources, and building the resource collection and does not include mapping each resource to a provider or configuring any part of the system.

.. note:: why-run mode is not a replacement for running cookbooks in a test environment that mirrors the production environment. Chef uses why-run mode to learn more about what is going on, but also Kitchen on developer systems, along with an internal OpenStack cloud and external cloud providers to test more thoroughly.

.. end_tag

.. tag chef_client_whyrun_mode_assumptions

When the chef-client is run in why-run mode, certain assumptions are made:

* If the **service** resource cannot find the appropriate command to verify the status of a service, why-run mode will assume that the command would have been installed by a previous resource and that the service would not be running
* For ``not_if`` and ``only_if`` attribute, why-run mode will assume these are commands or blocks that are safe to run. These conditions are not designed to be used to change the state of the system, but rather to help facilitate idempotency for the resource itself. That said, it may be possible that these attributes are being used in a way that modifies the system state
* The closer the current state of the system is to the desired state, the more useful why-run mode will be. For example, if a full run-list is run against a fresh system, that run-list may not be completely correct on the first try, but also that run-list will produce more output than a smaller run-list

.. end_tag

.. tag dsl_provider_method_whyrun_supported

The ``whyrun_supported?`` method is used to set a custom provider to support why-run mode. The syntax for the ``whyrun_supported?`` method is as follows:

.. code-block:: ruby

   def whyrun_supported?
     true
   end

where ``whyrun_supported?`` is set to ``true`` for any custom provider that supports using why-run mode. When why-run mode is supported by the a custom provider, the ``converge_by`` method is used to define the strings that are logged by the chef-client when it is run in why-run mode.

.. end_tag

.. note:: When a lightweight provider contains only platform resources, the ``converge_by`` method is not required because it is already built into all of the platform :doc:`resources <resource>`.

Examples
-----------------------------------------------------
The following examples show various lightweight providers that use platform resources.

aws_ebs_volume
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. tag lwrp_custom_provider_example_aws_ebs_volume

The ``aws_ebs_volume`` custom provider (found in the `aws <https://github.com/chef-cookbooks/aws>`_ cookbook) defines how the chef-client would handle a recipe that uses the ``ebs_volume`` custom resource and the ``:detach`` action. The following ``action`` block tells the chef-client what to do with the ``:detach`` action:

.. code-block:: ruby

   action :detach do
     vol = determine_volume
     return if vol[:aws_instance_id] != instance_id
     converge_by('detach volume with id: #{vol[:aws_id]}') do
       detach_volume(vol[:aws_id], new_resource.timeout)
     end
   end

and the following ``def`` block defines the ``vol`` variable called by the ``determine_volume`` method:

.. code-block:: ruby

   def determine_volume
     vol = currently_attached_volume(instance_id, new_resource.device)
     vol_id = new_resource.volume_id || volume_id_in_node_data || ( vol ? vol[:aws_id] : nil )
     raise 'volume_id attribute not set ... no volume is attached at the device' unless vol_id

     vol = volume_by_id(vol_id)
     raise 'No volume with id #{vol_id} exists' unless vol

     vol
   end

.. end_tag

cron_d
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. tag lwrp_custom_provider_example_cron_d

The ``cron_d`` custom provider (found in the `cron <https://github.com/chef-cookbooks/cron>`_ cookbook) is used to tell the chef-client what to do whenever the ``cron_d`` custom resource is used in a recipe:

.. code-block:: ruby

   action :delete do
     file '/etc/cron.d/#{new_resource.name}' do
       action :delete
     end
   end

   action :create do
     t = template '/etc/cron.d/#{new_resource.name}' do
       cookbook new_resource.cookbook
       source 'cron.d.erb'
       mode '0644'
       variables({
           :name => new_resource.name, 
           :minute => new_resource.minute,
           :hour => new_resource.hour,
           :day => new_resource.day,
           :month => new_resource.month,
           :weekday => new_resource.weekday,
           :command => new_resource.command,
           :user => new_resource.user,
           :mailto => new_resource.mailto,
           :path => new_resource.path,
           :home => new_resource.home,
           :shell => new_resource.shell
         })
       action :create
     end
     new_resource.updated_by_last_action(t.updated_by_last_action?)
   end

where:

* two ``action`` blocks are defined, one for the ``:create`` action and one for the ``:delete`` action
* the ``:delete`` action block calls the **file** resource (and it's ``:delete`` action) to delete a file in the ``/etc/cron.d`` folder
* the ``:create`` action block creates a new entry in the ``/etc/cron.d`` folder.

For example, if a recipe used the ``cron_d`` custom resource similar to the following:

.. code-block:: ruby

   cron_d 'daily-usage-report' do
     minute '0'
     hour '23'
     command '/srv/app/scripts/daily_report'
     user 'appuser'
   end

this tells the chef-client to use the ``cron_d`` custom provider and the credentials for a user named ``appuser`` to create a crontab entry named "daily-usage-report". This crontab entry executes a command located in the ``/srv/app/scripts/daily_report`` directory at a specified interval (defined by the ``minute`` and ``hour`` attributes). Any of the attributes that are not specified in the recipe (such as ``mailto``, ``weekday``, and ``day``) just use the default attribute values defined by the custom resource.

.. end_tag

rabbitmq_plugin
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. tag lwrp_custom_provider_example_rabbitmq_plugin

The ``rabbitmq_plugin`` custom provider (found in the `rabbitmq <https://supermarket.chef.io/cookbooks/rabbitmq>`_ cookbook) is used to tell the chef-client how to handle two actions (``:disable`` and ``:enable``) that are used to manage RabbitMQ plugins. Using this custom resource in a recipe is simple:

.. code-block:: ruby

   rabbitmq_plugin 'my_plugin' do
     action :enable
   end

The custom provider then does most of the work:

.. code-block:: ruby

   action :enable do
     unless plugin_enabled?(new_resource.plugin)
       execute 'rabbitmq-plugins enable #{new_resource.plugin}' do
         Chef::Log.info 'Enabling RabbitMQ plugin '#{new_resource.plugin}'.'
         path plugins_bin_path(true)
         new_resource.updated_by_last_action(true)
       end
     end
   end

   def plugins_bin_path(return_array=false)
     path = ENV.fetch('PATH') + ':/usr/lib/rabbitmq/bin'
     return_array ? path.split(':') : path
   end

   def plugin_enabled?(name)
     cmdStr = "rabbitmq-plugins list -e '#{name}\\b'"
     cmd = Mixlib::ShellOut.new(cmdStr)
     cmd.environment['HOME'] = ENV.fetch('HOME', '/root')
     cmd.environment['PATH'] = plugins_bin_path
     cmd.run_command
     Chef::Log.debug 'rabbitmq_plugin_enabled?: #{cmdStr}'
     Chef::Log.debug 'rabbitmq_plugin_enabled?: #{cmd.stdout}'
     cmd.error!
     cmd.stdout =~ /\b#{name}\b/
   end

.. end_tag

ssh_known_hosts_entry
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. tag lwrp_custom_provider_example_ssh_known_hosts_entry

The ``ssh_known_hosts_entry`` custom provider (found in the `ssh_known_hosts <https://github.com/chef-cookbooks/ssh_known_hosts>`_ cookbook) is used to add hosts and keys to the ``/etc/ssh_known_hosts`` file.

.. code-block:: ruby

   action :create do
     key = (new_resource.key || `ssh-keyscan -H #{new_resource.host} 2>&1`)
     comment = key.split('\n').first

     Chef::Application.fatal! 'Could not resolve #{new_resource.host}' if key =~ /getaddrinfo/

     file node['ssh_known_hosts']['file'] do
       action        :create
       backup        false
       content       
       only_if do
         !::File.exists?(node['ssh_known_hosts']['file']) || ::File.new(node['ssh_known_hosts']['file']).readlines.length == 0
       end
     end

     ruby_block "add #{new_resource.host} to #{node['ssh_known_hosts']['file']}" do
       block do
         file = ::Chef::Util::FileEdit.new(node['ssh_known_hosts']['file'])
         file.insert_line_if_no_match(/#{Regexp.escape(comment)}|#{Regexp.escape(key)}/, key)
         file.write_file
       end
     end
     new_resource.updated_by_last_action(true)
   end

.. end_tag

Custom Providers w/Ruby
=====================================================

.. tag resources_common_provider

Where a resource represents a piece of the system (and its desired state), a provider defines the steps that are needed to bring that piece of the system from its current state into the desired state.

.. end_tag

.. tag lwrp_custom_provider

A custom provider is a custom provider that defines the steps that are required to complete one (or more) actions defined by a custom resource. A custom provider and custom resource work together, each being defined in the same cookbook (the ``/providers`` and ``/resources`` subdirectories, respectively); together, they are referred as a LWRP (or "custom resource/provider"). A custom provider is always authored using Ruby. Anything that can be done using Ruby can be done in a custom provider. In addition to using Ruby, the Provider DSL provides additional methods that are specific to the chef-client.

.. end_tag

Syntax
-----------------------------------------------------
.. tag lwrp_custom_provider_syntax_ruby

This section shows some of the common structural elements that appear in a custom provider that is built using custom Ruby code. Remember:

* A custom provider tells the chef-client how to complete a task
* The structure of a custom provider will vary, depending on the complexity of the tasks required to complete an action
* At its platform, a custom provider is just Ruby code, which means that anything that can be done in Ruby can be done in a custom provider

The basic syntax for a custom provider that is built using custom Ruby code is as follows:

.. code-block:: ruby

   use_inline_resources

   def whyrun_supported?
     true
   end

   action :action_name do
     if updates_required?
       converge_by('message') do
         # some Ruby code
       end
     end
   end

   ...

   def updates_required?()
     # some Ruby code
     true
   end

where:

* ``use_inline_resources`` allows the custom provider to notify and be notified during the chef-client run
* ``whyrun_supported?`` indicates that a custom provider can be run in why-run mode
* ``action`` is the code block that tells the chef-client what to do when the ``:action_name`` is used in a recipe
* ``converge_by()`` is used to provide a ``'message'`` to be logged when a resource is updated during the chef-client run or to disable the code block when the chef-client is run in why-run mode

Other commonly used methods (that are not shown in the previous example) are ``current_resource``, ``load_current_resource``, and ``new_resource``.

The following example shows a custom provider:

.. code-block:: ruby

   require 'chef/mixin/shell_out'
   include Chef::Mixin::ShellOut

   use_inline_resources

   def whyrun_supported?
     true
   end

   action :fix do
     if modes_differ?
       converge_by("fix #{new_resource.path} mode to #{new_resource.mode}, was #{current_resource.mode}") do
         Chef::Log.debug "updating #{new_resource.path} to #{new_resource.mode} via shell_out!"
         shell_out!("chown #{new_resource.mode} #{new_resource.path}")

       end
     end
   end

   def modes_differ?
     current_resource.mode != new_resource.mode
   end

   def load_current_resource
     @current_resource = Chef::Resource::MyResource.new(new_resource.name)
     current_resource.path(new_resource.path)
     current_resource.mode(File.stat(new_resource.path).mode)
     current_resource
   end

where:

* ``converge_by`` uses the ``shell_out!`` method; ``FileUtils.chown`` is probably a better approach in most situations
* ``load_current_resource`` creates a ``current_resource`` with the same name as ``new_resource``, sets the new resource paths to be the same as the current resource paths, and then inspects the system for properties of the current resource

.. end_tag

Provider DSL Methods
-----------------------------------------------------
.. tag dsl_provider

The Provider DSL is a Ruby DSL that is used to help define a custom provider and to ensure that a custom provider takes the correct actions when it is called from a recipe. The Provider DSL is a small DSL with just a few methods that are specific to the chef-client. Because the Provider DSL is a Ruby DSL, anything that can be done using Ruby can also be done when defining a custom provider.

.. end_tag

action
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. tag dsl_provider_method_action_with_converge_by

The ``action`` method is used to define the steps that will be taken for each of the possible actions defined by the custom resource. Each action must be defined in separate ``action`` blocks within the same file. The syntax for the ``action`` method is as follows:

.. code-block:: ruby

   action :action_name do
     # Chef resources or Ruby converge_by blocks
   end

where:

* ``:action_name`` corresponds to an action defined by a custom resource
* ``converge_by`` tells the chef-client which message to provide when the chef-client is run in why-run mode

.. end_tag

converge_by
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. tag dsl_provider_method_converge_by

The ``converge_by`` method is a wrapper that is used to support why-run mode and must wrap any Ruby calls that updates system state.  All core Chef resources internally use ``converge_by`` and support why-run mode by default. To ensure that a custom provider is idempotent, ``converge_by`` blocks must be checked for idempotency.

The syntax of a ``converge_by`` block is:

.. code-block:: ruby

   converge_by('message')

where:

* ``converge_by()`` is added to an ``action`` block as a wrapper
* ``'message'`` is the message returned by the chef-client when the resource runs

Some examples:

.. code-block:: ruby

   unless Dir.exist?(new_resource.path)
     converge_by("Create directory #{ new_resource.path }") do
       FileUtils.mkdir new_resource.path
     end
   end

.. code-block:: ruby

   if should_create_user?
     converge_by("Create user #{ new_resource.user }") do
       shell_out!("adduser #{ new_resource.user }")
     end
   end

.. code-block:: ruby

   if should_update_stuff?
     description = 'create dir #{app_root} and change owner to #{new_resource.owner}'
     converge_by(description) do
       FileUtils.mkdir app_root, :mode => new_resource.app_home_mode
       FileUtils.chown new_resource.owner, new_resource.owner, app_root
     end
   end

where the last example shows using a variable (``description``) as the ``'message'`` in the ``converge_by`` block.

An example of the ``converge_by`` method exists in the provider for `directory <https://github.com/chef/chef/blob/master/lib/chef/provider/directory.rb>`_ resource, which is a core Chef resource:

.. code-block:: ruby

   def whyrun_supported?
     true
   end

   ...

   def action_create
     unless File.exist?(@new_resource.path)
       converge_by('create new directory #{@new_resource.path}') do 
         if @new_resource.recursive == true
           ::FileUtils.mkdir_p(@new_resource.path)
         else
           ::Dir.mkdir(@new_resource.path)
         end
         Chef::Log.info('#{@new_resource} created directory #{@new_resource.path}')
       end 
     end
     set_all_access_controls
     update_new_file_state
   end

.. note:: why-run mode is already enabled for platform resources. When platform resources are used as part of the ``action`` block in a custom provider, only the ``whyrun_supported?`` is required to allow the chef-client to run in why-run mode.

.. end_tag

current_resource
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. tag dsl_provider_method_current_resource

The ``current_resource`` method is used to represent a resource as it exists on the node at the beginning of the chef-client run. In other words: what the resource is currently. The custom provider should compare the resource as it exists on the node to the ``new_resource`` that is created during the chef-client run, and then determine what steps should be taken to bring the resource into the desired state.

For example:

.. code-block:: ruby

   action :add do
     unless current_resource.exists
       cmd = "#{appcmd} add app /site.name:\'#{new_resource.app_name}\'"
       cmd << " /path:\'#{new_resource.path}\'"
       cmd << " /applicationPool:\'#{new_resource.application_pool}\'" if new_resource.application_pool
       cmd << " /physicalPath:\'#{new_resource.physical_path}\'" if new_resource.physical_path
       converge_by("creating App") do
         Chef::Log.debug(cmd)
         shell_out!(cmd)
         Chef::Log.debug('App created')
       end
     else
       Chef::Log.debug('#{new_resource} app already exists - nothing to do')
     end
   end

where the ``unless`` conditional statement checks to make sure the resource doesn't already exist on a node, and then runs a series of commands when it doesn't. If the resource already exists, the log entry would be ``Foo app already exists - nothing to do``.

.. end_tag

load_current_resource
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. tag dsl_provider_method_load_current_resource

The ``load_current_resource`` method is used to construct the curent state of the resource on the node. This is in contrast to the ``new_resource`` method which represents the desired state of the resource on the node. Both methods are constructed the same way. Properties should be loaded from the node's state.

For example:

.. code-block:: ruby

   def load_current_resource

     @current_resource = Chef::Resource::MyResource.new(new_resource.name)

     current_resource.path(new_resource.path)
     # Most other current_resource properites will be found by inspecting the system (e.g. Wwhat is
     # the current version of the installed package?  What are the existing file modes?)
     current_resource.mode(File.stat(new_resource.path).mode)
     current_resource
   end

where:

* ``load_current_resource`` returns the ``current_resource`` (and builds the instance variable)
* ``@current_resource`` is an instance variable that creates a ``current_resource`` with the same name as ``new_resource``
* ``current_resource.path(new_resource.path)`` sets the new resource paths to be the same as the current resource paths
* ``current_resource.mode(File.stat(new_resource.path).mode)`` inspects the system for properties of the current resource
* ``current_resource`` returns the current resource and allows the ``new_resource`` to be compared to check for idempotentcy

.. end_tag

new_resource
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. tag dsl_provider_method_new_resource

The ``new_resource`` method is used to represent a resource as loaded by the chef-client during the chef-client run. In other words: what the resource should be. The custom provider should compare the resource as it exists on the node to the resource that is created during the chef-client run to determine what steps need to be taken to bring the resource into the desired state.

For example:

.. code-block:: ruby

   action :delete do
     if ::File.exists?(new_resource.path)
       converge_by("deleting #{new_resource.path}) do
         if ::File.writable?(new_resource.path)
           Chef::Log.info("Deleting #{new_resource} at #{new_resource.path}")
           ::File.delete(new_resource.path)
         else
           raise "Cannot delete #{new_resource} at #{new_resource.path}!"
         end
       end
     end
   end

where

* The chef-client checks to see if the file exists, then if the file is writable, and then attempts to delete the resource
* ``path`` is an attribute of the new resource that is defined by the custom resource

.. end_tag

updated_by_last_action
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. tag dsl_provider_method_updated_by_last_action_ruby

.. warning:: The direct use of ``updated_by_last_action`` is deprecated; any provider that is using this method must be updated to use the ``use_inline_resources`` method instead. For actions that modify the system state, define them with core Chef resources or group them within ``converge_by`` blocks.

.. end_tag

whyrun_supported?
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. tag chef_client_whyrun_mode

why-run mode is a way to see what the chef-client would have configured, had an actual chef-client run occurred. This approach is similar to the concept of "no-operation" (or "no-op"): decide what should be done, but then don't actually do anything until it's done right. This approach to configuration management can help identify where complexity exists in the system, where inter-dependencies may be located, and to verify that everything will be configured in the desired manner.

When why-run mode is enabled, a chef-client run will occur that does everything up to the point at which configuration would normally occur. This includes getting the configuration data, authenticating to the Chef server, rebuilding the node object, expanding the run-list, getting the necessary cookbook files, resetting node attributes, identifying the resources, and building the resource collection and does not include mapping each resource to a provider or configuring any part of the system.

.. note:: why-run mode is not a replacement for running cookbooks in a test environment that mirrors the production environment. Chef uses why-run mode to learn more about what is going on, but also Kitchen on developer systems, along with an internal OpenStack cloud and external cloud providers to test more thoroughly.

.. end_tag

.. tag chef_client_whyrun_mode_assumptions

When the chef-client is run in why-run mode, certain assumptions are made:

* If the **service** resource cannot find the appropriate command to verify the status of a service, why-run mode will assume that the command would have been installed by a previous resource and that the service would not be running
* For ``not_if`` and ``only_if`` attribute, why-run mode will assume these are commands or blocks that are safe to run. These conditions are not designed to be used to change the state of the system, but rather to help facilitate idempotency for the resource itself. That said, it may be possible that these attributes are being used in a way that modifies the system state
* The closer the current state of the system is to the desired state, the more useful why-run mode will be. For example, if a full run-list is run against a fresh system, that run-list may not be completely correct on the first try, but also that run-list will produce more output than a smaller run-list

.. end_tag

.. tag dsl_provider_method_whyrun_supported

The ``whyrun_supported?`` method is used to set a custom provider to support why-run mode. The syntax for the ``whyrun_supported?`` method is as follows:

.. code-block:: ruby

   def whyrun_supported?
     true
   end

where ``whyrun_supported?`` is set to ``true`` for any custom provider that supports using why-run mode. When why-run mode is supported by the a custom provider, the ``converge_by`` method is used to define the strings that are logged by the chef-client when it is run in why-run mode.

.. end_tag

Library Resources
=====================================================

.. tag libraries_custom_resource

.. This topic is NOT the same as the LWRP resource topic; keep separate.

A resource can also be defined in ``/libraries`` directory. Some advantages of this approach include more control over how resources behave in the provider, the ability to control the name of the resource directly, and more options available for writing tests. The resources and providers for a library resource, similar to lightweight resources (defined in the ``/resources`` and ``/providers`` folders) typically have a separate file for the resource and the provider, but this is not requirement. The main disadvantage of this approach is that resources defined in the ``/libraries`` directory may not use the Recipe DSL.

.. end_tag

.. tag libraries_custom_resource_core

.. This topic is NOT the same as the LWRP resource topic; keep separate.

A resource that is defined in the ``/libraries`` directory may leverage core chef-client resources by using the following syntax:

.. code-block:: ruby

   Chef::Resource::name_of_resource.new('name', run_context)

or:

.. code-block:: ruby

   Chef::Resource::name_of_resource.new(:action)

.. end_tag

.. tag libraries_custom_resource_example

.. This topic is NOT the same as the LWRP resource topic; keep separate.

For example, the following definition leverages the **directory** resource to create a new directory, and then evaluate that within the context of the custom resource:

.. code-block:: ruby

   def env_dir
     return @env_dir unless @env_dir.nil?
     @env_dir = Chef::Resource::Directory.new(::File.join(sv_dir_name, 'env'), run_context)
     @env_dir.owner(new_resource.owner)
     @env_dir.group(new_resource.group)
     @env_dir.mode(00755)
     @env_dir
   end

The following definition uses the **template** resource for Debian-specific cases, but then the **link** resource for everything else:

.. code-block:: ruby

   def lsb_init
     return @lsb_init unless @lsb_init.nil?
     initfile = ::File.join(new_resource.lsb_init_dir, new_resource.service_name)
     if node['platform'] == 'debian'
       ::File.unlink(initfile) if ::File.symlink?(initfile)
       @lsb_init = Chef::Resource::Template.new(initfile, run_context)
       @lsb_init.owner('root')
       @lsb_init.group('root')
       @lsb_init.mode(00755)
       @lsb_init.cookbook('runit')
       @lsb_init.source('init.d.erb')
       @lsb_init.variables(:name => new_resource.service_name)
     else
       @lsb_init = Chef::Resource::Link.new(initfile, run_context)
       @lsb_init.to(new_resource.sv_bin)
     end
     @lsb_init
   end

Otherwise, a resource defined in the ``/libraries`` directory is done using Ruby, is added to recipes as if it were any other resource, and is processed by the chef-client in the same way as any other resource. See the ``/libraries`` directory in the `database <https://github.com/chef-cookbooks/database>`_ and `runit <https://github.com/hw-cookbooks/runit>`_ cookbooks for complete examples of how to use this approach when defining a resource.

.. end_tag

More Reading
=====================================================
Doug Ireton (a community member) has a blog with a nice series on LWRPs:

* Part 1: http://dougireton.com/blog/2012/12/31/creating-an-lwrp/
* Part 2: http://dougireton.com/blog/2013/01/07/creating-an-lwrp-part-2/
* Part 3: http://dougireton.com/blog/2013/01/13/creating-an-lwrp-part-3/

