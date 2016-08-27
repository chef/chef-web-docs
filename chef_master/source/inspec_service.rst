=====================================================
service
=====================================================

.. include:: ../../includes_inspec_resources/includes_inspec_resource_service.rst

Syntax
-----------------------------------------------------
.. include:: ../../includes_inspec_resources/includes_inspec_resource_service_syntax.rst

Matchers
-----------------------------------------------------
.. include:: ../../includes_inspec_resources/includes_inspec_resource_generic_matchers_intro.rst

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
.. include:: ../../includes_inspec_resources/includes_inspec_resource_generic_examples_intro.rst

**Test if the postgresql service is both running and enabled**

.. include:: ../../step_inspec/step_inspec_service_postgresql.rst

**Test if the mysql service is both running and enabled**

.. include:: ../../step_inspec/step_inspec_service_mysql.rst

**Test if ClamAV (an antivirus engine) is installed and running**

.. include:: ../../step_inspec/step_inspec_service_clamav.rst

**Test Unix System V run levels**

.. include:: ../../step_inspec/step_inspec_service_sysv.rst

**Override the service manager**

.. include:: ../../step_inspec/step_inspec_service_override_service_manager.rst

**Verify if Memcached is installed, enabled, and running** 

.. include:: ../../step_inspec/step_inspec_service_memcached.rst

**Verify that IIS is running** 

.. include:: ../../step_inspec/step_inspec_service_iis.rst
