=====================================================
chef_node
=====================================================
`[edit on GitHub] <https://github.com/chef/chef-web-docs/blob/master/chef_master/source/resource_chef_node.rst>`__

.. meta::
    :robots: noindex

.. warning:: .. tag EOL_provisioning

             This functionality was available with Chef Provisioning and was packaged in the ChefDK.

             Chef Provisioning was officially end-of-life on August 31, 2019 and is no longer included with ChefDK. The Chef Provisioning source code and drivers have been moved into the chef-boneyard organization. If you are a current user of Chef Provisioning, please contact your Chef Customer Success Manager or Account Representative to review your options.

             .. end_tag

.. tag node

A node is any device---physical, virtual, cloud, network device, etc.---that is under management by Chef Infra.

.. end_tag

Use the **chef_node** resource to manage nodes.

Syntax
=====================================================
The syntax for using the **chef_node** resource in a recipe is as follows:

.. code-block:: ruby

   chef_node 'name' do
     attribute 'value' # see properties section below
     ...
     action :action # see actions section below
   end

where

* ``chef_node`` tells Chef Infra Client to use the ``Chef::Provider::ChefNode`` provider during a Chef Infra Client run
* ``name`` is the name of the resource block
* ``attribute`` is zero (or more) of the properties that are available for this resource
* ``action`` identifies which steps Chef Infra Client will take to bring the node into the desired state

Actions
=====================================================
This resource has the following actions:

``:create``
   Default. Use to create a node.

``:delete``
   Use to delete a node.

``:nothing``
   .. tag resources_common_actions_nothing

   This resource block does not act unless notified by another resource to take action. Once notified, this resource block either runs immediately or is queued up to run at the end of a Chef Infra Client run.

   .. end_tag

Properties
=====================================================
This resource has the following properties:

``automatic_attributes``
   .. tag node_attribute_type_automatic

   An ``automatic`` attribute contains data that is identified by Ohai at the beginning of every Chef Infra Client run. An ``automatic`` attribute cannot be modified and always has the highest attribute precedence.

   .. end_tag

   Default value: ``{}``.

``chef_environment``
   The Chef server environment in which this node should exist (or does exist).

``chef_server``
   The URL for the Chef server.

``complete``
   Use to specify if this resource defines a node completely. When ``true``, any property not specified by this resource will be reset to default property values.

``default_attributes``
   .. tag node_attribute_type_default

   A ``default`` attribute is automatically reset at the start of every Chef Infra Client run and has the lowest attribute precedence. Use ``default`` attributes as often as possible in cookbooks.

   .. end_tag

   Default value: ``{}``.

``ignore_failure``
   **Ruby Type:** true, false | **Default Value:** ``false``

   Continue running a recipe if a resource fails for any reason.

``name``
   The name of the node.

``normal_attributes``
   .. tag node_attribute_type_normal

   A ``normal`` attribute is a setting that persists in the node object. A ``normal`` attribute has a higher attribute precedence than a ``default`` attribute.

   .. end_tag

   Default value: ``{}``.

``notifies``
   **Ruby Type:** Symbol, 'Chef::Resource[String]'

   .. tag resources_common_notification_notifies

   A resource may notify another resource to take action when its state changes. Specify a ``'resource[name]'``, the ``:action`` that resource should take, and then the ``:timer`` for that action. A resource may notify more than one resource; use a ``notifies`` statement for each resource to be notified.

   .. end_tag

   .. tag resources_common_notification_timers

   A timer specifies the point during a Chef Infra Client run at which a notification is run. The following timers are available:

   ``:before``
      Specifies that the action on a notified resource should be run before processing the resource block in which the notification is located.

   ``:delayed``
      Default. Specifies that a notification should be queued up, and then executed at the end of a Chef Infra Client run.

   ``:immediate``, ``:immediately``
      Specifies that a notification should be run immediately, per resource notified.

   .. end_tag

   .. tag resources_common_notification_notifies_syntax

   The syntax for ``notifies`` is:

   .. code-block:: ruby

     notifies :action, 'resource[name]', :timer

   .. end_tag

``override_attributes``
   .. tag node_attribute_type_override

   An ``override`` attribute is automatically reset at the start of every Chef Infra Client run and has a higher attribute precedence than ``default``, ``force_default``, and ``normal`` attributes. An ``override`` attribute is most often specified in a recipe, but can be specified in an attribute file, for a role, and/or for an environment. A cookbook should be authored so that it uses ``override`` attributes only when required.

   .. end_tag

   Default value: ``{}``.

``raw_json``
   The node as JSON data. For example:

   .. code-block:: javascript

      {
        "overrides": {},
        "name": "latte",
        "chef_type": "node",
        "json_class": "Chef::Node",
        "attributes": {
          "hardware_type": "laptop"
        },
        "run_list": [
          "recipe[apache2]"
        ],
        "defaults": {}
      }

``retries``
   **Ruby Type:** Integer | **Default Value:** ``0``

   The number of attempts to catch exceptions and retry the resource.

``retry_delay``
   **Ruby Type:** Integer | **Default Value:** ``2``

   The retry delay (in seconds).

``run_list``
   A comma-separated list of roles and/or recipes to be applied. Default value: ``[]``. For example: ``["recipe[default]","recipe[apache2]"]``

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

   A timer specifies the point during a Chef Infra Client run at which a notification is run. The following timers are available:

   ``:before``
      Specifies that the action on a notified resource should be run before processing the resource block in which the notification is located.

   ``:delayed``
      Default. Specifies that a notification should be queued up, and then executed at the end of a Chef Infra Client run.

   ``:immediate``, ``:immediately``
      Specifies that a notification should be run immediately, per resource notified.

   .. end_tag

   .. tag resources_common_notification_subscribes_syntax

   The syntax for ``subscribes`` is:

   .. code-block:: ruby

      subscribes :action, 'resource[name]', :timer

   .. end_tag
