.. THIS PAGE DOCUMENTS chef-client version 11.18

=====================================================
chef_handler
=====================================================

.. include:: ../../includes_resources/includes_resource_chef_handler.rst

Handler Types
=====================================================
.. include:: ../../includes_handler/includes_handler_types.rst

Exception / Report
-----------------------------------------------------
.. include:: ../../includes_handler/includes_handler_type_exception_report.rst

.. include:: ../../includes_handler/includes_handler_type_exception_report_run_from_recipe.rst

Start
-----------------------------------------------------
.. include:: ../../includes_handler/includes_handler_type_start.rst

.. include:: ../../includes_handler/includes_handler_type_start_run_from_recipe.rst

Syntax
=====================================================
.. include:: ../../includes_resources/includes_resource_chef_handler_syntax.rst

Actions
=====================================================
.. include:: ../../includes_resources/includes_resource_chef_handler_actions.rst

Properties
=====================================================
.. include:: ../../includes_resources/includes_resource_chef_handler_attributes_12-5.rst

Custom Handlers
=====================================================
.. include:: ../../includes_handler/includes_handler_custom.rst

Syntax
-----------------------------------------------------
.. include:: ../../includes_handler/includes_handler_custom_syntax.rst

report Interface
-----------------------------------------------------
.. include:: ../../includes_handler/includes_handler_custom_interface_report.rst

Optional Interfaces
-----------------------------------------------------
The following interfaces may be used in a handler in the same way as the ``report`` interface to override the default handler behavior in the chef-client. That said, the following interfaces are not typically used in a handler and, for the most part, are completely unnecessary for a handler to work properly and/or as desired.

data
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_handler/includes_handler_custom_interface_data.rst

run_report_safely
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_handler/includes_handler_custom_interface_run_report_safely.rst

run_report_unsafe
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_handler/includes_handler_custom_interface_run_report_unsafe.rst

run_status Object
-----------------------------------------------------
.. include:: ../../includes_handler/includes_handler_custom_object_run_status.rst

Examples
=====================================================
The following examples demonstrate various approaches for using resources in recipes. If you want to see examples of how Chef uses resources in recipes, take a closer look at the cookbooks that Chef authors and maintains: https://github.com/chef-cookbooks.

**Enable the CloudkickHandler handler**

.. include:: ../../step_lwrp/step_lwrp_chef_handler_enable_cloudkickhandler.rst

**Enable handlers during the compile phase**

.. include:: ../../step_lwrp/step_lwrp_chef_handler_enable_during_compile.rst

**Handle only exceptions**

.. include:: ../../step_lwrp/step_lwrp_chef_handler_exceptions_only.rst

**Cookbook Versions (a custom handler)**

.. include:: ../../includes_handler/includes_handler_custom_example_cookbook_versions.rst

cookbook_versions.rb:

.. include:: ../../includes_handler/includes_handler_custom_example_cookbook_versions_handler.rst

default.rb:

.. include:: ../../includes_handler/includes_handler_custom_example_cookbook_versions_recipe.rst

**JsonFile Handler**

.. include:: ../../includes_handler/includes_handler_custom_example_json_file.rst

**Register the JsonFile handler**

.. include:: ../../step_lwrp/step_lwrp_chef_handler_register.rst

**ErrorReport Handler**

.. include:: ../../includes_handler/includes_handler_custom_example_error_report.rst
