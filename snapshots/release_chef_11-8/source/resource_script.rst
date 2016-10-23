.. THIS PAGE DOCUMENTS chef-client version 11.8

=====================================================
script
=====================================================

.. include:: ../../includes_resources/includes_resource_script.rst

This resource is the base resource for several other resources used for scripting on specific platforms. For more information about specific resources for specific platforms, see the following topics:

* :doc:`bash </resource_bash>`
* :doc:`csh </resource_csh>`
* :doc:`perl </resource_perl>`
* :doc:`python </resource_python>`
* :doc:`ruby </resource_ruby>`

Syntax
=====================================================
.. include:: ../../includes_resources/includes_resource_script_syntax.rst

Actions
=====================================================
.. include:: ../../includes_resources/includes_resource_script_actions.rst

Properties
=====================================================
.. include:: ../../includes_resources/includes_resource_script_attributes_12-5.rst

Guards
-----------------------------------------------------
.. include:: ../../includes_resources_common/includes_resources_common_guards.rst

**Attributes**

.. include:: ../../includes_resources_common/includes_resources_common_guards_attributes.rst

**Arguments**

.. include:: ../../includes_resources_common/includes_resources_common_guards_arguments.rst

Providers
=====================================================
.. include:: ../../includes_resources_common/includes_resources_common_provider.rst

.. include:: ../../includes_resources_common/includes_resources_common_provider_attributes.rst

.. include:: ../../includes_resources/includes_resource_script_providers.rst

Examples
=====================================================
The following examples demonstrate various approaches for using resources in recipes. If you want to see examples of how Chef uses resources in recipes, take a closer look at the cookbooks that Chef authors and maintains: https://github.com/chef-cookbooks.

**Use a named provider to run a script**

.. include:: ../../step_resource/step_resource_script_bash_provider_and_interpreter.rst

**Run a script**

.. include:: ../../step_resource/step_resource_script_bash_script.rst

**Install a file from a remote location using bash**

.. include:: ../../step_resource/step_resource_remote_file_install_with_bash.rst

**Install an application from git using bash**

.. include:: ../../step_resource/step_resource_scm_use_bash_and_ruby_build.rst

**Store certain settings**

.. include:: ../../step_resource/step_resource_remote_file_store_certain_settings.rst
