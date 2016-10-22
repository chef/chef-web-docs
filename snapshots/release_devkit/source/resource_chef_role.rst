.. THIS PAGE IS IDENTICAL TO docs.chef.io/resource_chef_role.html BY DESIGN
.. THIS PAGE IS LOCATED AT THE /release/devkit/ PATH.

=====================================================
chef_role
=====================================================

.. warning:: .. include:: ../../includes_notes/includes_notes_provisioning.rst

.. include:: ../../includes_role/includes_role.rst

Use the **chef_role** resource to manage roles.

Syntax
=====================================================
The syntax for using the **chef_role** resource in a recipe is as follows:

.. code-block:: ruby

   chef_role 'name' do
     attribute 'value' # see properties section below
     ...
     action :action # see actions section below
   end

where 

* ``chef_role`` tells the chef-client to use the ``Chef::Provider::ChefRole`` provider during the chef-client run
* ``name`` is the name of the resource block; when the ``name`` property is not specified as part of a recipe, ``name`` is also the name of the role
* ``attribute`` is zero (or more) of the properties that are available for this resource
* ``:action`` identifies which steps the chef-client will take to bring the node into the desired state

Actions
=====================================================
This resource has the following actions:

``:create``
   Default. Use to create a role.

``:delete``
   Use to delete a role.

``:nothing``
   .. include:: ../../includes_resources_common/includes_resources_common_actions_nothing.rst

Properties
=====================================================
This resource has the following properties:

``chef_server``
   The URL for the Chef server.

``complete``
   Use to specify if this resource defines a role completely. When ``true``, any property not specified by this resource will be reset to default property values.

``default_attributes``
   .. include:: ../../includes_node/includes_node_attribute_type_default.rst

   Default value: ``{}``.

``description``
   The description of the role. This value populates the description field for the role on the Chef server.

``env_run_lists``
   The environment-specific run-list for a role. Default value: ``[]``. For example: ``["env_run_lists[webserver]"]``

``ignore_failure``
   **Ruby Types:** TrueClass, FalseClass

   Continue running a recipe if a resource fails for any reason. Default value: ``false``.

``name``
   The name of the role.

``notifies``
   **Ruby Type:** Symbol, 'Chef::Resource[String]'

   .. include:: ../../includes_resources_common/includes_resources_common_notification_notifies.rst

   .. include:: ../../includes_resources_common/includes_resources_common_notification_timers.rst

   .. include:: ../../includes_resources_common/includes_resources_common_notification_notifies_syntax.rst

``override_attributes``
   .. include:: ../../includes_node/includes_node_attribute_type_override.rst

   Default value: ``{}``.

``raw_json``
   The role as JSON data. For example:
       
   .. code-block:: javascript
       
     {
       "name": "webserver",
       "chef_type": "role",
       "json_class": "Chef::Role",
       "default_attributes": {},
       "description": "A webserver",
       "run_list": [
         "recipe[apache2]"
       ],
       "override_attributes": {}
     }

``retries``
   **Ruby Type:** Integer

   The number of times to catch exceptions and retry the resource. Default value: ``0``.

``retry_delay``
   **Ruby Type:** Integer

   The retry delay (in seconds). Default value: ``2``.

``run_list``
   A comma-separated list of roles and/or recipes to be applied. Default value: ``[]``. For example: ``["recipe[default]","recipe[apache2]"]``

``subscribes``
   **Ruby Type:** Symbol, 'Chef::Resource[String]'

   .. include:: ../../includes_resources_common/includes_resources_common_notification_subscribes.rst

   .. include:: ../../includes_resources_common/includes_resources_common_notification_timers.rst

   .. include:: ../../includes_resources_common/includes_resources_common_notification_subscribes_syntax.rst

.. 
.. Providers
.. =====================================================
.. .. include:: ../../includes_resources_common/includes_resources_common_provider.rst
.. 
.. .. include:: ../../includes_resources_common/includes_resources_common_provider_attributes.rst
.. 
.. .. include:: ../../includes_resources/includes_resource_chef_role_providers.rst
.. 

Examples
=====================================================
None.
