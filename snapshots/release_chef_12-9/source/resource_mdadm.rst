.. THIS PAGE DOCUMENTS chef-client version 12.9

=====================================================
mdadm
=====================================================

.. include:: ../../includes_resources/includes_resource_mdadm.rst

Syntax
=====================================================
A **mdadm** resource block manages RAID devices in a Linux environment using the mdadm utility:

.. code-block:: ruby

   mdadm '/dev/md0' do
     devices [ '/dev/sda', '/dev/sdb' ]
     level 1
     action [ :create, :assemble ]
   end

The full syntax for all of the properties that are available to the **mdadm** resource is:

.. code-block:: ruby

   mdadm 'name' do
     bitmap                     String
     chunk                      Integer
     devices                    Array
     exists                     TrueClass, FalseClass
     level                      Integer
     metadata                   String
     notifies                   # see description
     provider                   Chef::Provider::Mdadm
     raid_device                String # defaults to 'name' if not specified
     subscribes                 # see description
     action                     Symbol # defaults to :create if not specified
   end

where 

* ``mdadm`` is the resource
* ``name`` is the name of the resource block
* ``:action`` identifies the steps the chef-client will take to bring the node into the desired state
* ``bitmap``, ``chunk``, ``devices``, ``exists``, ``level``, ``metadata``, ``provider``,  and ``raid_device`` are properties of this resource, with the Ruby type shown. See "Properties" section below for more information about all of the properties that may be used with this resource.

Actions
=====================================================
.. include:: ../../includes_resources/includes_resource_mdadm_actions.rst

Properties
=====================================================
This resource has the following properties:
   
``bitmap``
   **Ruby Type:** String

   The path to a file in which a write-intent bitmap is stored.
   
``chunk``
   **Ruby Type:** Integer

   The chunk size. This property should not be used for a RAID 1 mirrored pair (i.e. when the ``level`` property is set to ``1``). Default value: ``16``.
   
``devices``
   **Ruby Type:** Array

   A comma-separated list of devices to be part of a RAID array. Default value: ``[]``.
   
``exists``
   **Ruby Types:** TrueClass, FalseClass

   Indicates whether the RAID array exists. Default value: ``false``.
   
``ignore_failure``
   **Ruby Types:** TrueClass, FalseClass

   Continue running a recipe if a resource fails for any reason. Default value: ``false``.
   
``level``
   **Ruby Type:** Integer

   The RAID level. Default value: ``1``.
   
``metadata``
   **Ruby Type:** String

   The superblock type for RAID metadata. Default value: ``0.90``.
   
``notifies``
   **Ruby Type:** Symbol, 'Chef::Resource[String]'

   .. include:: ../../includes_resources_common/includes_resources_common_notification_notifies.rst

   .. include:: ../../includes_resources_common/includes_resources_common_notification_timers_12-5.rst

   .. include:: ../../includes_resources_common/includes_resources_common_notification_notifies_syntax.rst
   
``provider``
   **Ruby Type:** Chef Class

   Optional. Explicitly specifies a provider.
   
``raid_device``
   **Ruby Type:** String

   The name of the RAID device. Default value: the ``name`` of the resource block See "Syntax" section above for more information.
   
``retries``
   **Ruby Type:** Integer

   The number of times to catch exceptions and retry the resource. Default value: ``0``.
   
``retry_delay``
   **Ruby Type:** Integer

   The retry delay (in seconds). Default value: ``2``.
   
``subscribes``
   **Ruby Type:** Symbol, 'Chef::Resource[String]'

   .. include:: ../../includes_resources_common/includes_resources_common_notification_subscribes.rst

   .. include:: ../../includes_resources_common/includes_resources_common_notification_timers_12-5.rst

   .. include:: ../../includes_resources_common/includes_resources_common_notification_subscribes_syntax.rst

.. 
.. Providers
.. =====================================================
.. .. include:: ../../includes_resources_common/includes_resources_common_provider.rst
.. 
.. .. include:: ../../includes_resources_common/includes_resources_common_provider_attributes.rst
.. 
.. .. include:: ../../includes_resources/includes_resource_mdadm_providers.rst
.. 

Examples
=====================================================
The following examples demonstrate various approaches for using resources in recipes. If you want to see examples of how Chef uses resources in recipes, take a closer look at the cookbooks that Chef authors and maintains: https://github.com/chef-cookbooks.

**Create and assemble a RAID 0 array**

.. include:: ../../step_resource/step_resource_mdadm_raid0.rst

**Create and assemble a RAID 1 array**

.. include:: ../../step_resource/step_resource_mdadm_raid1.rst

**Create and assemble a RAID 5 array**

.. include:: ../../step_resource/step_resource_mdadm_raid5.rst
