=====================================================
openssl_x509_certificate resource
=====================================================
`[edit on GitHub] <https://github.com/chef/chef-web-docs/blob/master/chef_master/source/resource_openssl_x509_certificate.rst>`__

Use the **openssl_x509_certificate** resource to generate signed or self-signed, PEM-formatted x509 certificates. If no existing key is specified, the resource will automatically generate a passwordless key with the certificate. If a CA private key and certificate are provided, the certificate will be signed with them. Note: This resource was renamed from openssl_x509 to openssl_x509_certificate. The legacy name will continue to function, but cookbook code should be updated for the new resource name.

**New in Chef Client 14.4.**

Syntax
=====================================================
The openssl_x509_certificate resource has the following syntax:

.. code-block:: ruby

  openssl_x509_certificate 'name' do
    ca_cert_file          String
    ca_key_file           String
    ca_key_pass           String
    city                  String
    common_name           String
    country               String
    csr_file              String
    email                 String
    expire                Integer # default value: 365
    extensions            Hash
    group                 String
    key_curve             String # default value: "prime256v1"
    key_file              String
    key_length            Integer # default value: 2048
    key_pass              String
    key_type              String # default value: "rsa"
    mode                  Integer, String
    org                   String
    org_unit              String
    owner                 String
    path                  String # default value: 'name' unless specified
    state                 String
    subject_alt_name      Array
    action                Symbol # defaults to :create if not specified
  end

where:

* ``openssl_x509_certificate`` is the resource.
* ``name`` is the name given to the resource block.
* ``action`` identifies which steps the chef-client will take to bring the node into the desired state.
* ``ca_cert_file``, ``ca_key_file``, ``ca_key_pass``, ``city``, ``common_name``, ``country``, ``csr_file``, ``email``, ``expire``, ``extensions``, ``group``, ``key_curve``, ``key_file``, ``key_length``, ``key_pass``, ``key_type``, ``mode``, ``org``, ``org_unit``, ``owner``, ``path``, ``state``, and ``subject_alt_name`` are the properties available to this resource.

Actions
=====================================================

The openssl_x509_certificate resource has the following actions:

``:create``
   Default. Create the certificate file.

``:nothing``
   .. tag resources_common_actions_nothing

   This resource block does not act unless notified by another resource to take action. Once notified, this resource block either runs immediately or is queued up to run at the end of the Chef Client run.

   .. end_tag

Properties
=====================================================

The openssl_x509_certificate resource has the following properties:

``ca_cert_file``
   **Ruby Type:** String

   The path to the CA X509 Certificate on the filesystem. If the ca_cert_file property is specified, the ``ca_key_file`` property must also be specified, the certificate will be signed with them.

``ca_key_file``
   **Ruby Type:** String

   The path to the CA private key on the filesystem. If the ca_key_file property is specified, the ``ca_cert_file`` property must also be specified, the certificate will be signed with them.

``ca_key_pass``
   **Ruby Type:** String

   The passphrase for CA private key's passphrase.

``city``
   **Ruby Type:** String

   Value for the ``L`` certificate field.

``common_name``
   **Ruby Type:** String

   Value for the ``CN`` certificate field.

``country``
   **Ruby Type:** String

   Value for the ``C`` certificate field.

``csr_file``
   **Ruby Type:** String

   The path to a X509 Certificate Request (CSR) on the filesystem. If the csr_file property is specified, the resource will attempt to source a CSR from this location. If no CSR file is found, the resource will generate a Self-Signed Certificate and the certificate fields must be specified (common_name at last).

``email``
   **Ruby Type:** String

   Value for the ``email`` certificate field.

``expire``
   **Ruby Type:** Integer | **Default Value:** ``365``

   Value representing the number of days from now through which the issued certificate cert will remain valid. The certificate will expire after this period.

``extensions``
   **Ruby Type:** Hash

   Hash of X509 Extensions entries, in format ``{ 'keyUsage' => { 'values' => %w( keyEncipherment digitalSignature), 'critical' => true } }``.

``group``
   **Ruby Type:** String

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
   **Ruby Type:** String | **Default Value:** ``"rsa"``

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
   **Ruby Type:** String

   The owner applied to all files created by the resource.

``path``
   **Ruby Type:** String | **Default Value:** ``The resource block's name``

   The path to write the file to if it differs from the resource name.

``state``
   **Ruby Type:** String

   Value for the ``ST`` certificate field.

``subject_alt_name``
   **Ruby Type:** Array
   
   Array of Subject Alternative Name entries, in format DNS:example.com or IP:1.2.3.4.

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

**Create a simple self-signed certificate file**

.. code-block:: ruby

  openssl_x509 '/etc/httpd/ssl/mycert.pem' do
    common_name 'www.f00bar.com'
    org 'Foo Bar'
    org_unit 'Lab'
    country 'US'
  end

**Create a certificate using additional options**

.. code-block:: ruby

    openssl_x509_certificate '/etc/ssl_test/my_signed_cert.crt' do
    common_name 'www.f00bar.com'
    ca_key_file '/etc/ssl_test/my_ca.key'
    ca_cert_file '/etc/ssl_test/my_ca.crt'
    expire 365
    extensions(
      'keyUsage' => {
        'values' => %w(
          keyEncipherment
          digitalSignature),
        'critical' => true,
      },
      'extendedKeyUsage' => {
        'values' => %w(serverAuth),
        'critical' => false,
      }
    )
    subject_alt_name ['IP:127.0.0.1', 'DNS:localhost.localdomain']
  end
