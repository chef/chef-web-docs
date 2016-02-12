=====================================================
yum
=====================================================

.. include:: ../../includes_inspec_resources/includes_inspec_resource_yum.rst

Syntax
-----------------------------------------------------
.. include:: ../../includes_inspec_resources/includes_inspec_resource_yum_syntax.rst

Matchers
-----------------------------------------------------
|inspec resource matcher|

be_enabled
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_inspec_resources/includes_inspec_resource_yum_matcher_be_enabled.rst

exist
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_inspec_resources/includes_inspec_resource_yum_matcher_exist.rst

repo('name')
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_inspec_resources/includes_inspec_resource_yum_matcher_repo_name.rst

repos
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_inspec_resources/includes_inspec_resource_yum_matcher_repos.rst

Examples
-----------------------------------------------------
|inspec examples|

**Test if the yum repo exists**

.. include:: ../../step_inspec/step_inspec_yum_repo_exists.rst

**Test if the 'base/7/x86_64' repo exists and is enabled**

.. include:: ../../step_inspec/step_inspec_yum_named_repo_exists_is_enabled.rst

**Test if a specific yum repo exists**

.. include:: ../../step_inspec/step_inspec_yum_named_repo_exists.rst
