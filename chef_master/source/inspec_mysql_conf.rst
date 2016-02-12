=====================================================
mysql_conf
=====================================================

.. include:: ../../includes_inspec_resources/includes_inspec_resource_mysql_conf.rst

Syntax
-----------------------------------------------------
.. include:: ../../includes_inspec_resources/includes_inspec_resource_mysql_conf_syntax.rst

Matchers
-----------------------------------------------------
|inspec resource matcher|

setting
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_inspec_resources/includes_inspec_resource_mysql_conf_matcher_setting.rst

Examples
-----------------------------------------------------
|inspec examples|

**Test the maximum number of allowed connections**

.. include:: ../../step_inspec/step_inspec_mysql_conf_max_allowed_connections.rst

**Test slow query logging**

.. include:: ../../step_inspec/step_inspec_mysql_conf_slow_query_logging.rst

**Test the port and socket on which MySQL listens**

.. include:: ../../step_inspec/step_inspec_mysql_conf_port_and_socket.rst

**Test connection and thread variables**

.. include:: ../../step_inspec/step_inspec_mysql_conf_thread_variables.rst

**Test the safe-user-create parameter**

.. include:: ../../step_inspec/step_inspec_mysql_conf_safe_user_create.rst
  