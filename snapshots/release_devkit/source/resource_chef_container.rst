.. THIS PAGE IS IDENTICAL TO docs.chef.io/resource_chef_container.html BY DESIGN
.. THIS PAGE IS LOCATED AT THE /release/devkit/ PATH.

=====================================================
chef_container
=====================================================

.. warning:: .. include:: ../../includes_notes/includes_notes_provisioning.rst

.. include:: ../../includes_chef_client/includes_chef_client.rst

Use the **chef_container** resource to interact with container objects that exist on the Chef server.

Syntax
=====================================================
The syntax for using the **chef_container** resource in a recipe is as follows:

.. code-block:: ruby

   chef_container 'name' do
     attribute 'value' # see properties section below
     ...
     action :action # see actions section below
   end

where 

* ``chef_container`` tells the chef-client to use the ``Chef::Provider::ChefContainer`` provider during the chef-client run
* ``name`` is the name of the resource block
* ``attribute`` is zero (or more) of the properties that are available for this resource
* ``:action`` identifies which steps the chef-client will take to bring the node into the desired state

Actions
=====================================================
This resource has the following actions:

``:create``
   Default.

``:delete``
   

``:nothing``
   .. include:: ../../includes_resources_common/includes_resources_common_actions_nothing.rst

Properties
=====================================================
This resource has the following properties:

``chef_server``
   The URL for the Chef server.

``ignore_failure``
   **Ruby Types:** TrueClass, FalseClass

   Continue running a recipe if a resource fails for any reason. Default value: ``false``.

``name``
   The name of the container.

``notifies``
   **Ruby Type:** Symbol, 'Chef::Resource[String]'

   .. include:: ../../includes_resources_common/includes_resources_common_notification_notifies.rst

   .. include:: ../../includes_resources_common/includes_resources_common_notification_timers.rst

   .. include:: ../../includes_resources_common/includes_resources_common_notification_notifies_syntax.rst

``retries``
   **Ruby Type:** Integer

   The number of times to catch exceptions and retry the resource. Default value: ``0``.

``retry_delay``
   **Ruby Type:** Integer

   The retry delay (in seconds). Default value: ``2``.

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
.. .. include:: ../../includes_resources/includes_resource_chef_container_providers.rst
.. 

Examples
=====================================================
None.
