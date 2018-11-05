=====================================================
smartos_package resource
=====================================================
`[edit on GitHub] <https://github.com/chef/chef-web-docs/blob/master/chef_master/source/resource_smartos_package.rst>`__

.. tag resource_package_smartos

Use the **smartos_package** resource to manage packages for the SmartOS platform.

.. end_tag

.. note:: .. tag notes_resource_based_on_package

          In many cases, it is better to use the **package** resource instead of this one. This is because when the **package** resource is used in a recipe, the chef-client will use details that are collected by Ohai at the start of the chef-client run to determine the correct package application. Using the **package** resource allows a recipe to be authored in a way that allows it to be used across many platforms.

          .. end_tag

Syntax
=====================================================
A **smartos_package** resource block manages a package on a node, typically by installing it. The simplest use of the **smartos_package** resource is:

.. code-block:: ruby

   smartos_package 'package_name'

which will install the named package using all of the default options and the default action (``:install``).

The full syntax for all of the properties that are available to the **smartos_package** resource is:

.. code-block:: ruby

  smartos_package 'name' do
    options                      String, Array
    package_name                 String, Array
    response_file                String
    response_file_variables      Hash
    source                       String
    timeout                      String, Integer
    version                      String, Array
    action                       Symbol # defaults to :install if not specified
  end

where:

* ``smartos_package`` is the resource.
* ``name`` is the name given to the resource block.
* ``action`` identifies which steps the chef-client will take to bring the node into the desired state.
* ``options``, ``package_name``, ``response_file``, ``response_file_variables``, ``source``, ``timeout``, and ``version`` are the properties available to this resource.

Actions
=====================================================

The smartos_package resource has the following actions:

``:install``
   Default. Install a package. If a version is specified, install the specified version of the package.

``:nothing``
   .. tag resources_common_actions_nothing

   Define this resource block to do nothing until notified by another resource to take action. When this resource is notified, this resource block is either run immediately or it is queued up to be run at the end of the Chef Client run.

   .. end_tag

``:remove``
   Remove a package.

``:upgrade``
   Install a package and/or ensure that a package is the latest version.

Properties
=====================================================

The smartos_package resource has the following properties:
``options``
   **Ruby Type:** String

   One (or more) additional options that are passed to the command.

``package_name``
   **Ruby Type:** String, Array

   The name of the package. Default value: the ``name`` of the resource block. See "Syntax" section above for more information.

``source``
   **Ruby Type:** String

   Optional. The path to a package in the local file system.

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

   The number of times to catch exceptions and retry the resource.

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
The following examples demonstrate various approaches for using resources in recipes. If you want to see examples of how Chef uses resources in recipes, take a closer look at the cookbooks that Chef authors and maintains: https://github.com/chef-cookbooks.

**Install a package**

.. tag resource_smartos_package_install

.. To install a package:

.. code-block:: ruby

   smartos_package 'name of package' do
     action :install
   end

.. end_tag
