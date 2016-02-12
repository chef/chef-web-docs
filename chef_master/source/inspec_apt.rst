=====================================================
apt
=====================================================

.. include:: ../../includes_inspec_resources/includes_inspec_resource_apt.rst

Syntax
-----------------------------------------------------
.. include:: ../../includes_inspec_resources/includes_inspec_resource_apt_syntax.rst

Matchers
-----------------------------------------------------
|inspec resource matcher|

be_enabled
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_inspec_resources/includes_inspec_resource_apt_matcher_be_enabled.rst

exist
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_inspec_resources/includes_inspec_resource_apt_matcher_exist.rst

Examples
-----------------------------------------------------
|inspec examples|

**Test if apt repository exists and is enabled**

.. include:: ../../step_inspec/step_inspec_apt_repo_exists.rst

**Verify that a PPA repository exists and is enabled**

.. include:: ../../step_inspec/step_inspec_apt_ppa_repo_exists.rst

**Verify that a repository is not present**

.. include:: ../../step_inspec/step_inspec_apt_repo_not_present.rst
