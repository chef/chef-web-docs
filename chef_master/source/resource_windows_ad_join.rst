=====================================================
windows_ad_join resource
=====================================================
`[edit on GitHub] <https://github.com/chef/chef-web-docs/blob/master/chef_master/source/resource_windows_ad_join.rst>`__

Use the **windows_ad_join** resource to join a Windows Active Directory domain.

**New in Chef Client 14.0.**

Syntax
=====================================================
The windows_ad_join resource has the following syntax:

.. code-block:: ruby

  windows_ad_join 'name' do
    domain_name          String # default value: 'name' unless specified
    domain_password      String
    domain_user          String
    new_hostname         String
    ou_path              String
    reboot               Symbol # default value: immediate
    sensitive            true, false # default value: true
    action               Symbol # defaults to :join if not specified
  end

where:

* ``windows_ad_join`` is the resource.
* ``name`` is the name given to the resource block.
* ``action`` identifies which steps the chef-client will take to bring the node into the desired state.
* ``domain_name``, ``domain_password``, ``domain_user``, ``new_hostname``, ``ou_path``, ``reboot``, and ``sensitive`` are the properties available to this resource.

Actions
=====================================================

The windows_ad_join resource has the following actions:

``:join``
   Default. Join the Active Directory domain.

``:nothing``
   .. tag resources_common_actions_nothing

   Define this resource block to do nothing until notified by another resource to take action. When this resource is notified, this resource block is either run immediately or it is queued up to be run at the end of the Chef Client run.

   .. end_tag

Properties
=====================================================

The windows_ad_join resource has the following properties:

``domain_name``
   **Ruby Type:** String | **Default Value:** ``'name'``

   The FQDN of the Active Directory domain to join.

``domain_password``
   **Ruby Type:** String | ``REQUIRED``

   The password for the domain user. Note that this resource is set to hide sensitive information by default.

``domain_user``
   **Ruby Type:** String | ``REQUIRED``

   The domain user that will be used to join the domain.

``new_hostname``
   **Ruby Type:** String

   Specifies a new hostname for the computer in the new domain.

   New in Chef Client 14.5.

``ou_path``
   **Ruby Type:** String

   The path to the Organizational Unit where the host will be placed.

``reboot``
   **Ruby Type:** Symbol | **Default Value:** ``:immediate``

   Controls the system reboot behavior after joining the domain, with the following options:

   * ``:immediate``: reboot immediately
   * ``:delayed``: reboot after the Chef Client run completes
   * ``:never``: do not reboot

   Note that a reboot is necessary for changes to take effect.

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

      The number of times to catch exceptions and retry the resource.

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
**Join a domain**

.. code-block:: ruby

  windows_ad_join 'ad.example.org' do
    domain_user 'nick'
    domain_password 'p@ssw0rd1'
  end

**Join a domain, as `win-workstation`**

.. code-block:: ruby

  windows_ad_join 'ad.example.org' do
    domain_user 'nick'
    domain_password 'p@ssw0rd1'
    new_hostname 'win-workstation'
  end
