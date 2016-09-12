.. THIS PAGE IS IDENTICAL TO docs.chef.io/inspec_service.html BY DESIGN
.. THIS PAGE IS LOCATED AT THE /release/devkit/ PATH.

=====================================================
service
=====================================================

.. include:: ../../includes_inspec_resources/includes_inspec_resource_service.rst

.. 
.. Uncomment when InSpec 1.0 resources are also available in this release directory.
.. 
.. Under some circumstances, it may be necessary to specify the service manager by using one of the following service manager-specific resources:
.. 
.. * :doc:`bsd_service </inspec_bsd_service>`
.. * :doc:`launchd_service </inspec_launchd_service>`
.. * :doc:`runit_service </inspec_runit_service>`
.. * :doc:`systemd_service </inspec_systemd_service>`
.. * :doc:`sysv_service </inspec_sysv_service>`
.. * :doc:`upstart_service </inspec_upstart_service>`
.. 
.. These resources are based on the ``service`` |inspec resource|.
.. 

Syntax
-----------------------------------------------------
.. include:: ../../includes_inspec_resources/includes_inspec_resource_service_syntax.rst

Matchers
-----------------------------------------------------
.. include:: ../../includes_inspec_resources/includes_inspec_resource_generic_matchers_intro.rst

be
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_inspec_resources/includes_inspec_resource_common_matcher_be.rst

be_enabled
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_inspec_resources/includes_inspec_resource_service_matcher_be_enabled.rst

be_installed
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_inspec_resources/includes_inspec_resource_service_matcher_be_installed.rst

be_running
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_inspec_resources/includes_inspec_resource_service_matcher_be_running.rst

cmp
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_inspec_resources/includes_inspec_resource_common_matcher_cmp.rst

**Compare single value to array**

.. include:: ../../includes_inspec_resources/includes_inspec_resource_common_matcher_cmp_value_vs_array.rst

**Compare strings and regular expressions**

.. include:: ../../includes_inspec_resources/includes_inspec_resource_common_matcher_cmp_string_vs_regex.rst

**Compare strings and numbers**

.. include:: ../../includes_inspec_resources/includes_inspec_resource_common_matcher_cmp_string_vs_number.rst

**Ignoring case sensitivity**

.. include:: ../../includes_inspec_resources/includes_inspec_resource_common_matcher_cmp_case_sensitive.rst

**Printing octals**

.. include:: ../../includes_inspec_resources/includes_inspec_resource_common_matcher_cmp_octals.rst

eq
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_inspec_resources/includes_inspec_resource_common_matcher_eq.rst

include
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_inspec_resources/includes_inspec_resource_common_matcher_include.rst

match
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_inspec_resources/includes_inspec_resource_common_matcher_match.rst

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
