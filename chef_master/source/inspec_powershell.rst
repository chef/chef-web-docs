=====================================================
powershell
=====================================================

.. inspec_powershell deprecates inspec_script ... no redirect, just remove inspec_script from TOC and copy the inspec_powershell contents to inspec_script in case a future InSpec resource is generically called script, after which the appropriate changes can be made to that file.

.. include:: ../../includes_inspec_resources/includes_inspec_resource_powershell.rst

Syntax
-----------------------------------------------------
.. include:: ../../includes_inspec_resources/includes_inspec_resource_powershell_syntax.rst

Matchers
-----------------------------------------------------
.. include:: ../../includes_inspec_resources/includes_inspec_resource_generic_matchers_intro.rst

exit_status
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_inspec_resources/includes_inspec_resource_powershell_matcher_exit_status.rst

stderr
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_inspec_resources/includes_inspec_resource_powershell_matcher_stderr.rst

stdout
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_inspec_resources/includes_inspec_resource_powershell_matcher_stdout.rst

Examples
-----------------------------------------------------
.. include:: ../../includes_inspec_resources/includes_inspec_resource_generic_examples_intro.rst

**Get all groups of Administrator user**

.. include:: ../../step_inspec/step_inspec_powershell_user_get_all_groups.rst

**Write-Output 'hello'**

.. include:: ../../step_inspec/step_inspec_powershell_hello.rst
