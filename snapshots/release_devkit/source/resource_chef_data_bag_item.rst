.. THIS PAGE IS IDENTICAL TO docs.chef.io/resource_chef_data_bag_item.html BY DESIGN
.. THIS PAGE IS LOCATED AT THE /release/devkit/ PATH.

=====================================================
chef_data_bag_item
=====================================================

.. warning:: .. include:: ../../includes_notes/includes_notes_provisioning.rst

.. include:: ../../includes_data_bag/includes_data_bag_item.rst

Use the **chef_data_bag_item** resource to manage data bag items.

Syntax
=====================================================
The syntax for using the **chef_data_bag_item** resource in a recipe is as follows:

.. code-block:: ruby

   chef_data_bag_item 'name' do
     attribute 'value' # see properties section below
     ...
     action :action # see actions section below
   end

where 

* ``chef_data_bag_item`` tells the chef-client to use the ``Chef::Provider::ChefDataBagItem`` provider during the chef-client run
* ``name`` is the name of the resource block and also the name of the data bag item
* ``attribute`` is zero (or more) of the properties that are available for this resource
* ``:action`` identifies which steps the chef-client will take to bring the node into the desired state

Actions
=====================================================
This resource has the following actions:

``:create``
   Default. Use to create a data bag item.

``:delete``
   Use to delete a data bag item.

``:nothing``
   .. include:: ../../includes_resources_common/includes_resources_common_actions_nothing.rst

Properties
=====================================================
This resource has the following properties:

``chef_server``
   The URL for the Chef server.

``complete``
   Use to specify if this resource defines a data bag item completely. When ``true``, any property not specified by this resource will be reset to default property values.

``encrypt``
   Use to specify whether encryption is used for a data bag item.

``encryption_version``
   The minimum required version of data bag encryption. Possible values: ``0``, ``1``, and ``2``. When all of the machines in an organization are running chef-client version 11.6 (or higher), it is recommended that this value be set to ``2``.

``ignore_failure``
   **Ruby Types:** TrueClass, FalseClass

   Continue running a recipe if a resource fails for any reason. Default value: ``false``.

``notifies``
   **Ruby Type:** Symbol, 'Chef::Resource[String]'

   .. include:: ../../includes_resources_common/includes_resources_common_notification_notifies.rst

   .. include:: ../../includes_resources_common/includes_resources_common_notification_timers.rst

   .. include:: ../../includes_resources_common/includes_resources_common_notification_notifies_syntax.rst

``raw_data``
   Use to create a data bag from a local file from ``./data_bags/bag_name/file``.

``raw_json``
   The data bag item as JSON data. For example:
       
   .. code-block:: javascript
       
      {
        "id": "adam",
        "real_name": "Adam Brent Jacob"
      }

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
.. .. include:: ../../includes_resources/includes_resource_chef_databagitem_providers.rst
.. 

Examples
=====================================================
None.
