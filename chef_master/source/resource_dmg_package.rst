=====================================================
dmg_package
=====================================================
`[edit on GitHub] <https://github.com/chef/chef-web-docs/blob/master/chef_master/source/resource_dmg_package.rst>`__

Use the **dmg_package** resource to install a package from a ``.dmg`` file. The resource will retrieve the file from a remote URL, mount it using OS X's hdidutil, copy the application to the specified destination (``/Applications``), and detach the image using hdiutil. The ``.dmg`` file will be stored in the ``Chef::Config[:file_cache_path]``.

**New in Chef Client 14.0.**

Syntax
=====================================================
This resource has the following syntax:

.. code-block:: ruby

   dmg_package 'name' do
     accept_eula                True, False # default value: 'false'
     allow_untrusted            True, False # default value: 'false'
     app                        String # default value: 'name'
     checksum                   String
     destination                String # default value: '/Applications'
     dmg_name                   String
     dmg_passphrase             String
     file                       String
     headers                    Hash, nil # default value: 'nil'
     notifies                   # see description
     owner                      String
     package_id                 String
     source                     String
     subscribes                 # see description
     type                       String # default value: 'app'
     volumes_dir                String
     action                     Symbol # defaults to :install if not specified
   end

where:

* ``dmg_package`` is the resource
* ``'name'`` The name of the application as it exists in the ``/Volumes`` directory, or the name of the resource block
* ``accept_eula``, ``allow_untrusted``, ``app``, ``checksum``, ``destination``, ``dmg_name``, ``dmg_passphrase``, ``file``, ``headers``, ``notifies``, ``owner``, ``package_id``, ``source``, ``subscribes``, ``type``, and ``volumes_dir``  are the properties available to this resource

Actions
=====================================================
``:install``
   Default. Installs the application. 
   
``:nothing``
   .. tag resources_common_actions_nothing

   Define this resource block to do nothing until notified by another resource to take action. When this resource is notified, this resource block is either run immediately or it is queued up to be run at the end of the Chef Client run.

   .. end_tag
   
Properties
=====================================================
``accept_eula``
   **Ruby Type:** True, False | **Default Value:** ``false``
   
   Specify if the application's EULA should be accepted, if applicable.

``allow_untrusted``
   **Ruby Type:** True, False | **Default Value:** ``false``
   
   Allow installation of packages that do not have trusted certificates.

``app``
   **Ruby Type:** String | **Default Value:** ``'name'``

   The name of the application as it appears in the ``/Volumes`` directory, if it differs from the resource block name. 

``checksum``
   **Ruby Type:** String
   
   The sha256 checksum of the ``.dmg`` file to download.

``destination``
   **Ruby Type:** String | **Default Value:** ``/Applications``
   
   The directory to copy the ``.app`` into.

``dmg_name``
   **Ruby Type:** String
   
   The name of the ``.dmg`` file if it differs from that of the app, or if the name has spaces.

``dmg_passphrase``
   **Ruby Type:** String
   
   Specify a passphrase to be used to decrypt the ``.dmg`` file during the mount process.

``file``
   **Ruby Type:** String
   
   The full path to the ``.dmg`` file on the local system.

``headers``
   **Ruby Type:** Hash, nil | **Default Value:** ``nil``
   
   Allows custom HTTP headers (like cookies) to be set on the ``remote_file`` resource.
   
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

``owner``
   **Ruby Type:** String
   
   The system user that should own the package installation.

``package_id``
   **Ruby Type:** String
   
   The package ID that is registered with ``pkgutil`` when a ``pkg`` or ``mpkg`` is installed.

``source``
   **Ruby Type:** String
   
   The remote URL that is used to download the ``.dmg`` file, if specified.
   
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

``type``
   **Ruby Type:** String | **Default Value:** ``app``
   
   The type of package.

``volumes_dir``
   **Ruby Type:** String
   
   The directory under ``/Volumes`` where the dmg is mounted, if it differs from the name of the ``.dmg`` file.
