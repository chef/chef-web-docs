=====================================================
openssl_x509_crl
=====================================================
`[edit on GitHub] <https://github.com/chef/chef-web-docs/blob/master/chef_master/source/resource_openssl_x509_crl.rst>`__

Use the **openssl_x509_crl** resource to generate PEM-formatted x509 certificate revocation list (CRL) files.

New in Chef Client 14.5.

Syntax
=====================================================
This resource has the following syntax:

.. code-block:: ruby

   openssl_x509_crl 'name' do
     ca_cert_file               String # required
     ca_key_file                String # required
     ca_key_pass                String
     expire                     Integer # default value: 8
     group                      String
     mode                       Integer, String # default value: '0640'
     notifies                   # see description
     owner                      String
     path                       String # default value: 'name'
     renewal_threshold          Integer # default value: 1
     revocation_reason          Integer # default value: 0
     serial_to_revoke           Integer, String
     subscribes                 # see description
     action                     Symbol # defaults to :create if not specified

where:

* ``openssl_x509_crl`` is the name of the resource
* ``'name'`` is the path where the crl file will be written, or the name of the resource block
* ``ca_cert_file``, ``ca_key_file``, ``ca_key_pass``, ``expire``, ``group``, ``mode``, ``notifies``, ``owner``, ``path``, ``renewal_threshold``, ``revocation_reason``, ``serial_to_revoke``, and ``subscribes`` are the properties available to this resource

Actions
=====================================================
``:create``
   Default. Create the certificate revocation list file.

``:nothing``
   .. tag resources_common_actions_nothing

   Define this resource block to do nothing until notified by another resource to take action. When this resource is notified, this resource block is either run immediately or it is queued up to be run at the end of the Chef Client run.

   .. end_tag

Properties
=====================================================
``ca_cert_file``
   **Ruby Types:** Integer

   Required. The path to the CA X509 Certificate on the filesystem.

``ca_key_file``
   **Ruby Types:** Integer

   Required. The path to the CA private key on the filesystem.

``ca_key_pass``
   **Ruby Types:** Integer

   The passphrase for CA private key's passphrase

``expire``
   **Ruby Types:** Integer | **Default Value:** ``8``

   Value representing the number of days from now through which the issued CRL will remain valid. The CRL will expire after this period.

``group``
   **Ruby Types:** String

   The system group of all files created by the resource.

``mode``
   **Ruby Types:** Integer, String | **Default Value:** ``0640``

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

``path``
   **Ruby Type:** String

   The path to write the file to, if it differs from the resource name.

``renewal_threshold``
   **Ruby Types:** Integer | **Default Value:** ``1``

   Number of days before the expiration. It this threshold is reached, the CRL will be renewed

``revocation_reason``
   **Ruby Types:** Integer | **Default Value:** ``0``

   Reason for the revokation.

``serial_to_revoke``
   **Ruby Types:** Integer, String

   Serial of the X509 Certificate to revoke.

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
**Create a certificate revocation file**

.. code-block:: ruby

  openssl_x509_crl '/etc/ssl_test/my_ca.crl' do
    ca_cert_file '/etc/ssl_test/my_ca.crt'
    ca_key_file '/etc/ssl_test/my_ca.key'
  end

**Create a certificate revocation file for a particular serial**

.. code-block:: ruby

  openssl_x509_crl '/etc/ssl_test/my_ca.crl' do
    ca_cert_file '/etc/ssl_test/my_ca.crt'
    ca_key_file '/etc/ssl_test/my_ca.key'
    serial_to_revoke C7BCB6602A2E4251EF4E2827A228CB52BC0CEA2F
  end
