.. THIS PAGE DOCUMENTS chef-client version 12.13

=====================================================
git
=====================================================

.. include:: ../../includes_resources/includes_resource_scm_git.rst

.. note:: .. include:: ../../includes_notes/includes_notes_scm_resource_use_with_resource_deploy.rst

Syntax
=====================================================
.. include:: ../../includes_resources/includes_resource_scm_git_syntax.rst

Actions
=====================================================
.. include:: ../../includes_resources/includes_resource_scm_git_actions.rst

Properties
=====================================================
.. include:: ../../includes_resources/includes_resource_scm_git_attributes.rst

.. 
.. Providers
.. =====================================================
.. .. include:: ../../includes_resources_common/includes_resources_common_provider.rst
.. 
.. .. include:: ../../includes_resources_common/includes_resources_common_provider_attributes.rst
.. 
.. .. include:: ../../includes_resources/includes_resource_scm_git_providers.rst
.. 

Examples
=====================================================
The following examples demonstrate various approaches for using resources in recipes. If you want to see examples of how Chef uses resources in recipes, take a closer look at the cookbooks that Chef authors and maintains: https://github.com/chef-cookbooks.

**Use the git mirror**

.. include:: ../../step_resource/step_resource_scm_use_git_mirror.rst

**Use different branches**

.. include:: ../../step_resource/step_resource_scm_use_different_branches.rst

**Install an application from git using bash**

.. include:: ../../step_resource/step_resource_scm_use_bash_and_ruby_build.rst

**Upgrade packages from git**

.. include:: ../../step_resource/step_resource_scm_upgrade_packages.rst

**Pass in environment variables**

.. include:: ../../step_resource/step_resource_scm_git_environment_variables.rst
