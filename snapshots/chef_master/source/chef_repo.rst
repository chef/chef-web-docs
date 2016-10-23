=====================================================
About the chef-repo
=====================================================

.. include:: ../../includes_chef_repo/includes_chef_repo_11-all.rst

Directory Structure
=====================================================
.. include:: ../../includes_chef_repo/includes_chef_repo_11-all_directory.rst

.. include:: ../../includes_chef_repo/includes_chef_repo_11-all_directory_structure.rst

.chef/
-----------------------------------------------------
.. include:: ../../includes_chef_repo/includes_chef_repo_11-all_directory_chef.rst

cookbooks/
-----------------------------------------------------
.. include:: ../../includes_chef_repo/includes_chef_repo_11-all_directory_cookbooks.rst

data_bags/
-----------------------------------------------------
.. include:: ../../includes_chef_repo/includes_chef_repo_11-all_directory_data_bags.rst

environments/
-----------------------------------------------------
.. include:: ../../includes_chef_repo/includes_chef_repo_11-all_directory_environments.rst

roles/
-----------------------------------------------------
.. include:: ../../includes_chef_repo/includes_chef_repo_11-all_directory_roles.rst 

chefignore Files
=====================================================
.. include:: ../../includes_chef_repo/includes_chef_repo_11-all_directory_chefignore.rst 

Examples
-----------------------------------------------------
The following examples show how to add entries to the ``chefignore`` file.

**Ignore editor swap files**

.. include:: ../../includes_chef_repo/includes_chef_repo_11-all_directory_chefignore_swap_files.rst 

**Ignore top-level Subversion data**

.. include:: ../../includes_chef_repo/includes_chef_repo_11-all_directory_chefignore_svn.rst 

**Ignore all files in a directory**

.. include:: ../../includes_chef_repo/includes_chef_repo_11-all_directory_chefignore_directories.rst 

Many Users, Same Repo
=====================================================
.. include:: ../../includes_chef_repo/includes_chef_repo_many_users_same_repo.rst

Create the chef-repo
=====================================================
There are two ways to create a chef-repo when using the Chef boilerplate repository as a base:

* Clone the chef-repo from GitHub
* Download the chef-repo as a tar.gz file and place it into local version source control.

.. note:: Chef strongly recommends using some type of version control tool to manage the source code in the chef-repo. Chef uses git for everything, including for cookbooks. git and/or GitHub is not required to use Chef. If another version source control system is preferred over git (such as Subversion, Mercurial, or Bazaar) that is just fine.


Generate
-----------------------------------------------------
.. include:: ../../step_chef_repo/step_chef_repo_generate_repo.rst

Use git
=====================================================
.. include:: ../../includes_chef_repo/includes_chef_repo_git.rst

Set Up Repo
-----------------------------------------------------
.. include:: ../../includes_chef_repo/includes_chef_repo_git_master_setup.rst

Keep Master Current
-----------------------------------------------------
.. include:: ../../includes_chef_repo/includes_chef_repo_git_master_keep_current.rst

Sync Master
-----------------------------------------------------
.. include:: ../../includes_chef_repo/includes_chef_repo_git_master_sync.rst

Use Branch
-----------------------------------------------------
.. include:: ../../includes_chef_repo/includes_chef_repo_git_branch.rst

Delete Branch
-----------------------------------------------------
.. include:: ../../includes_chef_repo/includes_chef_repo_git_branch_delete.rst
