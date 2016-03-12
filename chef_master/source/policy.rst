=====================================================
About Policy
=====================================================

.. include:: ../../includes_chef/includes_chef_policy.rst

.. list-table::
   :widths: 150 450
   :header-rows: 1

   * - Policy Type
     - Description
   * - :doc:`Data Bags </data_bags>`
     - .. include:: ../../includes_data_bag/includes_data_bag.rst
   * - :doc:`Environments </environments>`
     - .. include:: ../../includes_environment/includes_environment.rst
   * - :doc:`Roles </roles>`
     - .. include:: ../../includes_role/includes_role.rst

Policyfile
=====================================================
.. warning:: Policy is a new (and experimental) feature released in the the |chef dk|. Policy will make improvements to how the code that is used to manage your infrastructure is authored, tested, and distributed. Policy is configured using a policy file. Some aspects of the design have not yet been finalized. If you are new to |chef|, please don't use it. If you are an experienced user, please try it out and provide feedback. If you do use it, please do so in a location that is isolated from production code.

Policy defines the cookbook revisions, environments, and roles that should be applied by the |chef client|.

For more information about policy and the configuration file used to manage and maintain policy---policyfile.rb---please see this topic on Github: https://github.com/chef/chef-dk/blob/master/POLICYFILE_README.md.


chef Commands
=====================================================
The following commands are built into the ``chef`` executable and support the use of |policyfile| files.



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

.. code-block:: bash

   $ chef diff --git HEAD

**Compare current lock with latest commit on master branch**

.. code-block:: bash

   $ chef diff --git master

**Compare current lock to specified revision**

.. code-block:: bash

   $ chef diff --git v1.0.0

**Compare lock on master branch to lock on revision**

.. code-block:: bash

   $ chef diff --git master...dev

**Compare lock for version with latest commit on master branch**

.. code-block:: bash

   $ chef diff --git v1.0.0...master

**Compare current lock with latest lock for policy group**

.. code-block:: bash

   $ chef diff staging

**Compare locks for two policy groups**

.. code-block:: bash

   $ chef diff production...staging



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






