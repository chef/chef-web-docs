=====================================================
windows_env resource
=====================================================
`[edit on GitHub] <https://github.com/chef/chef-web-docs/blob/master/chef_master/source/resource_windows_env.rst>`__

.. tag resource_env_summary

Use the **windows_env** resource to manage environment keys in Microsoft Windows. After an environment key is set, Microsoft Windows must be restarted before the environment key will be available to the Task Scheduler.

This resource was previously called the **env** resource; its name was updated in Chef Client 14.0 to reflect the fact that only Windows is supported. Existing cookbooks using ``env`` will continue to function, but should be updated to use the new name.

.. end_tag

.. note:: On UNIX-based systems, the best way to manipulate environment keys is with the ``ENV`` variable in Ruby; however, this approach does not have the same permanent effect as using the **windows_env** resource.

Syntax
=====================================================
The windows_env resource has the following syntax:

.. code-block:: ruby

  windows_env 'name' do
    delim         String, nil, false
    key_name      String # default value: 'name' unless specified
    user          String # default value: <System>
    value         String
    action        Symbol # defaults to :create if not specified
  end

where:

* ``windows_env`` is the resource.
* ``name`` is the name given to the resource block.
* ``action`` identifies which steps the chef-client will take to bring the node into the desired state.
* ``delim``, ``key_name``, ``user``, and ``value`` are the properties available to this resource.

Actions
=====================================================
.. tag resource_env_actions

This resource has the following actions:

``:create``
   Default. Create an environment variable. If an environment variable already exists (but does not match), update that environment variable to match.

``:delete``
   Delete an environment variable.

``:modify``
   Modify an existing environment variable. This prepends the new value to the existing value, using the delimiter specified by the ``delim`` property.

``:nothing``
   .. tag resources_common_actions_nothing

   Define this resource block to do nothing until notified by another resource to take action. When this resource is notified, this resource block is either run immediately or it is queued up to be run at the end of the Chef Client run.

   .. end_tag

.. end_tag

Properties
=====================================================
.. tag resource_env_attributes

This resource has the following properties:

``delim``
   **Ruby Type:** String

   The delimiter that is used to separate multiple values for a single key.

``ignore_failure``
   **Ruby Type:** true, false | **Default Value:** ``false``

   Continue running a recipe if a resource fails for any reason.

``key_name``
   **Ruby Type:** String

   The name of the key that is to be created, deleted, or modified. Default value: the ``name`` of the resource block. See "Syntax" section above for more information.

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

``retries``
   **Ruby Type:** Integer | **Default Value:** ``0``

   The number of times to catch exceptions and retry the resource.

``retry_delay``
   **Ruby Type:** Integer | **Default Value:** ``2``

   The retry delay (in seconds).

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

``value``
   **Ruby Type:** String

   The value with which ``key_name`` is set.

.. end_tag

Guards
-----------------------------------------------------
.. tag resources_common_guards

A guard property can be used to evaluate the state of a node during the execution phase of the chef-client run. Based on the results of this evaluation, a guard property is then used to tell the chef-client if it should continue executing a resource. A guard property accepts either a string value or a Ruby block value:

* A string is executed as a shell command. If the command returns ``0``, the guard is applied. If the command returns any other value, then the guard property is not applied. String guards in a **powershell_script** run Windows PowerShell commands and may return ``true`` in addition to ``0``.
* A block is executed as Ruby code that must return either ``true`` or ``false``. If the block returns ``true``, the guard property is applied. If the block returns ``false``, the guard property is not applied.

A guard property is useful for ensuring that a resource is idempotent by allowing that resource to test for the desired state as it is being executed, and then if the desired state is present, for the chef-client to do nothing.

.. end_tag

**Attributes**

.. tag resources_common_guards_attributes

The following properties can be used to define a guard that is evaluated during the execution phase of the chef-client run:

``not_if``
   Prevent a resource from executing when the condition returns ``true``.

``only_if``
   Allow a resource to execute only if the condition returns ``true``.

.. end_tag

**Arguments**

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

Examples
=====================================================
The following examples demonstrate various approaches for using resources in recipes. If you want to see examples of how Chef uses resources in recipes, take a closer look at the cookbooks that Chef authors and maintains: https://github.com/chef-cookbooks.

**Set an environment variable**

.. tag resource_environment_set_variable

.. To set an environment variable:

.. code-block:: ruby

   windows_env 'ComSpec' do
     value "C:\\Windows\\system32\\cmd.exe"
   end

.. end_tag

