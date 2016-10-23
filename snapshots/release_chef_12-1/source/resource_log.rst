.. THIS PAGE DOCUMENTS chef-client version 12.1

=====================================================
log
=====================================================

.. include:: ../../includes_resources/includes_resource_log.rst

Syntax
=====================================================
.. include:: ../../includes_resources/includes_resource_log_syntax.rst

Actions
=====================================================
.. include:: ../../includes_resources/includes_resource_log_actions.rst

Properties
=====================================================
.. include:: ../../includes_resources/includes_resource_log_attributes_12-5.rst

.. 
.. Providers
.. =====================================================
.. .. include:: ../../includes_resources_common/includes_resources_common_provider.rst
.. 
.. .. include:: ../../includes_resources_common/includes_resources_common_provider_attributes.rst
.. 
.. .. include:: ../../includes_resources/includes_resource_log_providers.rst
.. 

Chef::Log Entries
=====================================================
.. include:: ../../includes_ruby/includes_ruby_style_basics_chef_log.rst

.. include:: ../../step_ruby/step_ruby_class_chef_log_fatal.rst

.. include:: ../../step_ruby/step_ruby_class_chef_log_multiple.rst

Examples
=====================================================
The following examples demonstrate various approaches for using resources in recipes. If you want to see examples of how Chef uses resources in recipes, take a closer look at the cookbooks that Chef authors and maintains: https://github.com/chef-cookbooks.

**Set default logging level**

.. include:: ../../step_resource/step_resource_log_set_info.rst

**Set debug logging level**

.. include:: ../../step_resource/step_resource_log_set_debug.rst

**Add a message to a log file**

.. include:: ../../step_resource/step_resource_log_add_message.rst
