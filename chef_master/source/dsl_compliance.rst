=====================================================
|dsl compliance|
=====================================================

.. include:: ../../includes_inspec/includes_inspec.rst

.. include:: ../../includes_dsl_compliance/includes_dsl_compliance.rst

The following sections describe the syntax and show some simple examples of using the |inspec resource| framework to define controls.

Syntax
=====================================================
.. include:: ../../includes_dsl_compliance/includes_dsl_compliance_syntax.rst

|chef compliance| Webui
-----------------------------------------------------
.. include:: ../../includes_dsl_compliance/includes_dsl_compliance_webui.rst

InSpec Audit Resources
=====================================================
.. note:: See every |inspec resource| in a single topic: https://docs.chef.io/inspec_reference.html.

.. include:: ../../includes_inspec/includes_inspec_resources_list.rst

Examples
=====================================================
The following examples show simple compliance tests built using a single ``control`` block.

Test the System Event Log
-----------------------------------------------------
.. include:: ../../includes_dsl_compliance/includes_dsl_compliance_example_test_system_event_log.rst

Are |postgresql| passwords empty?
-----------------------------------------------------
.. include:: ../../includes_dsl_compliance/includes_dsl_compliance_example_postgresql_password_empty.rst

Are |mysql| passwords in ENV?
-----------------------------------------------------
.. include:: ../../includes_dsl_compliance/includes_dsl_compliance_example_mysql_password_env.rst

Is /etc/ssh a Directory?
-----------------------------------------------------
.. include:: ../../includes_dsl_compliance/includes_dsl_compliance_example_etc_ssh_directory.rst

Is |apache| running?
-----------------------------------------------------
.. include:: ../../includes_dsl_compliance/includes_dsl_compliance_example_apache_running.rst

Are insecure packages installed?
-----------------------------------------------------
.. include:: ../../includes_dsl_compliance/includes_dsl_compliance_example_insecure_packages.rst

Test Windows Registry Keys
-----------------------------------------------------
.. include:: ../../includes_dsl_compliance/includes_dsl_compliance_example_windows_registry_keys.rst
