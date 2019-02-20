=====================================================
sudo resource
=====================================================
`[edit on GitHub] <https://github.com/chef/chef-web-docs/blob/master/chef_master/source/resource_sudo.rst>`__

Use the **sudo** resource to add or remove individual sudo entries using ``sudoers.d`` files. Sudo version 1.7.2 or newer is required to use the sudo resource, as it relies on the ``#includedir`` directive introduced in version 1.7.2. This resource does not enforce installation of the required sudo version. Chef-supported releases of Ubuntu, Debian and RHEL (6+) all support this feature.

**New in Chef Client 14.0.**

Syntax
=====================================================
The sudo resource has the following syntax:

.. code-block:: ruby

  sudo 'name' do
    command_aliases        Array
    commands               Array # default value: ["ALL"]
    config_prefix          String # default value: Prefix values based on the node's platform
    defaults               Array
    env_keep_add           Array
    env_keep_subtract      Array
    filename               String # default value: 'name' unless specified
    groups                 String, Array
    host                   String # default value: "ALL"
    noexec                 true, false # default value: false
    nopasswd               true, false # default value: false
    runas                  String # default value: "ALL"
    setenv                 true, false # default value: false
    template               String
    users                  String, Array
    variables              Hash
    visudo_binary          String # default value: "/usr/sbin/visudo"
    visudo_path            String
    action                 Symbol # defaults to :create if not specified
  end

where:

* ``sudo`` is the resource.
* ``name`` is the name given to the resource block.
* ``action`` identifies which steps the chef-client will take to bring the node into the desired state.
* ``command_aliases``, ``commands``, ``config_prefix``, ``defaults``, ``env_keep_add``, ``env_keep_subtract``, ``filename``, ``groups``, ``host``, ``noexec``, ``nopasswd``, ``runas``, ``setenv``, ``template``, ``users``, ``variables``, ``visudo_binary``, and ``visudo_path`` are the properties available to this resource.

Actions
=====================================================

The sudo resource has the following actions:

``:create``
   Default. Create a single sudoers configuration file in the ``sudoers.d`` directory.

``:delete``
   Removed a sudoers configuration file from the ``sudoers.d`` directory.

``:nothing``
   .. tag resources_common_actions_nothing

   This resource block does not act unless notified by another resource to take action. Once notified, this resource block either runs immediately or is queued up to run at the end of the Chef Client run.

   .. end_tag

Properties
=====================================================

The sudo resource has the following properties:

``command_aliases``
   **Ruby Type:** Array

   Command aliases that can be used as allowed commands later in the configuration.


``commands``
   **Ruby Type:** Array | **Default Value:** ``["ALL"]``

   An array of commands this sudoer can execute.


``config_prefix``
   **Ruby Type:** String | **Default Value:** ``Prefix values based on the node's platform``

   The directory that contains the sudoers configuration file.

``defaults``
   **Ruby Type:** Array

   An array of defaults for the user/group.

``env_keep_add``
   **Ruby Type:** Array

   An array of strings to add to ``env_keep``.

``env_keep_subtract``
   **Ruby Type:** Array

   An array of strings to remove from ``env_keep``.

``filename``
   **Ruby Type:** String | **Default Value:** ``The resource block's name``

   The name of the sudoers.d file if it differs from the name of the resource block

``groups``
   **Ruby Type:** String, Array

   Group(s) to provide sudo privileges to. This property accepts either an array or a comma-separated list. Leading % on group names is optional.

``host``
   **Ruby Type:** String | **Default Value:** ``"ALL"``

   The host to set in the sudo configuration.

``noexec``
   **Ruby Type:** true, false | **Default Value:** ``false``

   Prevent commands from shelling out.

``nopasswd``
   **Ruby Type:** true, false | **Default Value:** ``false``

   Allow sudo to be run without specifying a password.


``runas``
   **Ruby Type:** String | **Default Value:** ``"ALL"``

   User that the command(s) can be run as.

``setenv``
   **Ruby Type:** true, false | **Default Value:** ``false``

   Determines whether or not to permit preservation of the environment with ``sudo -E``.


``template``
   **Ruby Type:** String

   The name of the ``.erb`` template in your cookbook, if you wish to supply your own template.

``users``
   **Ruby Type:** String, Array

   User(s) to provide sudo privileges to. This property accepts either an array or a comma-separated list.

``variables``
   **Ruby Type:** Hash

   The variables to pass to the custom template. This property is ignored if not using a custom template.

``visudo_binary``
   **Ruby Type:** String | **Default Value:** ``/usr/sbin/visudo``

   The path to ``visudo`` for configuration verification.

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
**Grant a user sudo privileges for any command**

.. code-block:: ruby

   sudo 'admin' do
     user 'admin'
   end

**Grant a user and groups sudo privileges for any command**

.. code-block:: ruby

   sudo 'admins' do
     users 'bob'
     groups 'sysadmins, superusers'
   end

**Grant passwordless sudo privileges for specific commands**

.. code-block:: ruby

   sudo 'passwordless-access' do
     commands ['systemctl restart httpd', 'systemctl restart mysql']
     nopasswd true
   end
