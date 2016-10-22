.. THIS PAGE IS IDENTICAL TO docs.chef.io/ctl_chef.html BY DESIGN
.. THIS PAGE IS LOCATED AT THE /release/devkit/ PATH.

=====================================================
chef (executable)
=====================================================

The chef executable is a command-line tool that does the following:

* Generates applications, cookbooks, recipes, attributes, files, templates, and custom resources (LWRPs)
* Ensures that RubyGems are downloaded properly for the chef-client development environment
* Verifies that all components are installed and configured correctly


chef env
=====================================================
Use the ``chef env`` subcommand to configure the environment for the Chef development kit.

Syntax
-----------------------------------------------------
This subcommand has the following syntax:

.. code-block:: bash

   $ chef env

Options
-----------------------------------------------------
This command does not have any specific options.

Examples
-----------------------------------------------------
None.


chef exec
=====================================================
Use the ``chef exec`` subcommand to run arbitrary shell commands with the ``PATH`` environment variable and the ``GEM_HOME`` and ``GEM_PATH`` Ruby environment variables pointed at the Chef development kit.

Syntax
-----------------------------------------------------
This subcommand has the following syntax:

.. code-block:: bash

   $ chef exec SYSTEM_COMMAND (options)

Options
-----------------------------------------------------
This subcommand has the following options:

``-h``, ``--help``
   Show help for the command.

``-v``, ``--version``
   The version of the chef-client.

Examples
-----------------------------------------------------
None.


chef gem
=====================================================
The ``chef gem`` subcommand is a wrapper around the ``gem`` command in RubyGems and is used by Chef to install RubyGems into the Chef development kit development environment. All knife plugins, drivers for Kitchen, and other Ruby applications that are not packaged within the Chef development kit will be installed to the ``.chefdk`` path in the home directory: ``~/.chefdk/gem/ruby/ver.si.on/bin`` (where ``ver.si.on`` is the version of Ruby that is packaged within the Chef development kit).

Syntax
-----------------------------------------------------
This subcommand has the following syntax:

.. code-block:: bash

   $ chef gem GEM_COMMAND GEM_OPTIONS (options)

Options
-----------------------------------------------------
This subcommand has the following options:

``-h``, ``--help``
   Show help for the command.

``-v``, ``--version``
   The version of the chef-client.

Examples
-----------------------------------------------------

**Show an existing gem in the chef-dk**

To show a gem, run a command similar to:

.. code-block:: bash

   $ chef gem list chef-dk

to return something similar to:

.. code-block:: bash

   *** LOCAL GEMS ***
   
   chef-dk (0.1.0)

**Install a gem**

To install a gem, run a command similar to:

.. code-block:: bash

   $ chef gem install knife-config

to return something similar to:

.. code-block:: bash

   Successfully installed knife-config-1.1.0
   1 gem installed

**View the contents of a gem**

To view the contents of a gem, run a command similar to:

.. code-block:: bash

   $ chef gem content knife-config

to return something similar to:

.. code-block:: bash

   /Users/user/.chefdk/gem/ruby/2.1.0/gems/knife-config-1.1.0/LICENSE
   /Users/user/.chefdk/gem/ruby/2.1.0/gems/knife-config-1.1.0/README.md
   /Users/user/.chefdk/gem/ruby/2.1.0/gems/knife-config-1.1.0/lib/chef/knife/config.rb
   /Users/user/.chefdk/gem/ruby/2.1.0/gems/knife-config-1.1.0/lib/knife-config.rb



chef generate app
=====================================================
.. note:: This command is built around the idea that there should be a middle ground between the "one cookbook per repo" and the "all cookbooks in one repo" approaches.

Use the ``chef generate app`` subcommand to generate a cookbook structure that:

* Supports multiple cookbooks (as many as needed to support an "application")
* Supports a top-level instance of Kitchen that can be used to test each cookbook in the appication
* Supports a single Policyfile.rb, which is an upcoming feature of the Chef development kit that defines a workflow around a set of cookbooks and related policy (such as roles, environments, and so on); for more information about Policyfile.rb, see the chef.lists discussions (search for "policyfile")


.. note:: .. include:: ../../includes_ruby/includes_ruby_style_patterns_hyphens.rst

Syntax
-----------------------------------------------------
This subcommand has the following syntax:

.. code-block:: bash

   $ chef generate app APP_NAME (options)

Options
-----------------------------------------------------
This subcommand has the following options:

``-g GENERATOR_COOKBOOK_PATH``, ``--generator-cookbook GENERATOR_COOKBOOK_PATH``
   The path at which a cookbook named ``code_generator`` is located. This cookbook is used by the ``chef generate`` subcommands to generate cookbooks, cookbook files, templates, attribute files, and so on. Default value: ``lib/chef-dk/skeletons``, under which is the default ``code_generator`` cookbook that is included as part of the Chef development kit.

``-h``, ``--help``
   Show help for the command.

``-v``, ``--version``
   The version of the chef-client.

Examples
-----------------------------------------------------

**Create an application**

To generate an application, run a command similar to:

.. code-block:: bash

   $ chef generate app chef-repo
   
will return something similar to:

.. code-block:: bash

   Recipe: code_generator::app
     * directory[/Users/grantmc/chef-repo] action create
       - create new directory /Users/grantmc/chef-repo
   
     * template[/Users/grantmc/chef-repo/.kitchen.yml] action create
       - create new file /Users/grantmc/chef-repo/.kitchen.yml
   
     * template[/Users/grantmc/chef-repo/README.md] action create
       - create new file /Users/grantmc/chef-repo/README.md
   
     * directory[/Users/grantmc/chef-repo/cookbooks] action create
       - create new directory /Users/grantmc/chef-repo/cookbooks
   
     * directory[/Users/grantmc/chef-repo/cookbooks/chef-repo] action create
       - create new directory /Users/grantmc/chef-repo/cookbooks/chef-repo
   
     * template[/Users/grantmc/chef-repo/cookbooks/chef-repo/metadata.rb] action create
       - create new file /Users/grantmc/chef-repo/cookbooks/chef-repo/metadata.rb
   
     * cookbook_file[/Users/grantmc/chef-repo/cookbooks/chef-repo/chefignore] action create
       - create new file /Users/grantmc/chef-repo/cookbooks/chef-repo/chefignore

     * cookbook_file[/Users/grantmc/chef-repo/cookbooks/chef-repo/Berksfile] action create
       - create new file /Users/grantmc/chef-repo/cookbooks/chef-repo/Berksfile

     * directory[/Users/grantmc/chef-repo/cookbooks/chef-repo/recipes] action create
       - create new directory /Users/grantmc/chef-repo/cookbooks/chef-repo/recipes

     * template[/Users/grantmc/chef-repo/cookbooks/chef-repo/recipes/default.rb] action create
       - create new file /Users/grantmc/chef-repo/cookbooks/chef-repo/recipes/default.rb
   
     * execute[initialize-git] action run
       - execute git init .
   
     * cookbook_file[/Users/grantmc/chef-repo/.gitignore] action create
       - create new file /Users/grantmc/chef-repo/.gitignore

and which creates a directory structure similar to::

   /chef-repo
     /.git
	 .gitignore
	 .kitchen.yml
     /cookbooks
	   /chef-repo
	     Berksfile
		 chefignore
		 metadata.rb
		 /recipes
		   default.rb
	  README.md


chef generate attribute
=====================================================
Use the ``chef generate attribute`` subcommand to generate an attribute file in the ``/attributes`` directory.

Syntax
-----------------------------------------------------
This subcommand has the following syntax:

.. code-block:: bash

   $ chef generate attribute COOKBOOK_PATH NAME (options)

Options
-----------------------------------------------------
This subcommand has the following options:

``-g GENERATOR_COOKBOOK_PATH``, ``--generator-cookbook GENERATOR_COOKBOOK_PATH``
   The path at which a cookbook named ``code_generator`` is located. This cookbook is used by the ``chef generate`` subcommands to generate cookbooks, cookbook files, templates, attribute files, and so on. Default value: ``lib/chef-dk/skeletons``, under which is the default ``code_generator`` cookbook that is included as part of the Chef development kit.

``-h``, ``--help``
   Show help for the command.

``-v``, ``--version``
   The version of the chef-client.

Examples
-----------------------------------------------------

**Create an attribute**

To generate an attribute, run a command similar to:

.. code-block:: bash

   $ chef generate attribute /path/to/cookbook FOO
   
will return something similar to:

.. code-block:: bash

   Recipe: code_generator::attribute
     * directory[/Users/grantmc/chef-repo/cookbooks/chef-repo/attributes] action create
       - create new directory /Users/grantmc/chef-repo/cookbooks/chef-repo/attributes
   
     * template[/Users/grantmc/chef-repo/cookbooks/chef-repo/attributes/FOO.rb] action create
       - create new file /Users/grantmc/chef-repo/cookbooks/chef-repo/attributes/FOO.rb



chef generate cookbook
=====================================================
Use the ``chef generate cookbook`` subcommand to generate a cookbook.

.. note:: .. include:: ../../includes_ruby/includes_ruby_style_patterns_hyphens.rst

Syntax
-----------------------------------------------------
This subcommand has the following syntax:

.. code-block:: bash

   $ chef generate cookbook COOKBOOK_PATH/COOKBOOK_NAME (options)

Options
-----------------------------------------------------
This subcommand has the following options:

``-g GENERATOR_COOKBOOK_PATH``, ``--generator-cookbook GENERATOR_COOKBOOK_PATH``
   The path at which a cookbook named ``code_generator`` is located. This cookbook is used by the ``chef generate`` subcommands to generate cookbooks, cookbook files, templates, attribute files, and so on. Default value: ``lib/chef-dk/skeletons``, under which is the default ``code_generator`` cookbook that is included as part of the Chef development kit.

``-b``, ``--berks``
   Create a Berksfile in the cookbook. Default value: enabled. This is disabled if the ``--policy`` option is given.

``-C COPYRIGHT``, ``--copyright COPYRIGHT``
   Specify the copyright holder for copyright notices in generated files. Default value: ``The Authors``

``-d``, ``--delivery``
   Generate a delivery config file and build cookbook inside the new cookbook. Default value: disabled.

``-m EMAIL``, ``--email EMAIL``
   Specify the email address of the author. Default value: ``you@example.com``.

``-a KEY=VALUE``, ``--generator-arg KEY=VALUE``
   Sets a property named ``KEY`` to the given ``VALUE`` on the generator context object in the generator cookbook. This allows custom generator cookbooks to accept optional user input on the command line.

``-I LICENSE``, ``--license LICENSE``
   Sets the license. Valid values are ``all_rights``, ``apache2``, ``mit``, ``gplv2``, or ``gplv3``. Default value: ``all_rights``.

``-P``, ``--policy``
   Create a Policyfile in the cookbook instead of a Berksfile. Default value: disabled.

``-h``, ``--help``
   Show help for the command.

``-v``, ``--version``
   The version of the chef-client.

Examples
-----------------------------------------------------

**Create a cookbook**

To generate a cookbook, run a command similar to:

.. code-block:: bash

   $ chef generate cookbook chefdocs

will return something similar to:

.. code-block:: bash

   Recipe: code_generator::cookbook
     * directory[/Users/grantmc/chefdocs] action create
       - create new directory /Users/grantmc/chefdocs
   
     * template[/Users/grantmc/chefdocs/metadata.rb] action create
       - create new file /Users/grantmc/chefdocs/metadata.rb
   
     * template[/Users/grantmc/chefdocs/README.md] action create
       - create new file /Users/grantmc/chefdocs/README.md
   
     * cookbook_file[/Users/grantmc/chefdocs/chefignore] action create
       - create new file /Users/grantmc/chefdocs/chefignore
   
     * cookbook_file[/Users/grantmc/chefdocs/Berksfile] action create
       - create new file /Users/grantmc/chefdocs/Berksfile
   
     * template[/Users/grantmc/chefdocs/.kitchen.yml] action create
       - create new file /Users/grantmc/chefdocs/.kitchen.yml
   
     * directory[/Users/grantmc/chefdocs/recipes] action create
       - create new directory /Users/grantmc/chefdocs/recipes
   
     * template[/Users/grantmc/chefdocs/recipes/default.rb] action create
       - create new file /Users/grantmc/chefdocs/recipes/default.rb
   
     * execute[initialize-git] action run
       - execute git init .
   
     * cookbook_file[/Users/grantmc/chefdocs/.gitignore] action create
       - create new file /Users/grantmc/chefdocs/.gitignore

and which creates a directory structure similar to::

   /chefdocs
     /.git
	 .gitignore
     .kitchen.yml
     Berksfile
     chefignore
     metadata.rb
     README.md
     /recipes
       default.rb

**Create a cookbook using a custom skeleton cookbook**

If a custom skeleton cookbook is located on a Mac OS X desktop (and in this example, the ``chef_generator`` cookbook is simply a copy of the same cookbook that ships in the Chef development kit), the following command will use the skeleton cookbook at the custom location to generate a cookbook into the repository from which the ``chef`` command is run:

.. code-block:: bash

   $ chef generate cookbook --generator-cookbook ~/Desktop testcookbook

.. note:: The ``code_generator`` cookbook itself is not specified as part of the path.

will return something similar to:

.. code-block:: bash

   Compiling Cookbooks...
   Recipe: code_generator::cookbook
     * directory[/Users/grantmc/Desktop/chef-repo/test-cookbook] action create
       - create new directory /Users/grantmc/Desktop/chef-repo/test-cookbook
	   
     * template[/Users/grantmc/Desktop/chef-repo/test-cookbook/metadata.rb] action create
       - create new file /Users/grantmc/Desktop/chef-repo/test-cookbook/metadata.rb
	   
     * template[/Users/grantmc/Desktop/chef-repo/test-cookbook/README.md] action create
       - create new file /Users/grantmc/Desktop/chef-repo/test-cookbook/README.md

     * cookbook_file[/Users/grantmc/Desktop/chef-repo/test-cookbook/chefignore] action create
       - create new file /Users/grantmc/Desktop/chef-repo/test-cookbook/chefignore

     * cookbook_file[/Users/grantmc/Desktop/chef-repo/test-cookbook/Berksfile] action create
       - create new file /Users/grantmc/Desktop/chef-repo/test-cookbook/Berksfile

     * template[/Users/grantmc/Desktop/chef-repo/test-cookbook/.kitchen.yml] action create
       - create new file /Users/grantmc/Desktop/chef-repo/test-cookbook/.kitchen.yml
	   
     * directory[/Users/grantmc/Desktop/chef-repo/test-cookbook/recipes] action create
       - create new directory /Users/grantmc/Desktop/chef-repo/test-cookbook/recipes
	   
     * template[/Users/grantmc/Desktop/chef-repo/test-cookbook/recipes/default.rb] action create
       - create new file /Users/grantmc/Desktop/chef-repo/test-cookbook/recipes/default.rb

chef generate build-cookbook
=====================================================
Use the ``chef generate build-cookbook`` subcommand to generate a delivery configuration file and build cookbook.


Syntax
-----------------------------------------------------
This subcommand has the following syntax:

.. code-block:: bash

   $ chef generate build-cookbook COOKBOOK_PATH/COOKBOOK_NAME (options)


Options
-----------------------------------------------------
This subcommand has the following options:

``-g GENERATOR_COOKBOOK_PATH``, ``--generator-cookbook GENERATOR_COOKBOOK_PATH``
   The path at which a cookbook named ``code_generator`` is located. This cookbook is used by the ``chef generate`` subcommands to generate cookbooks, cookbook files, templates, attribute files, and so on. Default value: ``lib/chef-dk/skeletons``, under which is the default ``code_generator`` cookbook that is included as part of the Chef development kit.

``-C COPYRIGHT``, ``--copyright COPYRIGHT``
   Specify the copyright holder for copyright notices in generated files. Default value: ``The Authors``

``-m EMAIL``, ``--email EMAIL``
   Specify the email address of the author. Default value: ``you@example.com``.

``-a KEY=VALUE``, ``--generator-arg KEY=VALUE``
   Sets a property named ``KEY`` to the given ``VALUE`` on the generator context object in the generator cookbook. This allows custom generator cookbooks to accept optional user input on the command line.

``-I LICENSE``, ``--license LICENSE``
   Sets the license. Valid values are ``all_rights``, ``apache2``, ``mit``, ``gplv2``, or ``gplv3``. Default value: ``all_rights``.

``-h``, ``--help``
   Show help for the command.

``-v``, ``--version``
   The version of the chef-client.


Examples
-----------------------------------------------------
None.


chef generate file
=====================================================
Use the ``chef generate file`` subcommand to generate a file in the ``/files`` directory.

Syntax
-----------------------------------------------------
This subcommand has the following syntax:

.. code-block:: bash

   $ chef generate file COOKBOOK_PATH NAME (options)

Options
-----------------------------------------------------
This subcommand has the following options:

``-g GENERATOR_COOKBOOK_PATH``, ``--generator-cookbook GENERATOR_COOKBOOK_PATH``
   The path at which a cookbook named ``code_generator`` is located. This cookbook is used by the ``chef generate`` subcommands to generate cookbooks, cookbook files, templates, attribute files, and so on. Default value: ``lib/chef-dk/skeletons``, under which is the default ``code_generator`` cookbook that is included as part of the Chef development kit.

``-h``, ``--help``
   Show help for the command.

``-s SOURCE_FILE``, ``--source SOURCE_FILE``
   Copy the contents from a source file.

``-v``, ``--version``
   The version of the chef-client.

Examples
-----------------------------------------------------
None.


chef generate lwrp
=====================================================
Use the ``chef generate lwrp`` subcommand to generate a lightweight resource and provider in the ``/resources`` and ``/providers`` directory.

.. note:: .. include:: ../../includes_ruby/includes_ruby_style_patterns_hyphens.rst

Syntax
-----------------------------------------------------
This subcommand has the following syntax:

.. code-block:: bash

   $ chef generate lwrp COOKBOOK_PATH NAME (options)

Options
-----------------------------------------------------
This subcommand has the following options:

``-g GENERATOR_COOKBOOK_PATH``, ``--generator-cookbook GENERATOR_COOKBOOK_PATH``
   The path at which a cookbook named ``code_generator`` is located. This cookbook is used by the ``chef generate`` subcommands to generate cookbooks, cookbook files, templates, attribute files, and so on. Default value: ``lib/chef-dk/skeletons``, under which is the default ``code_generator`` cookbook that is included as part of the Chef development kit.

``-h``, ``--help``
   Show help for the command.

``-v``, ``--version``
   The version of the chef-client.

Examples
-----------------------------------------------------
None.


chef generate recipe
=====================================================
Use the ``chef generate recipe`` subcommand to generate a recipe in the ``/recipes`` directory.

Syntax
-----------------------------------------------------
This subcommand has the following syntax:

.. code-block:: bash

   $ chef generate recipe COOKBOOK_PATH NAME (options)

Options
-----------------------------------------------------
This subcommand has the following options:

``-g GENERATOR_COOKBOOK_PATH``, ``--generator-cookbook GENERATOR_COOKBOOK_PATH``
   The path at which a cookbook named ``code_generator`` is located. This cookbook is used by the ``chef generate`` subcommands to generate cookbooks, cookbook files, templates, attribute files, and so on. Default value: ``lib/chef-dk/skeletons``, under which is the default ``code_generator`` cookbook that is included as part of the Chef development kit.

``-h``, ``--help``
   Show help for the command.

``-v``, ``--version``
   The version of the chef-client.

Examples
-----------------------------------------------------
None.


chef generate repo
=====================================================
.. include:: ../../includes_ctl_chef/includes_ctl_chef_generate_repo.rst

Syntax
-----------------------------------------------------
.. include:: ../../includes_ctl_chef/includes_ctl_chef_generate_repo_syntax.rst

Options
-----------------------------------------------------
.. include:: ../../includes_ctl_chef/includes_ctl_chef_generate_repo_options.rst

Examples
-----------------------------------------------------
None.


chef generate template
=====================================================
Use the ``chef generate template`` subcommand to generate a template in the ``/templates`` directory.

Syntax
-----------------------------------------------------
This subcommand has the following syntax:

.. code-block:: bash

   $ chef generate template COOKBOOK_PATH NAME (options)

Options
-----------------------------------------------------
This subcommand has the following options:

``-g GENERATOR_COOKBOOK_PATH``, ``--generator-cookbook GENERATOR_COOKBOOK_PATH``
   The path at which a cookbook named ``code_generator`` is located. This cookbook is used by the ``chef generate`` subcommands to generate cookbooks, cookbook files, templates, attribute files, and so on. Default value: ``lib/chef-dk/skeletons``, under which is the default ``code_generator`` cookbook that is included as part of the Chef development kit.

``-h``, ``--help``
   Show help for the command.

``-s SOURCE_FILE``, ``--source SOURCE_FILE``
   Copy the contents from a source file.

``-v``, ``--version``
   The version of the chef-client.

Examples
-----------------------------------------------------
None.


chef provision
=====================================================
.. include:: ../../includes_ctl_chef/includes_ctl_chef_provision.rst

Syntax
-----------------------------------------------------
.. include:: ../../includes_ctl_chef/includes_ctl_chef_provision_syntax.rst

Options
-----------------------------------------------------
.. include:: ../../includes_ctl_chef/includes_ctl_chef_provision_options.rst

Examples
-----------------------------------------------------

**Create a machine with lock file, synchronized to the Chef server**

.. include:: ../../step_ctl_chef/step_ctl_chef_provision_machine_with_lockfile.rst

**Pass arbitrary options**

.. include:: ../../step_ctl_chef/step_ctl_chef_provision_arbitrary_options.rst


chef shell-init
=====================================================
Use the ``chef shell-init`` subcommand to set the Ruby included in the Chef development kit as the system Ruby. The Chef development kit is designed to allow the isolation of applications used by the Chef development kit from other Ruby development tools that may be present on the workstation. This supports Bash, fish, Windows PowerShell (posh), and zsh.

bash zsh fish PowerShell (posh)

Syntax
-----------------------------------------------------
This subcommand has the following syntax:

.. code-block:: bash

   $ chef shell-init SHELL_NAME (options)

Options
-----------------------------------------------------
This subcommand has the following options:

``-h``, ``--help``
   Show help for the command.

``-v``, ``--version``
   The version of the chef-client.

Examples
-----------------------------------------------------

**Set PowerShell**

.. include:: ../../step_ruby/step_ruby_set_system_ruby_as_chefdk_ruby_windows.rst

**Set the execution policy on new machines**

.. include:: ../../step_ruby/step_ruby_set_system_ruby_as_chefdk_ruby_windows_admin.rst

**Create a $PROFILE on new machines**

.. include:: ../../step_ruby/step_ruby_set_system_ruby_as_chefdk_ruby_windows_user_profile.rst


chef verify
=====================================================
Use the ``chef verify`` subcommand to verify that components in the Chef development kit are installed correctly.

Syntax
-----------------------------------------------------
This subcommand has the following syntax:

.. code-block:: bash

   $ chef verify [APPLICATION]

Options
-----------------------------------------------------
This subcommand has the following options:

``APPLICATION``
   Use to verify a single, named application: ``berkshelf``, ``test-kitchen``, ``chef-client``, ``chef-dk``, ``chefspec``, ``rubocop``, ``fauxhai``, ``knife-spork``, ``kitchen-vagrant``. If an application is not specified, the subcommand will verify all applications.

``-h``, ``--help``
   Show help for the command.

``-v``, ``--version``
   The version of the chef-client.

Examples
-----------------------------------------------------
None.



Policyfile Commands
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
