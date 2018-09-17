=====================================================
apt_preference resource
=====================================================
`[edit on GitHub] <https://github.com/chef/chef-web-docs/blob/master/chef_master/source/resource_apt_preference.rst>`__

The **apt_preference** resource allows for the creation of APT `preference files <https://wiki.debian.org/AptPreferences>`__. Preference files are used to control which package versions and sources are prioritized during installation. 

**New in Chef Client 13.3.**

Syntax
=====================================================
The apt_preference resource has the following syntax:

.. code-block:: ruby

  apt_preference 'name' do
    glob              String
    package_name      String # default value: 'name' unless specified
    pin               String
    pin_priority      String, Integer
    action            Symbol # defaults to :add if not specified
  end

where:

* ``apt_preference`` is the resource.
* ``name`` is the name given to the resource block.
* ``action`` identifies which steps the chef-client will take to bring the node into the desired state.
* ``glob``, ``package_name``, ``pin``, and ``pin_priority`` are the properties available to this resource.

Actions
=====================================================

The apt_preference resource has the following actions:

``add``
  Default action. Creates a preferences file under ``/etc/apt/preferences.d``.

``remove``
  Removes the preferences file, thus unpinning the package.

Properties
=====================================================

The apt_preference resource has the following properties:

``glob``
   **Ruby Type:** String

   Pin by ``glob()`` expression or with regular expressions surrounded by ``/``.

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

``package_name``
   **Ruby Type:** String

   The name of the package. Default value: ``name``. 

``pin``
   **Ruby Type:** String

   The package version or repository to pin. 

``pin_priority``
   **Ruby Type:** String, Integer

   Sets the ``Pin-Priority`` for a package. See the `APT pinning documentation <https://wiki.debian.org/AptPreferences>`__ for more details. 

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

Examples
=====================================================

**Pin a package to a specific version**

This example pins the ``libmysqlclient16`` package to ``version 5.1.49-3``:

.. code-block:: ruby

   apt_preference 'libmysqlclient16' do
     pin          'version 5.1.49-3'
     pin_priority '700'
   end

Note that the ``pin_priority`` of ``700`` ensures that this version will be preferred over any other available versions. 

**Unpin a package**

This example unpins the ``libmysqlclient16`` package, disabling all preferences for it:

.. code-block:: ruby

   apt_preference 'libmysqlclient16' do
     action :remove
   end

**Pin all packages to prefer a specific repository**

This example instructs APT to prefer the ``packages.dotdeb.org`` repository:

.. code-block:: ruby

   apt_preference 'dotdeb' do
     glob         '*'
     pin          'origin packages.dotdeb.org'
     pin_priority '700'
   end
