=====================================================
windows_certificate resource
=====================================================
`[edit on GitHub] <https://github.com/chef/chef-web-docs/blob/master/chef_master/source/resource_windows_certificate.rst>`__

Use the **windows_certificate** resource to install a certificate into the Windows certificate store from a file. The resource grants read-only access to the private key for designated accounts. Due to current limitations in WinRM, installing certificates remotely may not work if the operation requires a user profile. Operations on the local machine store should still work.

**New in Chef Client 14.7.**

Syntax
=====================================================
The windows_certificate resource has the following syntax:

.. code-block:: ruby

  windows_certificate 'name' do
    cert_path            String
    pfx_password         String
    private_key_acl      Array
    source               String # default value: 'name' unless specified
    store_name           String # default value: "MY"
    user_store           true, false # default value: false
    action               Symbol # defaults to :create if not specified
  end

where:

* ``windows_certificate`` is the resource.
* ``name`` is the name given to the resource block.
* ``action`` identifies which steps the chef-client will take to bring the node into the desired state.
* ``cert_path``, ``pfx_password``, ``private_key_acl``, ``source``, ``store_name``, and ``user_store`` are the properties available to this resource.

Actions
=====================================================

The windows_certificate resource has the following actions:

``:acl_add``
    Adds read-only entries to a certificate's private key ACL.

``:create``
    Creates or updates a certificate.

``:delete``
    Deletes a certificate.

``:fetch``
    Fetches a certificate.

``:verify``
    Verifies a certificate.

``:nothing``
   .. tag resources_common_actions_nothing

   This resource block does not act unless notified by another resource to take action. Once notified, this resource block either runs immediately or is queued up to run at the end of the Chef Infra Client run.

   .. end_tag

Properties
=====================================================

The windows_certificate resource has the following properties:

``cert_path``
   **Ruby Type:** String

``pfx_password``
   **Ruby Type:** String

   The password to access the source if it is a pfx file.

``private_key_acl``
   **Ruby Type:** Array

   An array of 'domain\account' entries to be granted read-only access to the certificate's private key. Not idempotent.

``source``
   **Ruby Type:** String | **Default Value:** ``The resource block's name``

   The source file (for create and acl_add), thumbprint (for delete and acl_add) or subject (for delete).

``store_name``
   **Ruby Type:** String | **Default Value:** ``"MY"``

   The certificate store to manipulate.

``user_store``
   **Ruby Type:** true, false | **Default Value:** ``false``

   Use the user store of the local machine store if set to false.

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
==========================================

**Add PFX cert to local machine personal store and grant accounts read-only access to private key**

.. code-block:: ruby

  windows_certificate 'c:/test/mycert.pfx' do
    pfx_password 'password'
    private_key_acl ["acme\fred", "pc\jane"]
  end

**Add cert to trusted intermediate store**

.. code-block:: ruby

  windows_certificate 'c:/test/mycert.cer' do
    store_name 'CA'
  end

**Remove all certificates matching the subject**

.. code-block:: ruby

  windows_certificate 'me.acme.com' do
    action :delete
  end
