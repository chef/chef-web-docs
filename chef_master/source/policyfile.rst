=====================================================
About |policyfile|
=====================================================

.. include:: ../../includes_policy/includes_policy.rst

.. include:: ../../includes_policy/includes_policyfile.rst

.. warning:: |policyfile| is intended to be used with |chef server| 12.3 (and higher) and |chef client| 12.8 (and higher).

.. note:: For developer notes about |policyfile|, see https://github.com/chef/chef-dk/blob/master/POLICYFILE_README.md.


|policyfile| is Optional
=====================================================
|policyfile| is an optional and may be used alongside all existing functionality in the |chef client|, the |chef dk|, and the |chef server|. |policyfile| supports:

* Single and monolithic cookbook repo patterns
* Versioning via the |policylock| file, against which an opaque identifier is associated
* Naming policy groups after workflow deployment phases, such as ``dev``, ``stage``, ``prod``, and ``canary`` 
* Associating each policy group with an active version, such as revision ``123abc`` of the ``webapp`` policy, which is applied to the ``dev`` policy group; once validated and tested, the active version may then be applied to ``stage``, and then ``prod``, after which development might continue on the ``456def`` revision
* Environments via nested attributes. For example: ``default["production"]["app_setting"] = "prod value"`` and ``default["dev"]["app_setting"] = "dev value"``, where ``["app_setting"]`` is effectively the environment value
* Using data bag items to pull certain attribute values, when necessary


Why |policyfile|?
=====================================================
For some users of |chef|, |policyfile| will make it easier to test and promote code safely with a simpler interface. |policyfile| improves the user experience and resolves real-world problems that some workflows built around |chef| must deal with. The following sections discuss in more detail some of the good reasons to use |policyfile|, including:

* Focus the workflow on the entire system
* Safer development workflows
* Less expensive computation
* Code visibility
* Role mutability
* Cookbook mutability
* Replaces |berkshelf| and the environment cookbook pattern


Focused System Workflows
-----------------------------------------------------
The |knife| command line tool maps very closely to the |api chef server| and the objects defined by it: roles, environments, run-lists, cookbooks, data bags, nodes, and so on. The |chef client| assembles these pieces at run-time and configures a host to do useful work.

|policyfile| focuses that workflow onto the entire system, rather than the individual components. For example, |policyfile| describes whole systems, whereas each individual revision of the |policylock| file uploaded to the |chef server| describes a part of that system, inclusive of roles, environments, cookbooks, and the other |chef server| objects necessary to configure that part of the system.

Safer Workflows
-----------------------------------------------------
|policyfile| encourages safer workflows by making it easier to publish development versions of cookbooks to the |chef server| without the risk of mutating the production versions and without requiring a complicated versioning scheme to work around cookbook mutability issues. Roles are mutable and those changes are applied only to the nodes specified by the policy. |policyfile| does not require any changes to your normal workflows. Use the same repositories you are already using, the same cookbooks, and workflows. |policyfile| will prevent an updated cookbook or role from being applied immediately to all machines.

Code Visibility
-----------------------------------------------------
When running |chef| without |policyfile|, the exact set of cookbooks that are applied to a node is defined by:

* The node's ``run_list`` property
* Any roles that are present in the node's run-list or recursively included by those roles
* The environment, which restricts the set of valid cookbook versions for a node based on a variety of constraint operators
* Dependencies, as defined by each cookbook's metadata
* Dependency resolution picks the "best" set of cookbooks that meet dependency and environment criteria

These conditions are re-evaluated every time the |chef client| runs, which can make it harder to know which cookbooks will be run by the |chef client| or what the effects of updating a role or uploading a new cookbook will be.

|policyfile| simplifies this behavior by computing the cookbook set on the workstation, and then producing a readable document of that solution: a |policylock| file. This pre-computed file is uploaded to the |chef server|, and is then used by all of the |chef client| runs that are managed by that particular policy group.

Less Expensive Computation
-----------------------------------------------------
When running |chef| without |policyfile|, the |chef server| loads dependency data for all known versions of all known cookbooks, and then runs an expensive computation to determine the correct set.

|policyfile| moves this computation to the workstation, where it is done less frequently.

Role Mutability
-----------------------------------------------------
When running |chef| without |policyfile| roles are global objects. Changes to roles are applied immediately to any node that contains that role in its run-list. This can make it hard to update roles and in some use cases discourages using roles at all.

|policyfile| effectively replaces roles. |policyfile| files are versioned automatically and new versions are applied to systems only when promoted.

Cookbook Mutability
-----------------------------------------------------
When running |chef| without |policyfile|, existing versions of cookbooks are mutable. This is convenient for many use cases, especially if users upload in-development cookbook revisions to the |chef server|. But this sometimes creates issues that are similar to role mutability by allowing those cookbook changes to be applied immediately to nodes that use that cookbook. Users account for this by rigorous testing processes to ensure that only fully integrated cookbooks are ever published. This process does enforce good development habits, but at the same time it shoudn't be a required part of a workflow that ends with publishing an in-development cookbook to the |chef server| for testing against real nodes.

|policyfile| solves this issue by using a cookbook publishing API for the |chef server| that does not provide cookbook mutability. Name collisions are prevented by storing cookbooks by name and an opaque identifier that is computed from the content of the cookbook itself.

For example, name/version collisions can occur when users temporarily fork an upstream cookbook. Even if the user contributes their change and the maintainer is responsive, there may be a period of time where the user needs their fork in order to make progress. This situation presents a versioning dilemma: if the user doesn't update their own version, they must overwrite the existing copy of that cookbook on the |chef server|, wheres if they do update the version number it might conflict with the version number of the future release of that upstream cookbook.

Opaque IDs
+++++++++++++++++++++++++++++++++++++++++++++++++++++
The opaque identifier that is computed from the content of a cookbook is the only place where an opaque identifier is necessary. When working with |policyfile|, be sure to:

* Use the same names and version contraints as normal in the |policyfile rb| file
* Use the same references to cookbooks pulled from |supermarket|
* Use the same branch, tag, and revision patterns for cookbooks pulled from |git|
* Use the same paths for cookbooks pulled from disk

Extra metadata about the cookbook is stored and included in |api chef server| responses and in the |policylock| file, including the source of a cookbook (|supermarket|, |git|, local disk, etc.), as well as any upstream idenfiers, such as |git| revisions. For cookbooks that are loaded from the local disk that are in a |git| repo, the upstream URL, current revision ID, and the state of the repo are stored also. 

The opaque identifier is mostly behind the scenes and is only visible once published to the |chef server|. Cookbooks that are uploaded to the |chef server| may have extended version numbers such as ``1.0.0-dev``.

Environment Cookbooks
-----------------------------------------------------
|policyfile| replaces the environment cookbook pattern that is often required by |berkshelf|, along with a dependency solver and fetcher. That said, |policyfile| does not replace all |berkshelf| scenarios.


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


