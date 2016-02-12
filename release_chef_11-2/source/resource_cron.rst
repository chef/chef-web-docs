.. THIS PAGE DOCUMENTS chef-client version 11.2

=====================================================
cron
=====================================================

.. include:: ../../includes_resources/includes_resource_cron.rst

Syntax
=====================================================
.. include:: ../../includes_resources/includes_resource_11-10_cron_syntax.rst

Actions
=====================================================
.. include:: ../../includes_resources/includes_resource_cron_actions.rst

Properties
=====================================================
.. include:: ../../includes_resources/includes_resource_11-10_cron_attributes.rst

Providers
=====================================================
.. include:: ../../includes_resources_common/includes_resources_common_provider.rst

.. include:: ../../includes_resources_common/includes_resources_common_provider_attributes.rst

.. include:: ../../includes_resources/includes_resource_cron_providers.rst

Examples
=====================================================
|generic resource statement|

**Run a program at a specified interval**

.. include:: ../../step_resource/step_resource_cron_run_program_on_fifth_hour.rst

**Run an entry if a folder exists**

.. include:: ../../step_resource/step_resource_cron_run_entry_when_folder_exists.rst

**Run every Saturday, 8:00 AM**

.. include:: ../../step_resource/step_resource_cron_run_every_saturday.rst

**Run only in November**

.. include:: ../../step_resource/step_resource_cron_run_only_in_november.rst
