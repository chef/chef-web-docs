=====================================================
windows_service resource
=====================================================
`[edit on GitHub] <https://github.com/chef/chef-web-docs/blob/master/chef_master/source/resource_windows_service.rst>`__

Use the **windows_service** resource to create, delete, or manage a service on the Microsoft Windows platform.

Syntax
=====================================================
.. tag resource_service_windows_syntax

A **windows_service** resource block manages the state of a service on a machine that is running Microsoft Windows. For example:

.. code-block:: ruby

   windows_service 'BITS' do
     action :configure_startup
     startup_type :manual
   end

The full syntax for all of the properties that are available to the **windows_service** resource is:

.. code-block:: ruby

   windows_service 'name' do
     binary_path_name           String
     desired_access             Integer
     delayed_start              [Integer] # This only applies if startup_type is :automatic
     dependencies               [String, Array]
     description                String
     desired_access             Integer # defaults to 983551
     display_name               String
     error_control              Integer
     init_command               String
     load_order_group           String
     notifies                   # see description
     pattern                    String
     reload_command             String # not used on the Windows platform
     restart_command            String
     run_as_password            String
     run_as_user                String
     service_name               String # defaults to 'name' if not specified
     service_type               Integer # defaults to 'SERVICE_WIN32_OWN_PROCESS'
     start_command              String
     startup_type               Symbol
     status_command             String
     stop_command               String
     subscribes                 # see description
     supports                   Hash
     timeout                    Integer
     action                     Symbol # defaults to :nothing if not specified
   end

where:

* ``windows_service`` is the resource
* ``name`` is the name of the resource block
* ``action`` identifies the steps the chef-client will take to bring the node into the desired state
* ``binary_path_name``, ``display_name``, ``desired_access``, ``delayed_start``, ``dependencies``, ``description``, ``error_control``, ``init_command``, ``load_order_group``, ``pattern``, ``reload_command``, ``restart_command``, ``run_as_password``, ``run_as_user``, ``service_name``, ``service_type``, ``start_command``, ``startup_type``, ``status_command``, ``stop_command``, ``supports``, and ``timeout`` are properties of this resource, with the Ruby type shown. See "Properties" section below for more information about all of the properties that may be used with this resource.

.. end_tag

Actions
=====================================================
.. tag resource_service_windows_actions

The windows_service resource has the following actions:

``:configure_startup``
   Configure a service based on the value of the ``startup_type`` property.

``:create``
   Create the service based on the value of the ``binary_path_name``, ``service_name`` and/or ``display_name`` property.

   New in Chef Client 14.0.

``:delete``
   Delete the service based on the value of the ``service_name`` property.

   New in Chef Client 14.0.

``:disable``
   Disable a service. This action is equivalent to a ``Disabled`` startup type on the Microsoft Windows platform.

``:enable``
   Enable a service at boot. This action is equivalent to an ``Automatic`` startup type on the Microsoft Windows platform.

``:nothing``
   Default. Do nothing with a service.

``:reload``
   Reload the configuration for this service. This action is not supported on the Windows platform and will raise an error if used.

``:restart``
   Restart a service.

``:start``
   Start a service, and keep it running until stopped or disabled.

``:stop``
   Stop a service.

.. end_tag

Properties
=====================================================
.. tag resource_service_windows_attributes

The windows_service resource has the following properties:

``binary_path_name``
   **Ruby Type:** String

   **Required** The fully qualified path to the service binary file. The path can also include arguments for an auto-start service.

   New in Chef Client 14.0.

``display_name``
   **Ruby Type:** String

   The display name to be used by user interface programs to identify the service. This string has a maximum length of 256 characters.

   New in Chef Client 14.0.

``delayed_start``
   **Ruby Type:** Integer

   Set the startup type to delayed start. This only applies if ``startup_type`` is ``:automatic``.

   New in Chef Client 14.0.

``dependencies``
   **Ruby Type:** String, Array

   A pointer to a double null-terminated array of null-separated names of services or load ordering groups that the system must start before this service. Specify ``nil`` or an empty string if the service has no dependencies. Dependency on a group means that this service can run if at least one member of the group is running after an attempt to start all members of the group.

   New in Chef Client 14.0.

``description``
   **Ruby Type:** String

   Description of the service.

   New in Chef Client 14.0.

``ignore_failure``
   **Ruby Type:** true, false | **Default Value:** ``false``

   Continue running a recipe if a resource fails for any reason.

``init_command``
   **Ruby Type:** String

   The path to the init script that is associated with the service. This is typically ``/etc/init.d/SERVICE_NAME``. The ``init_command`` property can be used to prevent the need to specify  overrides for the ``start_command``, ``stop_command``, and ``restart_command`` attributes.

``load_order_group``
   **Ruby Type:** String

   The name of the service's load ordering group(s). Specify ``nil`` or an empty string if the service does not belong to a group.

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
      Default. Specifies that a notification should be queued up, and then executed at the end of the Chef Client run.

   ``:immediate``, ``:immediately``
      Specifies that a notification should be run immediately, per resource notified.

   .. end_tag

   .. tag resources_common_notification_notifies_syntax

   The syntax for ``notifies`` is:

   .. code-block:: ruby

      notifies :action, 'resource[name]', :timer

   .. end_tag

``pattern``
   **Ruby Type:** String | **Default Value:** ``service_name``

   The pattern to look for in the process table.

``reload_command``
   **Ruby Type:** String

   The command used to tell a service to reload its configuration.

``restart_command``
   **Ruby Type:** String

   The command used to restart a service.

``retries``
   **Ruby Type:** Integer | **Default Value:** ``0``

   The number of times to catch exceptions and retry the resource.

``retry_delay``
   **Ruby Type:** Integer | **Default Value:** ``2``

   The retry delay (in seconds).

``run_as_password``
   **Ruby Type:** String

   The password for the user specified by ``run_as_user``.

``run_as_user``
   **Ruby Type:** String

   The user under which a Microsoft Windows service runs.

``service_name``
   **Ruby Type:** String

   The name of the service. Default value: the ``name`` of the resource block. See the "Syntax" section above for more information.

``start_command``
   **Ruby Type:** String

   The command used to start a service.

``startup_type``
   **Ruby Type:** Symbol | **Default Value:** ``:automatic``

   Use to specify the startup type for a Microsoft Windows service. Possible values: ``:automatic``, ``:disabled``, or ``:manual``.

``status_command``
   **Ruby Type:** String

   The command used to check the run status for a service.

``stop_command``
   **Ruby Type:** String

   The command used to stop a service.

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

``supports``
   **Ruby Type:** Hash

   A list of properties that controls how the chef-client is to attempt to manage a service: ``:restart``, ``:reload``, ``:status``. For ``:restart``, the init script or other service provider can use a restart command; if ``:restart`` is not specified, the chef-client attempts to stop and then start a service. For ``:reload``, the init script or other service provider can use a reload command. For ``:status``, the init script or other service provider can use a status command to determine if the service is running; if ``:status`` is not specified, the chef-client attempts to match the ``service_name`` against the process table as a regular expression, unless a pattern is specified as a parameter property. Default value: ``{ restart: false, reload: false, status: false }`` for all platforms (except for the Red Hat platform family, which defaults to ``{ restart: false, reload: false, status: true }``.)

``timeout``
   **Ruby Type:** Integer | **Default Value:** ``60``

   The amount of time (in seconds) to wait before timing out.

.. end_tag

Examples
=====================================================
The following examples demonstrate various approaches for using resources in recipes. If you want to see examples of how Chef uses resources in recipes, take a closer look at the cookbooks that Chef authors and maintains: https://github.com/chef-cookbooks.

**Start a service manually**

.. tag resource_service_windows_manual_start

.. To install a package:

.. code-block:: ruby

   windows_service 'BITS' do
     action :configure_startup
     startup_type :manual
   end

.. end_tag

**Create a service**

.. tag resource_service_windows_create

.. To create service with 'name':

.. code-block:: ruby

   windows_service 'chef-client' do
     action :create
     binary_path_name "C:\\opscode\\chef\\bin"
   end

Create service with 'service_name' and 'display_name':

.. code-block:: ruby

   windows_service 'Create chef client as service' do
     action :create
     display_name "CHEF-CLIENT"
     service_name "chef-client"
     binary_path_name "C:\\opscode\\chef\\bin"
   end

Create service with the ``:manual`` startup type:

.. code-block:: ruby

   windows_service 'chef-client' do
     action :create
     binary_path_name "C:\\opscode\\chef\\bin"
     startup_type :manual
   end

Create a service with the ``:disabled`` startup type:

.. code-block:: ruby

   windows_service 'chef-client' do
     action :create
     binary_path_name "C:\\opscode\\chef\\bin"
     startup_type :disabled
   end

Create service with the ``:automatic`` startup type and delayed start enabled:

.. code-block:: ruby

   windows_service 'chef-client' do
     action :create
     binary_path_name "C:\\opscode\\chef\\bin"
     startup_type :automatic
     delayed_start true
   end

Create service with a description:

.. code-block:: ruby

   windows_service 'chef-client' do
     action :create
     binary_path_name "C:\\opscode\\chef\\bin"
     startup_type :automatic
     description "Chef client as service"
   end

.. end_tag

**Delete a service**

.. tag resource_service_windows_delete

Delete service with the ``'name'`` of ``chef-client``:

.. code-block:: ruby

   windows_service 'chef-client' do
     action :delete
   end

Delete service with ``'service_name'``:

.. code-block:: ruby

   windows_service 'Delete chef client' do
     action :delete
     service_name "chef-client"
   end

.. end_tag

**Configure a service**

.. tag resource_service_windows_configure

Change an existing service from automatic to manual startup:

.. code-block:: ruby

   windows_service 'chef-client' do
     action :configure
     binary_path_name "C:\\opscode\\chef\\bin"
     startup_type :manual
   end

.. end_tag
