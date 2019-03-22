=====================================================
windows_feature resource
=====================================================
`[edit on GitHub] <https://github.com/chef/chef-web-docs/blob/master/chef_master/source/resource_windows_feature.rst>`__

Use the **windows_feature** resource to add, remove or entirely delete Windows features and roles. This resource calls the `windows_feature_dism </resource_windows_feature_dism.html>`__ or `windows_feature_powershell </resource_windows_feature_powershell.html>`__ resources depending on the specified installation method, and defaults to DISM, which is available on both Workstation and Server editions of Windows.

**New in Chef Client 14.0.**

Syntax
=====================================================
The windows_feature resource has the following syntax:

.. code-block:: ruby

  windows_feature 'name' do
    all                   true, false # default value: false
    feature_name          Array, String # default value: 'name' unless specified
    install_method        Symbol # default value: :windows_feature_dism
    management_tools      true, false # default value: false
    source                String
    timeout               Integer # default value: 600
    action                Symbol # defaults to :install if not specified
  end

where:

* ``windows_feature`` is the resource.
* ``name`` is the name given to the resource block.
* ``action`` identifies which steps the chef-client will take to bring the node into the desired state.
* ``all``, ``feature_name``, ``install_method``, ``management_tools``, ``source``, and ``timeout`` are the properties available to this resource.

Actions
=====================================================

The windows_feature resource has the following actions:

``:install``
   Default. Install a Windows role / feature using PowerShell.

``:remove``
   Remove a Windows role / feature using PowerShell.

``:delete``
   Delete a Windows role / feature from the image using PowerShell.

``:nothing``
   .. tag resources_common_actions_nothing

   This resource block does not act unless notified by another resource to take action. Once notified, this resource block either runs immediately or is queued up to run at the end of the Chef Client run.

   .. end_tag

Properties
=====================================================

The windows_feature resource has the following properties:

``all``
   **Ruby Type:** true, false | **Default Value:** ``false``

   Install all subfeatures.

``feature_name``
   **Ruby Type:** Array, String | **Default Value:** ``The resource block's name``

   The name of the feature(s) or role(s) to install if it differs from the resource block name. The same feature may have different names depending on the underlying installation method being used (ie DHCPServer vs DHCP; DNS-Server-Full-Role vs DNS).

``install_method``
   **Ruby Type:** Symbol | **Default Value:** ``:windows_feature_dism``

   The underlying installation method to use for feature installation. Specify ':windows_feature_dism' for DISM or ':windows_feature_powershell' for PowerShell.


``management_tools``
   **Ruby Type:** true, false | **Default Value:** ``false``

   Install all applicable management tools for the roles, role services, or features (PowerShell-only).

``source``
   **Ruby Type:** String

   Specify a local repository for the feature install.

``timeout``
   **Ruby Type:** Integer | **Default Value:** ``600``

   Specifies a timeout (in seconds) for the feature installation.

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

**Install the DHCP Server feature**

.. code-block:: ruby

  windows_feature 'DHCPServer' do
    action :install
  end

**Install the .Net 3.5.1 feature using repository files on DVD**

.. code-block:: ruby

  windows_feature "NetFx3" do
    action :install
    source "d:\sources\sxs"
  end

**Remove Telnet Server and Client features**

.. code-block:: ruby

  windows_feature ['TelnetServer', 'TelnetClient'] do
    action :remove
  end

**Add the SMTP Server feature using the PowerShell provider**

.. code-block:: ruby

  windows_feature "smtp-server" do
    action :install
    all true
    install_method :windows_feature_powershell
  end

**Install multiple features using one resource with the PowerShell provider**

.. code-block:: ruby

  windows_feature ['Web-Asp-Net45', 'Web-Net-Ext45'] do
    action :install
    install_method :windows_feature_powershell
  end

**Install the Network Policy and Access Service feature, including the management tools. Which, for this example, will automatically install RSAT-NPAS as well.**

.. code-block:: ruby

  windows_feature 'NPAS' do
    action :install
    management_tools true
    install_method :windows_feature_powershell
  end
