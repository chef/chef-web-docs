=====================================================
processes
=====================================================

.. include:: ../../includes_inspec_resources/includes_inspec_resource_process.rst

Syntax
-----------------------------------------------------
.. include:: ../../includes_inspec_resources/includes_inspec_resource_process_syntax.rst

Matchers
-----------------------------------------------------
|inspec resource matcher|

property_name
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_inspec_resources/includes_inspec_resource_process_matcher_property_name.rst

Examples
-----------------------------------------------------
|inspec examples|

**Test if the list length for the mysqld process is 1**

.. include:: ../../step_inspec/step_inspec_process_list_length.rst

**Test if the init process is owned by the root user**

.. include:: ../../step_inspec/step_inspec_process_init_process.rst

**Test if a high-priority process is running**

.. include:: ../../step_inspec/step_inspec_process_high_priority_process.rst
