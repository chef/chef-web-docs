=====================================================
About |policyfile|
=====================================================

.. include:: ../../includes_policy/includes_policy.rst

.. include:: ../../includes_policy/includes_policyfile.rst

.. warning:: |policyfile| is intended to be used with |chef server| 12.3 (and higher) and |chef client| 12.8 (and higher).


Why |policyfile|?
=====================================================
.. include:: ../../includes_policy/includes_policyfile_about.rst

Focused System Workflows
-----------------------------------------------------
.. include:: ../../includes_policy/includes_policyfile_about_focused_workflows.rst

Safer Workflows
-----------------------------------------------------
.. include:: ../../includes_policy/includes_policyfile_about_safer_workflows.rst

Code Visibility
-----------------------------------------------------
.. include:: ../../includes_policy/includes_policyfile_about_code_visibility.rst

Less Expensive Computation
-----------------------------------------------------
.. include:: ../../includes_policy/includes_policyfile_about_less_expensive_computation.rst

Role Mutability
-----------------------------------------------------
.. include:: ../../includes_policy/includes_policyfile_about_role_mutability.rst

Cookbook Mutability
-----------------------------------------------------
.. include:: ../../includes_policy/includes_policyfile_about_cookbook_mutability.rst

Opaque IDs
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_policy/includes_policyfile_about_opaque_ids.rst

Environment Cookbooks
-----------------------------------------------------
.. include:: ../../includes_policy/includes_policyfile_about_environment_cookbooks.rst


|policyfile rb|
=====================================================
.. include:: ../../includes_policy/includes_policyfile_rb.rst

Syntax
-----------------------------------------------------
.. include:: ../../includes_policy/includes_policyfile_rb_syntax.rst

Settings
-----------------------------------------------------
.. include:: ../../includes_policy/includes_policyfile_rb_settings.rst

Example
-----------------------------------------------------
.. include:: ../../includes_policy/includes_policyfile_rb_example.rst

client.rb Settings
=====================================================
The following settings may be configured in the |client rb| file for use with |policyfile|:

``named_run_list``
   |run_list policy|

``policy_group``
   |name policy_name| ``policy_name`` must also be specified.

``policy_name``
   |name policy_group| ``policy_group`` must also be specified.

``use_policyfile``
  |use policyfile| Default value: ``false``.


knife bootstrap
=====================================================
A node may be bootstrapped to use |policyfile| files. Use the following options as part of the bootstrap command:

``--policy-group POLICY_GROUP``
   |name policy_name|

``--policy-name POLICY_NAME``
   |name policy_group|

For a customized bootstrap process, add ``policy_name`` and ``policy_group`` to the first-boot |json| file that is passed to the |chef client|.


knife search
=====================================================
The ``policy_name`` and ``policy_group`` settings for a node are stored as searchable attributes and as such are available when using a fuzzy matching search pattern. For example: ``knife search dev`` will return nodes that are part of the ``dev`` policy group.


Test w/|kitchen|
=====================================================
.. include:: ../../includes_test_kitchen/includes_test_kitchen_yml_example_policyfile.rst


chef Commands
=====================================================
.. include:: ../../includes_policy/includes_policyfile_chef_commands.rst


chef clean-policy-cookbooks
-----------------------------------------------------
.. include:: ../../includes_ctl_chef/includes_ctl_chef_clean_policy_cookbooks.rst

Syntax
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_ctl_chef/includes_ctl_chef_clean_policy_cookbooks_syntax.rst

Options
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_ctl_chef/includes_ctl_chef_clean_policy_cookbooks_options.rst

Examples
+++++++++++++++++++++++++++++++++++++++++++++++++++++
None.


chef clean-policy-revisions
-----------------------------------------------------
.. include:: ../../includes_ctl_chef/includes_ctl_chef_clean_policy_revisions.rst

Syntax
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_ctl_chef/includes_ctl_chef_clean_policy_revisions_syntax.rst

Options
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_ctl_chef/includes_ctl_chef_clean_policy_revisions_options.rst

Examples
+++++++++++++++++++++++++++++++++++++++++++++++++++++
None.


chef delete-policy
-----------------------------------------------------
.. include:: ../../includes_ctl_chef/includes_ctl_chef_delete_policy.rst

Syntax
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_ctl_chef/includes_ctl_chef_delete_policy_syntax.rst

Options
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_ctl_chef/includes_ctl_chef_delete_policy_options.rst

Examples
+++++++++++++++++++++++++++++++++++++++++++++++++++++
None.


chef delete-policy-group
-----------------------------------------------------
.. include:: ../../includes_ctl_chef/includes_ctl_chef_delete_policy_group.rst

Syntax
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_ctl_chef/includes_ctl_chef_delete_policy_group_syntax.rst

Options
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_ctl_chef/includes_ctl_chef_delete_policy_group_options.rst

Examples
+++++++++++++++++++++++++++++++++++++++++++++++++++++
None.


chef diff
-----------------------------------------------------
.. include:: ../../includes_ctl_chef/includes_ctl_chef_diff.rst

Syntax
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_ctl_chef/includes_ctl_chef_diff_syntax.rst

Options
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_ctl_chef/includes_ctl_chef_diff_options.rst

Examples
+++++++++++++++++++++++++++++++++++++++++++++++++++++

**Compare current lock to latest commit on latest branch**

.. include:: ../../step_ctl_chef/step_ctl_chef_diff_current_lock_latest_branch.rst

**Compare current lock with latest commit on master branch**

.. include:: ../../step_ctl_chef/step_ctl_chef_diff_current_lock_master_branch.rst

**Compare current lock to specified revision**

.. include:: ../../step_ctl_chef/step_ctl_chef_diff_current_lock_specified_revision.rst

**Compare lock on master branch to lock on revision**

.. include:: ../../step_ctl_chef/step_ctl_chef_diff_master_lock_revision_lock.rst

**Compare lock for version with latest commit on master branch**

.. include:: ../../step_ctl_chef/step_ctl_chef_diff_version_lock_master_branch.rst

**Compare current lock with latest lock for policy group**

.. include:: ../../step_ctl_chef/step_ctl_chef_diff_current_lock_policy_group.rst

**Compare locks for two policy groups**

.. include:: ../../step_ctl_chef/step_ctl_chef_diff_two_policy_groups.rst


chef export
-----------------------------------------------------
.. include:: ../../includes_ctl_chef/includes_ctl_chef_export.rst

Syntax
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_ctl_chef/includes_ctl_chef_export_syntax.rst

Configuration Settings
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_ctl_chef/includes_ctl_chef_export_config.rst

Options
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_ctl_chef/includes_ctl_chef_export_options.rst

Examples
+++++++++++++++++++++++++++++++++++++++++++++++++++++
None.


chef generate policyfile
-----------------------------------------------------
.. include:: ../../includes_ctl_chef/includes_ctl_chef_generate_policyfile.rst

Syntax
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_ctl_chef/includes_ctl_chef_generate_policyfile_syntax.rst

Options
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_ctl_chef/includes_ctl_chef_generate_policyfile_options.rst

Examples
+++++++++++++++++++++++++++++++++++++++++++++++++++++
None.


chef generate repo
-----------------------------------------------------
.. include:: ../../includes_ctl_chef/includes_ctl_chef_generate_repo.rst

.. note:: This subcommand requires using one (or more) of the options (below) to support |policyfile| files.

Syntax
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_ctl_chef/includes_ctl_chef_generate_repo_syntax.rst

Options
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_ctl_chef/includes_ctl_chef_generate_repo_options.rst

Examples
+++++++++++++++++++++++++++++++++++++++++++++++++++++
None.


chef install
-----------------------------------------------------
.. include:: ../../includes_ctl_chef/includes_ctl_chef_install.rst

Syntax
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_ctl_chef/includes_ctl_chef_install_syntax.rst

Options
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_ctl_chef/includes_ctl_chef_install_options.rst

Policyfile.lock.json
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_policy/includes_policyfile_lock_json.rst

.. include:: ../../includes_policy/includes_policyfile_lock_json_example.rst

Examples
+++++++++++++++++++++++++++++++++++++++++++++++++++++
None.


chef provision
-----------------------------------------------------
.. include:: ../../includes_ctl_chef/includes_ctl_chef_provision.rst

Syntax
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_ctl_chef/includes_ctl_chef_provision_syntax.rst

Options
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_ctl_chef/includes_ctl_chef_provision_options.rst

Examples
+++++++++++++++++++++++++++++++++++++++++++++++++++++

**Create a machine with lock file, synchronized to the Chef server**

.. include:: ../../step_ctl_chef/step_ctl_chef_provision_machine_with_lockfile.rst

**Pass arbitrary options**

.. include:: ../../step_ctl_chef/step_ctl_chef_provision_arbitrary_options.rst


chef push
-----------------------------------------------------
.. include:: ../../includes_ctl_chef/includes_ctl_chef_push.rst

Syntax
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_ctl_chef/includes_ctl_chef_push_syntax.rst

Options
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_ctl_chef/includes_ctl_chef_push_options.rst

Examples
+++++++++++++++++++++++++++++++++++++++++++++++++++++
None.


chef push-archive
-----------------------------------------------------
.. include:: ../../includes_ctl_chef/includes_ctl_chef_push_archive.rst

Syntax
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_ctl_chef/includes_ctl_chef_push_archive_syntax.rst

Options
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_ctl_chef/includes_ctl_chef_push_archive_options.rst

Examples
+++++++++++++++++++++++++++++++++++++++++++++++++++++
None.


chef show-policy
-----------------------------------------------------
.. include:: ../../includes_ctl_chef/includes_ctl_chef_show_policy.rst

Syntax
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_ctl_chef/includes_ctl_chef_show_policy_syntax.rst

Options
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_ctl_chef/includes_ctl_chef_show_policy_options.rst

Examples
+++++++++++++++++++++++++++++++++++++++++++++++++++++
None.


chef undelete
-----------------------------------------------------
.. include:: ../../includes_ctl_chef/includes_ctl_chef_undelete.rst

Syntax
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_ctl_chef/includes_ctl_chef_undelete_syntax.rst

Options
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_ctl_chef/includes_ctl_chef_undelete_options.rst

Examples
+++++++++++++++++++++++++++++++++++++++++++++++++++++
None.


chef update
-----------------------------------------------------
.. include:: ../../includes_ctl_chef/includes_ctl_chef_update.rst

Syntax
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_ctl_chef/includes_ctl_chef_update_syntax.rst

Options
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_ctl_chef/includes_ctl_chef_update_options.rst

Examples
+++++++++++++++++++++++++++++++++++++++++++++++++++++
None.


