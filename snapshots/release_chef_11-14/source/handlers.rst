.. THIS PAGE DOCUMENTS chef-client version 11.14

=====================================================
About Handlers
=====================================================

.. include:: ../../includes_handler/includes_handler.rst

.. include:: ../../includes_handler/includes_handler_types.rst

Exception/Report Handlers
=====================================================
.. include:: ../../includes_handler/includes_handler_type_exception_report.rst

Run from Recipes
-----------------------------------------------------
.. include:: ../../includes_handler/includes_handler_type_exception_report_run_from_recipe.rst

Run from client.rb
-----------------------------------------------------
.. include:: ../../includes_handler/includes_handler_type_exception_report_run_from_client_rb.rst

Start Handlers
=====================================================
.. include:: ../../includes_handler/includes_handler_type_start.rst

Run from Recipes
-----------------------------------------------------
.. include:: ../../includes_handler/includes_handler_type_start_run_from_recipe.rst

Run from client.rb
-----------------------------------------------------
.. include:: ../../includes_handler/includes_handler_type_start_run_from_client_rb.rst


Handlers and Cookbooks
=====================================================
The following cookbooks can be used to load handlers during the chef-client run.

chef_handler
-----------------------------------------------------
.. include:: ../../includes_handler/includes_handler_cookbook_chef_handler.rst

chef-client
-----------------------------------------------------
.. include:: ../../includes_handler/includes_handler_cookbook_chef_client.rst


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
The following sections show examples of handlers.

Cookbook Versions
-----------------------------------------------------
.. include:: ../../includes_handler/includes_handler_custom_example_cookbook_versions.rst

cookbook_versions.rb
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_handler/includes_handler_custom_example_cookbook_versions_handler.rst

default.rb
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_handler/includes_handler_custom_example_cookbook_versions_recipe.rst

Reporting
-----------------------------------------------------
.. include:: ../../includes_handler/includes_handler_custom_example_reporting.rst

.. note:: .. include:: ../../includes_notes/includes_notes_start_handler_for_reporting.rst

start_handler.rb
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_handler/includes_handler_custom_example_reporting_handler.rst

json_file Handler
-----------------------------------------------------
.. include:: ../../includes_handler/includes_handler_custom_example_json_file.rst

error_report Handler
-----------------------------------------------------
.. include:: ../../includes_handler/includes_handler_custom_example_error_report.rst

Community Handlers
-----------------------------------------------------
.. include:: ../../includes_handler/includes_handler_community_handlers.rst






