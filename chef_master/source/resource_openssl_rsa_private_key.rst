=====================================================
openssl_rsa_private_key resource
=====================================================
`[edit on GitHub] <https://github.com/chef/chef-web-docs/blob/master/chef_master/source/resource_openssl_rsa_private_key.rst>`__

Use the **openssl_rsa_private_key** resource to generate RSA private key files. If a valid RSA key file can be opened at the specified location, no new file will be created. If the RSA key file cannot be opened or does not exist, it will be overwritten.

.. note:: If the password to your RSA key file does not match the password in the recipe, it cannot be opened, and will be overwritten.

**New in Chef Client 14.0.**

Syntax
=====================================================
The openssl_rsa_private_key resource has the following syntax:

.. code-block:: ruby

  openssl_rsa_private_key 'name' do
    force           true, false # default value: false
    group           String
    key_cipher      String # default value: des3
    key_length      Integer # default value: 2048
    key_pass        String
    mode            Integer, String # default value: 0600
    owner           String
    path            String # default value: 'name' unless specified
    action          Symbol # defaults to :create if not specified
  end

where:

* ``openssl_rsa_private_key`` is the resource.
* ``name`` is the name given to the resource block.
* ``action`` identifies which steps the chef-client will take to bring the node into the desired state.
* ``force``, ``group``, ``key_cipher``, ``key_length``, ``key_pass``, ``mode``, ``owner``, and ``path`` are the properties available to this resource.

Actions
=====================================================
``:create``
   Default. Create the RSA private key file.

``:nothing``
   .. tag resources_common_actions_nothing

   Define this resource block to do nothing until notified by another resource to take action. When this resource is notified, this resource block is either run immediately or it is queued up to be run at the end of the Chef Client run.

   .. end_tag

Properties
=====================================================
``force``
   **Ruby Type:** True, False | **Default Value:** ``false``

   Force creation of the key even if the same key already exists on the node.

``group``
   **Ruby Type:** String

   The group ownership applied to all files created by the resource.

``key_cipher``
   **Ruby Type:** String | **Default Value:** ``des3``

   The designed cipher to use when generating your key. Run ``openssl list-cipher-algorithms`` to see available options.

``key_length``
   **Ruby Type:** Integer | **Default Value:** ``2048``

   The desired bit length of the generated key; available options are ``1024``, ``2048``, ``4096``, and ``8192``.

``key_pass``
   **Ruby Type:** String

   The desired passphrase for the key.

``mode``
   **Ruby Type:** Integer, String | **Default Value:** ``0600``

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

   The path where the private key file will be created, if it differs from the resource name.

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
