=====================================================
InSpec CLI
=====================================================

.. include:: ../../includes_ctl_inspec/includes_ctl_inspec.rst

Common Options
=====================================================
.. include:: ../../includes_ctl_inspec/includes_ctl_inspec_common_options.rst

inspec check
=====================================================
.. include:: ../../includes_ctl_inspec/includes_ctl_inspec_check.rst

Syntax
-----------------------------------------------------
.. include:: ../../includes_ctl_inspec/includes_ctl_inspec_check_syntax.rst

inspec detect
=====================================================
.. include:: ../../includes_ctl_inspec/includes_ctl_inspec_detect.rst

Syntax
-----------------------------------------------------
.. include:: ../../includes_ctl_inspec/includes_ctl_inspec_detect_syntax.rst

inspec exec
=====================================================
.. include:: ../../includes_ctl_inspec/includes_ctl_inspec_exec.rst

Syntax
-----------------------------------------------------
.. include:: ../../includes_ctl_inspec/includes_ctl_inspec_exec_syntax.rst

Options
-----------------------------------------------------
.. include:: ../../includes_ctl_inspec/includes_ctl_inspec_exec_options.rst

Examples
-----------------------------------------------------
The following examples show how to use this subcommand.

**Run a test locally**

.. code-block:: bash

   $ inspec exec test.rb

**Run a test on a remote host using SSH**

.. code-block:: bash

   $ inspec exec test.rb -t ssh://user@hostname

**Run a test on a remote host using WinRM**

.. code-block:: bash

   $ inspec exec test.rb -t winrm://Administrator@windowshost --password 'password'

**Run a test against a Docker container**

.. code-block:: bash

   $ inspec exec test.rb -t docker://container_id

inspec help
=====================================================
.. include:: ../../includes_ctl_inspec/includes_ctl_inspec_help.rst

inspec json
=====================================================
.. include:: ../../includes_ctl_inspec/includes_ctl_inspec_json.rst

Syntax
-----------------------------------------------------
.. include:: ../../includes_ctl_inspec/includes_ctl_inspec_json_syntax.rst

Options
-----------------------------------------------------
.. include:: ../../includes_ctl_inspec/includes_ctl_inspec_json_options.rst

inspec shell
=====================================================
.. include:: ../../includes_ctl_inspec/includes_ctl_inspec_shell.rst

Debug Controls
-----------------------------------------------------
.. include:: ../../includes_dsl_inspec/includes_dsl_inspec_debug.rst

Use |pry|
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_dsl_inspec/includes_dsl_inspec_debug_pry.rst

Use inspec shell
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_dsl_inspec/includes_dsl_inspec_debug_inspec_shell.rst


inspec version
=====================================================
.. include:: ../../includes_ctl_inspec/includes_ctl_inspec_version.rst

