=====================================================
openssl_rsa_public_key resource
=====================================================
`[edit on GitHub] <https://github.com/chef/chef-web-docs/blob/master/chef_master/source/resource_openssl_rsa_public_key.rst>`__

Use the **openssl_rsa_public_key** resource to generate RSA public key files for a given RSA private key.

**New in Chef Client 14.0.**

Syntax
=====================================================
The openssl_rsa_public_key resource has the following syntax:

.. code-block:: ruby

  openssl_rsa_public_key 'name' do
    group                    String
    mode                     Integer, String # default value: 0640
    owner                    String
    path                     String # default value: 'name' unless specified
    private_key_content      String
    private_key_pass         String
    private_key_path         String
    action                   Symbol # defaults to :create if not specified
  end

where:

* ``openssl_rsa_public_key`` is the resource.
* ``name`` is the name given to the resource block.
* ``action`` identifies which steps the chef-client will take to bring the node into the desired state.
* ``group``, ``mode``, ``owner``, ``path``, ``private_key_content``, ``private_key_pass``, and ``private_key_path`` are the properties available to this resource.

Actions
=====================================================

The openssl_rsa_public_key resource has the following actions:

``:create``
   Default. Create the RSA public key.

``:nothing``
   .. tag resources_common_actions_nothing

   Define this resource block to do nothing until notified by another resource to take action. When this resource is notified, this resource block is either run immediately or it is queued up to be run at the end of the Chef Client run.

   .. end_tag

Properties
=====================================================

The openssl_rsa_public_key resource has the following properties:

``group``
   **Ruby Type:** String

   The group ownership applied to all files created by the resource.

``mode``
   **Ruby Type:** Integer, String | **Default Value:** ``0640``

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
   **Ruby Type:** String

   The owner applied to all files created by the resource.

``path``
   **Ruby Type:** String

   The path to the public key file, if it differs from the resource name.

``private_key_content``
   **Ruby Type:** String

   The content of the private key, including new lines. This property is used in place of ``private_key_path`` in instances where you want to avoid having to first write the private key to disk.

``private_key_pass``
   **Ruby Type:** String

   The passphrase of the provided private key.

``private_key_path``
   **Ruby Type:** String

   The path to the private key file.

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
**Create a public key from a private key file**

.. code-block:: ruby

   openssl_rsa_public_key '/etc/example/key.pub' do
     private_key_path '/etc/example/key.pem'
   end

**Create a public key from a private key, without writing the private key to disk**

You can provide the private key content as a string to the openssl_rsa_public_key resource. In this example we just pass a string, but this content could be loaded from an encrypted data bag or other secure storage.

.. code-block:: ruby

   openssl_rsa_public_key '/etc/example/key.pub' do
     private_key_content 'KEY_CONTENT_HERE_AS_A_STRING'
   end
