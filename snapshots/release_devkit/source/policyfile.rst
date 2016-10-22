.. THIS PAGE IS IDENTICAL TO docs.chef.io/policyfile.html BY DESIGN
.. THIS PAGE IS LOCATED AT THE /release/devkit/ PATH.

=====================================================
About Policyfile
=====================================================

.. include:: ../../includes_policy/includes_policyfile.rst

.. warning:: Policyfile is intended to be used with Chef server 12.3 (and higher) and chef-client 12.8 (and higher).


Why Policyfile?
=====================================================
For some users of Chef, Policyfile will make it easier to test and promote code safely with a simpler interface. Policyfile improves the user experience and resolves real-world problems that some workflows built around Chef must deal with. The following sections discuss in more detail some of the good reasons to use Policyfile, including:

* Focus the workflow on the entire system
* Safer development workflows
* Less expensive computation
* Code visibility
* Role mutability
* Cookbook mutability
* Replaces Berkshelf and the environment cookbook pattern

Focused System Workflows
-----------------------------------------------------
The knife command line tool maps very closely to the Chef server API and the objects defined by it: roles, environments, run-lists, cookbooks, data bags, nodes, and so on. The chef-client assembles these pieces at run-time and configures a host to do useful work.

Policyfile focuses that workflow onto the entire system, rather than the individual components. For example, Policyfile describes whole systems, whereas each individual revision of the Policyfile.lock.json file uploaded to the Chef server describes a part of that system, inclusive of roles, environments, cookbooks, and the other Chef server objects necessary to configure that part of the system.

Safer Workflows
-----------------------------------------------------
Policyfile encourages safer workflows by making it easier to publish development versions of cookbooks to the Chef server without the risk of mutating the production versions and without requiring a complicated versioning scheme to work around cookbook mutability issues. Roles are mutable and those changes are applied only to the nodes specified by the policy. Policyfile does not require any changes to your normal workflows. Use the same repositories you are already using, the same cookbooks, and workflows. Policyfile will prevent an updated cookbook or role from being applied immediately to all machines.

Code Visibility
-----------------------------------------------------
When running Chef without Policyfile, the exact set of cookbooks that are applied to a node is defined by:

* The node's ``run_list`` property
* Any roles that are present in the node's run-list or recursively included by those roles
* The environment, which restricts the set of valid cookbook versions for a node based on a variety of constraint operators
* Dependencies, as defined by each cookbook's metadata
* Dependency resolution picks the "best" set of cookbooks that meet dependency and environment criteria

These conditions are re-evaluated every time the chef-client runs, which can make it harder to know which cookbooks will be run by the chef-client or what the effects of updating a role or uploading a new cookbook will be.

Policyfile simplifies this behavior by computing the cookbook set on the workstation, and then producing a readable document of that solution: a Policyfile.lock.json file. This pre-computed file is uploaded to the Chef server, and is then used by all of the chef-client runs that are managed by that particular policy group.

Less Expensive Computation
-----------------------------------------------------
When running Chef without Policyfile, the Chef server loads dependency data for all known versions of all known cookbooks, and then runs an expensive computation to determine the correct set.

Policyfile moves this computation to the workstation, where it is done less frequently.

Role Mutability
-----------------------------------------------------
When running Chef without Policyfile roles are global objects. Changes to roles are applied immediately to any node that contains that role in its run-list. This can make it hard to update roles and in some use cases discourages using roles at all.

Policyfile effectively replaces roles. Policyfile files are versioned automatically and new versions are applied to systems only when promoted.

Cookbook Mutability
-----------------------------------------------------
When running Chef without Policyfile, existing versions of cookbooks are mutable. This is convenient for many use cases, especially if users upload in-development cookbook revisions to the Chef server. But this sometimes creates issues that are similar to role mutability by allowing those cookbook changes to be applied immediately to nodes that use that cookbook. Users account for this by rigorous testing processes to ensure that only fully integrated cookbooks are ever published. This process does enforce good development habits, but at the same time it shoudn't be a required part of a workflow that ends with publishing an in-development cookbook to the Chef server for testing against real nodes.

Policyfile solves this issue by using a cookbook publishing API for the Chef server that does not provide cookbook mutability. Name collisions are prevented by storing cookbooks by name and an opaque identifier that is computed from the content of the cookbook itself.

For example, name/version collisions can occur when users temporarily fork an upstream cookbook. Even if the user contributes their change and the maintainer is responsive, there may be a period of time where the user needs their fork in order to make progress. This situation presents a versioning dilemma: if the user doesn't update their own version, they must overwrite the existing copy of that cookbook on the Chef server, wheres if they do update the version number it might conflict with the version number of the future release of that upstream cookbook.

Opaque IDs
+++++++++++++++++++++++++++++++++++++++++++++++++++++
The opaque identifier that is computed from the content of a cookbook is the only place where an opaque identifier is necessary. When working with Policyfile, be sure to:

* Use the same names and version contraints as normal in the Policyfile.rb file
* Use the same references to cookbooks pulled from Chef Supermarket
* Use the same branch, tag, and revision patterns for cookbooks pulled from git
* Use the same paths for cookbooks pulled from disk

Extra metadata about the cookbook is stored and included in Chef server API responses and in the Policyfile.lock.json file, including the source of a cookbook (Chef Supermarket, git, local disk, etc.), as well as any upstream idenfiers, such as git revisions. For cookbooks that are loaded from the local disk that are in a git repo, the upstream URL, current revision ID, and the state of the repo are stored also. 

The opaque identifier is mostly behind the scenes and is only visible once published to the Chef server. Cookbooks that are uploaded to the Chef server may have extended version numbers such as ``1.0.0-dev``.

Environment Cookbooks
-----------------------------------------------------
Policyfile replaces the environment cookbook pattern that is often required by Berkshelf, along with a dependency solver and fetcher. That said, Policyfile does not replace all Berkshelf scenarios.


Policyfile.rb
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
The following settings may be configured in the client.rb file for use with Policyfile:

``named_run_list``
   The run-list associated with a policy file.

``policy_group``
   The name of a policy group that exists on the Chef server. ``policy_name`` must also be specified.

``policy_name``
   The name of a policy, as identified by the ``name`` setting in a Policyfile.rb file. ``policy_group`` must also be specified.

``use_policyfile``
  The chef-client automatically checks the configuration, node JSON, and the stored node on the Chef server to determine if Policyfile files are being used, and then automatically updates this flag. Default value: ``false``.


knife bootstrap
=====================================================
A node may be bootstrapped to use Policyfile files. Use the following options as part of the bootstrap command:

``--policy-group POLICY_GROUP``
   The name of a policy group that exists on the Chef server.

``--policy-name POLICY_NAME``
   The name of a policy, as identified by the ``name`` setting in a Policyfile.rb file.

For a customized bootstrap process, add ``policy_name`` and ``policy_group`` to the first-boot JSON file that is passed to the chef-client.


knife search
=====================================================
The ``policy_name`` and ``policy_group`` settings for a node are stored as searchable attributes and as such are available when using a fuzzy matching search pattern. For example: ``knife search dev`` will return nodes that are part of the ``dev`` policy group.


Test w/Kitchen
=====================================================
Kitchen may be used to test Policyfile files. Add the following to .kitchen.yml:

.. code-block:: yaml

   provisioner:
     name: policyfile_zero

A named run-list may be used on a per-suite basis:

.. code-block:: yaml

   suites:
     - name: client
       provisioner:
         named_run_list: test_client_recipe
     - name: server
       provisioner:
         named_run_list: test_server_recipe

or globally:

.. code-block:: yaml

   provisioner:
     name: policyfile_zero
     named_run_list: integration_test_run_list


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

.. note:: This subcommand requires using one (or more) of the options (below) to support Policyfile files.

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


