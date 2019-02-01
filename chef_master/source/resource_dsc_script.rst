=====================================================
dsc_script resource
=====================================================
`[edit on GitHub] <https://github.com/chef/chef-web-docs/blob/master/chef_master/source/resource_dsc_script.rst>`__

.. tag resources_common_powershell

Windows PowerShell is a task-based command-line shell and scripting language developed by Microsoft. Windows PowerShell uses a document-oriented approach for managing Microsoft Windows-based machines, similar to the approach that is used for managing Unix and Linux-based machines. Windows PowerShell is `a tool-agnostic platform <https://docs.microsoft.com/en-us/powershell/scripting/powershell-scripting>`_ that supports using Chef for configuration management.

.. end_tag

.. tag resources_common_powershell_dsc

Desired State Configuration (DSC) is a feature of Windows PowerShell that provides `a set of language extensions, cmdlets, and resources <https://docs.microsoft.com/en-us/powershell/dsc/overview>`_ that can be used to declaratively configure software. DSC is similar to Chef, in that both tools are idempotent, take similar approaches to the concept of resources, describe the configuration of a system, and then take the steps required to do that configuration. The most important difference between Chef and DSC is that Chef uses Ruby and DSC is exposed as configuration data from within Windows PowerShell.

.. end_tag

.. tag resource_dsc_script_summary

Many DSC resources are comparable to built-in Chef resources. For example, both DSC and Chef have **file**, **package**, and **service** resources. The **dsc_script** resource is most useful for those DSC resources that do not have a direct comparison to a resource in Chef, such as the ``Archive`` resource, a custom DSC resource, an existing DSC script that performs an important task, and so on. Use the **dsc_script** resource to embed the code that defines a DSC configuration directly within a Chef recipe.

.. end_tag

.. note:: Windows PowerShell 4.0 is required for using the **dsc_script** resource with Chef.

.. note:: The WinRM service must be enabled. (Use ``winrm quickconfig`` to enable the service.)

.. warning:: The **dsc_script** resource  may not be used in the same run-list with the **dsc_resource**. This is because the **dsc_script** resource requires that ``RefreshMode`` in the Local Configuration Manager be set to ``Push``, whereas the **dsc_resource** resource requires it to be set to ``Disabled``.

Syntax
=====================================================
.. tag resource_dsc_script_syntax

A **dsc_script** resource block embeds the code that defines a DSC configuration directly within a Chef recipe:

.. code-block:: ruby

   dsc_script 'get-dsc-resource-kit' do
     code <<-EOH
       Archive reskit
       {
         ensure = 'Present'
         path = "#{Chef::Config[:file_cache_path]}\\DSCResourceKit620082014.zip"
         destination = "#{ENV['PROGRAMW6432']}\\WindowsPowerShell\\Modules"
       }
     EOH
   end

where the **remote_file** resource is first used to download the ``DSCResourceKit620082014.zip`` file.

The full syntax for all of the properties that are available to the **dsc_script** resource is:

.. code-block:: ruby

   dsc_script 'name' do
     code                       String
     command                    String
     configuration_data         String
     configuration_data_script  String
     configuration_name         String
     cwd                        String
     environment                Hash
     flags                      Hash
     imports                    Array
     timeout                    Integer
     action                     Symbol # defaults to :run if not specified
   end

where:

* ``dsc_script`` is the resource.
* ``name`` is the name given to the resource block.
* ``action`` identifies which steps the chef-client will take to bring the node into the desired state.
* ``code``, ``command``, ``configuration_data``, ``configuration_data_script``, ``configuration_name``, ``cwd``, ``environment``, ``flags``, ``imports``, and ``timeout`` are properties of this resource, with the Ruby type shown. See "Properties" section below for more information about all of the properties that may be used with this resource.

.. end_tag

Actions
=====================================================
.. tag resource_dsc_script_actions

The dsc_script resource has the following actions:

``:nothing``

   .. tag resources_common_actions_nothing

   This resource block does not act unless notified by another resource to take action. Once notified, this resource block either runs immediately or is queued up to run at the end of the Chef Client run.

   .. end_tag

``:run``
   Default. Use to run the DSC configuration defined as defined in this resource.

.. end_tag

Properties
=====================================================
.. tag resource_dsc_script_properties

The dsc_script resource has the following properties:

``code``
   **Ruby Type:** String

   The code for the DSC configuration script. This property may not be used in conjunction with the ``command`` property.

``command``
   **Ruby Type:** String

   The path to a valid Windows PowerShell data file that contains the DSC configuration script. This data file must be capable of running independently of Chef and must generate a valid DSC configuration. This property may not be used in conjunction with the ``code`` property.

``configuration_data``
   **Ruby Type:** String

   The configuration data for the DSC script. The configuration data must be `a valid Windows PowerShell data file <https://docs.microsoft.com/en-us/powershell/developer/windows-powershell>`_. This property may not be used in conjunction with the ``configuration_data_script`` property.

``configuration_data_script``
   **Ruby Type:** String

   The path to a valid Windows PowerShell data file that also contains a node called ``localhost``. This property may not be used in conjunction with the ``configuration_data`` property.

``configuration_name``
   **Ruby Type:** String

   The name of a valid Windows PowerShell cmdlet. The name may only contain letter (a-z, A-Z), number (0-9), and underscore (_) characters and should start with a letter. The name may not be null or empty. This property may not be used in conjunction with the ``code`` property.

``cwd``
   **Ruby Type:** String

   The current working directory.

``environment``
   **Ruby Type:** Hash

   A Hash of environment variables in the form of ``({'ENV_VARIABLE' => 'VALUE'})``. (These variables must exist for a command to be run successfully.)

``flags``
   **Ruby Type:** Hash

   Pass parameters to the DSC script that is specified by the ``command`` property. Parameters are defined as key-value pairs, where the value of each key is the parameter to pass. This property may not be used in the same recipe as the ``code`` property. For example: ``flags ({ :EditorChoice => 'emacs', :EditorFlags => '--maximized' })``.

``imports``
   **Ruby Type:** Array

   .. warning:: This property **MUST** be used with the ``code`` attribute.

   Use to import DSC resources from a module.

   To import all resources from a module, specify only the module name:

   .. code-block:: ruby

      imports 'module_name'

   To import specific resources, specify the module name, and then specify the name for each resource in that module to import:

   .. code-block:: ruby

      imports 'module_name', 'resource_name_a', 'resource_name_b', ...

   For example, to import all resources from a module named ``cRDPEnabled``:

   .. code-block:: ruby

      imports 'cRDPEnabled'

   To import only the ``PSHOrg_cRDPEnabled`` resource:

   .. code-block:: ruby

      imports 'cRDPEnabled', 'PSHOrg_cRDPEnabled'

``timeout``
   **Ruby Type:** Integer

   The amount of time (in seconds) a command is to wait before timing out.

.. end_tag

ps_credential Helper
-----------------------------------------------------
.. tag resource_dsc_script_helper_ps_credential

Use the ``ps_credential`` helper to embed a ``PSCredential`` object--- `a set of security credentials, such as a user name or password <https://technet.microsoft.com/en-us/magazine/ff714574.aspx>`__ ---within a script, which allows that script to be run using security credentials.

For example, assuming the ``CertificateID`` is configured in the local configuration manager, the ``SeaPower1@3`` object is created and embedded within the ``seapower-user`` script:

.. code-block:: ruby

   dsc_script 'seapower-user' do
     code <<-EOH
       User AlbertAtom
       {
         UserName = 'AlbertAtom'
         Password = #{ps_credential('SeaPower1@3')}
       }
    EOH
    configuration_data <<-EOH
      @{
        AllNodes = @(
          @{
            NodeName = "localhost";
            CertificateID = 'A8D1234559F349F7EF19104678908F701D4167'
          }
        )
      }
    EOH
  end

.. end_tag

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

**Specify DSC code directly**

.. tag resource_dsc_script_code

DSC data can be specified directly in a recipe:

.. code-block:: ruby

   dsc_script 'emacs' do
     code <<-EOH
     Environment 'texteditor'
     {
       Name = 'EDITOR'
       Value = 'c:\\emacs\\bin\\emacs.exe'
     }
     EOH
   end

.. end_tag

**Specify DSC code using a Windows PowerShell data file**

.. tag resource_dsc_script_command

Use the ``command`` property to specify the path to a Windows PowerShell data file. For example, the following Windows PowerShell script defines the ``DefaultEditor``:

.. code-block:: powershell

   Configuration 'DefaultEditor'
   {
     Environment 'texteditor'
       {
         Name = 'EDITOR'
         Value = 'c:\emacs\bin\emacs.exe'
       }
   }

Use the following recipe to specify the location of that data file:

.. code-block:: ruby

   dsc_script 'DefaultEditor' do
     command 'c:\dsc_scripts\emacs.ps1'
   end

.. end_tag

**Pass parameters to DSC configurations**

.. tag resource_dsc_script_flags

If a DSC script contains configuration data that takes parameters, those parameters may be passed using the ``flags`` property. For example, the following Windows PowerShell script takes parameters for the ``EditorChoice`` and ``EditorFlags`` settings:

.. code-block:: powershell

   $choices = @{'emacs' = 'c:\emacs\bin\emacs';'vi' = 'c:\vim\vim.exe';'powershell' = 'powershell_ise.exe'}
     Configuration 'DefaultEditor'
       {
         [CmdletBinding()]
         param
           (
             $EditorChoice,
             $EditorFlags = ''
           )
         Environment 'TextEditor'
         {
           Name = 'EDITOR'
           Value =  "$($choices[$EditorChoice]) $EditorFlags"
         }
       }

Use the following recipe to set those parameters:

.. code-block:: ruby

   dsc_script 'DefaultEditor' do
     flags ({ :EditorChoice => 'emacs', :EditorFlags => '--maximized' })
     command 'c:\dsc_scripts\editors.ps1'
   end

.. end_tag

**Use custom configuration data**

.. tag resource_dsc_script_custom_config_data

Configuration data in DSC scripts may be customized from a recipe. For example, scripts are typically customized to set the behavior for Windows PowerShell credential data types. Configuration data may be specified in one of three ways:

* By using the ``configuration_data`` attribute
* By using the ``configuration_data_script`` attribute
* By specifying the path to a valid Windows PowerShell data file

.. end_tag

.. tag resource_dsc_script_configuration_data

The following example shows how to specify custom configuration data using the ``configuration_data`` property:

.. code-block:: ruby

   dsc_script 'BackupUser' do
     configuration_data <<-EOH
       @{
        AllNodes = @(
             @{
             NodeName = "localhost";
             PSDscAllowPlainTextPassword = $true
             })
        }
     EOH
     code <<-EOH
       $user = 'backup'
       $password = ConvertTo-SecureString -String "YourPass$(random)" -AsPlainText -Force
       $cred = New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList $user, $password

      User $user
        {
          UserName = $user
          Password = $cred
          Description = 'Backup operator'
          Ensure = "Present"
          Disabled = $false
          PasswordNeverExpires = $true
          PasswordChangeRequired = $false
        }
      EOH
   end

.. end_tag

.. tag resource_dsc_script_configuration_name

The following example shows how to specify custom configuration data using the ``configuration_name`` property. For example, the following Windows PowerShell script defines the ``vi`` configuration:

.. code-block:: powershell

   Configuration 'emacs'
     {
       Environment 'TextEditor'
       {
         Name = 'EDITOR'
         Value = 'c:\emacs\bin\emacs.exe'
       }
   }

   Configuration 'vi'
   {
       Environment 'TextEditor'
       {
         Name = 'EDITOR'
         Value = 'c:\vim\bin\vim.exe'
       }
   }

Use the following recipe to specify that configuration:

.. code-block:: ruby

   dsc_script 'EDITOR' do
     configuration_name 'vi'
     command 'C:\dsc_scripts\editors.ps1'
   end

.. end_tag

**Using DSC with other Chef resources**

.. tag resource_dsc_script_remote_files

The **dsc_script** resource can be used with other resources. The following example shows how to download a file using the **remote_file** resource, and then uncompress it using the DSC ``Archive`` resource:

.. code-block:: ruby

   remote_file "#{Chef::Config[:file_cache_path]}\\DSCResourceKit620082014.zip" do
     source 'http://gallery.technet.microsoft.com/DSC-Resource-Kit-All-c449312d/file/124481/1/DSC%20Resource%20Kit%20Wave%206%2008282014.zip'
   end

   dsc_script 'get-dsc-resource-kit' do
     code <<-EOH
       Archive reskit
       {
         ensure = 'Present'
         path = "#{Chef::Config[:file_cache_path]}\\DSCResourceKit620082014.zip"
         destination = "#{ENV['PROGRAMW6432']}\\WindowsPowerShell\\Modules"
       }
     EOH
   end

.. end_tag
