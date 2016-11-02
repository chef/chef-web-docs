

.. tag chef_repo_25

=====================================================
About the chef-repo
=====================================================

.. tag all

The chef-repo is the location in which the following data objects are stored:

* Cookbooks (including recipes, attributes, custom resources, libraries, and templates)
* Roles
* Data bags
* Environments

The chef-repo is located on a workstation and should be synchronized with a version control system, such as git. All of the data in the chef-repo should be treated like source code.

knife is used to upload data to the Chef server from the chef-repo. Once uploaded, that data is used by the chef-client to manage all of the nodes that are registered with the Chef server and to ensure that the correct cookbooks, environments, roles, and other settings are applied to nodes correctly.

.. end_tag

Directory Structure
=====================================================
.. tag all_directory

The chef-repo contains several directories, each with a README file that describes what it is for and how to use that directory when managing systems.

.. note:: This document describes the default directory that is present in most instances of the chef-repo.

.. end_tag

.. tag all_directory_structure

The sub-directories in the chef-repo are:

.. list-table::
   :widths: 200 300
   :header-rows: 1

   * - Directory
     - Description
   * - ``.chef/``
     - A hidden directory that is used to store validation key files and the knife.rb file.
   * - ``cookbooks/``
     - Contains cookbooks that have been downloaded from the |url community| or created locally.
   * - ``data_bags/``
     - Stores data bags (and data bag items) in JSON (.json).
   * - ``environments/``
     - Stores environment in Ruby (.rb) or JSON (.json).
   * - ``roles/``
     - Stores roles in Ruby (.rb) or JSON (.json).

.. end_tag

.chef/
-----------------------------------------------------
.. tag all_directory_chef

The .chef directory is a hidden directory that is used to store validation key files and the knife.rb file. These files are required for interaction with a Chef server.

.. end_tag

cookbooks/
-----------------------------------------------------
.. tag all_directory_cookbooks

The ``cookbooks/`` directory is used to store the cookbooks that are used by the chef-client when configuring the various systems in the organization. This directory contains the cookbooks that are used to configure systems in the infrastructure. Each cookbook can be configured to contain cookbook-specific copyright, email, and license data.

.. end_tag

data_bags/
-----------------------------------------------------
.. tag all_directory_data_bags

The ``data_bags/`` directory is used to store all of the data bags that exist for an organization. Each sub-directory corresponds to a single data bag on the Chef server and contains a JSON file for each data bag item. If a sub-directory does not exist, then create it using SSL commands. After a data bag item is created, it can then be uploaded to the Chef server.

.. end_tag

environments/
-----------------------------------------------------
.. tag all_directory_environments

The ``environments/`` directory is used to store the files that define the environments that are available to the Chef server. The environments files can be Ruby DSL files (.rb) or they can be JSON files (.json). Use knife to install environment files to the Chef server.

.. end_tag

roles/
-----------------------------------------------------
.. tag all_directory_roles

The ``roles/`` directory is used to store the files that define the roles that are available to the Chef server. The roles files can be Ruby DSL files (.rb) or they can be JSON files (.json). Use knife to install role files to the Chef server.

.. end_tag

chefignore Files
=====================================================
.. tag all_directory_chefignore

The chefignore file is used to tell knife which cookbook files in the chef-repo should be ignored when uploading data to the Chef server. The type of data that should be ignored includes swap files, version control data, build output data, and so on. The chefignore file uses the ``File.fnmatch`` Ruby syntax to define the ignore patterns using ``*``, ``**``, and ``?`` wildcards.

* A pattern is relative to the cookbook root
* A pattern may contain relative directory names
* A pattern may match all files in a directory

The chefignore file is located at the root of the ``/cookbooks`` subdirectory in the chef-repo. It should contain sections similar to the following:

.. code-block:: none

   # section
   *ignore_pattern

   # section
   ignore_pattern*

   # section
   **ignore_pattern

   # section
   ignore_pattern**

   # section
   ?ignore_pattern

   # section
   ignore_pattern?

.. end_tag

Examples
-----------------------------------------------------
The following examples show how to add entries to the ``chefignore`` file.

**Ignore editor swap files**

.. tag all_directory_chefignore_swap_files

Many text editors leave files behind. To prevent these files from being uploaded to the Chef server, add an entry to the chefignore file. For Emacs, do something like:

.. code-block:: none

   *~

and for vim, do something like:

.. code-block:: none

   *.sw[a-z]

.. end_tag

**Ignore top-level Subversion data**

.. tag all_directory_chefignore_svn

If Subversion is being used as the version source control application, it is important not to upload certain files that Subversion uses to maintain the version history of each file. This is because the chef-client will never use it while configuring nodes, plus the amount of data in an upload that includes top-level Subversion data could be significant.

To prevent the upload of top-level Subversion data, add something like the following to the chefignore file:

.. code-block:: none

   */.svn/*

To verify that the top-level Subversion data is not being uploaded to the Chef server, use knife and run a command similar to:

.. code-block:: bash

   $ knife cookbook show name_of_cookbook cookbook_version | grep .svn

.. end_tag

**Ignore all files in a directory**

.. tag all_directory_chefignore_directories

The chefignore file can be used to ignore all of the files in a directory. For example:

.. code-block:: none

   files/default/subdirectory/*

or:

.. code-block:: none

   files/default/subdirectory/**

.. end_tag

Many Users, Same Repo
=====================================================
.. tag chef_repo_many_users_same_repo

It is possible for multiple users to access the Chef server using the same knife.rb file. (A user can even access multiple organizations if, for example, each instance of the chef-repo contained the same copy of the knife.rb file.) This can be done by adding the knife.rb file to the chef-repo, and then using environment variables to handle the user-specific credential details and/or sensitive values. For example:

.. code-block:: none

   current_dir = File.dirname(__FILE__)
     user = ENV['OPSCODE_USER'] || ENV['USER']
     node_name                user
     client_key               "#{ENV['HOME']}/chef-repo/.chef/#{user}.pem"
     validation_client_name   "#{ENV['ORGNAME']}-validator"
     validation_key           "#{ENV['HOME']}/chef-repo/.chef/#{ENV['ORGNAME']}-validator.pem"
     chef_server_url          "https://api.opscode.com/organizations/#{ENV['ORGNAME']}"
     syntax_check_cache_path  "#{ENV['HOME']}/chef-repo/.chef/syntax_check_cache"
     cookbook_path            ["#{current_dir}/../cookbooks"]
     cookbook_copyright       "Your Company, Inc."
     cookbook_license         "apachev2"
     cookbook_email           "cookbooks@yourcompany.com"

     # Amazon AWS
     knife[:aws_access_key_id] = ENV['AWS_ACCESS_KEY_ID']
     knife[:aws_secret_access_key] = ENV['AWS_SECRET_ACCESS_KEY']

     # Rackspace Cloud
     knife[:rackspace_api_username] = ENV['RACKSPACE_USERNAME']
     knife[:rackspace_api_key] = ENV['RACKSPACE_API_KEY']

.. end_tag

Create the chef-repo
=====================================================
There are two ways to create a chef-repo when using the Chef boilerplate repository as a base:

* Clone the chef-repo from GitHub
* Download the chef-repo as a tar.gz file and place it into local version source control.

.. note:: Chef strongly recommends using some type of version control tool to manage the source code in the chef-repo. Chef uses git for everything, including for cookbooks. git and/or GitHub is not required to use Chef. If another version source control system is preferred over git (such as Subversion, Mercurial, or Bazaar) that is just fine.

Generate
-----------------------------------------------------
.. tag chef_repo_generate_repo

To create a chef-repo, run the following command:

.. code-block:: bash

   $ chef generate repo REPO_NAME

This command uses the ``chef`` command-line tool that is packaged as part of the Chef development kit to create a chef-repo.

.. end_tag

Use git
=====================================================
.. tag chef_repo_git

Chef is maintained on GitHub. To contribute to Chef, such as submitting a pull request, requires using GitHub and git. The sections below describe how to use git to set up the Chef repository, keep it current and synchronized, and how to use branches to submit pull requests.

.. end_tag

Set Up Repo
-----------------------------------------------------
.. tag chef_repo_git_master_setup

Use the following steps to set up a development repository for Chef:

#. Set up a GitHub account.
#. Fork the https://github.com/chef/chef repository to your GitHub account.
#. Clone the https://github.com/chef/chef repository:

   .. code-block:: bash

      $ git clone git@github.com:yourgithubusername/chef.git

#. From the command line, browse to the ``chef/`` directory:

   .. code-block:: bash

      $ cd chef/

#. From the ``chef/`` directory, add a remote named ``chef``:

   .. code-block:: bash

      $ git remote add chef git://github.com/chef/chef.git

#. Verify:

   .. code-block:: bash

      $ git config --get-regexp "^remote\.chef"

   which should return something like:

   .. code-block:: bash

      remote.chef.url git://github.com/chef/chef.git
      remote.chef.fetch +refs/heads/*:refs/remotes/chef/*

#. Adjust your branch to track the ``chef/master`` remote branch:

   .. code-block:: bash

      $ git config --get-regexp "^branch\.master"

   which should return something like:

   .. code-block:: bash

      branch.master.remote origin
      branch.master.merge refs/heads/master

   and then change it:

   .. code-block:: bash

      $ git config branch.master.remote chef

.. end_tag

Keep Master Current
-----------------------------------------------------
.. tag chef_repo_git_master_keep_current

Use the following steps to keep the master branch up to date.

#. Run:

   .. code-block:: bash

      $ git checkout master

#. And then run:

   .. code-block:: bash

      $ git pull --rebase

The following ``rakefile`` can be used to update Chef, Ohai, and cookbooks. Edit as necessary:

.. code-block:: ruby

   projects = %w[chef cookbooks ohai]
   chef = "#{ENV['HOME']}/projects/chef"

   desc 'Update local repositories from upstream'
   task :update do
     projects.each do |p|
       Dir.chdir('#{chef}/#{p}') do
         sh 'git fetch chef'
         sh 'git rebase chef/master master'
       end
     end
   end

.. end_tag

Sync Master
-----------------------------------------------------
.. tag chef_repo_git_master_sync

Use the following steps to synchronize the master branch.

#. Run:

   .. code-block:: bash

      $ git fetch chef

#. And then run:

   .. code-block:: bash

      $ git rebase chef/master master

   .. note:: Use ``rebase`` instead of ``merge`` to ensure that a linear history is maintained that does not include unnecessary merge commits. ``rebase`` will also rewind, apply, and then reapply commits to the ``master`` branch.

.. end_tag

Use Branch
-----------------------------------------------------
.. tag chef_repo_git_branch

Commits to the Chef repositories should never be made against the master branch. Use a topic branch instead. A topic branch solves a single and unique problem and often maps closely to an issue being tracked in the repository. For example, a topic branch to add support for a new init system or a topic branch to resolve a bug that occurs in a specific version of CentOS. Ideally, a topic branch is named in a way that associates it closely with the issue it is attempting to resolve. This helps ensure that others may easily find it.

Use the following steps to create a topic branch:

#. For a brand new clone of the Chef repository (that was created using the steps listed earlier), fetch the ``opscode`` remote:

   .. code-block:: bash

      $ git fetch chef

#. Create an appropriately named tracking branch:

   .. code-block:: bash

      $ git checkout --track -b CHEF-XX chef/master

   Set up a topic branch to track ``chef/master``. This allows commits to be easily rebased prior to merging.

#. Make your changes, and then commit them:

   .. code-block:: bash

      $ git status

#. And then run:

   .. code-block:: bash

      $ git commit <filespec>

#. Rebase the commits against ``chef/master``. After work in the topic branch is finished, rebase these commits against the upstream master. Do this manually with ``git fetch`` followed by a ``git rebase`` or use ``git pull --rebase``.

   git will let you know if there are any problems. In the event of problems, fix them as directed, and then mark as fixed with a ``git add``, and then continue the rebase process using ``git rebase --continue``.

   For example:

   .. code-block:: bash

      $ git fetch chef

   followed by:

   .. code-block:: bash

      $ git rebase chef/master CHEF-XX

   Or:

   .. code-block:: bash

      $ git pull --rebase

#. Push the local topic branch to GitHub:

   .. code-block:: bash

      $ git push origin CHEF-XX

#. Send a GitHub pull request for the changes, and then update the Chef ticket with the appropriate information.

.. end_tag

Delete Branch
-----------------------------------------------------
.. tag chef_repo_git_branch_delete

After work has been merged by the branch maintainer, the topic branch is no longer necessary and should be removed.

#. Synchronize the local master:

   .. code-block:: bash

      $ git checkout master

   followed by:

   .. code-block:: bash

      $ git pull --rebase

#. Remove the local branch using ``-d`` to ensure that it has been merged by upstream. This option will not delete a branch that is not an ancestor of the current ``HEAD``. From the git man page:

   .. code-block:: bash

      -d
        Delete a branch. The branch must be fully merged in HEAD.
      -D
        Delete a branch irrespective of its merged status.

#. Remove the local branch:

   .. code-block:: bash

      $ git branch -d CHEF-XX

   Or remove the remote branch by using the full syntax to ``push`` and by omitting a source branch:

   .. code-block:: bash

      $ git push origin :CHEF-XX

.. end_tag

.. end_tag

