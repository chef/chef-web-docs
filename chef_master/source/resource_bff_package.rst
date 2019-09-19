=====================================================
bff_package resource
=====================================================
`[edit on GitHub] <https://github.com/chef/chef-web-docs/blob/master/chef_master/source/resource_bff_package.rst>`__

.. tag resource_package_bff

Use the **bff_package** resource to manage packages for the AIX platform using the installp utility. When a package is installed from a local file, it must be added to the node using the **remote_file** or **cookbook_file** resources.

.. note:: A Backup File Format (BFF) package may not have a ``.bff`` file extension. Chef Infra Client will still identify the correct provider to use based on the platform, regardless of the file extension.

.. end_tag

.. note:: .. tag notes_resource_based_on_package

          In many cases, it is better to use the **package** resource instead of this one. This is because when the **package** resource is used in a recipe, Chef Infra Client will use details that are collected by Ohai at the start of a Chef Infra Client run to determine the correct package application. Using the **package** resource allows a recipe to be authored in a way that allows it to be used across many platforms.

          .. end_tag

Syntax
=====================================================
A **bff_package** resource manages a package on a node, typically by installing it. The simplest use of the **bff_package** resource is:

.. code-block:: ruby

   bff_package 'package_name'

which will install the named package using all of the default options and the default action (``:install``).

The full syntax for all of the properties that are available to the **bff_package** resource is:

.. code-block:: ruby

   bff_package 'name' do
     options                    String
     package_name               String, Array # defaults to 'name' if not specified
     source                     String
     timeout                    String, Integer
     version                    String, Array
     action                     Symbol # defaults to :install if not specified
   end

where:

* ``bff_package`` is the resource.
* ``name`` is the name given to the resource block.
* ``action`` identifies which steps Chef Infra Client will take to bring the node into the desired state.
* ``options``, ``package_name``, ``source``, ``timeout``, and ``version`` are properties of this resource, with the Ruby type shown. See "Properties" section below for more information about all of the properties that may be used with this resource.



Actions
=====================================================
The bff_package resource has the following actions:

``:install``
   Default. Install a package. If a version is specified, install the specified version of the package.

``:nothing``
   .. tag resources_common_actions_nothing

   This resource block does not act unless notified by another resource to take action. Once notified, this resource block either runs immediately or is queued up to run at the end of a Chef Infra Client run.

   .. end_tag

``:purge``
   Purge a package. This action typically removes the configuration files as well as the package.

``:remove``
   Remove a package.



Properties
=====================================================

The bff_package resource has the following properties:

``options``
   **Ruby Type:** String, Array

   One (or more) additional command options that are passed to the command.

``package_name``
   **Ruby Type:** String, Array

   An optional property to set the package name if it differs from the resource block's name.

``source``
   **Ruby Type:** String

   Required. The path to a package in the local file system. The AIX platform requires ``source`` to be a local file system path because ``installp`` does not retrieve packages using HTTP or FTP.

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

**Install a package**

.. tag resource_bff_package_install

.. To install a package:

The **bff_package** resource is the default package provider on the AIX platform. The base **package** resource may be used, and then when the platform is AIX, Chef Infra Client will identify the correct package provider. The following examples show how to install part of the IBM XL C/C++ compiler.

Using the base **package** resource:

.. code-block:: ruby

   package 'xlccmp.13.1.0' do
     source '/var/tmp/IBM_XL_C_13.1.0/usr/sys/inst.images/xlccmp.13.1.0'
     action :install
   end

Using the **bff_package** resource:

.. code-block:: ruby

   bff_package 'xlccmp.13.1.0' do
     source '/var/tmp/IBM_XL_C_13.1.0/usr/sys/inst.images/xlccmp.13.1.0'
     action :install
   end

.. end_tag
