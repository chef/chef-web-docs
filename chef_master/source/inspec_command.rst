=====================================================
command
=====================================================

.. include:: ../../includes_inspec_resources/includes_inspec_resource_command.rst

Syntax
-----------------------------------------------------
.. include:: ../../includes_inspec_resources/includes_inspec_resource_command_syntax.rst

Matchers
-----------------------------------------------------
|inspec resource matcher|

exist
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_inspec_resources/includes_inspec_resource_command_matcher_exist.rst

exit_status
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_inspec_resources/includes_inspec_resource_command_matcher_exit_status.rst

stderr
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_inspec_resources/includes_inspec_resource_command_matcher_stderr.rst

stdout
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_inspec_resources/includes_inspec_resource_command_matcher_stdout.rst

Examples
-----------------------------------------------------
|inspec examples|

**Test for PostgreSQL database running a RC, development, or beta release**

.. include:: ../../step_inspec/step_inspec_command_postgresql_rc.rst

**Test standard output (stdout)**

.. include:: ../../step_inspec/step_inspec_command_stdout.rst

**Test standard error (stderr)**

.. include:: ../../step_inspec/step_inspec_command_stderr.rst

**Test an exit status code**

.. include:: ../../step_inspec/step_inspec_command_exit_status_code.rst

**Test if the command shell exists**

.. include:: ../../step_inspec/step_inspec_command_shell_exists.rst

**Test for a command that should not exist**

.. include:: ../../step_inspec/step_inspec_command_should_not_exist.rst
