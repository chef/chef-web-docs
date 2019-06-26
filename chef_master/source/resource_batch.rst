=====================================================
batch resource
=====================================================
`[edit on GitHub] <https://github.com/chef/chef-web-docs/blob/master/chef_master/source/resource_batch.rst>`__

.. tag resource_batch_summary

Use the **batch** resource to execute a batch script using the cmd.exe interpreter on Windows. The **batch** resource creates and executes a temporary file (similar to how the **script** resource behaves), rather than running the command inline. Commands that are executed with this resource are (by their nature) not idempotent, as they are typically unique to the environment in which they are run. Use ``not_if`` and ``only_if`` to guard this resource for idempotence.

.. end_tag

Syntax
=====================================================
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
     returns                    Integer, Array
     timeout                    Integer, Float
     user                       String
     password                   String
     domain                     String
     action                     Symbol # defaults to :run if not specified
   end

where:

* ``batch`` is the resource.
* ``name`` is the name given to the resource block.
* ``action`` identifies which steps the Chef Infra Client will take to bring the node into the desired state.
* ``architecture``, ``code``, ``command``, ``creates``, ``cwd``, ``flags``, ``group``, ``guard_interpreter``, ``interpreter``, ``returns``, ``timeout``, ``user``, ``password`` and ``domain`` are properties of this resource, with the Ruby type shown. See "Properties" section below for more information about all of the properties that may be used with this resource.

.. end_tag

Actions
=====================================================

The batch resource has the following actions:

``:nothing``
   .. tag resources_common_actions_nothing

   This resource block does not act unless notified by another resource to take action. Once notified, this resource block either runs immediately or is queued up to run at the end of the Chef Infra Client run.

   .. end_tag

``:run``
   Run a batch file.

Properties
=====================================================
.. tag resource_batch_properties

The batch resource has the following properties:

``architecture``
   **Ruby Type:** Symbol

   The architecture of the process under which a script is executed. If a value is not provided, the Chef Infra Client defaults to the correct value for the architecture, as determined by Ohai. An exception is raised when anything other than ``:i386`` is specified for a 32-bit process. Possible values: ``:i386`` (for 32-bit processes) and ``:x86_64`` (for 64-bit processes).

``code``
   **Ruby Type:** String | ``REQUIRED``

   A quoted (" ") string of code to be executed.

``command``
   **Ruby Type:** String, Array

   The name of the command to be executed.

``creates``
   **Ruby Type:** String

   Prevent a command from creating a file when that file already exists.

``cwd``
   **Ruby Type:** String

   The current working directory from which the command will be run.

``flags``
   **Ruby Type:** String

   One or more command line flags that are passed to the interpreter when a command is invoked.

``group``
   **Ruby Type:** String, Integer

   The group name or group ID that must be changed before running a command.

``guard_interpreter``
   **Ruby Type:** Symbol | **Default Value:** ``:batch``

   When this property is set to ``:batch``, the 64-bit version of the cmd.exe shell will be used to evaluate strings values for the ``not_if`` and ``only_if`` properties. Set this value to ``:default`` to use the 32-bit version of the cmd.exe shell.

``interpreter``
   **Ruby Type:** String

   The script interpreter to use during code execution. Changing the default value of this property is not supported.

``returns``
   **Ruby Type:** Integer, Array | **Default Value:** ``0``

   The return value for a command. This may be an array of accepted values. An exception is raised when the return value(s) do not match.

``timeout``
   **Ruby Type:** Integer, Float | **Default Value:** ``3600``

   The amount of time (in seconds) a command is to wait before timing out.

``user``
   **Ruby Type:** String

   The user name of the user identity with which to launch the new process. The user name may optionally be specified with a domain, i.e. `domain\user` or `user@my.dns.domain.com` via Universal Principal Name (UPN)format. It can also be specified without a domain simply as user if the domain is instead specified using the `domain` attribute. On Windows only, if this property is specified, the `password` property must be specified.

``password``
   **Ruby Type:** String

   *Windows only*: The password of the user specified by the `user` property.
   This property is mandatory if `user` is specified on Windows and may only be specified if `user` is specified. The `sensitive` property for this resource will automatically be set to true if password is specified.

``domain``
   **Ruby Type:** String

   *Windows only*: The domain of the user user specified by the `user` property.
   If not specified, the user name and password specified by the `user` and `password` properties will be used to resolve that user against the domain in which the system running Chef Infra Client is joined, or if that system is not joined to a domain it will resolve the user as a local account on that system. An alternative way to specify the domain is to leave this property unspecified and specify the domain as part of the `user` property.

.. note:: See https://docs.microsoft.com/en-us/windows-server/administration/windows-commands/cmd for more information about the cmd.exe interpreter.

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

  Ensure that sensitive resource data is not logged by the Chef Infra Client.

.. end_tag

Notifications
-----------------------------------------------------
``notifies``
  **Ruby Type:** Symbol, 'Chef::Resource[String]'

  .. tag resources_common_notification_notifies

  A resource may notify another resource to take action when its state changes. Specify a ``'resource[name]'``, the ``:action`` that resource should take, and then the ``:timer`` for that action. A resource may notify more than one resource; use a ``notifies`` statement for each resource to be notified.

  .. end_tag

.. tag resources_common_notification_timers

A timer specifies the point during the Chef Infra Client run at which a notification is run. The following timers are available:

``:before``
   Specifies that the action on a notified resource should be run before processing the resource block in which the notification is located.

``:delayed``
   Default. Specifies that a notification should be queued up, and then executed at the end of the Chef Infra Client run.

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

A timer specifies the point during the Chef Infra Client run at which a notification is run. The following timers are available:

``:before``
   Specifies that the action on a notified resource should be run before processing the resource block in which the notification is located.

``:delayed``
   Default. Specifies that a notification should be queued up, and then executed at the end of the Chef Infra Client run.

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

A guard property can be used to evaluate the state of a node during the execution phase of the Chef Infra Client run. Based on the results of this evaluation, a guard property is then used to tell the Chef Infra Client if it should continue executing a resource. A guard property accepts either a string value or a Ruby block value:

* A string is executed as a shell command. If the command returns ``0``, the guard is applied. If the command returns any other value, then the guard property is not applied. String guards in a **powershell_script** run Windows PowerShell commands and may return ``true`` in addition to ``0``.
* A block is executed as Ruby code that must return either ``true`` or ``false``. If the block returns ``true``, the guard property is applied. If the block returns ``false``, the guard property is not applied.

A guard property is useful for ensuring that a resource is idempotent by allowing that resource to test for the desired state as it is being executed, and then if the desired state is present, for the Chef Infra Client to do nothing.

.. end_tag

.. tag resources_common_guards_properties

The following properties can be used to define a guard that is evaluated during the execution phase of the Chef Infra Client run:

``not_if``
  Prevent a resource from executing when the condition returns ``true``.

``only_if``
  Allow a resource to execute only if the condition returns ``true``.

.. end_tag

Examples
=====================================================
The following examples demonstrate various approaches for using resources in recipes:

**Unzip a file, and then move it**

.. tag resource_batch_unzip_file_and_move

To run a batch file that unzips and then moves Ruby, do something like:

.. code-block:: ruby

   batch 'unzip_and_move_ruby' do
     code <<-EOH
       7z.exe x #{Chef::Config[:file_cache_path]}/ruby-1.8.7-p352-i386-mingw32.7z
         -oC:\\source -r -y
       xcopy C:\\source\\ruby-1.8.7-p352-i386-mingw32 C:\\ruby /e /y
       EOH
   end

   batch 'echo some env vars' do
     code <<-EOH
       echo %TEMP%
       echo %SYSTEMDRIVE%
       echo %PATH%
       echo %WINDIR%
       EOH
   end

or:

.. code-block:: ruby

   batch 'unzip_and_move_ruby' do
     code <<-EOH
       7z.exe x #{Chef::Config[:file_cache_path]}/ruby-1.8.7-p352-i386-mingw32.7z
         -oC:\\source -r -y
       xcopy C:\\source\\ruby-1.8.7-p352-i386-mingw32 C:\\ruby /e /y
       EOH
   end

   batch 'echo some env vars' do
     code 'echo %TEMP%\\necho %SYSTEMDRIVE%\\necho %PATH%\\necho %WINDIR%'
   end

.. end_tag

**Run a command as an alternate user**

*Note*: When Chef is running as a service, this feature requires that the user that Chef runs as has 'SeAssignPrimaryTokenPrivilege' (aka 'SE_ASSIGNPRIMARYTOKEN_NAME') user right. By default only LocalSystem and NetworkService have this right when running as a service. This is necessary even if the user is an Administrator.

This right can be added and checked in a recipe using this example:

.. code-block:: ruby

    # Add 'SeAssignPrimaryTokenPrivilege' for the user
    Chef::ReservedNames::Win32::Security.add_account_right('<user>', 'SeAssignPrimaryTokenPrivilege')

    # Check if the user has 'SeAssignPrimaryTokenPrivilege' rights
    Chef::ReservedNames::Win32::Security.get_account_right('<user>').include?('SeAssignPrimaryTokenPrivilege')

The following example shows how to run ``mkdir test_dir`` from a chef-client run as an alternate user.

.. code-block:: ruby

   # Passing only username and password
   batch 'mkdir test_dir' do
    code "mkdir test_dir"
    cwd Chef::Config[:file_cache_path]
    user "username"
    password "password"
   end

   # Passing username and domain
   batch 'mkdir test_dir' do
    code "mkdir test_dir"
    cwd Chef::Config[:file_cache_path]
    domain "domain"
    user "username"
    password "password"
   end

   # Passing username = 'domain-name\\username'. No domain is passed
   batch 'mkdir test_dir' do
    code "mkdir test_dir"
    cwd Chef::Config[:file_cache_path]
    user "domain-name\\username"
    password "password"
   end

   # Passing username = 'username@domain-name'. No domain is passed
   batch 'mkdir test_dir' do
    code "mkdir test_dir"
    cwd Chef::Config[:file_cache_path]
    user "username@domain-name"
    password "password"
   end


