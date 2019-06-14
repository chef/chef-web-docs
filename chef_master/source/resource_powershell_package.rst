=====================================================
powershell_package resource
=====================================================
`[edit on GitHub] <https://github.com/chef/chef-web-docs/blob/master/chef_master/source/resource_powershell_package.rst>`__

Use the **powershell_package** resource to install and manage packages via the PowerShell Package Manager for the Microsoft Windows platform.  The **powershell_package** resource requires administrative access, and a source must be configured in the PowerShell Package Manager via the `Register-PackageSource <https://docs.microsoft.com/en-us/powershell/module/packagemanagement/register-packagesource?view=powershell-5.1>`_ command or the `powershell_package_source </resource_powershell_package_source.html>`__ resource.

**New in Chef Client 12.16.**

Syntax
=====================================================
A **powershell_package** resource block manages a package on a node, typically by installing it. The simplest use of the **powershell_package** resource is:

.. code-block:: ruby

   powershell_package 'package_name'

which will install the named package using all of the default options and the default action (``:install``).

The powershell_package resource has the following syntax:

.. code-block:: ruby

  powershell_package 'name' do
    package_name              String, Array
    skip_publisher_check      true, false # default value: false
    source                    String
    timeout                   String, Integer
    version                   String, Array
    action                    Symbol # defaults to :install if not specified
  end

where:

* ``powershell_package`` is the resource.
* ``name`` is the name given to the resource block.
* ``action`` identifies which steps the chef-client will take to bring the node into the desired state.
* ``package_name``, ``skip_publisher_check``, ``source``, ``timeout``, and ``version`` are the properties available to this resource.

Actions
=====================================================

The powershell_package resource has the following actions:

``:install``
   Default. Install a package. If a version is specified, install the specified version of the package.

``:remove``
   Remove a package.

Properties
=====================================================

The powershell_package resource has the following properties:

``package_name``
   **Ruby Type:** String, Array

   The name of the package. Default value: the name of the resource block.

``skip_publisher_check``
   **Ruby Type:** true, false | **Default Value:** ``false``

   Skip validating module author.

   *New in Chef Client 14.3.*

``source``
   **Ruby Type:** String

   Specify the source of the package.

   *New in Chef Client 14.0.*

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
**Install a specific version of a package:**

.. code-block:: ruby

   powershell_package 'xCertificate' do
     action :install
     version '1.1.0.0'
   end

**Install multiple packages:**

.. code-block:: ruby

   powershell_package 'Install Multiple Packages' do
     action :install
     package_name %w(xCertificate xNetworking)
   end

**Install a package from a custom source:**

.. code-block:: ruby

   powershell_package 'xCertificate' do
     action :install
     source 'MyGallery'
   end

**Install multiple packages, and specify package versions:**

.. code-block:: ruby

    powershell_package 'Install Multiple Packages' do
      action :install
      package_name %w(xCertificate xNetworking)
      version ['2.0.0.0', '2.12.0.0']
    end

** Install multiple packages, specifying the package version for one package but not the other:**

.. code-block:: ruby

   powershell_package 'Install Multiple Packages' do
      action :install
      package_name %w(xCertificate xNetworking)
      version [nil, '2.12.0.0']
    end

In this example, the ``nil`` tells ``powershell_package`` to install the most up to date version of ``xCertificate`` that is available, while pinning ``xNetworking`` to version 2.12.0.0.

**Remove a package:**

.. code-block:: ruby

    powershell_package 'xCertificate' do
      action :remove
    end
