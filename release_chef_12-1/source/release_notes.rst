=====================================================
Release Notes: |chef client| 12.1
=====================================================

.. include:: ../../includes_chef/includes_chef.rst

What's New
=====================================================
The following items are new for |chef client| 12.1 and/or are changes from previous versions. The short version:

* **chef-client may be run in audit-mode** Use |chef client_audit| to run audit tests against a node.
* **control method added to Recipe DSL** Use the ``control`` method to define specific tests that match directories, files, packages, ports, and services. A ``control`` method must be contained within a ``control_group`` block.
* **control_group method added to Recipe DSL** Use the ``control_group`` method to group one (or more) ``control`` methods into a single audit.
* **Bootstrap nodes without using the ORGANIZATION-validator.key file** A node may now be bootstrapped using the |user pem| file, instead of the |organization pem| file. Also known as a "validatorless bootstrap".
* **New options for knife-bootstrap** Use the ``--bootstrap-vault-file``, ``--bootstrap-vault-item``, and ``--bootstrap-vault-json`` options with ``knife bootstrap`` to specify items that are stored in |chef vault|.
* **New verify attribute for cookbook_file, file, remote_file, and template resources** Use the ``verify`` attribute to test a file using a block of code or a string.
* **New imports attribute for dsc_script resource** Use the ``imports`` attribute to import |windows powershell_dsc_short| resources from modules.
* **New attribute for chef_gem resource** Use the ``compile_time`` attribute to disable compile-time installation of |gems|.
* **New openbsd_package resource** Use the |resource package_openbsd| resource to install packages on the |open bsd| platform.
* **New --proxy-auth option for knife raw subcommand** |proxy_auth|.
* **New watchdog_timeout setting for the Windows platform** Use the ``windows_service.watchdog_timeout`` setting in the |client rb| file to specify the maximum amount of time allowed for a |chef client| run on the |windows| platform.
* **Support for multiple packages and versions** Multiple packages and versions may be specified for platforms that use |yum| or |apt|.
* **New attributes for windows_service resource** Use the ``run_as_user`` and ``run_as_password`` attributes to specify the user under which a |windows| service should run.

|chef client|, |chef client_audit|
-----------------------------------------------------
.. include:: ../../includes_chef_client/includes_chef_client_audit_mode.rst

Use following option to run the |chef client| in |chef client_audit| mode:

``--audit-mode MODE``
   |audit_mode| Default value: ``disabled``.

The Audit Run
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_chef_client/includes_chef_client_audit_mode_run.rst

control
-----------------------------------------------------
.. include:: ../../includes_analytics/includes_analytics_controls.rst

.. include:: ../../includes_dsl_recipe/includes_dsl_recipe_method_control.rst

.. include:: ../../includes_dsl_recipe/includes_dsl_recipe_method_control_syntax.rst

directory Matcher
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_dsl_recipe/includes_dsl_recipe_method_control_matcher_directory.rst

file Matcher
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_dsl_recipe/includes_dsl_recipe_method_control_matcher_file.rst

package Matcher
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_dsl_recipe/includes_dsl_recipe_method_control_matcher_package.rst

port Matcher
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_dsl_recipe/includes_dsl_recipe_method_control_matcher_port.rst

service Matcher
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_dsl_recipe/includes_dsl_recipe_method_control_matcher_service.rst

Examples
+++++++++++++++++++++++++++++++++++++++++++++++++++++

**A package is installed**

.. include:: ../../step_dsl_recipe/step_dsl_recipe_control_matcher_package_installed.rst

**A package version is installed**

.. include:: ../../step_dsl_recipe/step_dsl_recipe_control_matcher_package_installed_version.rst

**A package is not installed**

.. include:: ../../step_dsl_recipe/step_dsl_recipe_control_matcher_package_not_installed.rst

**A service is enabled**

.. include:: ../../step_dsl_recipe/step_dsl_recipe_control_matcher_service_enabled.rst

**A configuration file contains specific settings**

.. include:: ../../step_dsl_recipe/step_dsl_recipe_control_matcher_file_sshd_configuration.rst

**A file contains desired permissions and contents**

.. include:: ../../step_dsl_recipe/step_dsl_recipe_control_matcher_file_permissions.rst

control_group
-----------------------------------------------------
.. include:: ../../includes_dsl_recipe/includes_dsl_recipe_method_control_group.rst

.. include:: ../../includes_dsl_recipe/includes_dsl_recipe_method_control_group_syntax.rst

Examples
+++++++++++++++++++++++++++++++++++++++++++++++++++++

**control_group block with multiple control blocks**

.. include:: ../../step_dsl_recipe/step_dsl_recipe_control_group_many_controls.rst

**Duplicate control_group names**

.. include:: ../../step_dsl_recipe/step_dsl_recipe_control_group_duplicate_names.rst

**Verify a package is installed**

.. include:: ../../step_dsl_recipe/step_dsl_recipe_control_group_simple_recipe.rst

Validatorless Bootstrap
-----------------------------------------------------
.. include:: ../../includes_knife/includes_knife_bootstrap_no_validator.rst

knife bootstrap Options
+++++++++++++++++++++++++++++++++++++++++++++++++++++
Use the following options to specify items that are stored in |chef vault|:

``--bootstrap-vault-file VAULT_FILE``
   |bootstrap vault_file|

``--bootstrap-vault-item VAULT_ITEM``
   |bootstrap vault_item|

``--bootstrap-vault-json VAULT_JSON``
   |bootstrap vault_json|

   .. include:: ../../step_knife/step_knife_bootstrap_vault_json.rst

New Resource Attributes
-----------------------------------------------------
The following attributes are new for |chef client| 12.1.

verify
+++++++++++++++++++++++++++++++++++++++++++++++++++++
The ``verify`` attribute may be used with the |resource cookbook_file|, |resource file|, |resource remote_file|, and |resource template| resources.

.. list-table::
   :widths: 150 450
   :header-rows: 1

   * - Attribute
     - Description
   * - ``verify``
     - |verify_file|

       The following examples show how the ``verify`` attribute is used with the |resource template| resource. The same approach (but with different resource names) is true for the |resource cookbook_file|, |resource file|, and |resource remote_file| resources:

       .. include:: ../../includes_resources/includes_resource_template_attributes_verify.rst


imports
+++++++++++++++++++++++++++++++++++++++++++++++++++++
The following attribute is new for the |resource dsc_script| resource:

.. list-table::
   :widths: 150 450
   :header-rows: 1

   * - Attribute
     - Description
   * - ``imports``
     - Use to import |windows powershell_dsc_short| resources from a module. To import all resources from a module, specify only the module name:

       .. code-block:: ruby

          imports "module_name"

       To import specific resources, specify the module name and then the name for each resource in that module to import:

       .. code-block:: ruby

          imports "module_name", "resource_name_a", "resource_name_b", ...

       For example, to import all resources from a module named ``cRDPEnabled``:

       .. code-block:: ruby

          imports "cRDPEnabled"

       And to import only the ``PSHOrg_cRDPEnabled`` resource:

       .. code-block:: ruby

          imports "cRDPEnabled", "PSHOrg_cRDPEnabled"


compile_time
+++++++++++++++++++++++++++++++++++++++++++++++++++++
The following attribute is new for the |resource chef_gem| resource:

.. list-table::
   :widths: 150 450
   :header-rows: 1

   * - Attribute
     - Description
   * - ``compile_time``
     - |chef_gem compile_time| Recommended value: ``false``. The |chef client| will emit a warning when this setting is ``true``. Use a ``respond_to?`` check to ensure backward compatibility. For example:

       .. code-block:: ruby

          chef_gem 'aws-sdk' do
            compile_time false if respond_to?(:compile_time)
          end

run_as_
+++++++++++++++++++++++++++++++++++++++++++++++++++++
The following attributes are new for the |resource service_windows| resource:

.. list-table::
   :widths: 150 450
   :header-rows: 1

   * - Attribute
     - Description
   * - ``run_as_password``
     - |password windows_service_run_as|
   * - ``run_as_user``
     - |user windows_service_run_as|




openbsd_package
-----------------------------------------------------
.. include:: ../../includes_resources/includes_resource_package_openbsd.rst

.. note:: ../../includes_notes/includes_notes_resource_based_on_package.rst

Syntax
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_package_openbsd_syntax.rst

Actions
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_package_openbsd_actions.rst

Attributes
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_package_openbsd_attributes.rst

Examples
+++++++++++++++++++++++++++++++++++++++++++++++++++++

**Install a package**

.. include:: ../../step_resource/step_resource_openbsd_package_install.rst

New |client rb| Settings
-----------------------------------------------------
The following |client rb| settings are new:

.. list-table::
   :widths: 150 450
   :header-rows: 1

   * - Attribute
     - Description
   * - ``windows_service.watchdog_timeout``
     - |watchdog_timeout| Default value: ``2 * (60 * 60)``.

Multiple Packages and Versions
-----------------------------------------------------
.. include:: ../../includes_resources_common/includes_resources_common_multiple_packages.rst

Changelog
=====================================================
https://github.com/chef/chef/blob/12.1.2/CHANGELOG.md
