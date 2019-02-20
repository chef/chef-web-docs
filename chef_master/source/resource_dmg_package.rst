=====================================================
dmg_package resource
=====================================================
`[edit on GitHub] <https://github.com/chef/chef-web-docs/blob/master/chef_master/source/resource_dmg_package.rst>`__

Use the **dmg_package** resource to install a package from a ``.dmg`` file. The resource will retrieve the file from a remote URL, mount it using OS X's hdidutil, copy the application to the specified destination (``/Applications``), and detach the image using hdiutil. The ``.dmg`` file will be stored in the ``Chef::Config[:file_cache_path]``.

**New in Chef Client 14.0.**

Syntax
=====================================================
The dmg_package resource has the following syntax:

.. code-block:: ruby

  dmg_package 'name' do
    accept_eula          true, false # default value: false
    allow_untrusted      true, false # default value: false
    app                  String # default value: 'name' unless specified
    checksum             String
    destination          String # default value: "/Applications"
    dmg_name             String # default value: The value passed for the application name.
    dmg_passphrase       String
    file                 String
    headers              Hash
    owner                String
    package_id           String
    source               String
    type                 String # default value: "app"
    volumes_dir          String # default value: The value passed for the application name.
    action               Symbol # defaults to :install if not specified
  end

where:

* ``dmg_package`` is the resource.
* ``name`` is the name given to the resource block.
* ``action`` identifies which steps the chef-client will take to bring the node into the desired state.
* ``accept_eula``, ``allow_untrusted``, ``app``, ``checksum``, ``destination``, ``dmg_name``, ``dmg_passphrase``, ``file``, ``headers``, ``owner``, ``package_id``, ``source``, ``type``, and ``volumes_dir`` are the properties available to this resource.

Actions
=====================================================

The dmg_package resource has the following actions:

``:install``
   Default. Installs the application.

``:nothing``
   .. tag resources_common_actions_nothing

   This resource block does not act unless notified by another resource to take action. Once notified, this resource block either runs immediately or is queued up to run at the end of the Chef Client run.

   .. end_tag

Properties
=====================================================

The dmg_package resource has the following properties:

``accept_eula``
   **Ruby Type:** true, false | **Default Value:** ``false``

   Specify whether to accept the EULA. Certain dmgs require acceptance of EULA before mounting.

``allow_untrusted``
   **Ruby Type:** true, false | **Default Value:** ``false``

   Allow installation of packages that do not have trusted certificates.

``app``
   **Ruby Type:** String | **Default Value:** ``The resource block's name``

   The name of the application as it appears in the ``/Volumes`` directory if it differs from the resource block's name.

``checksum``
   **Ruby Type:** String

   The sha256 checksum of the ``.dmg`` file to download.

``destination``
   **Ruby Type:** String | **Default Value:** ``"/Applications"``

   The directory to copy the ``.app`` into.

``dmg_name``
   **Ruby Type:** String | **Default Value:** ``The value passed for the application name.``

   The name of the ``.dmg`` file if it differs from that of the app, or if the name has spaces.

``dmg_passphrase``
   **Ruby Type:** String

   Specify a passphrase to be used to decrypt the ``.dmg`` file during the mount process.

``file``
   **Ruby Type:** String

   The full path to the ``.dmg`` file on the local system.

``headers``
   **Ruby Type:** Hash

   Allows custom HTTP headers (like cookies) to be set on the ``remote_file`` resource.

``owner``
   **Ruby Type:** String

   The user that should own the package installation.

``package_id``
   **Ruby Type:** String

   The package ID that is registered with ``pkgutil`` when a ``pkg`` or ``mpkg`` is installed.

``source``
   **Ruby Type:** String

   The remote URL that is used to download the ``.dmg`` file, if specified.

``type``
   **Ruby Type:** String | **Default Value:** ``"app"``

   The type of package.

``volumes_dir``
   **Ruby Type:** String | **Default Value:** ``The value passed for the application name.``

   The directory under ``/Volumes`` where the dmg is mounted if it differs from the name of the ``.dmg`` file.

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
