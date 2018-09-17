=====================================================
zypper_repository resource
=====================================================
`[edit on GitHub] <https://github.com/chef/chef-web-docs/blob/master/chef_master/source/resource_zypper_repository.rst>`__

Use the **zypper_repository** resource to create Zypper package repositories on SUSE Enterprise Linux and openSUSE systems. This resource maintains full compatibility with the **zypper_repository** resource in the existing zypper cookbook.

**New in Chef Client 13.3.**

Syntax
=====================================================
The zypper_repository resource has the following syntax:

.. code-block:: ruby

  zypper_repository 'name' do
    autorefresh            true, false # default value: true
    baseurl                String
    cookbook               String
    description            String
    enabled                true, false # default value: true
    gpgautoimportkeys      true, false # default value: true
    gpgcheck               true, false # default value: true
    gpgkey                 String
    keeppackages           true, false # default value: false
    mirrorlist             String
    mode                   String, Integer # default value: 0644
    path                   String
    priority               Integer # default value: 99
    refresh_cache          true, false # default value: true
    repo_name              String # default value: 'name' unless specified
    source                 String
    type                   String # default value: NONE
    action                 Symbol # defaults to :create if not specified
  end

where:

* ``zypper_repository`` is the resource.
* ``name`` is the name given to the resource block.
* ``action`` identifies which steps the chef-client will take to bring the node into the desired state.
* ``autorefresh``, ``baseurl``, ``cookbook``, ``description``, ``enabled``, ``gpgautoimportkeys``, ``gpgcheck``, ``gpgkey``, ``keeppackages``, ``mirrorlist``, ``mode``, ``path``, ``priority``, ``refresh_cache``, ``repo_name``, ``source``, and ``type`` are the properties available to this resource.

Actions
=====================================================

The zypper_repository resource has the following actions:

``:add``

   Default action. Add a new Zypper repository.

``:remove``

   Remove a Zypper repository.

``:refresh``

   Refresh a Zypper repository.

Properties
=====================================================

The zypper_repository resource has the following properties:

``autorefresh``
   **Ruby Type:** true, false | **Default Value:** ``true``

   Determines whether or not the repository should be refreshed automatically.

``baseurl``
   **Ruby Type:** String

   The base URL for the Zypper repository, such as ``http://download.opensuse.org``.

``cookbook``
   **Ruby Type:** String

   The cookbook to source the repository template file from. Only necessary if you're not using the built in template.

``description``
   **Ruby Type:** String

   The description of the repository that will be shown by the ``zypper repos`` command.

``enabled``
   **Ruby Type:** true, false | **Default Value:** ``true``

   Determines whether or not the repository should be enabled.

``gpgautoimportkeys``
   **Ruby Type:** true, false | **Default Value:** ``true``

   Automatically import the specified key when setting up the repository.
``gpgcheck``
   **Ruby Type:** true, false | **Default Value:** ``true``

   Determines whether or not to perform a GPG signature check on the repository.

``gpgkey``
   **Ruby Type:** String

   The location of the repository key to be imported.

``keeppackages``
   **Ruby Type:** true, false | **Default Value:** ``false``

   Determines whether or not packages should be saved.

``mirrorlist``
   **Ruby Type:** String

   The URL of the mirror list that will be used.

``mode``
   **Ruby Type:** String, Integer | **Default Value:** ``0644``

   The file mode of the repository file.

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

``path``
   **Ruby Type:** String

   The relative path from the repository's base URL.

``priority``
   **Ruby Type:** Integer  |  **Default Value:** ``99``

   Determines the priority of the Zypper repository.

``refresh_cache``
   **Ruby Type:** true, false | **Default Value:** ``true``

   Determines whether or not the package cache should be refreshed.

``repo_name``
   **Ruby Type:** String | **Default Value:** ``'name'``

   Specifies the repository name, if it differs from the resource name.

``source``
   **Ruby Type:** String

   The name of the template for the repository file. Only necessary if you're not using the built in template.


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
   **Ruby Type:** String  |  **Default Value:** ``NONE``

   Specifies the repository type.

Examples
==========================================

**Add a repository**

This example adds the "Apache" repository for OpenSUSE Leap 42.2:

.. code-block:: ruby

   zypper_repository 'apache' do
     baseurl 'http://download.opensuse.org/repositories/Apache'
     path '/openSUSE_Leap_42.2'
     type 'rpm-md'
     priority '100'
   end
