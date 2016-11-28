=====================================================
Release Notes: chef-client 12.7
=====================================================

.. tag chef

Chef is a powerful automation platform that transforms infrastructure into code. Whether you’re operating in the cloud, on-premises, or in a hybrid environment, Chef automates how infrastructure is configured, deployed, and managed across your network, no matter its size.

This diagram shows how you develop, test, and deploy your Chef code.

.. image:: ../../images/start_chef.svg
   :width: 700px
   :align: center

.. end_tag

What's New
=====================================================
The following items are new for chef-client 12.7 and/or are changes from previous versions. The short version:

* **Chef::REST => require 'chef/rest'** Internal API calls are moved from ``Chef::REST`` to ``Chef::ServerAPI``. Any code that uses ``Chef::REST`` must use ``require 'chef/rest'``.
* **New chocolatey_package resource** Use the **chocolatey_package** resource to manage packages using Chocolatey for the Microsoft Windows platform.
* **New osx_profile resource** Use the **osx_profile** resource to manage configuration profiles (``.mobileconfig`` files) on the Mac OS X platform.
* **New apt_update resource** Use the **apt_update** resource to manage Apt repository updates on Debian and Ubuntu platforms.
* **Improved support for UTF-8** The chef-client 12.7 release fixes a UTF-8 handling bug present in chef-client versions 12.4, 12.5, and 12.6.
* **New options for the chef-client** The chef-client has a new option: ``--delete-entire-chef-repo``.
* **Multi-package support for Chocolatey and Zypper** A resource may specify multiple packages and/or versions for platforms that use Zypper or Chocolatey package managers (in addition to the existing support for specifying multiple packages for Yum and Apt packages).

Chef::REST => require 'chef/rest'
-----------------------------------------------------
Internal API calls are moved from ``Chef::REST`` to ``Chef::ServerAPI``. As a result of this move, ``Chef::REST`` is no longer globally required. Any code that uses ``Chef::REST`` must be required as follows:

.. code-block:: ruby

   require 'chef/rest'

For code that is run using knife or chef command line interfaces, consider using ``Chef::ServerAPI`` instead.

chocolatey_package
-----------------------------------------------------
.. tag resource_package_chocolatey

Use the **chocolatey_package** resource to manage packages using Chocolatey for the Microsoft Windows platform.

.. end_tag

Syntax
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. tag resource_package_chocolatey_syntax

A **chocolatey_package** resource block manages packages using Chocolatey for the Microsoft Windows platform. The simplest use of the **chocolatey_package** resource is:

.. code-block:: ruby

   chocolatey_package 'package_name'

which will install the named package using all of the default options and the default action (``:install``).

The full syntax for all of the properties that are available to the **chocolatey_package** resource is:

.. code-block:: ruby

   chocolatey_package 'name' do
     notifies                   # see description
     options                    String
     package_name               String, Array # defaults to 'name' if not specified
     provider                   Chef::Provider::Package::Chocolatey
     source                     String
     subscribes                 # see description
     timeout                    String, Integer
     version                    String, Array
     action                     Symbol # defaults to :install if not specified
   end

where

* ``chocolatey_package`` tells the chef-client to manage a package
* ``'name'`` is the name of the package
* ``:action`` identifies which steps the chef-client will take to bring the node into the desired state
* ``options``, ``package_name``, ``provider``, ``source``, ``timeout``, and ``version`` are properties of this resource, with the Ruby type shown. See "Properties" section below for more information about all of the properties that may be used with this resource.

.. end_tag

Actions
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. tag resource_package_chocolatey_actions

This resource has the following actions:

``:install``
   Default. Install a package. If a version is specified, install the specified version of the package.

``:nothing``
   .. tag resources_common_actions_nothing

   Define this resource block to do nothing until notified by another resource to take action. When this resource is notified, this resource block is either run immediately or it is queued up to be run at the end of the chef-client run.

   .. end_tag

``:purge``
   Purge a package. This action typically removes the configuration files as well as the package.

``:reconfig``
   Reconfigure a package. This action requires a response file.

``:remove``
   Remove a package.

``:uninstall``
   Uninstall a package.

``:upgrade``
   Install a package and/or ensure that a package is the latest version.

.. end_tag

Properties
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. tag resource_package_chocolatey_attributes

This resource has the following properties:

``ignore_failure``
   **Ruby Types:** TrueClass, FalseClass

   Continue running a recipe if a resource fails for any reason. Default value: ``false``.

``notifies``
   **Ruby Type:** Symbol, 'Chef::Resource[String]'

   .. tag resources_common_notification_notifies

   A resource may notify another resource to take action when its state changes. Specify a ``'resource[name]'``, the ``:action`` that resource should take, and then the ``:timer`` for that action. A resource may notifiy more than one resource; use a ``notifies`` statement for each resource to be notified.

   .. end_tag

   .. tag resources_common_notification_timers

   A timer specifies the point during the chef-client run at which a notification is run. The following timers are available:

   ``:before``
      Specifies that the action on a notified resource should be run before processing the resource block in which the notification is located.

   ``:delayed``
      Default. Specifies that a notification should be queued up, and then executed at the very end of the chef-client run.

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
   **Ruby Types:** String, Array

   The name of the package. Default value: the ``name`` of the resource block See "Syntax" section above for more information.

``provider``
   **Ruby Type:** Chef Class

   Optional. Explicitly specifies a provider. See "Providers" section below for more information.

``retries``
   **Ruby Type:** Integer

   The number of times to catch exceptions and retry the resource. Default value: ``0``.

``retry_delay``
   **Ruby Type:** Integer

   The retry delay (in seconds). Default value: ``2``.

``source``
   **Ruby Type:** String

   Optional. The path to a package in the local file system.

``subscribes``
   **Ruby Type:** Symbol, 'Chef::Resource[String]'

   .. tag resources_common_notification_subscribes

   A resource may listen to another resource, and then take action if the state of the resource being listened to changes. Specify a ``'resource[name]'``, the ``:action`` to be taken, and then the ``:timer`` for that action.

   .. end_tag

   .. tag resources_common_notification_timers

   A timer specifies the point during the chef-client run at which a notification is run. The following timers are available:

   ``:before``
      Specifies that the action on a notified resource should be run before processing the resource block in which the notification is located.

   ``:delayed``
      Default. Specifies that a notification should be queued up, and then executed at the very end of the chef-client run.

   ``:immediate``, ``:immediately``
      Specifies that a notification should be run immediately, per resource notified.

   .. end_tag

   .. tag resources_common_notification_subscribes_syntax

   The syntax for ``subscribes`` is:

   .. code-block:: ruby

      subscribes :action, 'resource[name]', :timer

   .. end_tag

``timeout``
   **Ruby Types:** String, Integer

   The amount of time (in seconds) to wait before timing out.

``version``
   **Ruby Types:** String, Array

   The version of a package to be installed or upgraded.

.. end_tag

Examples
+++++++++++++++++++++++++++++++++++++++++++++++++++++

**Install a package**

.. tag resource_chocolatey_package_install

.. To install a package:

.. code-block:: ruby

   chocolatey_package 'name of package' do
     action :install
   end

.. end_tag

osx_profile
-----------------------------------------------------
.. tag resource_osx_profile_7

Use the **osx_profile** resource to manage configuration profiles (``.mobileconfig`` files) on the Mac OS X platform. The **osx_profile** resource installs profiles by using the ``uuidgen`` library to generate a unique ``ProfileUUID``, and then using the ``profiles`` command to install the profile on the system.

.. end_tag

Syntax
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. tag resource_osx_profile_syntax

A **osx_profile** resource block manages configuration profiles on the Mac OS X platform:

.. code-block:: ruby

   osx_profile 'Install screensaver profile' do
     profile 'com.company.screensaver.mobileconfig'
   end

The full syntax for all of the properties that are available to the **osx_profile** resource is:

.. code-block:: ruby

   osx_profile 'name' do
     path                       # set automatically
     profile                    String, Hash
     profile_name               String # defaults to 'name' if not specified
     identifier                 String
     action                     Symbol # defaults to :install if not specified
   end

where

* ``osx_profile`` is the resource
* ``name`` is the name of the resource block
* ``:action`` identifies the steps the chef-client will take to bring the node into the desired state
* ``profile``, ``profile_name``, and ``identifier`` are properties of this resource, with the Ruby type shown. See "Properties" section below for more information about all of the properties that may be used with this resource.

.. end_tag

Actions
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. tag resource_osx_profile_actions

This resource has the following actions:

``:install``
   Default. Install the specified configuration profile.

``:nothing``
   Default. .. tag resources_common_actions_nothing

            Define this resource block to do nothing until notified by another resource to take action. When this resource is notified, this resource block is either run immediately or it is queued up to be run at the end of the chef-client run.

            .. end_tag

``:remove``
   Remove the specified configuration profile.

.. end_tag

Properties
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. tag resource_osx_profile_attributes

This resource has the following properties:

``identifier``
   **Ruby Type:** String

   Use to specify the identifier for the profile, such as ``com.company.screensaver``.

``ignore_failure``
   **Ruby Types:** TrueClass, FalseClass

   Continue running a recipe if a resource fails for any reason. Default value: ``false``.

``notifies``
   **Ruby Type:** Symbol, 'Chef::Resource[String]'

   .. tag resources_common_notification_notifies

   A resource may notify another resource to take action when its state changes. Specify a ``'resource[name]'``, the ``:action`` that resource should take, and then the ``:timer`` for that action. A resource may notifiy more than one resource; use a ``notifies`` statement for each resource to be notified.

   .. end_tag

   .. tag resources_common_notification_timers

   A timer specifies the point during the chef-client run at which a notification is run. The following timers are available:

   ``:before``
      Specifies that the action on a notified resource should be run before processing the resource block in which the notification is located.

   ``:delayed``
      Default. Specifies that a notification should be queued up, and then executed at the very end of the chef-client run.

   ``:immediate``, ``:immediately``
      Specifies that a notification should be run immediately, per resource notified.

   .. end_tag

   .. tag resources_common_notification_notifies_syntax

   The syntax for ``notifies`` is:

   .. code-block:: ruby

      notifies :action, 'resource[name]', :timer

   .. end_tag

``profile``
   **Ruby Types:** String, Hash

   Use to specify a profile. This may be the name of a profile contained in a cookbook or a Hash that contains the contents of the profile.

``profile_name``
   **Ruby Type:** String

   Use to specify the name of the profile, if different from the name of the resource block.

``provider``
   **Ruby Type:** Chef Class

   Optional. Explicitly specifies a provider.

``retries``
   **Ruby Type:** Integer

   The number of times to catch exceptions and retry the resource. Default value: ``0``.

``retry_delay``
   **Ruby Type:** Integer

   The retry delay (in seconds). Default value: ``2``.

``subscribes``
   **Ruby Type:** Symbol, 'Chef::Resource[String]'

   .. tag resources_common_notification_subscribes

   A resource may listen to another resource, and then take action if the state of the resource being listened to changes. Specify a ``'resource[name]'``, the ``:action`` to be taken, and then the ``:timer`` for that action.

   .. end_tag

   .. tag resources_common_notification_timers

   A timer specifies the point during the chef-client run at which a notification is run. The following timers are available:

   ``:before``
      Specifies that the action on a notified resource should be run before processing the resource block in which the notification is located.

   ``:delayed``
      Default. Specifies that a notification should be queued up, and then executed at the very end of the chef-client run.

   ``:immediate``, ``:immediately``
      Specifies that a notification should be run immediately, per resource notified.

   .. end_tag

   .. tag resources_common_notification_subscribes_syntax

   The syntax for ``subscribes`` is:

   .. code-block:: ruby

      subscribes :action, 'resource[name]', :timer

   .. end_tag

.. end_tag

Examples
+++++++++++++++++++++++++++++++++++++++++++++++++++++

**One liner to install profile from cookbook file**

.. tag resource_osx_profile_install_file_oneline

The ``profiles`` command will be used to install the specified configuration profile.

.. code-block:: ruby

   osx_profile 'com.company.screensaver.mobileconfig'

.. end_tag

**Install profile from cookbook file**

.. tag resource_osx_profile_install_file

The ``profiles`` command will be used to install the specified configuration profile. It can be in sub-directory within a cookbook.

.. code-block:: ruby

   osx_profile 'Install screensaver profile' do
     profile 'screensaver/com.company.screensaver.mobileconfig'
   end

.. end_tag

**Install profile from a hash**

.. tag resource_osx_profile_install_hash

The ``profiles`` command will be used to install the configuration profile, which is provided as a hash.

.. code-block:: ruby

   profile_hash = {
     'PayloadIdentifier' => 'com.company.screensaver',
     'PayloadRemovalDisallowed' => false,
     'PayloadScope' => 'System',
     'PayloadType' => 'Configuration',
     'PayloadUUID' => '1781fbec-3325-565f-9022-8aa28135c3cc',
     'PayloadOrganization' => 'Chef',
     'PayloadVersion' => 1,
     'PayloadDisplayName' => 'Screensaver Settings',
     'PayloadContent'=> [
       {
         'PayloadType' => 'com.apple.ManagedClient.preferences',
         'PayloadVersion' => 1,
         'PayloadIdentifier' => 'com.company.screensaver',
         'PayloadUUID' => '73fc30e0-1e57-0131-c32d-000c2944c108',
         'PayloadEnabled' => true,
         'PayloadDisplayName' => 'com.apple.screensaver',
         'PayloadContent' => {
           'com.apple.screensaver' => {
             'Forced' => [
               {
                 'mcx_preference_settings' => {
                   'idleTime' => 0,
                 }
               }
             ]
           }
         }
       }
     ]
   }

   osx_profile 'Install screensaver profile' do
     profile profile_hash
   end

.. end_tag

**Remove profile using identifier in resource name**

.. tag resource_osx_profile_remove_by_name

The ``profiles`` command will be used to remove the configuration profile specified by the provided ``identifier`` property.

.. code-block:: ruby

   osx_profile 'com.company.screensaver' do
     action :remove
   end

.. end_tag

**Remove profile by identifier and user friendly resource name**

.. tag resource_osx_profile_remove_by_identifier

The ``profiles`` command will be used to remove the configuration profile specified by the provided ``identifier`` property.

.. code-block:: ruby

   osx_profile 'Remove screensaver profile' do
     identifier 'com.company.screensaver'
     action :remove
   end

.. end_tag

apt_update
-----------------------------------------------------

.. tag resource_apt_update_7

Use the **apt_update** resource to manage Apt repository updates on Debian and Ubuntu platforms.

.. end_tag

Syntax
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. tag resource_apt_update_syntax

A **apt_update** resource block defines the update frequency for Apt repositories:

.. code-block:: ruby

   apt_update 'name' do
     frequency                  Integer
     action                     Symbol # defaults to :periodic if not specified
   end

where

* ``apt_update`` is the resource
* ``name`` is the name of the resource block
* ``:action`` identifies the steps the chef-client will take to bring the node into the desired state
* ``frequency`` is a property of this resource, with the Ruby type shown. See "Properties" section below for more information about all of the properties that may be used with this resource.

.. end_tag

Actions
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. tag resource_apt_update_actions

This resource has the following actions:

``:nothing``
   .. tag resources_common_actions_nothing

   Define this resource block to do nothing until notified by another resource to take action. When this resource is notified, this resource block is either run immediately or it is queued up to be run at the end of the chef-client run.

   .. end_tag

``:periodic``
   Update the Apt repository at the interval specified by the ``frequency`` property.

``:update``
   Update the Apt repository at the start of the chef-client run.

.. end_tag

Properties
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. tag resource_apt_update_attributes

This resource has the following properties:

``frequency``
   **Ruby Type:** Integer

   The frequency at which Apt repository updates are made. Use this property when the ``:periodic`` action is specified. Default value: ``86400``.

``ignore_failure``
   **Ruby Types:** TrueClass, FalseClass

   Continue running a recipe if a resource fails for any reason. Default value: ``false``.

``notifies``
   **Ruby Type:** Symbol, 'Chef::Resource[String]'

   .. tag resources_common_notification_notifies

   A resource may notify another resource to take action when its state changes. Specify a ``'resource[name]'``, the ``:action`` that resource should take, and then the ``:timer`` for that action. A resource may notifiy more than one resource; use a ``notifies`` statement for each resource to be notified.

   .. end_tag

   .. tag resources_common_notification_timers

   A timer specifies the point during the chef-client run at which a notification is run. The following timers are available:

   ``:before``
      Specifies that the action on a notified resource should be run before processing the resource block in which the notification is located.

   ``:delayed``
      Default. Specifies that a notification should be queued up, and then executed at the very end of the chef-client run.

   ``:immediate``, ``:immediately``
      Specifies that a notification should be run immediately, per resource notified.

   .. end_tag

   .. tag resources_common_notification_notifies_syntax

   The syntax for ``notifies`` is:

   .. code-block:: ruby

      notifies :action, 'resource[name]', :timer

   .. end_tag

``provider``
   **Ruby Type:** Chef Class

   Optional. Explicitly specifies a provider.

``retries``
   **Ruby Type:** Integer

   The number of times to catch exceptions and retry the resource. Default value: ``0``.

``retry_delay``
   **Ruby Type:** Integer

   The retry delay (in seconds). Default value: ``2``.

``subscribes``
   **Ruby Type:** Symbol, 'Chef::Resource[String]'

   .. tag resources_common_notification_subscribes

   A resource may listen to another resource, and then take action if the state of the resource being listened to changes. Specify a ``'resource[name]'``, the ``:action`` to be taken, and then the ``:timer`` for that action.

   .. end_tag

   .. tag resources_common_notification_timers

   A timer specifies the point during the chef-client run at which a notification is run. The following timers are available:

   ``:before``
      Specifies that the action on a notified resource should be run before processing the resource block in which the notification is located.

   ``:delayed``
      Default. Specifies that a notification should be queued up, and then executed at the very end of the chef-client run.

   ``:immediate``, ``:immediately``
      Specifies that a notification should be run immediately, per resource notified.

   .. end_tag

   .. tag resources_common_notification_subscribes_syntax

   The syntax for ``subscribes`` is:

   .. code-block:: ruby

      subscribes :action, 'resource[name]', :timer

   .. end_tag

.. end_tag

Examples
+++++++++++++++++++++++++++++++++++++++++++++++++++++

**Update the Apt repository at a specified interval**

.. tag resource_apt_update_periodic

.. To update the Apt repository at a specified interval:

.. code-block:: ruby

   apt_update 'all platforms' do
     frequency 86400
     action :periodic
   end

.. end_tag

**Update the Apt repository at the start of a chef-client run**

.. tag resource_apt_update_at_start_of_client_run

.. To update the Apt repository at the start of a chef-client run:

.. code-block:: ruby

   apt_update if node['platform_family'] == 'debian' do
     action :update
   end

.. end_tag

New chef-client options
-----------------------------------------------------
The chef-client has the following new options:

``--delete-entire-chef-repo``
   Delete the entire chef-repo. This option may only be used when running the chef-client in local mode (``--local-mode``) mode. This options requires ``--recipe-url`` to be specified.

Changelog
=====================================================
https://github.com/chef/chef/blob/master/CHANGELOG.md
