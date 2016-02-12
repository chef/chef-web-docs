=====================================================
service
=====================================================

.. include:: ../../includes_inspec_resources/includes_inspec_resource_service.rst

Syntax
-----------------------------------------------------
.. include:: ../../includes_inspec_resources/includes_inspec_resource_service_syntax.rst

Matchers
-----------------------------------------------------
|inspec resource matcher|

be_enabled
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_inspec_resources/includes_inspec_resource_service_matcher_be_enabled.rst

be_installed
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_inspec_resources/includes_inspec_resource_service_matcher_be_installed.rst

be_running
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_inspec_resources/includes_inspec_resource_service_matcher_be_running.rst

Examples
-----------------------------------------------------
|inspec examples|

**Test if the postgresql service is both running and enabled**

.. include:: ../../step_inspec/step_inspec_service_postgresql.rst

**Test if the mysql service is both running and enabled**

.. include:: ../../step_inspec/step_inspec_service_mysql.rst

**Test if ClamAV (an antivirus engine) is installed and running**

.. include:: ../../step_inspec/step_inspec_service_clamav.rst
