=====================================================
postgres_conf
=====================================================

.. include:: ../../includes_inspec_resources/includes_inspec_resource_postgres_conf.rst

Syntax
-----------------------------------------------------
.. include:: ../../includes_inspec_resources/includes_inspec_resource_postgres_conf_syntax.rst

Matchers
-----------------------------------------------------
|inspec resource matcher|

setting
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_inspec_resources/includes_inspec_resource_postgres_conf_matcher_setting.rst

Examples
-----------------------------------------------------
|inspec examples|

**Test the maximum number of allowed client connections**

.. include:: ../../step_inspec/step_inspec_postgres_conf_max_allowed_clients.rst

**Test system logging**

.. include:: ../../step_inspec/step_inspec_postgres_conf_system_logging.rst

**Test the port on which PostgreSQL listens**

.. include:: ../../step_inspec/step_inspec_postgres_conf_port.rst

**Test the Unix socket settings**

.. include:: ../../step_inspec/step_inspec_postgres_conf_unix_socket.rst
