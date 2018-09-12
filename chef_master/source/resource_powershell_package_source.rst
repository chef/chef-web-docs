=====================================================
powershell_package_source resource
=====================================================
`[edit on GitHub] <https://github.com/chef/chef-web-docs/blob/master/chef_master/source/resource_powershell_package_source.rst>`__

Use the **powershell_package_source** resource to register a PowerShell package repository.

**New in Chef Client 14.3.**

Syntax
=====================================================
The powershell_package_source resource has the following syntax:

.. code-block:: ruby

  powershell_package_source 'name' do
    provider_name                String # default value: NuGet
    publish_location             String
    script_publish_location      String
    script_source_location       String
    source_name                  String # default value: 'name' unless specified
    trusted                      true, false # default value: false
    url                          String
    action                       Symbol # defaults to :register if not specified
  end

where:

* ``powershell_package_source`` is the resource.
* ``name`` is the name given to the resource block.
* ``action`` identifies which steps the chef-client will take to bring the node into the desired state.
* ``provider_name``, ``publish_location``, ``script_publish_location``, ``script_source_location``, ``source_name``, ``trusted``, and ``url`` are the properties available to this resource.

Actions
=====================================================

``register``
   Default. Registers and updates the PowerShell package source.

``unregister``
   Unregisters the PowerShell package source.

``:nothing``
   Define this resource block to do nothing until notified by another resource to take action. When this resource is notified, this resource block is either run immediately or it is queued up to be run at the end of the Chef Client run.

Properties
=====================================================

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

``provider_name``
   **Ruby Type:** String | **Default Value:** ``NuGet``

   The package management provider for the source. It supports the following providers: 'Programs', 'msi', 'NuGet', 'msu', 'PowerShellGet', 'psl' and 'chocolatey'.

``publish_location``
   **Ruby Type:** String

   The url where modules will be published to for this source. Only valid if the provider is 'PowerShellGet'.

``script_publish_location``
   **Ruby Type:** String

   The location where scripts will be published to for this source. Only valid if the provider is 'PowerShellGet'.

``script_source_location``
   **Ruby Type:** String

   The url where scripts are located for this source. Only valid if the provider is 'PowerShellGet'.

``source_name``
   **Ruby Type:** String

   The name of the package source.

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

``trusted``
   **Ruby Type:** true, false | **Default Value:** ``false``

   Whether or not to trust packages from this source.

``url``
   **Ruby Type:** String

   The url to the package source.
