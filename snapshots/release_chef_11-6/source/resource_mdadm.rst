.. THIS PAGE DOCUMENTS chef-client version 11.6

=====================================================
mdadm
=====================================================

.. include:: ../../includes_resources/includes_resource_mdadm.rst

Syntax
=====================================================
.. include:: ../../includes_resources/includes_resource_mdadm_syntax_12-8.rst

Actions
=====================================================
.. include:: ../../includes_resources/includes_resource_mdadm_actions.rst

Properties
=====================================================
.. include:: ../../includes_resources/includes_resource_mdadm_attributes_12-5.rst

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
