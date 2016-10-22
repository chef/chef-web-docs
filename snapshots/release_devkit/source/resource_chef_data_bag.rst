.. THIS PAGE IS IDENTICAL TO docs.chef.io/resource_chef_data_bag.html BY DESIGN
.. THIS PAGE IS LOCATED AT THE /release/devkit/ PATH.

=====================================================
chef_data_bag
=====================================================

.. warning:: .. include:: ../../includes_notes/includes_notes_provisioning.rst

.. include:: ../../includes_data_bag/includes_data_bag.rst

Use the **chef_data_bag** resource to manage data bags.

Syntax
=====================================================
The syntax for using the **chef_data_bag** resource in a recipe is as follows:

.. code-block:: ruby

   chef_data_bag 'name' do
     attribute 'value' # see properties section below
     ...
     action :action # see actions section below
   end

where 

* ``chef_data_bag`` tells the chef-client to use the ``Chef::Provider::ChefDataBag`` provider during the chef-client run
* ``name`` is the name of the resource block and also the name of the data bag
* ``attribute`` is zero (or more) of the properties that are available for this resource
* ``:action`` identifies which steps the chef-client will take to bring the node into the desired state

Actions
=====================================================
This resource has the following actions:

``:create``
   Default. Use to create a data bag.

``:delete``
   Use to delete a data bag.

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
   The name of the data bag.

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
.. .. include:: ../../includes_resources/includes_resource_chef_databag_providers.rst
.. 

Examples
=====================================================
None.
