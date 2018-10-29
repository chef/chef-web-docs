=====================================================
chocolatey_package resource
=====================================================
`[edit on GitHub] <https://github.com/chef/chef-web-docs/blob/master/chef_master/source/resource_chocolatey_package.rst>`__

.. tag resource_package_chocolatey

Use the **chocolatey_package** resource to manage packages using Chocolatey on the Microsoft Windows platform.

.. end_tag

.. warning:: .. tag notes_resource_chocolatey_package

             The **chocolatey_package** resource must be specified as ``chocolatey_package`` and cannot be shortened to ``package`` in a recipe.

             .. end_tag
             
**New in Chef Client 12.7.**

Syntax
=====================================================
.. tag resource_package_chocolatey_syntax

A **chocolatey_package** resource manages packages using Chocolatey on the Microsoft Windows platform. The simplest use of the **chocolatey_package** resource is:

.. code-block:: ruby

   chocolatey_package 'package_name'

which will install the named package using all of the default options and the default action (``:install``).

The full syntax for all of the properties that are available to the **chocolatey_package** resource is:

.. code-block:: ruby

   chocolatey_package 'name' do
     options                    String
     package_name               String, Array # defaults to 'name' if not specified
     returns                    Integer, Array # default value: [0]
     source                     String
     timeout                    String, Integer
     version                    String, Array
     action                     Symbol # defaults to :install if not specified
   end

where:

* ``chocolatey_package`` is the resource.
* ``name`` is the name given to the resource block.
* ``action`` identifies which steps the chef-client will take to bring the node into the desired state.
* ``options``, ``package_name``, ``source``, ``timeout``, and ``version`` are properties of this resource, with the Ruby type shown. See "Properties" section below for more information about all of the properties that may be used with this resource.

.. end_tag

Actions
=====================================================
.. tag resource_package_chocolatey_actions

This resource has the following actions:

``:install``
   Default. Install a package. If a version is specified, install the specified version of the package.

``:nothing``
   .. tag resources_common_actions_nothing

   Define this resource block to do nothing until notified by another resource to take action. When this resource is notified, this resource block is either run immediately or it is queued up to be run at the end of the Chef Client run.

   .. end_tag

``:purge``
   Purge a package. This action typically removes the configuration files as well as the package.

``:reconfig``
   Reconfigure a package. This action requires a response file.

``:remove``
   Remove a package.

``:uninstall``
   Uninstall a package.

   Deprecated as of Chef 13.7

``:upgrade``
   Install a package and/or ensure that a package is the latest version.

.. end_tag

Properties
=====================================================
.. tag resource_package_chocolatey_attributes

The chocolatey_package resource has the following properties:

``ignore_failure``
   **Ruby Type:** true, false | **Default Value:** ``false``

   Continue running a recipe if a resource fails for any reason.

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

``options``
   **Ruby Type:** String

   One (or more) additional options that are passed to the command.

``package_name``
   **Ruby Type:** String, Array

   The name of the package. Default value: the ``name`` of the resource block. See "Syntax" section above for more information.

``retries``
   **Ruby Type:** Integer | **Default Value:** ``0``

   The number of times to catch exceptions and retry the resource.

``retry_delay``
   **Ruby Type:** Integer | **Default Value:** ``2``

   The retry delay (in seconds).

``source``
   **Ruby Type:** String

   Optional. The path to a package in the local file system or a reachable UNC path. Ensure that the path specified is to the **folder** containing the chocolatey package(s), not to the package itself.

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

``timeout``
   **Ruby Type:** String, Integer

   The amount of time (in seconds) to wait before timing out.

``version``
   **Ruby Type:** String, Array

   The version of a package to be installed or upgraded.

``returns``
   **Ruby Type:** Integer, Array of Integers

   The exit code(s) returned a chocolatey package that indicate success. Default is 0.

   The syntax for ``returns`` is:

   .. code-block:: ruby

      returns [0, 1605, 1614, 1641]

.. end_tag

Examples
=====================================================
The following examples demonstrate various approaches for using resources in recipes. If you want to see examples of how Chef uses resources in recipes, take a closer look at the cookbooks that Chef authors and maintains: https://github.com/chef-cookbooks.

**Install a package**

.. tag resource_chocolatey_package_install

.. To install a package:

.. code-block:: ruby

   chocolatey_package 'name of package' do
     action :install
   end

**Install a package with options**

This example uses Chocolatey's ``--checksum`` option:

.. code-block:: ruby

   chocolatey_package 'name of package' do
     options '--checksum 1234567890'
     action :install
   end

.. end_tag
