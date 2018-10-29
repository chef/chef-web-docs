=====================================================
apt_package resource
=====================================================
`[edit on GitHub] <https://github.com/chef/chef-web-docs/blob/master/chef_master/source/resource_apt_package.rst>`__

.. tag resource_package_apt

Use the **apt_package** resource to manage packages on Debian and Ubuntu platforms.

.. end_tag

.. note:: .. tag notes_resource_based_on_package

          In many cases, it is better to use the **package** resource instead of this one. This is because when the **package** resource is used in a recipe, the chef-client will use details that are collected by Ohai at the start of the chef-client run to determine the correct package application. Using the **package** resource allows a recipe to be authored in a way that allows it to be used across many platforms.

          .. end_tag

Syntax
=====================================================
A **apt_package** resource block manages a package on a node, typically by installing it. The simplest use of the **apt_package** resource is:

.. code-block:: ruby

   apt_package 'package_name'

which will install the named package using all of the default options and the default action (``:install``).

The full syntax for all of the properties that are available to the **apt_package** resource is:

.. code-block:: ruby

   apt_package 'name' do
     default_release            String
     notifies                   # see description
     options                    String, Array
     overwrite_config_files     true, false # default value: 'false'
     package_name               String, Array # defaults to 'name' if not specified
     response_file              String
     response_file_variables    Hash
     subscribes                 # see description
     timeout                    String, Integer
     version                    String, Array
     action                     Symbol # defaults to :install if not specified
   end

where:

* ``apt_package`` is the resource.
* ``name`` is the name given to the resource block.
* ``action`` identifies which steps the chef-client will take to bring the node into the desired state.
* ``default_release``, ``options``, ``package_name``, ``source``, ``timeout``, and ``version`` are properties of this resource, with the Ruby type shown. See "Properties" section below for more information about all of the properties that may be used with this resource.

Actions
=====================================================

The apt_package resource has the following actions:

``:install``
   Default. Install a package. If a version is specified, install the specified version of the package.

``:lock``
   Locks the apt package to a specific version.

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

``:unlock``
   Unlocks the apt package so that it can be upgraded to a newer version.

``:upgrade``
   Install a package and/or ensure that a package is the latest version.

Properties
=====================================================

The apt_package resource has the following properties:

``default_release``
   **Ruby Type:** String

   The default release. For example: ``stable``.

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
   **Ruby Type:** String, Array

   One (or more) additional options that are passed to the command. For example, common apt-get directives, such as ``--no-install-recommends``. See the `apt-get man page <http://manpages.ubuntu.com/manpages/zesty/man8/apt-get.8.html>`_ for the full list.

``overwrite_config_files``
   **Ruby Type:** true, false | **Default Value:** ``false``
   
   Overwrite existing configuration files with those supplied by the package, if prompted by APT.
   
   New in Chef Client 14.0.

``package_name``
   **Ruby Type:** String, Array

   The name of the package. Default value: the ``name`` of the resource block. See "Syntax" section above for more information.

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

``timeout``
   **Ruby Type:** String, Integer

   The amount of time (in seconds) to wait before timing out.

``version``
   **Ruby Type:** String, Array

   The version of a package to be installed or upgraded.

Multiple Packages
-----------------------------------------------------
.. tag resources_common_multiple_packages

A resource may specify multiple packages and/or versions for platforms that use Yum, DNF, Apt, Zypper, or Chocolatey package managers. Specifing multiple packages and/or versions allows a single transaction to:

* Download the specified packages and versions via a single HTTP transaction
* Update or install multiple packages with a single resource during the chef-client run

For example, installing multiple packages:

.. code-block:: ruby

   package %w(package1 package2)

Installing multiple packages with versions:

.. code-block:: ruby

   package %w(package1 package2) do
     version [ '1.3.4-2', '4.3.6-1']
   end

Upgrading multiple packages:

.. code-block:: ruby

   package %w(package1 package2)  do
     action :upgrade
   end

Removing multiple packages:

.. code-block:: ruby

   package %w(package1 package2)  do
     action :remove
   end

Purging multiple packages:

.. code-block:: ruby

   package %w(package1 package2)  do
     action :purge
   end

Notifications, via an implicit name:

.. code-block:: ruby

   package %w(package1 package2)  do
     action :nothing
   end

   log 'call a notification' do
     notifies :install, 'package[package1, package2]', :immediately
   end

.. note:: Notifications and subscriptions do not need to be updated when packages and versions are added or removed from the ``package_name`` or ``version`` properties.

.. end_tag

Examples
=====================================================

The following examples demonstrate various approaches for using apt_update in recipes.

**Install a package using package manager**

.. tag resource_apt_package_install_package

.. To install a package using package manager:

.. code-block:: ruby

   apt_package 'name of package' do
     action :install
   end

.. end_tag

**Install without using recommend packages as a dependency**

.. tag resource_apt_package_install_without_recommends_suggests

.. To install without using recommend packages as a dependency:

.. code-block:: ruby

   package 'apache2' do
     options '--no-install-recommends'
   end

.. end_tag
