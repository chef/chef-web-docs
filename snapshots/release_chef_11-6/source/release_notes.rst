=====================================================
Release Notes: chef-client 11.6
=====================================================

.. tag chef

Chef is a powerful automation platform that transforms infrastructure into code. Whether you’re operating in the cloud, on-premises, or in a hybrid environment, Chef automates how infrastructure is configured, deployed, and managed across your network, no matter its size.

This diagram shows how you develop, test, and deploy your Chef code.

.. image:: ../../images/start_chef.svg
   :width: 700px
   :align: center

.. end_tag

Known Issues
=====================================================
The following issues are known for chef-client 11.6 and/or may affect the behavior of your current environment if you upgrade to chef-client 11.6:

* `CHEF-4406 <http://tickets.opscode.com/browse/CHEF-4406>`_  --- response_file fails trying to load preseed templates and falls back to cookbook files
* `CHEF-4419 <http://tickets.opscode.com/browse/CHEF-4419>`_  --- Absolute file paths with no drive letter for file resources on Windows fails chef-client run
* `CHEF-4422 <http://tickets.opscode.com/browse/CHEF-4422>`_  --- remote_file fails when source becomes too long
* `CHEF-4435 <http://tickets.opscode.com/browse/CHEF-4435>`_  --- Chef::DataBag.save does a PUT getting a 405 from the chef server; as a result of changes to the Chef server API, a chef-client must be version 11.6 (or higher) when using the ``knife data bag from file`` argument with the Enterprise Chef or Open Source Chef version 11 servers.

What's New
=====================================================
The following items are new for chef-client 11.6 and/or are changes from previous versions. The short version:

* **Support for SELinux** Support for SELinux has been improved, including the chef-client using the ``restorecon`` command when using **file**-based resources, correctly matching default policy settings (when the underlying cookbook also conforms to the same policy settings), and configurable file permission fixup (with the ``enable_selinux_file_permission_fixup`` setting in the client.rb file).
* **Atomic file updates** Atomic file updates ensure that updates are still made in certain situations, such as if disk space runs out or when a binary is being updated.
* **Lazy attribute evaluation** In some cases, the value for an attribute cannot be known until the execute phase of a chef-client run. Instead of an attribute being assigned a value, it may instead be assigned a code block, which can then be used during the execute phase to determine the attribute value.
* **Rebuilt file resource** The **file** resource has been refactored and is now the base resource for the **cookbook_file**, **remote_file**, and **template** resources.
* **New common attributes for file-based resources** The ``atomic_update``, ``force_unlink``, and ``manage_symlink_source`` attributes have been added.
* **New attributes for remote_file resource** The ``ftp_active_mode``, ``headers``, ``use_conditional_get``, ``use_etag``, and ``use_last_modified`` have been added.
* **New helper methods for the template resource** The ``helper`` and ``helpers`` attributes have been added. Use these to define helper methods to extend templates using by using inline helper methods, inline helper modules, and cookbook library modules.
* **Updated attributes for file-based resources** The ``source`` attribute has been modified to support FTP and local files.
* **Updated behavior for the mode attribute** The ``mode`` attribute default behavior is changed for file-based resources and the **directory** resource.
* **New batch resource** Execute a batch script using the cmd.exe interpreter. A temporary file is created and then executed like other script resources.
* **New powershell_script resource** Execute a script using the Windows PowerShell interpreter just like the **script** resource, but designed for the Microsoft Windows platform and the Windows PowerShell interpreter.
* **New settings for the client.rb file** The ``data_bag_decrypt_minimum_version``, ``enable_selinux_file_permission_fixup``, and ``file_atomic_update`` settings have been added.
* **New subcommands for Knife** ``knife deps``, ``knife edit``, and ``knife xargs`` have been added.
* **New options for Knife subcommands** The ``knife delete``, ``knife diff``, ``knife download``, ``knife list``, and ``knife upload`` subcommands have new options.
* **Support for environments in chef-solo** chef-solo now supports environments.
* **New way to force a redeploy when using the deploy resource** To force a redeploy, delete either the deployment directory or the cache file.
* **Changed behavior for chef-shell** chef-shell behavior is changed to load recipes while in chef-client mode. This is by design and represents the behavior as originally intended.

Required Updates
-----------------------------------------------------
.. warning:: The following updates must also be made at the same time as any upgrade to chef-client 11.6.

* If the ``partial-search`` cookbook is being used, it must be upgraded to version 1.0.2 (or higher)
* If the ``sudo`` cookbook is being used, it must be upgraded to version 2.1.4 (or higher)

Atomic File Updates
-----------------------------------------------------
.. tag resources_common_atomic_update

Atomic updates are used with **file**-based resources to help ensure that file updates can be made when updating a binary or if disk space runs out.

Atomic updates are enabled by default. They can be managed globally using the ``file_atomic_update`` setting in the client.rb file. They can be managed on a per-resource basis using the ``atomic_update`` property that is available with the **cookbook_file**, **file**, **remote_file**, and **template** resources.

.. note:: On certain platforms, and after a file has been moved into place, the chef-client may modify file permissions to support features specific to those platforms. On platforms with SELinux enabled, the chef-client will fix up the security contexts after a file has been moved into the correct location by running the ``restorecon`` command. On the Microsoft Windows platform, the chef-client will create files so that ACL inheritance works as expected.

.. end_tag

Lazy Attribute Evaluation
-----------------------------------------------------
.. tag resources_common_lazy_evaluation

In some cases, the value for a property cannot be known until the execution phase of a chef-client run. In this situation, using lazy evaluation of property values can be helpful. Instead of a property being assigned a value, it may instead be assigned a code block. The syntax for using lazy evaluation is as follows:

.. code-block:: ruby

   attribute_name lazy { code_block }

where ``lazy`` is used to tell the chef-client to evaluate the contents of the code block later on in the resource evaluation process (instead of immediately) and ``{ code_block }`` is arbitrary Ruby code that provides the value.

For example, a resource that is **not** doing lazy evaluation:

.. code-block:: ruby

   template 'template_name' do
     # some attributes
     path '/foo/bar'
   end

and a resource block that is doing lazy evaluation:

.. code-block:: ruby

   template 'template_name' do
     # some attributes
     path lazy { ' some Ruby code ' }
   end

In the previous examples, the first resource uses the value ``/foo/bar`` and the second resource uses the value provided by the code block, as long as the contents of that code block are a valid resource property.

The following example shows how to use lazy evaluation with template variables:

.. code-block:: ruby

   template '/tmp/canvey_island.txt' do
     source 'canvey_island.txt.erb'
     variables(
       lazy {
         { :canvey_island => node.run_state['sea_power'] }
       }
     )
   end

.. end_tag

**file**-based Resources
-----------------------------------------------------
Prior to chef-client 11.6, the chef-client relied on the underlying Ruby implementation to define behaviors for file-based resources (**cookbook_file**, **file**, **remote_file**, and **template**). These resources have been standardized and are now all fully based on the **file** resource.

* File-based providers now create all files with the same default permissions. This default is determined by operating system, file system type, and umask settings.
* When an SSH configuration file is created using the **cookbook_file** or **template** resources and the file mode for that SSH configuration file is not specified, it is possible for incorrect permissions to be applied. In previous versions, the chef-client would attempt to create the file with ``0600`` permissions if the file mode was not specified. For example:

   .. code-block:: ruby

      cookbook_file "/home/bob/.ssh/authorized_keys" do
        owner "bob"
        group "bob"
      end

   In chef-client 11.6, the chef-client may create files with other permissions---such as ``0644``---when the file mode is not specified. This may create situations where the correct permissions for an SSH configuration file are not applied, and subsequent SSH operations could fail. Use the ``mode`` attribute to ensure the correct permissions are applied to a file. For example:

   .. code-block:: ruby

      cookbook_file "/home/bob/.ssh/authorized_keys" do
        owner "bob"
        group "bob"
        mode 0600
      end

* File-based providers now have a defined behavior for when they encounter something other than a file when attempting to update a file. The ``force_unlink`` attribute is used to trigger an error (default) or to overwrite the target with the specified file. See the attributes section (below) for more information about this attribute.
* Many methods that were present in the file-based providers prior to chef-client 11.6 have been deprecated. If a custom provider has been authored that subclasses the pre-chef-client 11.6 file-based providers, the behavior of that custom provider should be re-tested after upgrading to chef-client 11.6 to verify all of the desired behaviors.

.. warning:: For a machine on which SELinux is enabled, the chef-client will create files that correctly match the default policy settings only when the cookbook that defines the action also conforms to the same policy.

File-based Attributes
-----------------------------------------------------
New attributes (common to all **file**-based resources):

.. list-table::
   :widths: 150 450
   :header-rows: 1

   * - Attribute
     - Description
   * - ``atomic_update``
     - Perform atomic file updates on a per-resource basis. Set to ``true`` for atomic file updates. Set to ``false`` for non-atomic file updates. This setting overrides ``file_atomic_update``, which is a global setting found in the client.rb file.
   * - ``force_unlink``
     - How the chef-client handles certain situations when the target file turns out not to be a file. For example, when a target file is actually a symlink. Set to ``true`` for the chef-client delete the non-file target and replace it with the specified file. Set to ``false`` for the chef-client to raise an error.
   * - ``manage_symlink_source``
     - Cause the chef-client to detect and manage the source file for a symlink. Possible values: ``nil``, ``true``, or ``false``. When this value is set to ``nil``, the chef-client will manage a symlink's source file and emit a warning. When this value is set to ``true``, the chef-client will manage a symlink's source file and not emit a warning. Default value: ``nil``. The default value will be changed to ``false`` in a future version.

**remote_file** Attributes
-----------------------------------------------------
The **remote_file** resource was updated to be fully-based on the **file** resource. Updated attributes:

.. list-table::
   :widths: 150 450
   :header-rows: 1

   * - Attribute
     - Description
   * - ``source``
     - Required. The location of the source file. Default value: ``nil``.

New attributes:

.. list-table::
   :widths: 150 450
   :header-rows: 1

   * - Attribute
     - Description
   * - ``ftp_active_mode``
     - Whether the chef-client uses active or passive FTP. Set to ``true`` to use active FTP. Default value: ``false``.
   * - ``headers``
     - A Hash of custom headers. Default value: ``{}``.
   * - ``use_conditional_get``
     - Enable conditional HTTP requests by using a conditional ``GET`` (with the If-Modified-Since header) or an opaque identifier (ETag). To use If-Modified-Since headers, ``use_last_modified`` must also be set to ``true``. To use ETag headers, ``use_etag`` must also be set to ``true``. Default value: ``true``.
   * - ``use_etag``
     - Enable ETag headers. Set to ``false`` to disable ETag headers. To use this setting, ``use_conditional_get`` must also be set to ``true``. Default value: ``true``.
   * - ``use_last_modified``
     - Enable If-Modified-Since headers. Set to ``false`` to disable If-Modified-Since headers. To use this setting, ``use_conditional_get`` must also be set to ``true``. Default value: ``true``.

**template** Attributes
-----------------------------------------------------
The **template** resource was updated to be fully-based on the **file** resource. Updated attributes:

.. list-table::
   :widths: 150 450
   :header-rows: 1

   * - Attribute
     - Description
   * - ``source``
     - The location of a template file. Can be used to distribute specific files to specific platforms. Default value: the ``name`` of the resource block.

New attributes:

.. list-table::
   :widths: 150 450
   :header-rows: 1

   * - Attribute
     - Description
   * - ``helper``
     - Define a helper method inline. For example: ``helper(:hello_world) { "hello world" }`` or ``helper(:app) { node["app"] }`` or ``helper(:app_conf) { |setting| node["app"][setting] }``. Default value: ``{}``.
   * - ``helpers``
     - Define a helper module inline or in a library. For example, an inline module: ``helpers do``, which is then followed by a block of Ruby code. And for a library module: ``helpers(MyHelperModule)``. Default value: ``[]``.

Helper Methods
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. tag resource_template_helper

A helper is a method or a module that can be used to extend a template. There are three approaches:

* An inline helper method
* An inline helper module
* A cookbook library module

Use the ``helper`` attribute in a recipe to define an inline helper method. Use the ``helpers`` attribute to define an inline helper module or a cookbook library module.

.. end_tag

**Inline Helper Methods**

.. tag resource_template_inline_method

A template helper method is always defined inline on a per-resource basis. A simple example:

.. code-block:: ruby

   template '/path' do
     helper(:hello_world) { 'hello world' }
   end

Another way to define an inline helper method is to reference a node object so that repeated calls to one (or more) cookbook attributes can be done efficiently:

.. code-block:: ruby

   template '/path' do
     helper(:app) { node['app'] }
   end

An inline helper method can also take arguments:

.. code-block:: ruby

   template '/path' do
     helper(:app_conf) { |setting| node['app'][setting] }
   end

Once declared, a template can then use the helper methods to build a file. For example:

.. code-block:: ruby

   Say hello: <%= hello_world %>

or:

.. code-block:: ruby

   node['app']['listen_port'] is: <%= app['listen_port'] %>

or:

.. code-block:: ruby

   node['app']['log_location'] is: <%= app_conf('log_location') %>

.. end_tag

**Inline Helper Modules**

.. tag resource_template_inline_module

A template helper module can be defined inline on a per-resource basis. This approach can be useful when a template requires more complex information. For example:

.. code-block:: ruby

   template '/path' do
     helpers do

       def hello_world
         'hello world'
       end

       def app
         node['app']
       end

       def app_conf(setting)
         node['app']['setting']
       end

     end
   end

where the ``hello_world``, ``app``, and ``app_conf(setting)`` methods comprise the module that extends a template.

.. end_tag

**Cookbook Library Modules**

.. tag resource_template_library_module

A template helper module can be defined in a library. This is useful when extensions need to be reused across recipes or to make it easier to manage code that would otherwise be defined inline on a per-recipe basis.

.. code-block:: ruby

   template '/path/to/template.erb' do
     helpers(MyHelperModule)
   end

.. end_tag

**cookbook_file** Attributes
-----------------------------------------------------
The **cookbook_file** resource was updated to be fully-based on the **file** resource. Updated attributes:

.. list-table::
   :widths: 150 450
   :header-rows: 1

   * - Attribute
     - Description
   * - ``source``
     - The name of the file in ``COOKBOOK_NAME/files/default`` or the path to a file located in ``COOKBOOK_NAME/files``. The path must include the file name and its extension. Can be used to distribute specific files to specific platforms. Default value: the ``name`` of the resource block.

Updated Behavior for mode Attribute
-----------------------------------------------------
The default behavior for the ``mode`` attribute has been updated. For the **directory** resource:

.. list-table::
   :widths: 150 450
   :header-rows: 1

   * - Attribute
     - Description
   * - ``mode``
     - If ``mode`` is not specified and if the directory already exists, the existing mode on the directory is used. If ``mode`` is not specified, the directory does not exist, and the ``:create`` action is specified, the chef-client assumes a mask value of ``'0777'``, and then applies the umask for the system on which the directory is to be created to the ``mask`` value. For example, if the umask on a system is ``'022'``, the chef-client uses the default value of ``'0755'``.

And for each of the file-based resources (**cookbook_file**, **file**, **remote_file**, and **template**):

.. list-table::
   :widths: 150 450
   :header-rows: 1

   * - Attribute
     - Description
   * - ``mode``
     - If ``mode`` is not specified and if the file already exists, the existing mode on the file is used. If ``mode`` is not specified, the file does not exist, and the ``:create`` action is specified, the chef-client assumes a mask value of ``'0777'`` and then applies the umask for the system on which the file is to be created to the ``mask`` value. For example, if the umask on a system is ``'022'``, the chef-client uses the default value of ``'0755'``.

**batch** Resource 
-----------------------------------------------------
.. tag resource_batch_21

Use the **batch** resource to execute a batch script using the cmd.exe interpreter. The **batch** resource creates and executes a temporary file (similar to how the **script** resource behaves), rather than running the command inline. This resource inherits actions (``:run`` and ``:nothing``) and properties (``creates``, ``cwd``, ``environment``, ``group``, ``path``, ``timeout``, and ``user``) from the **execute** resource. Commands that are executed with this resource are (by their nature) not idempotent, as they are typically unique to the environment in which they are run. Use ``not_if`` and ``only_if`` to guard this resource for idempotence.

.. end_tag

Syntax
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. tag resource_batch_syntax

A **batch** resource block executes a batch script using the cmd.exe interpreter:

.. code-block:: ruby

   batch 'echo some env vars' do
     code <<-EOH
       echo %TEMP%
       echo %SYSTEMDRIVE%
       echo %PATH%
       echo %WINDIR%
       EOH
   end

The full syntax for all of the properties that are available to the **batch** resource is:

.. code-block:: ruby

   batch 'name' do
     architecture               Symbol
     code                       String
     command                    String, Array
     creates                    String
     cwd                        String
     flags                      String
     group                      String, Integer
     guard_interpreter          Symbol
     interpreter                String
     notifies                   # see description
     provider                   Chef::Provider::Batch
     returns                    Integer, Array
     subscribes                 # see description
     timeout                    Integer, Float
     user                       String, Integer
     action                     Symbol # defaults to :run if not specified
   end

where

* ``batch`` is the resource
* ``name`` is the name of the resource block
* ``command`` is the command to be run and ``cwd`` is the location from which the command is run
* ``:action`` identifies the steps the chef-client will take to bring the node into the desired state
* ``architecture``, ``code``, ``command``, ``creates``, ``cwd``, ``flags``, ``group``, ``guard_interpreter``, ``interpreter``, ``provider``, ``returns``, ``timeout``, and ``user`` are properties of this resource, with the Ruby type shown. See "Properties" section below for more information about all of the properties that may be used with this resource.

.. end_tag

Actions
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. tag resource_batch_actions

This resource has the following actions:

``:nothing``
   .. tag resources_common_actions_nothing

   Define this resource block to do nothing until notified by another resource to take action. When this resource is notified, this resource block is either run immediately or it is queued up to be run at the end of the chef-client run.

   .. end_tag

``:run``
   Run a batch file.

.. end_tag

Attributes
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. tag 16_12

This resource has the following properties:

``architecture``
   **Ruby Type:** Symbol

   The architecture of the process under which a script is executed. If a value is not provided, the chef-client defaults to the correct value for the architecture, as determined by Ohai. An exception is raised when anything other than ``:i386`` is specified for a 32-bit process. Possible values: ``:i386`` (for 32-bit processes) and ``:x86_64`` (for 64-bit processes).

``code``
   **Ruby Type:** String

   A quoted (" ") string of code to be executed.

``command``
   **Ruby Types:** String, Array

   The name of the command to be executed.

``creates``
   **Ruby Type:** String

   Prevent a command from creating a file when that file already exists.

``cwd``
   **Ruby Type:** String

   The current working directory from which a command is run.

``flags``
   **Ruby Type:** String

   One or more command line flags that are passed to the interpreter when a command is invoked.

``group``
   **Ruby Types:** String, Integer

   The group name or group ID that must be changed before running a command.

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

``provider``
   **Ruby Type:** Chef Class

   Optional. Explicitly specifies a provider.

``retries``
   **Ruby Type:** Integer

   The number of times to catch exceptions and retry the resource. Default value: ``0``.

``retry_delay``
   **Ruby Type:** Integer

   The retry delay (in seconds). Default value: ``2``.

``returns``
   **Ruby Types:** Integer, Array

   The return value for a command. This may be an array of accepted values. An exception is raised when the return value(s) do not match. Default value: ``0``.

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
   **Ruby Types:** Integer, Float

   The amount of time (in seconds) a command is to wait before timing out. Default value: ``3600``.

``user``
   **Ruby Types:** String, Integer

   A user name or identifier that must be changed before running a command.

.. note:: .. tag notes_batch_resource_link_to_cmdexe_technet

          See http://technet.microsoft.com/en-us/library/bb490880.aspx for more information about the cmd.exe interpreter.

          .. end_tag

.. end_tag

**powershell_script** Resource 
-----------------------------------------------------
.. tag resource_powershell_script_21

Use the **powershell_script** resource to execute a script using the Windows PowerShell interpreter, much like how the **script** and **script**-based resources---**bash**, **csh**, **perl**, **python**, and **ruby**---are used. The **powershell_script** is specific to the Microsoft Windows platform and the Windows PowerShell interpreter.

The **powershell_script** resource creates and executes a temporary file (similar to how the **script** resource behaves), rather than running the command inline. Commands that are executed with this resource are (by their nature) not idempotent, as they are typically unique to the environment in which they are run. Use ``not_if`` and ``only_if`` to guard this resource for idempotence.

.. end_tag

Syntax
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. tag resource_powershell_script_syntax

A **powershell_script** resource block executes a batch script using the Windows PowerShell interpreter. For example, writing to an interpolated path:

.. code-block:: ruby

   powershell_script 'write-to-interpolated-path' do
     code <<-EOH
     $stream = [System.IO.StreamWriter] "#{Chef::Config[:file_cache_path]}/powershell-test.txt"
     $stream.WriteLine("In #{Chef::Config[:file_cache_path]}...word.")
     $stream.close()
     EOH
   end

The full syntax for all of the properties that are available to the **powershell_script** resource is:

.. code-block:: ruby

   powershell_script 'name' do
     architecture               Symbol
     code                       String
     command                    String, Array
     convert_boolean_return     TrueClass, FalseClass
     creates                    String
     cwd                        String
     environment                Hash
     flags                      String
     group                      String, Integer
     guard_interpreter          Symbol
     interpreter                String
     notifies                   # see description
     provider                   Chef::Provider::PowershellScript
     returns                    Integer, Array
     subscribes                 # see description
     timeout                    Integer, Float
     action                     Symbol # defaults to :run if not specified
   end

where

* ``powershell_script`` is the resource
* ``name`` is the name of the resource block
* ``command`` is the command to be run and ``cwd`` is the location from which the command is run
* ``:action`` identifies the steps the chef-client will take to bring the node into the desired state
* ``architecture``, ``code``, ``command``, ``convert_boolean_return``, ``creates``, ``cwd``, ``environment``, ``flags``, ``group``, ``guard_interpreter``, ``interpreter``, ``provider``, ``returns``, and ``timeout`` are properties of this resource, with the Ruby type shown. See "Properties" section below for more information about all of the properties that may be used with this resource.

.. end_tag

Actions
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. tag resource_powershell_script_actions

This resource has the following actions:

``:nothing``
   Inherited from **execute** resource. Prevent a command from running. This action is used to specify that a command is run only when another resource notifies it.

``:run``
   Default. Run the script.

.. end_tag

Attributes
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. tag 10_7

This resource has the following properties:

``architecture``
   **Ruby Type:** Symbol

   The architecture of the process under which a script is executed. If a value is not provided, the chef-client defaults to the correct value for the architecture, as determined by Ohai. An exception is raised when anything other than ``:i386`` is specified for a 32-bit process. Possible values: ``:i386`` (for 32-bit processes) and ``:x86_64`` (for 64-bit processes).

``code``
   **Ruby Type:** String

   A quoted (" ") string of code to be executed.

``command``
   **Ruby Types:** String, Array

   The name of the command to be executed. Default value: the ``name`` of the resource block See "Syntax" section above for more information.

``flags``
   **Ruby Type:** String

   A string that is passed to the Windows PowerShell command. Default value: ``-NoLogo, -NonInteractive, -NoProfile, -ExecutionPolicy RemoteSigned, -InputFormat None, -File``.

``ignore_failure``
   **Ruby Types:** TrueClass, FalseClass

   Continue running a recipe if a resource fails for any reason. Default value: ``false``.

``interpreter``
   **Ruby Type:** String

   The script interpreter to use during code execution. Changing the default value of this property is not supported.

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

``provider``
   **Ruby Type:** Chef Class

   Optional. Explicitly specifies a provider.

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

.. end_tag

client.rb Settings
-----------------------------------------------------
New settings have been added to the client.rb file:

.. list-table::
   :widths: 200 300
   :header-rows: 1

   * - Setting
     - Description
   * - ``data_bag_decrypt_minimum_version``
     - The minimum required version of data bag encryption. Possible values: ``0``, ``1``, and ``2``. When all of the machines in an organization are running chef-client version 11.6 (or higher), it is recommended that this value be set to ``2``. For example:

       .. code-block:: ruby

          data_bag_decrypt_minimum_version "2"
   * - ``enable_selinux_file_permission_fixup``
     - SELinux environments only. Cause the chef-client to attempt to apply the correct file permissions to an updated file via the ``restorecon`` command. Set this value to ``false`` to prevent the chef-client from attempting this action. For example:

       .. code-block:: ruby

          enable_selinux_file_permission_fixup true
   * - ``file_atomic_update``
     - Apply atomic file updates to all resources. Set to ``true`` for global atomic file updates. Set to ``false`` for global non-atomic file updates. (Use the ``atomic_update`` setting on a per-resource basis to override this setting.) For example:

       .. code-block:: ruby

          file_atomic_update true
   * - ``no_lazy_load``
     - Download all cookbook files and templates at the beginning of the chef-client run. Default value: ``false``. For example:

       .. code-block:: ruby

          no_lazy_load false

knife Subcommands
-----------------------------------------------------
The following updates have been made to knife subcommands:

* The knife essentials group of subcommands can be used with all objects in the chef-repo and/or on the Chef server: ``clients/``, ``cookbooks/``, ``data_bags/``, ``environments/``, ``nodes``, ``roles/``, and ``users``
* The knife essentials group of subcommands can be used with the following objects located in Hosted Chef: ``acls``, ``groups``, and ``containers``
* The ``knife download`` subcommand can access all objects on the Chef server and can now be used to pull a full-fidelity backup of the entire organization

New subcommands have been added to knife:

* ``knife deps``
* ``knife edit``
* ``knife xargs``

knife deps
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. tag knife_deps_22

Use the ``knife deps`` subcommand to identify dependencies for a node, role, or cookbook.

.. end_tag

**Syntax**

.. tag knife_deps_syntax

This subcommand has the following syntax:

.. code-block:: bash

   $ knife deps (options)

.. end_tag

**Options**

.. tag knife_deps_options

This subcommand has the following options:

``--chef-repo-path PATH``
   The path to the chef-repo. This setting will override the default path to the chef-repo. Default: same value as specified by ``chef_repo_path`` in client.rb.

``--concurrency``
   The number of allowed concurrent connections. Default: ``10``.

``--[no-]recurse``
   Use ``--recurse`` to list dependencies recursively. This option can only be used when ``--tree`` is set to ``true``. Default: ``--no-recurse``.

``--remote``
   Determine dependencies from objects located on the Chef server instead of in the local chef-repo. Default: ``false``.

``--repo-mode MODE``
   The layout of the local chef-repo. Possible values: ``static``, ``everything``, or ``hosted_everything``. Use ``static`` for just roles, environments, cookbooks, and data bags. By default, ``everything`` and ``hosted_everything`` are dynamically selected depending on the server type. Default: ``everything`` / ``hosted_everything``.

``--tree``
   Show dependencies in a visual tree structure (including duplicates, if they exist). Default: ``false``.

.. end_tag

Many of these settings are also configurable in the knife.rb file.

knife edit
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. tag knife_edit_22

Use the ``knife edit`` subcommand to edit objects on the Chef server. This subcommand works similar to ``knife cookbook edit``, ``knife data bag edit``, ``knife environment edit``, ``knife node edit``, and ``knife role edit``, but with a single verb (and a single action).

.. end_tag

**Syntax**

.. tag knife_edit_syntax

This subcommand has the following syntax:

.. code-block:: bash

   $ knife edit (options)

.. end_tag

**Options**

.. tag knife_edit_options

This subcommand has the following options:

``--chef-repo-path PATH``
   The path to the chef-repo. This setting will override the default path to the chef-repo. Default: same value as specified by ``chef_repo_path`` in client.rb.

``--concurrency``
   The number of allowed concurrent connections. Default: ``10``.

``--local``
   Show files in the local chef-repo instead of a remote location. Default: ``false``.

``--repo-mode MODE``
   The layout of the local chef-repo. Possible values: ``static``, ``everything``, or ``hosted_everything``. Use ``static`` for just roles, environments, cookbooks, and data bags. By default, ``everything`` and ``hosted_everything`` are dynamically selected depending on the server type. Default: ``everything`` / ``hosted_everything``.

.. end_tag

Many of these settings are also configurable in the knife.rb file.

knife xargs
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. tag knife_xargs_22

Use the ``knife xargs`` subcommand to take patterns from standard input, download as JSON, run a command against the downloaded JSON, and then upload any changes.

.. end_tag

**Syntax**

.. tag knife_xargs_syntax

This subcommand has the following syntax:

.. code-block:: bash

   $ knife xargs [PATTERN...] (options)

.. end_tag

**Options**

.. tag knife_xargs_options

This subcommand has the following options:

``-0``
   |use null_character| Default: ``false``.

``--chef-repo-path PATH``
   The path to the chef-repo. This setting will override the default path to the chef-repo. Default: same value as specified by ``chef_repo_path`` in client.rb.

``--concurrency``
   The number of allowed concurrent connections. Default: ``10``.

``--[no-]diff``
   Show a diff when a file changes. Default: ``--diff``.

``--dry-run``
   Prevent changes from being uploaded to the Chef server. Default: ``false``.

``--[no-]force``
   Force the upload of files even if they haven't been changed. Default: ``--no-force``.

``-I REPLACE_STRING``, ``--replace REPLACE_STRING``
   Define a string that is to be used to replace all occurrences of a file name. Default: ``nil``.

``-J REPLACE_STRING``, ``--replace-first REPLACE_STRING``
   Define a string that is to be used to replace the first occurrence of a file name. Default: ``nil``.

``--local``
   Build or execute a command line against a local file. Set to ``false`` to build or execute against a remote file. Default: ``false``.

``-n MAX_ARGS``, ``--max-args MAX_ARGS``
   The maximum number of arguments per command line. Default: ``nil``.

``-p [PATTERN...]``, ``--pattern [PATTERN...]``
   One (or more) patterns for a command line. If this option is not specified, a list of patterns may be expected on standard input. Default: ``nil``.

``--repo-mode MODE``
   The layout of the local chef-repo. Possible values: ``static``, ``everything``, or ``hosted_everything``. Use ``static`` for just roles, environments, cookbooks, and data bags. By default, ``everything`` and ``hosted_everything`` are dynamically selected depending on the server type. Default value: ``default``.

``-s LENGTH``, ``--max-chars LENGTH``
   The maximum size (in characters) for a command line. Default: ``nil``.

``-t``
   Run the print command on the command line. Default: ``nil``.

.. end_tag

Many of these settings are also configurable in the knife.rb file.

knife Options
-----------------------------------------------------
New options have been added to the following knife subcommands:

knife delete
+++++++++++++++++++++++++++++++++++++++++++++++++++++

``--both``
   Delete both local and remote copies of an object. Default: ``false``.

``--local``
   Delete only the local copy of an object. A remote copy will not be deleted. Default: ``false``.

knife diff
+++++++++++++++++++++++++++++++++++++++++++++++++++++

``--diff-filter=[(A|D|M|T)...[*]]``
   Select only files that have been added (``A``), deleted (``D``), modified (``M``), and/or have had their type changed (``T``). Any combination of filter characters may be used, including no filter characters. Use ``*`` to select all paths if a file matches other criteria in the comparison. Default value: ``nil``.

knife download
+++++++++++++++++++++++++++++++++++++++++++++++++++++

``--[no-]diff``
   Download only new and modified files. Set to ``false`` to download all files. Default: ``--diff``.

knife list
+++++++++++++++++++++++++++++++++++++++++++++++++++++

``-f``, ``--flat``
   Show a list of file names. Set to ``false`` to view ``ls``-like output. Default: ``false``.

``--local``
   Return only the contents of the local directory. Default: ``false``.

``-1``
   Show only one column of results. Default: ``false``.

``-p``
   Show directories with trailing slashes (/). Default: ``false``.

knife upload
+++++++++++++++++++++++++++++++++++++++++++++++++++++

``--[no-]freeze``
   Require changes to a cookbook be included as a new version. Only the ``--force`` option can override this setting. Default: ``--no-freeze``.

``--[no-]diff``
   Upload only new and modified files. Set to ``false`` to upload all files. Default: ``--diff``.

New common options for certain Knife subcommands
-----------------------------------------------------
The following options are new for the ``knife delete``, ``knife deps``, ``knife diff``, ``knife download``, ``knife edit``, ``knife list``, ``knife raw``, ``knife show``, ``knife upload``, and ``knife xargs`` subcommands:

``--chef-repo-path PATH``
   The path to the chef-repo. This setting will override the default path to the chef-repo. Default: same as specified by ``chef_repo_path`` in config.rb.

``--concurrency``
   The maximum number of simultaneous requests to be sent. Default: ``10``.

``--repo-mode MODE``
   The layout of the local chef-repo. Possible values: ``static``, ``everything``, or ``hosted_everything``. Use ``static`` for just roles, environments, cookbooks, and data bags. By default, ``everything`` and ``hosted_everything`` are dynamically selected depending on the server type. Default value: ``default``.

knife.rb Settings
-----------------------------------------------------
New settings have been added to the knife.rb file:

.. list-table::
   :widths: 200 300
   :header-rows: 1

   * - Setting
     - Description
   * - ``versioned_cookbooks``
     - Append cookbook versions to cookbooks. Set to ``false`` to hide cookbook versions: ``cookbooks/apache``. Set to ``true`` to show cookbook versions: ``cookbooks/apache-1.0.0`` and/or ``cookbooks/apache-1.0.1``. When this setting is ``true``, ``knife download`` downloads ALL cookbook versions, which can be useful if a full-fidelity backup of data on the Chef server is required. For example:

       .. code-block:: ruby

          versioned_cookbooks true

chef-solo Environments
-----------------------------------------------------
chef-solo now supports environments.

.. tag chef_solo_environments

An environment is defined using JSON or the Ruby DSL. chef-solo will look for environments in ``/var/chef/environments``, but this location can be modified by changing the setting for ``environment_path`` in solo.rb. For example, the following setting in solo.rb:

.. code-block:: ruby

   environment_path '/var/chef-solo/environments'

Environment data looks like the following in JSON:

.. code-block:: javascript

   {
     "name": "dev",
     "default_attributes": {
       "apache2": {
         "listen_ports": [
           "80",
           "443"
         ]
       }
     },
     "json_class": "Chef::Environment",
       "description": "",
       "cookbook_versions": {
       "couchdb": "= 11.0.0"
     },
     "chef_type": "environment"
     }

and like the following in the Ruby DSL:

.. code-block:: ruby

   name 'environment_name'
   description 'environment_description'
   cookbook OR cookbook_versions  'cookbook' OR 'cookbook' => 'cookbook_version'
   default_attributes 'node' => { 'attribute' => [ 'value', 'value', 'etc.' ] }
   override_attributes 'node' => { 'attribute' => [ 'value', 'value', 'etc.' ] }

.. end_tag

solo.rb
+++++++++++++++++++++++++++++++++++++++++++++++++++++
A new setting has been added to the solo.rb file:

.. list-table::
   :widths: 200 300
   :header-rows: 1

   * - Setting
     - Description
   * - ``environment_path``
     - The path to the environment.  Default value: ``/var/chef/environments``. For example:

       .. code-block:: ruby

          environment_path "/var/chef/environments"

Force a Redeploy
-----------------------------------------------------
Previous versions required the cache file to be deleted to force a redeploy. In chef-client 11.6, in addition to deleting the cache file, deleting the deployment directory will also force a redeploy.

What's Fixed
=====================================================
The following bugs were fixed:

* `CHEF-679 <http://tickets.opscode.com/browse/CHEF-679>`_  --- remote_file acts unexpectedly when it encounters a link
* `CHEF-955 <http://tickets.opscode.com/browse/CHEF-955>`_  --- 11: Make git provider respond to a new repo URL
* `CHEF-972 <http://tickets.opscode.com/browse/CHEF-972>`_  --- resource action should have higher precedence than only_if/not_if
* `CHEF-1162 <http://tickets.opscode.com/browse/CHEF-1162>`_  --- Deploy should redeploy when the deploy directory is removed
* `CHEF-1707 <http://tickets.opscode.com/browse/CHEF-1707>`_  --- unable to set password for user on solaris
* `CHEF-1782 <http://tickets.opscode.com/browse/CHEF-1782>`_  --- remote_file gives deceptive error message replacing remote_file of running process
* `CHEF-1967 <http://tickets.opscode.com/browse/CHEF-1967>`_  --- Mount provider should be able to allow "none" as a valid mountpoint
* `CHEF-2406 <http://tickets.opscode.com/browse/CHEF-2406>`_  --- pretty knife status is ugly on windows
* `CHEF-2420 <http://tickets.opscode.com/browse/CHEF-2420>`_  --- Git resource always re-checks out unchanged annotated tags
* `CHEF-2467 <http://tickets.opscode.com/browse/CHEF-2467>`_  --- 11: Attributes set in role not available via node object when running shef in client mode
* `CHEF-2682 <http://tickets.opscode.com/browse/CHEF-2682>`_  --- Redirected API requests can result in confusing error messages
* `CHEF-2694 <http://tickets.opscode.com/browse/CHEF-2694>`_  --- ErrorHandler json format can cause complete meltdown of chef client
* `CHEF-2741 <http://tickets.opscode.com/browse/CHEF-2741>`_  --- deploy resource does not recover from failures partway through operation on future invocations
* `CHEF-2770 <http://tickets.opscode.com/browse/CHEF-2770>`_  --- user_valid_regex is too restrictive
* `CHEF-2840 <http://tickets.opscode.com/browse/CHEF-2840>`_  --- SSL Verification fails using omnibus installer because of missing certs
* `CHEF-3005 <http://tickets.opscode.com/browse/CHEF-3005>`_  --- chef-client ignores port specification in an HTTPS URL
* `CHEF-3045 <http://tickets.opscode.com/browse/CHEF-3045>`_  --- Chef errors out with 403 when retrieving cookbook_file, template resources on a very long Chef run
* `CHEF-3192 <http://tickets.opscode.com/browse/CHEF-3192>`_  --- File providers in whyrun branch need cleanup in how they handle tempfiles
* `CHEF-3237 <http://tickets.opscode.com/browse/CHEF-3237>`_  --- Expanding '~/Library/LaunchAgents' fails resolving HOME when running chef-client as root
* `CHEF-3255 <http://tickets.opscode.com/browse/CHEF-3255>`_  --- Knife doesn't filter out older versions of plugins
* `CHEF-3332 <http://tickets.opscode.com/browse/CHEF-3332>`_  --- The route resource provider will always delete config file even for :add action
* `CHEF-3366 <http://tickets.opscode.com/browse/CHEF-3366>`_  --- zypper provider for package resource can block
* `CHEF-3386 <http://tickets.opscode.com/browse/CHEF-3386>`_  --- 11: Chef init script improper PID check
* `CHEF-3442 <http://tickets.opscode.com/browse/CHEF-3442>`_  --- Portage package provider souldn't raise an error "Multiple packages found for ..." when the category is specified
* `CHEF-3452 <http://tickets.opscode.com/browse/CHEF-3452>`_  --- uploading frozen cookbooks shows unfriendly error message
* `CHEF-3471 <http://tickets.opscode.com/browse/CHEF-3471>`_  --- knife bootstrap of a Solaris 10 host is an immediate failure
* `CHEF-3516 <http://tickets.opscode.com/browse/CHEF-3516>`_  --- 11: Some knife commands emit Errno::EPIPE when used in a pipeline
* `CHEF-3521 <http://tickets.opscode.com/browse/CHEF-3521>`_  --- Chef should set a timeout for yum-dump
* `CHEF-3535 <http://tickets.opscode.com/browse/CHEF-3535>`_  --- Chef::REST doesn't require 'chef/platform' but uses it
* `CHEF-3544 <http://tickets.opscode.com/browse/CHEF-3544>`_  --- 11: Cookbook syntax check should honor chefignore file
* `CHEF-3557 <http://tickets.opscode.com/browse/CHEF-3557>`_  --- File Security Metadata Reporting is Broken on Windows
* `CHEF-3683 <http://tickets.opscode.com/browse/CHEF-3683>`_  --- 11: Chef::Node objects should be sortable
* `CHEF-3685 <http://tickets.opscode.com/browse/CHEF-3685>`_  --- rspec tests fail because chef-10.16.2.gem does not contain .dotfile
* `CHEF-3690 <http://tickets.opscode.com/browse/CHEF-3690>`_  --- refactor of windows_service.rb has broken chef-client when run as windows service
* `CHEF-3731 <http://tickets.opscode.com/browse/CHEF-3731>`_  --- Delayed attribute evaluation
* `CHEF-3772 <http://tickets.opscode.com/browse/CHEF-3772>`_  --- Managing services on Solaris and SmartOS does not works well
* `CHEF-3779 <http://tickets.opscode.com/browse/CHEF-3779>`_  --- Add -A (forward SSH agent) option to knife commands
* `CHEF-3781 <http://tickets.opscode.com/browse/CHEF-3781>`_  --- Add knife deps and knife-essentials changes from 1.0.0
* `CHEF-3798 <http://tickets.opscode.com/browse/CHEF-3798>`_  --- user provider on Windows tries to set the password even if not provided
* `CHEF-3803 <http://tickets.opscode.com/browse/CHEF-3803>`_  --- mount resource does not update fstab entry when mount options have changed
* `CHEF-3804 <http://tickets.opscode.com/browse/CHEF-3804>`_  --- device_mount_regex in mount provider does not handle symlinks correctly
* `CHEF-3817 <http://tickets.opscode.com/browse/CHEF-3817>`_  --- Overriding duplicate definition *
* `CHEF-3847 <http://tickets.opscode.com/browse/CHEF-3847>`_  --- LanguageIncludeRecipe deprecation warning is incorrect
* `CHEF-3858 <http://tickets.opscode.com/browse/CHEF-3858>`_  --- Unsuccessful decryption of encrypted data bag items does not always cause an error
* `CHEF-3872 <http://tickets.opscode.com/browse/CHEF-3872>`_  --- chef-client fails when run in open source XenServer ( platform xcp )
* `CHEF-3878 <http://tickets.opscode.com/browse/CHEF-3878>`_  --- Chef should have a native partial search library
* `CHEF-3895 <http://tickets.opscode.com/browse/CHEF-3895>`_  --- Cannot Upload Cookbooks
* `CHEF-3903 <http://tickets.opscode.com/browse/CHEF-3903>`_  --- File resource doesn't handle binary correctly on windows
* `CHEF-3920 <http://tickets.opscode.com/browse/CHEF-3920>`_  --- Repeated text in converge_by message for LWRPs when running in why_run mode
* `CHEF-3932 <http://tickets.opscode.com/browse/CHEF-3932>`_  --- Later Knife.deps (i.e. dependency lazy loading) call overrides the earlier block
* `CHEF-3933 <http://tickets.opscode.com/browse/CHEF-3933>`_  --- Gem Package provider incompatible with rubygems 2.0
* `CHEF-3935 <http://tickets.opscode.com/browse/CHEF-3935>`_  --- Logger mutex causes errors in trap handlers with ruby 2.0
* `CHEF-3937 <http://tickets.opscode.com/browse/CHEF-3937>`_  --- Chef::Knife::CookbookUpload is missing [require 'chef/cookbook_uploader'] causing exceptions from ref on line 230
* `CHEF-3938 <http://tickets.opscode.com/browse/CHEF-3938>`_  --- Make gpg checks configurable in the zypper package provider
* `CHEF-3949 <http://tickets.opscode.com/browse/CHEF-3949>`_  --- File Provider Refactor
* `CHEF-3963 <http://tickets.opscode.com/browse/CHEF-3963>`_  --- and_return with should_not_receive is deprecated in rspec
* `CHEF-3978 <http://tickets.opscode.com/browse/CHEF-3978>`_  --- remote_file does not support why-run correctly
* `CHEF-3979 <http://tickets.opscode.com/browse/CHEF-3979>`_  --- remote_file source "downloaded from" is empty, but works
* `CHEF-3982 <http://tickets.opscode.com/browse/CHEF-3982>`_  --- wget/curl dep in chef-full knife bootstrap script fails on Solaris 10
* `CHEF-4010 <http://tickets.opscode.com/browse/CHEF-4010>`_  --- Chef client does not release lock when connection to server failed
* `CHEF-4015 <http://tickets.opscode.com/browse/CHEF-4015>`_  --- suse group provider is broken on openSUSE 12.3 with shadow utils
* `CHEF-4022 <http://tickets.opscode.com/browse/CHEF-4022>`_  --- "knife cookbook download" of nonexistant cookbook throws NoMethodError
* `CHEF-4038 <http://tickets.opscode.com/browse/CHEF-4038>`_  --- File diffs in functional tests run very slowly under jenkins on windows 2k8
* `CHEF-4050 <http://tickets.opscode.com/browse/CHEF-4050>`_  --- include etags, last-modified, expires and cache-control header handling in Chef::REST
* `CHEF-4065 <http://tickets.opscode.com/browse/CHEF-4065>`_  --- change chef-client config default to use client_fork
* `CHEF-4082 <http://tickets.opscode.com/browse/CHEF-4082>`_  --- When the file / template has a hardcoded path defined (either set via node attribute or hard coded as in the example), the notifies parameter does not work
* `CHEF-4083 <http://tickets.opscode.com/browse/CHEF-4083>`_  --- Typo in status running chef-client
* `CHEF-4100 <http://tickets.opscode.com/browse/CHEF-4100>`_  --- Chef::Util::FileEdit raise()s if file exists but is just empty -- this is bogus
* `CHEF-4102 <http://tickets.opscode.com/browse/CHEF-4102>`_  --- chef-apply ignores all command line flags
* `CHEF-4114 <http://tickets.opscode.com/browse/CHEF-4114>`_  --- Broken raise of ConfigurationError when log_location not writable
* `CHEF-4115 <http://tickets.opscode.com/browse/CHEF-4115>`_  --- The config file's path isn't shown in exceptions
* `CHEF-4118 <http://tickets.opscode.com/browse/CHEF-4118>`_  --- Event handlers should get run_started events
* `CHEF-4123 <http://tickets.opscode.com/browse/CHEF-4123>`_  --- Chef-10.24.4 break Chef-server bootstrap installation
* `CHEF-4135 <http://tickets.opscode.com/browse/CHEF-4135>`_  --- Malformed arguments to notifies fail without a helpful message
* `CHEF-4153 <http://tickets.opscode.com/browse/CHEF-4153>`_  --- Requiring chef/node throws a NameError
* `CHEF-4158 <http://tickets.opscode.com/browse/CHEF-4158>`_  --- auth_credentials_spec test sets the http_proxy variables twice
* `CHEF-4176 <http://tickets.opscode.com/browse/CHEF-4176>`_  --- Chef 11 Default knife chef_server_url References Chef 10 Servers
* `CHEF-4199 <http://tickets.opscode.com/browse/CHEF-4199>`_  --- usermod for changing groups on SmartOS should use -G
* `CHEF-4204 <http://tickets.opscode.com/browse/CHEF-4204>`_  --- Chef::Provider::User::Useradd doesn't deal with apostrophes in users' full names
* `CHEF-4208 <http://tickets.opscode.com/browse/CHEF-4208>`_  --- Monkey Patch Dir.rb exception on windows
* `CHEF-4233 <http://tickets.opscode.com/browse/CHEF-4233>`_  --- 'knife upload' of encrypted data bags is adding extra keys to the data bag
* `CHEF-4236 <http://tickets.opscode.com/browse/CHEF-4236>`_  --- resource "file" is non-idempotent when specifying file mode in combination with a non-existing user
* `CHEF-4239 <http://tickets.opscode.com/browse/CHEF-4239>`_  --- git provider breaks if repository path has spaces
* `CHEF-4259 <http://tickets.opscode.com/browse/CHEF-4259>`_  --- Unpacking recipes fails on SmartOS
* `CHEF-4272 <http://tickets.opscode.com/browse/CHEF-4272>`_  --- "knife list" shows files that can't be uploaded
* `CHEF-4274 <http://tickets.opscode.com/browse/CHEF-4274>`_  --- chef-client never runs again after an http timeout to the chef server
* `CHEF-4275 <http://tickets.opscode.com/browse/CHEF-4275>`_  --- Rubygems 2.0 heuristic is incorrect on some environments upgraded from rubygems 1.8
* `CHEF-4305 <http://tickets.opscode.com/browse/CHEF-4305>`_  --- Usermod on CentOS/RHEL 5 requires the -d option to appear before -m in argv list
* `CHEF-4312 <http://tickets.opscode.com/browse/CHEF-4312>`_  --- File Provider Refactor Breaks Cookbooks That Depend on Managing Content via Symlink
* `CHEF-4314 <http://tickets.opscode.com/browse/CHEF-4314>`_  --- atomic gem doesn't compile on sparc and older 32bit redhat
* `CHEF-4327 <http://tickets.opscode.com/browse/CHEF-4327>`_  --- directory resource broken on Windows 2012
* `CHEF-4328 <http://tickets.opscode.com/browse/CHEF-4328>`_  --- native Windows service won't start in Windows 2012
* `CHEF-4333 <http://tickets.opscode.com/browse/CHEF-4333>`_  --- package resource broken on 11.6.0rc0 on EL6
* `CHEF-4336 <http://tickets.opscode.com/browse/CHEF-4336>`_  --- Knife cookbook upload cannot upload cookbooks with custom metadata name
* `CHEF-4341 <http://tickets.opscode.com/browse/CHEF-4341>`_  --- File Resources Erroneously Trigger Notifications When Managing Symlink Source
* `CHEF-4349 <http://tickets.opscode.com/browse/CHEF-4349>`_  --- NoMethodError for NilClass#version installing a package on OpenSuSE 12.3 (11.6 RC)
* `CHEF-4350 <http://tickets.opscode.com/browse/CHEF-4350>`_  --- knife cookbook site share broken on 11.6.0
* `CHEF-4357 <http://tickets.opscode.com/browse/CHEF-4357>`_  --- Chef Client/Solo with --fork spews extra stacktraces and breaks stacktrace logging
* `CHEF-4365 <http://tickets.opscode.com/browse/CHEF-4365>`_  --- Remote file resource fails when cache control data is corrupted
* `CHEF-4380 <http://tickets.opscode.com/browse/CHEF-4380>`_  --- package resource with "source" is broken on EL6 using 11.6.0rc3
* `CHEF-4429 <http://tickets.opscode.com/browse/CHEF-4429>`_  --- All recipes are being loaded in chef-shell while in client mode

What's Improved
=====================================================
The following improvements were made:

* `CHEF-1367 <http://tickets.opscode.com/browse/CHEF-1367>`_  --- Make remote_file avoid downloading a file if it hasn't changed
* `CHEF-2506 <http://tickets.opscode.com/browse/CHEF-2506>`_  --- remote_file should respect ETags
* `CHEF-3348 <http://tickets.opscode.com/browse/CHEF-3348>`_  --- 11: Better CHANGELOG formatting
* `CHEF-3364 <http://tickets.opscode.com/browse/CHEF-3364>`_  --- Fix up Smartos Package provider
* `CHEF-3615 <http://tickets.opscode.com/browse/CHEF-3615>`_  --- Encrypted data bag items should use authenticated encryption.
* `CHEF-3664 <http://tickets.opscode.com/browse/CHEF-3664>`_  --- The 'map' variable is defined and never used in the set_or_return method of lib/chef/mixim/params_validate.rb
* `CHEF-3695 <http://tickets.opscode.com/browse/CHEF-3695>`_  --- File provider follows symlinks; Template provider does not (security implications and inconsistency)
* `CHEF-3735 <http://tickets.opscode.com/browse/CHEF-3735>`_  --- typos in resource names should show the typo in the error message/exception
* `CHEF-3749 <http://tickets.opscode.com/browse/CHEF-3749>`_  --- Use HTTPS to download the Omnibus installer
* `CHEF-3819 <http://tickets.opscode.com/browse/CHEF-3819>`_  --- Execute with cwd attribute should check existence of sentiel file according to cwd value
* `CHEF-3942 <http://tickets.opscode.com/browse/CHEF-3942>`_  --- The chef-repo should gitignore .chef directory by default
* `CHEF-3967 <http://tickets.opscode.com/browse/CHEF-3967>`_  --- Use HTTPS when connecting to RubyGems.org
* `CHEF-3987 <http://tickets.opscode.com/browse/CHEF-3987>`_  --- Resource collection has duplicate code in "push" and "<<"
* `CHEF-4011 <http://tickets.opscode.com/browse/CHEF-4011>`_  --- default location of "encrypted_data_bag_secret" should be set in Chef::Config
* `CHEF-4053 <http://tickets.opscode.com/browse/CHEF-4053>`_  --- Add powershell providers in Core Chef
* `CHEF-4054 <http://tickets.opscode.com/browse/CHEF-4054>`_  --- Add windows batch provider to core Chef
* `CHEF-4055 <http://tickets.opscode.com/browse/CHEF-4055>`_  --- Add Win8/2012 to Chef Windows Helper
* `CHEF-4070 <http://tickets.opscode.com/browse/CHEF-4070>`_  --- Support DataBag.list on chef-solo
* `CHEF-4076 <http://tickets.opscode.com/browse/CHEF-4076>`_  --- knife node run list set [list of roles/recipes]
* `CHEF-4081 <http://tickets.opscode.com/browse/CHEF-4081>`_  --- let knife show/search return more than one attribute using -a
* `CHEF-4088 <http://tickets.opscode.com/browse/CHEF-4088>`_  --- sorting the knife commands is done, but would be cool if you also sort the sub commands...
* `CHEF-4090 <http://tickets.opscode.com/browse/CHEF-4090>`_  --- refactor zypper package provider to make command output visible
* `CHEF-4106 <http://tickets.opscode.com/browse/CHEF-4106>`_  --- Remove obsolete default configuration
* `CHEF-4130 <http://tickets.opscode.com/browse/CHEF-4130>`_  --- knife * edit presents a .js file not a .json file
* `CHEF-4146 <http://tickets.opscode.com/browse/CHEF-4146>`_  --- Update Reporting Client Protocol
* `CHEF-4161 <http://tickets.opscode.com/browse/CHEF-4161>`_  --- remove newlines from knife search -i output
* `CHEF-4220 <http://tickets.opscode.com/browse/CHEF-4220>`_  --- Define helper functions on template resource
* `CHEF-4225 <http://tickets.opscode.com/browse/CHEF-4225>`_  --- Bump windows ruby version to p429 in omnibus-chef

New Features
=====================================================
The following features were added:

* `CHEF-1031 <http://tickets.opscode.com/browse/CHEF-1031>`_  --- remote file resource should handle ftp urls
* `CHEF-1761 <http://tickets.opscode.com/browse/CHEF-1761>`_  --- Change signal TERM to quit after the running jobs are finished
* `CHEF-2750 <http://tickets.opscode.com/browse/CHEF-2750>`_  --- git SCM/Deploy Resource should have an option to require a "git submodule sync"
* `CHEF-2821 <http://tickets.opscode.com/browse/CHEF-2821>`_  --- add "--sudo-use-password" option to knife bootstrap to tell sudo to read --ssh-password from stdin
* `CHEF-3029 <http://tickets.opscode.com/browse/CHEF-3029>`_  --- ifconfig provider for debian/ubuntu platforms
* `CHEF-3356 <http://tickets.opscode.com/browse/CHEF-3356>`_  --- Support for environments from json and ruby dsl files on chef-solo
* `CHEF-3481 <http://tickets.opscode.com/browse/CHEF-3481>`_  --- Chef should respect SELinux security contexts
* `CHEF-3786 <http://tickets.opscode.com/browse/CHEF-3786>`_  --- remote_file: support authenticated HTTP/HTTPS requests
* `CHEF-3880 <http://tickets.opscode.com/browse/CHEF-3880>`_  --- Recognize GCEL as a platform
* `CHEF-3919 <http://tickets.opscode.com/browse/CHEF-3919>`_  --- Modify Chef::Platform to allow "greater than" conditionals
* `CHEF-4154 <http://tickets.opscode.com/browse/CHEF-4154>`_  --- file provider support for configuring bool, policy, restorecon
