.. THIS PAGE DOCUMENTS chef-client version 12.11

=====================================================
apt_update
=====================================================

.. include:: ../../includes_resources/includes_resource_apt_update.rst

Syntax
=====================================================
.. include:: ../../includes_resources/includes_resource_apt_update_syntax.rst

Actions
=====================================================
.. include:: ../../includes_resources/includes_resource_apt_update_actions.rst

Properties
=====================================================
.. include:: ../../includes_resources/includes_resource_apt_update_attributes.rst

.. 
.. Providers
.. =====================================================
.. .. include:: ../../includes_resources_common/includes_resources_common_provider.rst
.. 
.. .. include:: ../../includes_resources_common/includes_resources_common_provider_attributes.rst
.. 
.. .. include:: ../../includes_resources/includes_resource_apt_update_providers.rst
.. 

Examples
=====================================================
.. include:: ../../includes_resources_common/includes_resources_common_examples_intro.rst

**Update the Apt repository at a specified interval** 

.. include:: ../../step_resource/step_resource_apt_update_periodic.rst

**Update the Apt repository at the start of a chef-client run** 

.. include:: ../../step_resource/step_resource_apt_update_at_start_of_client_run.rst