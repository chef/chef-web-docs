=====================================================
homebrew_cask resource
=====================================================
`[edit on GitHub] <https://github.com/chef/chef-web-docs/blob/master/chef_master/source/resource_homebrew_cask.rst>`__

Use the **homebrew_cask** resource to install binaries distributed via the Homebrew package manager.

**New in Chef Client 14.0.**

Syntax
=====================================================
The homebrew_cask resource has the following syntax:

.. code-block:: ruby

  homebrew_cask 'name' do
    cask_name          String # default value: 'name' unless specified
    homebrew_path      String # default value: /usr/local/bin/brew
    install_cask       true, false # default value: true
    options            String
    owner              String
    action             Symbol # defaults to :install if not specified
  end

where:

* ``homebrew_cask`` is the resource.
* ``name`` is the name given to the resource block.
* ``action`` identifies which steps the chef-client will take to bring the node into the desired state.
* ``cask_name``, ``homebrew_path``, ``install_cask``, ``options``, and ``owner`` are the properties available to this resource.

Actions
=====================================================

The homebrew_cask resource has the following actions:

``:install``
   Default. Install an application that is packaged as a Homebrew cask.
   
``:remove``
   Remove an application that is packaged as a Homebrew cask.
   
``:nothing``
   .. tag resources_common_actions_nothing

   Define this resource block to do nothing until notified by another resource to take action. When this resource is notified, this resource block is either run immediately or it is queued up to be run at the end of the Chef Client run.

   .. end_tag
   
Properties
=====================================================
``cask_name``
   **Ruby Type:** String | **Default Value:** ``'name'``
   
   The name of the Homebrew cask, if it differs from the resource block name.

``homebrew_path``
   **Ruby Type:** String | **Default Value:** ``/usr/local/bin/brew``
   
   The path to the Homebrew binary.

``install_cask``
   **Ruby Type:** true, false | **Default Value:** ``true``

   Automatically install the Homebrew cask tap, if necessary.

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
   
``options``
   **Ruby Type:** String
   
   Options to pass to the ``brew`` command during installation.

``owner``
   **Ruby Type:** String
   
   The owner of the Homebrew installation.
   
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
