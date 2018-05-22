=====================================================
powershell_package
=====================================================
`[edit on GitHub] <https://github.com/chef/chef-web-docs/blob/master/chef_master/source/resource_powershell_package.rst>`__

Use the **powershell_package** resource to install and manage packages via the Powershell Package Manager for the Microsoft Windows platform.  The **powershell_package** resource requires administrative access, and a source must be configured in the Powershell Package Manager via the `Register-PackageSource <https://docs.microsoft.com/en-us/powershell/module/packagemanagement/register-packagesource?view=powershell-5.1>`_ command

**Available in Chef Client 12.16 and above**

Syntax
=====================================================
A **powershell_package** resource block manages a package on a node, typically by installing it. The simplest use of the **powershell_package** resource is:

.. code-block:: ruby

   powershell_package 'package_name'

which will install the named package using all of the default options and the default action (``:install``).

The full syntax for all of the properties that are available to the **powershell_package** resource:

.. code-block:: ruby

   powershell_package 'name' do

     package_name               String, Array # defaults to 'name' if not specified
     version                    String, Array
     source                     String
     notifies                   # see description
     subscribes                 # see description
     action                     Symbol # defaults to :install if not specified
   end

where:

* ``powershell_package`` tells the chef-client to manage a package
* ``'name'`` is the name of the package
* ``action`` identifies which steps the chef-client will take to bring the node into the desired state
* ``package_name``, ``version``, ``source``, ``notifies``, and ``subscribes`` are properties of this resource, with the Ruby type shown. See the "Properties" section below for more information about all of the properties that may be used with this resource.

Actions
=====================================================
``:install``
   Default. Install a package. If a version is specified, install the specified version of the package.

``:remove``
   Remove a package.

Properties
=====================================================
``package_name``
   **Ruby Types:** String, Array

   The name of the package. Default value: the name of the resource block.

``version``
   **Ruby Types:** String, Array

   The version of a package to be installed or upgraded.

``source``
   **Ruby Types:** String
   
   Specify the source of the package.
   
   New in Chef Client 14.0.

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
      Default. Specifies that a notification should be queued up, and then executed at the very end of the Chef Client run.

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
      Default. Specifies that a notification should be queued up, and then executed at the very end of the Chef Client run.

   ``:immediate``, ``:immediately``
      Specifies that a notification should be run immediately, per resource notified.

   .. end_tag

   .. tag resources_common_notification_subscribes_syntax

   The syntax for ``subscribes`` is:

   .. code-block:: ruby

      subscribes :action, 'resource[name]', :timer

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
