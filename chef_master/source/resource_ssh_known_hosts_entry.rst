=====================================================
ssh_known_hosts_entry
=====================================================
`[edit on GitHub] <https://github.com/chef/chef-web-docs/blob/master/chef_master/source/resource_ssh_known_hosts_entry.rst>`__

Use the **ssh_known_hosts_entry** resource to add an entry for the specified host in /etc/ssh/ssh_known_hosts or a user's known hosts file if specified.

**New in Chef Client 14.3.**

Syntax
=====================================================
This resource has the following syntax:

.. code-block:: ruby

   ssh_known_hosts_entry 'name' do
     file_location             String # defaults to /etc/ssh/ssh_known_hosts
     group                     String # defaults to the root_group on the system
     hash_entries              true, false # defaults to false
     host                      String
     key                       String
     key_type                  String # defaults to rsa
     mode                      String # defaults to 0644
     notifies                  # see description
     owner                     String # defaults to root
     port                      Integer # defaults to 22
     subscribes                # see description
     timeout                   Integer # defaults to 30
     action                    Symbol # defaults to :create if not specified
   end

where:

* ``ssh_known_hosts_entry`` is the name of the resource
* ``file_location``, ``group``, ``hash_entries``, ``host``, ``key``, ``key_type``, ``mode``, ``owner``, and ``port`` are the properties available to this resource

Actions
=====================================================

``:create``
   Default. Create an entry in the ssh_known_hosts file.

``:flush``
   Immediately flush the entries to the config file. Without this the actual writing of the file is delayed in the Chef run so all entries can be accumulated before writing the file out.

``:nothing``
   .. tag resources_common_actions_nothing

   Define this resource block to do nothing until notified by another resource to take action. When this resource is notified, this resource block is either run immediately or it is queued up to be run at the end of the Chef Client run.

   .. end_tag
Properties
=====================================================

``file_location``
   **Ruby Type:** String | **Default Value:** ``/etc/ssh/ssh_known_hosts``

   The location of the ssh known hosts file. Change this to set a known host file for a particular user.

``group``
   **Ruby Type:** String

   The file group for the ssh_known_hosts file.

``hash_entries``
   **Ruby Type:** true, false | **Default Value:** ``false``

   Hash the hostname and addresses in the ssh_known_hosts file for privacy.

``host``
   **Ruby Type:** String

   The host to add to the known hosts file.

``key``
   **Ruby Type:** String

   An optional key for the host. If not provided this will be automatically determined.

``key_type``
   **Ruby Type:** String | **Default Value:** ``rsa``

   The type of key to store.

``mode``
   **Ruby Type:** String | **Default Value:** ``0644``

   The file mode for the ssh_known_hosts file.

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
   **Ruby Type:** String | **Default Value:** ``root``

   The file owner for the ssh_known_hosts file.

``port``
   **Ruby Type:** Integer | **Default Value:** ``22``

   The server port that the ssh-keyscan command will use to gather the public key.


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

``timeout``
   **Ruby Type:** Integer | **Default Value:** ``30``

   The timeout in seconds for ssh-keyscan.
