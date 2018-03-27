=====================================================
openssl_dhparam
=====================================================
`[edit on GitHub] <https://github.com/chef/chef-web-docs/blob/master/chef_master/source/resource_openssl_dhparam.rst>`__

Use the **openssl_dhparam** resource to generate ``dhparam.pem`` files. If a valid ``dhparam.pem`` file is found at the specified location, no new file will be created. If a file is found at the specified location, but it is not a valid dhparam file, it will be overwritten.

Syntax
=====================================================
This resource has the following syntax:

.. code-block:: ruby

   openssl_dhparam 'name' do
     generator                  Integer # default value: '2'
     group                      String, nil
     key_length                 Integer # default value: '2048'
     mode                       Integer, String # default value: '0640'
     notifies                   # see description
     owner                      String, nil
     path                       String # default value: 'name'
     subscribes                 # see description
     action                     Symbol # defaults to :create if not specified

where:

* ``openssl_dhparam`` is the name of the resource
* ``'name'`` is the path where the dhparam file will be written, or the name of the resource block
* ``generator``, ``group``, ``key_length``, ``mode``, ``notifies``, ``owner``, and ``path``, and ``subscribes`` are the properties available to this resource

Actions
=====================================================
``:create``
   Default. Create the ``dhparam.pem`` file.

``:nothing``
   .. tag resources_common_actions_nothing

   Define this resource block to do nothing until notified by another resource to take action. When this resource is notified, this resource block is either run immediately or it is queued up to be run at the end of the Chef Client run.

   .. end_tag

Properties
=====================================================
``generator``
   **Ruby Type:** Integer | **Default Value:** ``2``

   The desired Diffie-Hellmann generator; available options are ``2`` and ``5``. 

``group``
   **Ruby Types:** String, nil

   The system group of all files created by the resource. 

``key_length``
   **Ruby Type:** Integer | **Default Value:** ``2048``

   The desired bit length of the generated key; available options are ``1024``, ``2048``, ``4096``, and ``8192``.

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
      Default. Specifies that a notification should be queued up, and then executed at the very end of the Chef Client run.

   ``:immediate``, ``:immediately``
      Specifies that a notification should be run immediately, per resource notified.

   .. end_tag

   .. tag resources_common_notification_notifies_syntax

   The syntax for ``notifies`` is:

   .. code-block:: ruby

      notifies :action, 'resource[name]', :timer

   .. end_tag 

``owner``
   **Ruby Types:** String, nil

   The owner of all files created by the resource. 

``path``
   **Ruby Type:** String

   The path to write the file to, if it differs from the resource name.

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
      Default. Specifies that a notification should be queued up, and then executed at the very end of the Chef Client run.

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
**Create a dhparam file**

.. code-block:: ruby

   openssl_dhparam '/etc/httpd/ssl/dhparam.pem'

**Create a dhparam file with a specific key length**

.. code-block:: ruby

   openssl_dhparam '/etc/httpd/ssl/dhparam.pem' do
     key_length 4096
   end

**Create a dhparam file with specific user/group ownership**

.. code-block:: ruby 
   
   openssl_dhparam '/etc/httpd/ssl/dhparam.pem' do
     owner 'www-data'
     group 'www-data'
   end

**Manually specify the dhparam file path**

.. code-block:: ruby

   openssl_dhparam 'httpd_dhparam' do
     path '/etc/httpd/ssl/dhparam.pem'
   end