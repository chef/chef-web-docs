=====================================================
openssl_x509_request resource
=====================================================
`[edit on GitHub] <https://github.com/chef/chef-web-docs/blob/master/chef_master/source/resource_openssl_x509_request.rst>`__

Use the **openssl_x509_request** resource to generate PEM-formatted x509 certificates requests. If no existing key is specified, the resource will automatically generate a passwordless key with the certificate.

**New in Chef Client 14.4.**

Syntax
=====================================================
The openssl_x509_request resource has the following syntax:

.. code-block:: ruby

  openssl_x509_request 'name' do
    city             String
    common_name      String
    country          String
    email            String
    group            String, Integer
    key_curve        String # default value: "prime256v1"
    key_file         String
    key_length       Integer # default value: 2048
    key_pass         String
    key_type         String # default value: "ec"
    mode             Integer, String
    org              String
    org_unit         String
    owner            String, Integer
    path             String # default value: 'name' unless specified
    state            String
    action           Symbol # defaults to :create if not specified
  end

where:

* ``openssl_x509_request`` is the resource.
* ``name`` is the name given to the resource block.
* ``action`` identifies which steps the chef-client will take to bring the node into the desired state.
* ``city``, ``common_name``, ``country``, ``email``, ``group``, ``key_curve``, ``key_file``, ``key_length``, ``key_pass``, ``key_type``, ``mode``, ``org``, ``org_unit``, ``owner``, ``path``, and ``state`` are the properties available to this resource.

Actions
=====================================================

The openssl_x509_request resource has the following actions:

``:create``
   Default. Create the certificate request file.

``:nothing``
   .. tag resources_common_actions_nothing

   This resource block does not act unless notified by another resource to take action. Once notified, this resource block either runs immediately or is queued up to run at the end of the Chef Client run.

   .. end_tag

Properties
=====================================================

The openssl_x509_request resource has the following properties:

``city``
   **Ruby Type:** String

   Value for the ``L`` certificate field.

``common_name``
   **Ruby Type:** String | ``REQUIRED``

   Value for the ``CN`` certificate field.

``country``
   **Ruby Type:** String

   Value for the ``C`` certificate field.

``email``
   **Ruby Type:** String

   Value for the ``email`` certificate field.

``group``
   **Ruby Type:** String, Integer

   The group ownership applied to all files created by the resource.

``key_curve``
   **Ruby Type:** String | **Default Value:** ``"prime256v1"``

   The desired curve of the generated key (if key_type is equal to 'ec'). Run ``openssl ecparam -list_curves`` to see available options.

``key_file``
   **Ruby Type:** String

   The path to a certificate key file on the filesystem. If the key_file property is specified, the resource will attempt to source a key from this location. If no key file is found, the resource will generate a new key file at this location. If the key_file property is not specified, the resource will generate a key file in the same directory as the generated certificate, with the same name as the generated certificate.

``key_length``
   **Ruby Type:** Integer | **Default Value:** ``2048``

   The desired bit length of the generated key (if key_type is equal to 'rsa'). Available options are ``1024``, ``2048``, ``4096``, and ``8192``.

``key_pass``
   **Ruby Type:** String

   The passphrase for an existing key's passphrase.

``key_type``
   **Ruby Type:** String | **Default Value:** ``"ec"``

   The desired type of the generated key (rsa or ec).

``mode``
   **Ruby Type:** Integer, String

   The permission mode applied to all files created by the resource.

``org``
   **Ruby Type:** String

   Value for the ``O`` certificate field.

``org_unit``
   **Ruby Type:** String

   Value for the ``OU`` certificate field.

``owner``
   **Ruby Type:** String, Integer

   The owner applied to all files created by the resource.

``path``
   **Ruby Type:** String | **Default Value:** ``The resource block's name``

   An optional property for specifying the path to write the file to if it differs from the resource block's name.

``state``
   **Ruby Type:** String

   Value for the ``ST`` certificate field.

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

**Create a certificate request file**

.. code-block:: ruby

  openssl_x509_request '/etc/ssl_test/my_ec_request.csr' do
    common_name 'myecrequest.example.com'
    org 'Test Kitchen Example'
    org_unit 'Kitchens'
    country 'UK'
  end
