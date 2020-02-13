=====================================================
dsc_resource resource
=====================================================
`[edit on GitHub] <https://github.com/chef/chef-web-docs/blob/master/chef_master/source/resource_dsc_resource.rst>`__

.. tag resources_common_powershell

Windows PowerShell is a task-based command-line shell and scripting language developed by Microsoft. Windows PowerShell uses a document-oriented approach for managing Microsoft Windows-based machines, similar to the approach that is used for managing Unix and Linux-based machines. Windows PowerShell is `a tool-agnostic platform <https://docs.microsoft.com/en-us/powershell/scripting/powershell-scripting>`_ that supports using Chef for configuration management.

.. end_tag

.. tag resources_common_powershell_dsc

Desired State Configuration (DSC) is a feature of Windows PowerShell that provides `a set of language extensions, cmdlets, and resources <https://docs.microsoft.com/en-us/powershell/dsc/overview>`_ that can be used to declaratively configure software. DSC is similar to Chef, in that both tools are idempotent, take similar approaches to the concept of resources, describe the configuration of a system, and then take the steps required to do that configuration. The most important difference between Chef and DSC is that Chef uses Ruby and DSC is exposed as configuration data from within Windows PowerShell.

.. end_tag

The **dsc_resource** resource allows any DSC resource to be used in a Chef recipe, as well as any custom resources that have been added to your Windows PowerShell environment. Microsoft `frequently adds new resources <https://github.com/powershell/DscResources>`_ to the DSC resource collection.



.. warning:: Using the **dsc_resource** has the following requirements:

             * Windows Management Framework (WMF) 5.0 February Preview (or higher), which includes Windows PowerShell 5.0.10018.0 (or higher).
             * The ``RefreshMode`` configuration setting in the Local Configuration Manager must be set to ``Disabled``.

               **NOTE:** Starting with the Chef Client 12.6 release, this requirement applies only for versions of Windows PowerShell earlier than 5.0.10586.0. The latest version of Windows Management Framework (WMF) 5 has relaxed the limitation that prevented Chef Infra Client from running in non-disabled refresh mode.

             * The **dsc_script** resource  may not be used in the same run-list with the **dsc_resource**. This is because the **dsc_script** resource requires that ``RefreshMode`` in the Local Configuration Manager be set to ``Push``, whereas the **dsc_resource** resource requires it to be set to ``Disabled``.

               **NOTE:** Starting with the Chef Client 12.6 release, this requirement applies only for versions of Windows PowerShell earlier than 5.0.10586.0. The latest version of Windows Management Framework (WMF) 5 has relaxed the limitation that prevented Chef Infra Client from running in non-disabled refresh mode, which allows the Local Configuration Manager to be set to ``Push``.

             * The **dsc_resource** resource can only use binary- or script-based resources. Composite DSC resources may not be used.

               This is because composite resources aren't "real" resources from the perspective of the Local Configuration Manager (LCM). Composite resources are used by the "configuration" keyword from the ``PSDesiredStateConfiguration`` module, and then evaluated in that context. When using DSC to create the configuration document (the Managed Object Framework (MOF) file) from the configuration command, the composite resource is evaluated. Any individual resources from that composite resource are written into the Managed Object Framework (MOF) document. As far as the Local Configuration Manager (LCM) is concerned, there is no such thing as a composite resource. Unless that changes, the **dsc_resource** resource and/or ``Invoke-DscResource`` command cannot directly use them.

             

Syntax
=====================================================

A **dsc_resource** resource block allows DSC resources to be used in a Chef recipe. For example, the DSC ``Archive`` resource:

.. code-block:: powershell

   Archive ExampleArchive {
     Ensure = "Present"
     Path = "C:\Users\Public\Documents\example.zip"
     Destination = "C:\Users\Public\Documents\ExtractionPath"
   }

and then the same **dsc_resource** with Chef:

.. code-block:: ruby

   dsc_resource 'example' do
      resource :archive
      property :ensure, 'Present'
      property :path, "C:\Users\Public\Documents\example.zip"
      property :destination, "C:\Users\Public\Documents\ExtractionPath"
    end

The full syntax for all of the properties that are available to the **dsc_resource** resource is:

.. code-block:: ruby

   dsc_resource 'name' do
     module_name                String
     module_version             String
     property                   Symbol
     reboot_action              Symbol # default value: :nothing
     resource                   Symbol
     timeout                    Integer
     action                     Symbol # defaults to :run if not specified
   end

where:

* ``dsc_resource`` is the resource.
* ``name`` is the name given to the resource block.
* ``action`` identifies which steps Chef Infra Client will take to bring the node into the desired state.
* ``property`` is zero (or more) properties in the DSC resource, where each property is entered on a separate line, ``:dsc_property_name`` is the case-insensitive name of that property, and ``"property_value"`` is a Ruby value to be applied by Chef Infra Client
* ``module_name``, ``module_version``, ``property``, ``reboot_action``, ``resource``, and ``timeout`` are properties of this resource, with the Ruby type shown. See "Properties" section below for more information about all of the properties that may be used with this resource.


Actions
=====================================================

The dsc_resource resource has the following actions:

``:nothing``
   .. tag resources_common_actions_nothing

   This resource block does not act unless notified by another resource to take action. Once notified, this resource block either runs immediately or is queued up to run at the end of a Chef Infra Client run.

   .. end_tag

``:run``
   Default. Use to run the DSC configuration defined as defined in this resource.

Properties
=====================================================
The dsc_resource resource has the following properties:

``module_name``
   **Ruby Type:** String

   The name of the module from which a DSC resource originates. If this property is not specified, it will be inferred.

``module_version``
   **Ruby Type:** String

   The version number of the module to use. PowerShell 5.0.10018.0 (or higher) supports having multiple versions of a module installed. This should be specified along with the ``module_name``.

``property``
   **Ruby Type:** Symbol

   A property from a Desired State Configuration (DSC) resource. Use this property multiple times, one for each property in the Desired State Configuration (DSC) resource. The format for this property must follow ``property :dsc_property_name, "property_value"`` for each DSC property added to the resource block.

   The ``:dsc_property_name`` must be a symbol.

   Use the following Ruby types to define ``property_value``:

   .. list-table::
      :widths: 250 250
      :header-rows: 1

      * - Ruby
        - Windows PowerShell
      * - ``Array``
        - ``Object[]``
      * - ``Chef::Util::Powershell:PSCredential``
        - ``PSCredential``
      * - ``False``
        - ``bool($false)``
      * - ``Fixnum``
        - ``Integer``
      * - ``Float``
        - ``Double``
      * - ``Hash``
        - ``Hashtable``
      * - ``True``
        - ``bool($true)``

   These are converted into the corresponding Windows PowerShell type during a Chef Infra Client run.

``reboot_action``
   **Ruby Type:** Symbol | **Default Value:** ``:nothing``

   Use to request an immediate reboot or to queue a reboot using the :reboot_now (immediate reboot) or :request_reboot (queued reboot) actions built into the reboot resource.

``resource``
   **Ruby Type:** Symbol

   The name of the DSC resource. This value is case-insensitive and must be a symbol that matches the name of the DSC resource.

   For built-in DSC resources, use the following values:

   .. list-table::
      :widths: 250 250
      :header-rows: 1

      * - Value
        - Description
      * - ``:archive``
        - Use to `unpack archive (.zip) files <https://msdn.microsoft.com/en-us/powershell/dsc/archiveresource>`_.
      * - ``:environment``
        - Use to `manage system environment variables <https://msdn.microsoft.com/en-us/powershell/dsc/environmentresource>`_.
      * - ``:file``
        - Use to `manage files and directories <https://msdn.microsoft.com/en-us/powershell/dsc/fileresource>`_.
      * - ``:group``
        - Use to `manage local groups <https://msdn.microsoft.com/en-us/powershell/dsc/groupresource>`_.
      * - ``:log``
        - Use to `log configuration messages <https://msdn.microsoft.com/en-us/powershell/dsc/logresource>`_.
      * - ``:package``
        - Use to `install and manage packages <https://msdn.microsoft.com/en-us/powershell/dsc/packageresource>`_.
      * - ``:registry``
        - Use to `manage registry keys and registry key values <https://msdn.microsoft.com/en-us/powershell/dsc/registryresource>`_.
      * - ``:script``
        - Use to `run PowerShell script blocks <https://msdn.microsoft.com/en-us/powershell/dsc/scriptresource>`_.
      * - ``:service``
        - Use to `manage services <https://msdn.microsoft.com/en-us/powershell/dsc/serviceresource>`_.
      * - ``:user``
        - Use to `manage local user accounts <https://msdn.microsoft.com/en-us/powershell/dsc/userresource>`_.
      * - ``:windowsfeature``
        - Use to `add or remove Windows features and roles <https://msdn.microsoft.com/en-us/powershell/dsc/windowsfeatureresource>`_.
      * - ``:windowsoptionalfeature``
        - Use to configure Microsoft Windows optional features.
      * - ``:windowsprocess``
        - Use to `configure Windows processes <https://msdn.microsoft.com/en-us/powershell/dsc/windowsprocessresource>`_.

   Any DSC resource may be used in a Chef recipe. For example, the DSC Resource Kit contains resources for `configuring Active Directory components <http://www.powershellgallery.com/packages/xActiveDirectory/2.8.0.0>`_, such as ``xADDomain``, ``xADDomainController``, and ``xADUser``. Assuming that these resources are available to Chef Infra Client, the corresponding values for the ``resource`` attribute would be: ``:xADDomain``, ``:xADDomainController``, and ``xADUser``.

``timeout``
   **Ruby Type:** Integer

   The amount of time (in seconds) a command is to wait before timing out.



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

**Open a Zip file**

.. To use a zip file:

.. code-block:: ruby

   dsc_resource 'example' do
      resource :archive
      property :ensure, 'Present'
      property :path, 'C:\Users\Public\Documents\example.zip'
      property :destination, 'C:\Users\Public\Documents\ExtractionPath'
    end



**Manage users and groups**

.. To manage users and groups

.. code-block:: ruby

   dsc_resource 'demogroupadd' do
     resource :group
     property :groupname, 'demo1'
     property :ensure, 'present'
   end

   dsc_resource 'useradd' do
     resource :user
     property :username, 'Foobar1'
     property :fullname, 'Foobar1'
     property :password, ps_credential('P@assword!')
     property :ensure, 'present'
   end

   dsc_resource 'AddFoobar1ToUsers' do
     resource :Group
     property :GroupName, 'demo1'
     property :MembersToInclude, ['Foobar1']
   end



**Create and register a windows service**

.. To create a windows service:

The following example creates a windows service, defines it's execution path, and prevents windows from starting the service
in case the executable is not at the defined location:

.. code-block:: ruby

  dsc_resource 'NAME' do
    resource :service
    property :name, 'NAME'
    property :startuptype, 'Disabled'
    property :path, 'D:\\Sites\\Site_name\file_to_run.exe'
    property :ensure, 'Present'
    property :state, 'Stopped'
  end



**Create a test message queue**

.. To manage a message queue:

The following example creates a file on a node (based on one that is located in a cookbook), unpacks the ``MessageQueue.zip`` Windows PowerShell module, and then uses the **dsc_resource** to ensure that Message Queuing (MSMQ) sub-features are installed, a test queue is created, and that permissions are set on the test queue:

.. code-block:: ruby

   cookbook_file 'cMessageQueue.zip' do
     path "#{Chef::Config[:file_cache_path]}\\MessageQueue.zip"
     action :create_if_missing
   end

   windows_zipfile "#{ENV['PROGRAMW6432']}\\WindowsPowerShell\\Modules" do
     source "#{Chef::Config[:file_cache_path]}\\MessageQueue.zip"
     action :unzip
   end

   dsc_resource 'install-sub-features' do
     resource :windowsfeature
     property :ensure, 'Present'
     property :name, 'msmq'
     property :IncludeAllSubFeature, true
   end

   dsc_resource 'create-test-queue' do
     resource :cPrivateMsmqQueue
     property :ensure, 'Present'
     property :name, 'Test_Queue'
   end

   dsc_resource 'set-permissions' do
     resource :cPrivateMsmqQueuePermissions
     property :ensure, 'Present'
     property :name, 'Test_Queue_Permissions'
     property :QueueNames, 'Test_Queue'
     property :ReadUsers, node['msmq']['read_user']
   end



**Example to show usage of module properties**

.. To show usage of module properties:

.. code-block:: ruby

   dsc_resource 'test-cluster' do
     resource :xCluster
     module_name 'xFailOverCluster'
     module_version '1.6.0.0'
     property :name, 'TestCluster'
     property :staticipaddress, '10.0.0.3'
     property :domainadministratorcredential, ps_credential('abcd')
   end

