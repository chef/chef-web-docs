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
    config_prefix          String
    defaults               Array
    env_keep_add           Array
    env_keep_subtract      Array
    filename               String # default value: 'name' unless specified
    groups                 String, Array
    host                   String # default value: ALL
    noexec                 true, false # default value: false
    nopasswd               true, false # default value: false
    runas                  String # default value: ALL
    setenv                 true, false # default value: false
    template               String
    users                  String, Array
    variables              Hash, nil
    visudo_binary          String # default value: /usr/sbin/visudo
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
``:create``
   Default. Create a single sudoers configuration file in the ``sudoers.d`` directory.

``:delete``
   Removed a sudoers configuration file from the ``sudoers.d`` directory.

``:nothing``
   .. tag resources_common_actions_nothing

   Define this resource block to do nothing until notified by another resource to take action. When this resource is notified, this resource block is either run immediately or it is queued up to be run at the end of the Chef Client run.

   .. end_tag

Properties
=====================================================
``commands``
   **Ruby Type:** Array | **Default Value:** ``["ALL"]``

   An array of commands this sudoer can execute.

``command_aliases``
   **Ruby Type:** Array | **Default Value:** ``[]``

   Command aliases that can be used as allowed commands later in the configuration.

``config_prefix``
   **Ruby Type:** String | **Default Value:** ``Prefix values based on the node's platform``

   The directory that contains the sudoers configuration file.

``defaults``
   **Ruby Type:** Array | **Default Value:** ``[]``

   An array of defaults for the user/group.

``env_keep_add``
   **Ruby Type:** Array | **Default Value:** ``[]``

   An array of strings to add to ``env_keep``.

``env_keep_subtract``
   **Ruby Type:** Array | **Default Value:** ``[]``

   An array of strings to remove from ``env_keep``.

``filename``
   **Ruby Type:** String | **Default Value:** ``'name'``

   Optional. The name of the ``sudoers.d`` file, if it differs from the name of the resource block.

``groups``
   **Ruby Type:** String, Array | **Default Value:** ``[]``

   Group(s) to provide sudo privileges to. This accepts either an array or a comma-separated list. Leading % on group names is optional.

``host``
   **Ruby Type:** String| **Default Value:** ``"ALL"``

   The host to set in the sudo configuration.

``noexec``
   **Ruby Type:** True, False | **Default Value:** ``false``

   Prevent commands from shelling out.

``nopasswd``
   **Ruby Type:** True, False | **Default Value:** ``false``

   Allow sudo to be run without specifying a password.

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

``runas``
   **Ruby Type:** String | **Default Value:** ``"ALL"``

   User that the command(s) can be run as.

``setenv``
   **Ruby Type:** True, False | **Default Value:** ``false``

   Determines whether or not to permit preservation of the environment with ``sudo -E``.

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

``template``
   **Ruby Type:** String

   The name of the ``.erb`` template in your cookbook, if you wish to supply your own template.

``users``
   **Ruby Type:** String, Array | **Default Value:** ``[]``

   User(s) to provide sudo privileges to. This property accepts either an array or a comma-separated list.

``variables``
   **Ruby Type:** Hash, nil | **Default Value:** ``nil``

   The variables to pass to the custom template. This property is ignored if not using a custom template.

``visudo_binary``
   **Ruby Type:** String | **Default Value:** ``/usr/sbin/visudo``

   The path to ``visudo`` for configuration verification.

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
     nopasswd True
   end
