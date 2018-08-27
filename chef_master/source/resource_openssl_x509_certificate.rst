=====================================================
openssl_x509_certificate
=====================================================
`[edit on GitHub] <https://github.com/chef/chef-web-docs/blob/master/chef_master/source/resource_openssl_x509_certificate.rst>`__

Use the **openssl_x509_certificate** resource to generate signed or self-signed, PEM-formatted x509 certificates. If no existing key is specified, the resource will automatically generate a passwordless key with the certificate. If a CA private key and certificate are provided, the certificate will be signed with them. Note: This resource was renamed from openssl_x509 to openssl_x509_certificate. The legacy name will continue to function, but cookbook code should be updated for the new resource name.

New in Chef Client 14.4.

Syntax
=====================================================
This resource has the following syntax:

.. code-block:: ruby

   openssl_x509_certificate 'name' do
     city                       String
     email                      String
     ca_cert_file               String
     ca_key_file                String
     ca_key_pass                String
     common_name                String
     country                    String
     csr_file                   String
     expire                     Integer, # default value '365'
     extensions                 Hash
     group                      String
     key_curve                  String # default value: 'prime256v1'
     key_file                   String
     key_length                 Integer # default value: '2048'
     key_pass                   String
     key_type                   String # default value: 'rsa'
     mode                       Integer, String
     notifies                   # see description
     owner                      String
     org                        String
     org_unit                   String
     path                       String # default value: 'name'
     state                      String
     subject_alt_name           Array
     subscribes                 # see description
     action                     Symbol # defaults to :create if not specified

where:

* ``openssl_x509_certificate`` is the name of the resource
* ``'name'`` is the path where the certificate file will be written, or the name of the resource block
* ``city``, ``email``, ``ca_cert_file``, ``ca_key_file``, ``ca_key_pass``, ``common_name``, ``country``, ``csr_file``, ``expire``, ``extensions``,  ``group``, ``key_curve``, ``key_file``, ``key_length``, ``key_pass``, ``key_type``, ``mode``, ``notifies``, ``org``, ``org_unit``, ``owner``, ``path``, ``state``, ``subject_alt_name``, and ``subscribes`` are the properties available to this resource

Actions
=====================================================
``:create``
   Default. Create the certificate file.

``:nothing``
   .. tag resources_common_actions_nothing

   Define this resource block to do nothing until notified by another resource to take action. When this resource is notified, this resource block is either run immediately or it is queued up to be run at the end of the Chef Client run.

   .. end_tag

Properties
=====================================================
``city``
   **Ruby Type:** String

   Value for the ``L`` certificate field.

``email``
   **Ruby Type:** String

   Value for the ``email`` ssl field.

``ca_cert_file``
   **Ruby Type:** String

   The path to the CA X509 Certificate on the filesystem. If the ca_cert_file property is specified, the ``ca_key_file`` property must also be specified, the certificate will be signed with them.

``ca_key_file``
   **Ruby Type:** String

   The path to the CA private key on the filesystem. If the ca_key_file property is specified, the ``ca_cert_file`` property must also be specified, the certificate will be signed with them.

``ca_key_pass``
   **Ruby Type:** String

   The passphrase for CA private key's passphrase.

``common_name``
   **Ruby Type:** String

   Value for the ``CN`` certificate field.

``country``
   **Ruby Type:** String

   Value for the ``C`` certificate field.

``csr_file``
   **Ruby Type:** String

   The path to a X509 Certificate Request (CSR) on the filesystem. If the csr_file property is specified, the resource will attempt to source a CSR from this location. If no CSR file is found, the resource will generate a Self-Signed Certificate and the certificate fields must be specified (common_name at last).

``expire``
   **Ruby Type:** Integer | **Default Value:** ``365``

   Value representing the number of days from now through which the issued certificate cert will remain valid. The certificate will expire after this period.

``extension``
   **Ruby Type:** Array

   Hash of X509 Extensions entries, in format ``{ 'keyUsage' => { 'values' => %w( keyEncipherment digitalSignature), 'critical' => true } }``.

``group``
   **Ruby Types:** String

   The system group of all files created by the resource.

``key_curve``
   **Ruby Types:** String | **Default Value:** ``prime256v1``

   The desired curve of the generated key (if key_type is equal to 'ec'). Run ``openssl ecparam -list_curves`` to see available options.

``key_file``
   **Ruby Types:** String

   The path to a certificate key file on the filesystem. If the key_file property is specified, the resource will attempt to source a key from this location. If no key file is found, the resource will generate a new key file at this location. If the key_file property is not specified, the resource will generate a key file in the same directory as the generated certificate, with the same name as the generated certificate.

``key_length``
   **Ruby Type:** Integer | **Default Value:** ``2048``

   The desired bit length of the generated key (if key_type is equal to 'rsa'). Available options are ``1024``, ``2048``, ``4096``, and ``8192``.

``key_pass``
   **Ruby Types:** String

   The passphrase for an existing key's passphrase

``key_type``
   **Ruby Types:** String | **Default Value:** ``rsa``

   The desired type of the generated key (rsa or ec).

``mode``
   **Ruby Types:** Integer, String

   The permission mode applied to all files created by the resource.

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
   **Ruby Types:** String

   The owner of all files created by the resource.

``org``
   **Ruby Types:** String

``org_unit``
   **Ruby Types:** String

``path``
   **Ruby Type:** String

   The path to write the file to, if it differs from the resource name.

``state``
   **Ruby Types:** String

   Value for the ``ST`` certificate field.

``subject_alt_name``
   **Ruby Types:** String

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
