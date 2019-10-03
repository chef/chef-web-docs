=====================================================
chef (executable)
=====================================================
`[edit on GitHub] <https://github.com/chef/chef-web-docs/blob/master/chef_master/source/ctl_chef.rst>`__

The chef executable is a command-line tool that does the following:

* Generates repositories, cookbooks, recipes, attributes, templates, and custom resources.
* Installs gems into the Chef development environment's Ruby installation.

chef env
=====================================================
Use the ``chef env`` subcommand to configure the environment for Chef Workstation.

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
Use the ``chef exec`` subcommand to run arbitrary shell commands with the ``PATH`` environment variable and the ``GEM_HOME`` and ``GEM_PATH`` Ruby environment variables pointed at Chef Workstation.

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
   The Chef Infra Client version.

Examples
-----------------------------------------------------
None.

chef gem
=====================================================
The ``chef gem`` subcommand is a wrapper around the ``gem`` command in RubyGems and is used by Chef to install RubyGems into Chef Workstation development environment. All knife plugins, drivers for Kitchen, and other Ruby applications that are not packaged within Chef Workstation will be installed to the ``.Chef Workstation`` path in the home directory: ``~/.Chef Workstation/gem/ruby/ver.si.on/bin`` (where ``ver.si.on`` is the version of Ruby that is packaged within Chef Workstation).

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
   The Chef Infra Client version.

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

**List all local gems**

To list all of the installed gems on your development environment, use the ``list`` command without any arguments:

.. code-block:: bash

   $ chef gem list

**Search for local gems**

The ``list`` command can also be used to search for locally installed gems. For example, to list all of the gems with ``knife`` in their title:

.. code-block:: bash

   $ chef gem list knife

which returns the following output:

.. code-block:: bash

   *** LOCAL GEMS ***

   knife-opc (0.3.2)
   knife-push (1.0.2)
   knife-spork (1.6.3)
   knife-windows (1.9.0)

**Search remote gems**

Use the ``search`` command to search for remote gems available for installation:

.. code-block:: bash

   $ chef gem search kitchen

to return something similar to:

.. code-block:: bash

   *** REMOTE GEMS ***

   chefkitchen_cli (0.0.1)
   gst-kitchen (0.9.0)
   guard-kitchen (0.0.2)
   jackal-kitchen (0.1.2)
   jackal-kitchen-slack (0.1.2)
   kitchen (0.0.3)

**Install a gem**

To install a gem, run a command similar to:

.. code-block:: bash

   $ chef gem install knife-config

to return something similar to:

.. code-block:: bash

   Successfully installed knife-config-1.1.0
   1 gem installed

**Uninstall a gem**

To uninstall a gem from Chef Workstation environment:

.. code-block:: bash

   $ chef gem uninstall knife-config

to return something similar to:

.. code-block:: bash

   Successfully uninstalled knife-config-1.1.0

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
   The path at which a cookbook named ``code_generator`` is located. This cookbook is used by the ``chef generate`` subcommands to generate cookbooks, cookbook files, templates, attribute files, and so on. Default value: ``lib/chef-dk/skeletons``, under which is the default ``code_generator`` cookbook that is included as part of Chef Workstation.

``-h``, ``--help``
   Show help for the command.

``-v``, ``--version``
   The Chef Infra Client version.

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

.. note:: .. tag ruby_style_patterns_hyphens

          Cookbook and custom resource names should contain only alphanumeric characters. A hyphen (``-``) is a valid character and may be used in cookbook and custom resource names, but it is discouraged. Chef Infra Client will return an error if a hyphen is not converted to an underscore (``_``) when referencing from a recipe the name of a custom resource in which a hyphen is located.

          .. end_tag

Syntax
-----------------------------------------------------
This subcommand has the following syntax:

.. code-block:: bash

   $ chef generate cookbook COOKBOOK_PATH/COOKBOOK_NAME (options)

Options
-----------------------------------------------------
This subcommand has the following options:

``-g GENERATOR_COOKBOOK_PATH``, ``--generator-cookbook GENERATOR_COOKBOOK_PATH``
   The path at which a cookbook named ``code_generator`` is located. This cookbook is used by the ``chef generate`` subcommands to generate cookbooks, cookbook files, templates, attribute files, and so on. Default value: ``lib/chef-dk/skeletons``, under which is the default ``code_generator`` cookbook that is included as part of Chef Workstation.

``-b``, ``--berks``
   Create a Berksfile in the cookbook. Default value: enabled. This is disabled if the ``--policy`` option is given.

``-C COPYRIGHT``, ``--copyright COPYRIGHT``
   Specify the copyright holder for copyright notices in generated files. Default value: ``The Authors``

``-d``, ``--delivery``
   Generate a delivery config file and build cookbook inside the new cookbook. Default value: disabled.  This option is disabled. It has no effect and exists only for compatibility with past releases

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
   The Chef Infra Client version.

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

     * template[/Users/grantmc/chefdocs/kitchen.yml] action create
       - create new file /Users/grantmc/chefdocs/kitchen.yml

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
     kitchen.yml
     Berksfile
     chefignore
     metadata.rb
     README.md
     /recipes
       default.rb

**Create a cookbook using a custom skeleton cookbook**

If a custom skeleton cookbook is located on a macOS desktop (and in this example, the ``chef_generator`` cookbook is simply a copy of the same cookbook that ships in Chef Workstation), the following command will use the skeleton cookbook at the custom location to generate a cookbook into the repository from which the ``chef`` command is run:

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

     * template[/Users/grantmc/Desktop/chef-repo/test-cookbook/kitchen.yml] action create
       - create new file /Users/grantmc/Desktop/chef-repo/test-cookbook/kitchen.yml

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
   The path at which a cookbook named ``code_generator`` is located. This cookbook is used by the ``chef generate`` subcommands to generate cookbooks, cookbook files, templates, attribute files, and so on. Default value: ``lib/chef-dk/skeletons``, under which is the default ``code_generator`` cookbook that is included as part of Chef Workstation.

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
   The Chef Infra Client version.

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
   The path at which a cookbook named ``code_generator`` is located. This cookbook is used by the ``chef generate`` subcommands to generate cookbooks, cookbook files, templates, attribute files, and so on. Default value: ``lib/chef-dk/skeletons``, under which is the default ``code_generator`` cookbook that is included as part of Chef Workstation.

``-h``, ``--help``
   Show help for the command.

``-s SOURCE_FILE``, ``--source SOURCE_FILE``
   Copy the contents from a source file.

``-v``, ``--version``
   The Chef Infra Client version.

Examples
-----------------------------------------------------
None.

chef generate resource
=====================================================
Use the ``chef generate resource`` subcommand to generate a custom resource in the ``/resources`` directory.

.. note:: .. tag ruby_style_patterns_hyphens

          Cookbook and custom resource names should contain only alphanumeric characters. A hyphen (``-``) is a valid character and may be used in cookbook and custom resource names, but it is discouraged. Chef Infra Client will return an error if a hyphen is not converted to an underscore (``_``) when referencing from a recipe the name of a custom resource in which a hyphen is located.

          .. end_tag

Syntax
-----------------------------------------------------
This subcommand has the following syntax:

.. code-block:: bash

   $ chef generate resource COOKBOOK_PATH NAME (options)

Options
-----------------------------------------------------
This subcommand has the following options:

``-g GENERATOR_COOKBOOK_PATH``, ``--generator-cookbook GENERATOR_COOKBOOK_PATH``
   The path at which a cookbook named ``code_generator`` is located. This cookbook is used by the ``chef generate`` subcommands to generate cookbooks, cookbook files, templates, attribute files, and so on. Default value: ``lib/chef-dk/skeletons``, under which is the default ``code_generator`` cookbook that is included as part of Chef Workstation.

``-h``, ``--help``
   Show help for the command.

``-v``, ``--version``
   The Chef Infra Client version.

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
   The path at which a cookbook named ``code_generator`` is located. This cookbook is used by the ``chef generate`` subcommands to generate cookbooks, cookbook files, templates, attribute files, and so on. Default value: ``lib/chef-dk/skeletons``, under which is the default ``code_generator`` cookbook that is included as part of Chef Workstation.

``-h``, ``--help``
   Show help for the command.

``-v``, ``--version``
   The Chef Infra Client version.

Examples
-----------------------------------------------------
None.

chef generate repo
=====================================================
.. tag ctl_chef_generate_repo

Use the ``chef generate repo`` subcommand to create a chef-repo. By default, the repo is a cookbook repo with options available to support generating a cookbook that supports Policyfile.

.. end_tag

Syntax
-----------------------------------------------------
.. tag ctl_chef_generate_repo_syntax

This subcommand has the following syntax:

.. code-block:: bash

   $ chef generate repo REPO_NAME (options)

.. end_tag

Options
-----------------------------------------------------
.. tag ctl_chef_generate_repo_options

This subcommand has the following options:

``-h``, ``--help``
   Show help for the command.

``-p``, ``--policy-only``
   Create a repository that does not store cookbook files, only Policyfile files.

``-P``, ``--policy``
   Use Policyfile instead of Berkshelf.

``-r``, ``--roles``
   Create directories for ``/roles`` and ``/environments`` instead of creating directories for Policyfile.

``-v``, ``--version``
   The Chef Infra Client version.

.. end_tag

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
   The path at which a cookbook named ``code_generator`` is located. This cookbook is used by the ``chef generate`` subcommands to generate cookbooks, cookbook files, templates, attribute files, and so on. Default value: ``lib/chef-dk/skeletons``, under which is the default ``code_generator`` cookbook that is included as part of Chef Workstation.

``-h``, ``--help``
   Show help for the command.

``-s SOURCE_FILE``, ``--source SOURCE_FILE``
   Copy the contents from a source file.

``-v``, ``--version``
   The Chef Infra Client version.

Examples
-----------------------------------------------------
None.

chef shell-init
=====================================================
Use the ``chef shell-init`` subcommand to set the Ruby included in Chef Workstation as the system Ruby. Chef Workstation is designed to allow the isolation of applications used by Chef Workstation from other Ruby development tools that may be present on the workstation. This supports Bash, fish, Windows PowerShell (posh), and zsh.

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
   The Chef Infra Client version.

Examples
-----------------------------------------------------

**Set PowerShell**

You can use the ``chef shell-init`` command with Windows PowerShell to add the appropriate variables to your environment.

To try it in your current session:

.. code-block:: bash

   chef shell-init powershell | Invoke-Expression

To enable it permanently:

.. code-block:: bash

   "chef shell-init powershell | Invoke-Expression" >> $PROFILE



**Set the execution policy on new machines**

On new Windows machines, PowerShell scripts will not work until an administrator runs the following command:

.. code-block:: bash

   Set-ExecutionPolicy RemoteSigned



**Create a $PROFILE on new machines**

On new Windows machines, commands cannot be appended to ``$PROFILE`` if the folder does not exist, or if there is a new user profile. This will result in an error similar to the following:

.. code-block:: bash

   PS C:\Users\Stuart> "chef shell-init powershell | Invoke-Expression" >> $PROFILE
   out-file : Could not find a part of the path
   'C:\Users\Stuart\Documents\WindowsPowerShell\Microsoft.PowerShell_profile.ps1'.
   At line:1 char:1
   + "chef shell-init powershell | Invoke-Expression" >> $PROFILE
   + ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
       + CategoryInfo          : OpenError: (:) [Out-File], DirectoryNotFoundException
       + FullyQualifiedErrorId : FileOpenFailure,Microsoft.PowerShell.Commands.OutFileCommand

In this situation, run the following ``chef shell-init`` command instead:

.. code-block:: bash

   if(Test-Path $PROFILE){ chef shell-init powershell | Add-Content $PROFILE } else { New-Item -Force -ItemType File $PROFILE; chef shell-init powershell | Add-Content $PROFILE }



Policyfile Commands
=====================================================
.. tag policyfile_chef_commands

The following commands are built into the ``chef`` executable and support the use of Policyfile files.

.. end_tag

chef clean-policy-cookbooks
-----------------------------------------------------
.. tag ctl_chef_clean_policy_cookbooks

Use the ``chef clean-policy-cookbooks`` subcommand to delete cookbooks that are not used by Policyfile files. Cookbooks are considered unused when they are not referenced by any policy revisions on the Chef Infra Server.

.. note:: Cookbooks that are referenced by orphaned policy revisions are not removed. Use ``chef clean-policy-revisions`` to remove orphaned policies.

.. end_tag

Syntax
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. tag ctl_chef_clean_policy_cookbooks_syntax

This subcommand has the following syntax:

.. code-block:: bash

   $ chef clean-policy-cookbooks (options)

.. end_tag

Options
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. tag ctl_chef_clean_policy_cookbooks_options

This subcommand has the following options:

``-c CONFIG_FILE``, ``--config CONFIG_FILE``
   The path to the knife configuration file.

``-D``, ``--debug``
   Enable stack traces and other debug output. Default value: ``false``.

``-h``, ``--help``
   Show help for the command.

``-v``, ``--version``
   The Chef Infra Client version.

.. end_tag

Examples
+++++++++++++++++++++++++++++++++++++++++++++++++++++
None.

chef clean-policy-revisions
-----------------------------------------------------
.. tag ctl_chef_clean_policy_revisions

Use the ``chef clean-policy-revisions`` subcommand to delete orphaned policy revisions to Policyfile files from the Chef Infra Server. An orphaned policy revision is not associated to any policy group and therefore is not in active use by any node. Use ``chef show-policy --orphans`` to view a list of orphaned policy revisions.

.. end_tag

Syntax
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. tag ctl_chef_clean_policy_revisions_syntax

This subcommand has the following syntax:

.. code-block:: bash

   $ chef clean-policy-revisions (options)

.. end_tag

Options
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. tag ctl_chef_clean_policy_revisions_options

This subcommand has the following options:

``-c CONFIG_FILE``, ``--config CONFIG_FILE``
   The path to the knife configuration file.

``-D``, ``--debug``
   Enable stack traces and other debug output. Default value: ``false``.

``-h``, ``--help``
   Show help for the command.

``-v``, ``--version``
   The Chef Infra Client version.

.. end_tag

Examples
+++++++++++++++++++++++++++++++++++++++++++++++++++++
None.

chef delete-policy
-----------------------------------------------------
.. tag ctl_chef_delete_policy

Use the ``chef delete-policy`` subcommand to delete all revisions of the named policy that exist on the Chef Infra Server. (The state of the policy revision is backed up locally and may be restored using the ``chef undelete`` subcommand.)

.. end_tag

Syntax
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. tag ctl_chef_delete_policy_syntax

This subcommand has the following syntax:

.. code-block:: bash

   $ chef delete-policy POLICY_NAME (options)

.. end_tag

Options
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. tag ctl_chef_delete_policy_options

This subcommand has the following options:

``-c CONFIG_FILE``, ``--config CONFIG_FILE``
   The path to the knife configuration file.

``-D``, ``--debug``
   Enable stack traces and other debug output. Default value: ``false``.

``-h``, ``--help``
   Show help for the command.

``-v``, ``--version``
   The Chef Infra Client version.

.. end_tag

Examples
+++++++++++++++++++++++++++++++++++++++++++++++++++++
None.

chef delete-policy-group
-----------------------------------------------------
.. tag ctl_chef_delete_policy_group

Use the ``chef delete-policy-group`` subcommand to delete the named policy group from the Chef Infra Server. Any policy revision associated with that policy group is not deleted. (The state of the policy group is backed up locally and may be restored using the ``chef undelete`` subcommand.)

.. end_tag

Syntax
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. tag ctl_chef_delete_policy_group_syntax

This subcommand has the following syntax:

.. code-block:: bash

   $ chef delete-policy-group POLICY_GROUP (options)

.. end_tag

Options
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. tag ctl_chef_delete_policy_group_options

This subcommand has the following options:

``-c CONFIG_FILE``, ``--config CONFIG_FILE``
   The path to the knife configuration file.

``-D``, ``--debug``
   Enable stack traces and other debug output. Default value: ``false``.

``-h``, ``--help``
   Show help for the command.

``-v``, ``--version``
   The Chef Infra Client version.

.. end_tag

Examples
+++++++++++++++++++++++++++++++++++++++++++++++++++++
None.

chef diff
-----------------------------------------------------
.. tag ctl_chef_diff

Use the ``chef diff`` subcommand to display an itemized comparison of two revisions of a ``Policyfile.lock.json`` file.

.. end_tag

Syntax
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. tag ctl_chef_diff_syntax

This subcommand has the following syntax:

.. code-block:: bash

   $ chef diff POLICY_FILE --head | --git POLICY_GROUP | POLICY_GROUP...POLICY_GROUP (options)

.. end_tag

Options
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. tag ctl_chef_diff_options

This subcommand has the following options:

``-c CONFIG_FILE``, ``--config CONFIG_FILE``
   The path to the knife configuration file.

``-D``, ``--debug``
   Enable stack traces and other debug output. Default value: ``false``.

``-g GIT_REF``, ``--git GIT_REF``
   Compare the specified git reference against the current revision of a ``Policyfile.lock.json`` file or against another git reference.

``-h``, ``--help``
   Show help for the command.

``--head``
   A shortcut for ``chef diff --git HEAD``. When a git-specific flag is not provided, the on-disk ``Policyfile.lock.json`` file is compared to one on the Chef Infra Server or (if a ``Policyfile.lock.json`` file is not present on-disk) two ``Policyfile.lock.json`` files in the specified policy group on the Chef Infra Server are compared.

``--[no-]pager``
   Use ``--pager`` to enable paged output for a ``Policyfile.lock.json`` file. Default value: ``--pager``.

``-v``, ``--version``
   The Chef Infra Client version.

.. end_tag

Examples
+++++++++++++++++++++++++++++++++++++++++++++++++++++

**Compare current lock to latest commit on latest branch**

.. tag ctl_chef_diff_current_lock_latest_branch

.. To compare current lock to latest commit on latest branch:

.. code-block:: bash

   $ chef diff --git HEAD

.. end_tag

**Compare current lock with latest commit on master branch**

.. tag ctl_chef_diff_current_lock_master_branch

.. To compare current lock with latest commit on master branch:

.. code-block:: bash

   $ chef diff --git master

.. end_tag

**Compare current lock to specified revision**

.. tag ctl_chef_diff_current_lock_specified_revision

.. To compare current lock to specified revision:

.. code-block:: bash

   $ chef diff --git v1.0.0

.. end_tag

**Compare lock on master branch to lock on revision**

.. tag ctl_chef_diff_master_lock_revision_lock

.. To compare lock on master branch to lock on revision:

.. code-block:: bash

   $ chef diff --git master...dev

.. end_tag

**Compare lock for version with latest commit on master branch**

.. tag ctl_chef_diff_version_lock_master_branch

.. To compare lock for version with latest commit on master branch:

.. code-block:: bash

   $ chef diff --git v1.0.0...master

.. end_tag

**Compare current lock with latest lock for policy group**

.. tag ctl_chef_diff_current_lock_policy_group

.. To compare current lock with latest lock for policy group:

.. code-block:: bash

   $ chef diff staging

.. end_tag

**Compare locks for two policy groups**

.. tag ctl_chef_diff_two_policy_groups

.. To compare locks for two policy groups:

.. code-block:: bash

   $ chef diff production...staging

.. end_tag

chef export
-----------------------------------------------------
.. tag ctl_chef_export

Use the ``chef export`` subcommand to create a chef-zero-compatible chef-repo that contains the cookbooks described by a ``Policyfile.lock.json`` file. After a chef-zero-compatible chef-repo is copied to a node, the policy can be applied locally on that machine by running ``chef-client -z`` (local mode).

.. end_tag

Syntax
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. tag ctl_chef_export_syntax

This subcommand has the following syntax:

.. code-block:: bash

   $ chef export POLICY_FILE DIRECTORY (options)

.. end_tag

Configuration Settings
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. tag ctl_chef_export_config

The client.rb file on that machine requires the following settings:

``deployment_group``
   This setting should be set to ``'$POLICY_NAME-local'``.

``policy_document_native_api``
   This setting should be set to ``false``.

``use_policyfile``
   This setting should be set to ``true``.

``versioned_cookbooks``
   This setting should be set to ``true``.

.. end_tag

Options
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. tag ctl_chef_export_options

This subcommand has the following options:

``-a``, ``--archive``
   Export an archive as a tarball, instead as a directory. Default value: ``false``.

``-D``, ``--debug``
   Enable stack traces and other debug output. Default value: ``false``.

``-f``, ``--force``
   Remove the contents of the destination directory if that directory is not empty. Default value: ``false``.

``-h``, ``--help``
   Show help for the command.

``-v``, ``--version``
   The Chef Infra Client version.

.. end_tag

Examples
+++++++++++++++++++++++++++++++++++++++++++++++++++++
None.

chef generate policyfile
-----------------------------------------------------
.. tag ctl_chef_generate_policyfile

Use the ``chef generate policyfile`` subcommand to generate a file to be used with Policyfile.

.. end_tag

Syntax
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. tag ctl_chef_generate_policyfile_syntax

This subcommand has the following syntax:

.. code-block:: bash

   $ chef generate policyfile POLICY_NAME (options)

.. end_tag

Options
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. tag ctl_chef_generate_policyfile_options

This subcommand has the following options:

``-h``, ``--help``
   Show help for the command.

``-v``, ``--version``
   The Chef Infra Client version.

.. end_tag

Examples
+++++++++++++++++++++++++++++++++++++++++++++++++++++
None.

chef install
-----------------------------------------------------
.. tag ctl_chef_install

Use the ``chef install`` subcommand to evaluate a policy file and find a compatible set of cookbooks, build a run-list, cache it locally, and then emit a ``Policyfile.lock.json`` file that describes the locked policy set. The ``Policyfile.lock.json`` file may be used to install the locked policy set to other machines and may be pushed to a policy group on the Chef Infra Server to apply that policy to a group of nodes that are under management by Chef.

.. end_tag

Syntax
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. tag ctl_chef_install_syntax

This subcommand has the following syntax:

.. code-block:: bash

   $ chef install POLICY_FILE (options)

.. end_tag

Options
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. tag ctl_chef_install_options

This subcommand has the following options:

``-D``, ``--debug``
   Enable stack traces and other debug output.

``-h``, ``--help``
   Show help for the command.

``-v``, ``--version``
   The Chef Infra Client version.

.. end_tag

Policyfile.lock.json
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. tag policyfile_lock_json

When the ``chef install`` command is run, Chef Workstation caches any necessary cookbooks and emits a ``Policyfile.lock.json`` file that describes:

* The versions of cookbooks in use
* A Hash of cookbook content
* The source for all cookbooks

A ``Policyfile.lock.json`` file is associated with a specific policy group, i.e. is associated with one (or more) nodes that use the same revision of a given policy.

.. end_tag

.. tag policyfile_lock_json_example

A ``Policyfile.lock.json`` file is similar to:

.. code-block:: javascript

   {
     "revision_id": "288ed244f8db8bff3caf58147e840bbe079f76e0",
     "name": "jenkins",
     "run_list": [
       "recipe[java::default]",
       "recipe[jenkins::master]",
       "recipe[policyfile_demo::default]"
     ],
     "cookbook_locks": {
       "policyfile_demo": {
         "version": "0.1.0",
         "identifier": "f04cc40faf628253fe7d9566d66a1733fb1afbe9",
         "dotted_decimal_identifier": "67638399371010690.23642238397896298.25512023620585",
         "source": "cookbooks/policyfile_demo",
         "cache_key": null,
         "scm_info": null,
         "source_options": {
           "path": "cookbooks/policyfile_demo"
         }
       },
     "java": {
       "version": "1.24.0",
       "identifier": "4c24ae46a6633e424925c24e683e0f43786236a3",
       "dotted_decimal_identifier": "21432429158228798.18657774985439294.16782456927907",
       "cache_key": "java-1.24.0-supermarket.chef.io",
       "origin": "https://supermarket.chef.io/api/v1/cookbooks/java/versions/1.24.0/download",
       "source_options": {
         "artifactserver": "https://supermarket.chef.io/api/v1/cookbooks/java/versions/1.24.0/download",
         "version": "1.24.0"
       }

.. end_tag

Examples
+++++++++++++++++++++++++++++++++++++++++++++++++++++
None.

chef push
-----------------------------------------------------
.. tag ctl_chef_push

Use the ``chef push`` subcommand to upload an existing ``Policyfile.lock.json`` file to the Chef Infra Server, along with all of the cookbooks that are contained in the file. The ``Policyfile.lock.json`` file will be applied to the specified policy group, which is a set of nodes that share the same run-list and cookbooks.

.. end_tag

Syntax
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. tag ctl_chef_push_syntax

This subcommand has the following syntax:

.. code-block:: bash

   $ chef push POLICY_GROUP POLICY_FILE (options)

.. end_tag

Options
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. tag ctl_chef_push_options

This subcommand has the following options:

``-c CONFIG_FILE``, ``--config CONFIG_FILE``
   The path to the knife configuration file.

``-D``, ``--debug``
   Enable stack traces and other debug output.

``-h``, ``--help``
   Show help for the command.

``-v``, ``--version``
   The Chef Infra Client version.

.. end_tag

Examples
+++++++++++++++++++++++++++++++++++++++++++++++++++++
None.

chef push-archive
-----------------------------------------------------
.. tag ctl_chef_push_archive

The ``chef push-archive`` subcommand is used to publish a policy archive file to the Chef Infra Server. (A policy archive is created using the ``chef export`` subcommand.) The policy archive is assigned to the specified policy group, which is a set of nodes that share the same run-list and cookbooks.

.. end_tag

Syntax
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. tag ctl_chef_push_archive_syntax

This subcommand has the following syntax:

.. code-block:: bash

   $ chef push-archive POLICY_GROUP ARCHIVE_FILE (options)

.. end_tag

Options
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. tag ctl_chef_push_archive_options

This subcommand has the following options:

``-c CONFIG_FILE``, ``--config CONFIG_FILE``
   The path to the knife configuration file.

``-D``, ``--debug``
   Enable stack traces and other debug output. Default value: ``false``.

``-h``, ``--help``
   Show help for the command.

``-v``, ``--version``
   The Chef Infra Client version.

.. end_tag

Examples
+++++++++++++++++++++++++++++++++++++++++++++++++++++
None.

chef show-policy
-----------------------------------------------------
.. tag ctl_chef_show_policy

Use the ``chef show-policy`` subcommand to display revisions for every ``Policyfile.rb`` file that is on the Chef Infra Server. By default, only active policy revisions are shown. When both a policy and policy group are specified, the contents of the active ``Policyfile.lock.json`` file for the policy group is returned.

.. end_tag

Syntax
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. tag ctl_chef_show_policy_syntax

This subcommand has the following syntax:

.. code-block:: bash

   $ chef show-policy POLICY_NAME POLICY_GROUP (options)

.. end_tag

Options
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. tag ctl_chef_show_policy_options

This subcommand has the following options:

``-c CONFIG_FILE``, ``--config CONFIG_FILE``
   The path to the knife configuration file.

``-D``, ``--debug``
   Enable stack traces and other debug output. Default value: ``false``.

``-h``, ``--help``
   Show help for the command.

``-o``, ``--orphans``
   Show policy revisions that are not currently assigned to any policy group.

``--[no-]pager``
   Use ``--pager`` to enable paged output for a ``Policyfile.lock.json`` file. Default value: ``--pager``.

``-v``, ``--version``
   The Chef Infra Client version.

.. end_tag

Examples
+++++++++++++++++++++++++++++++++++++++++++++++++++++
None.

chef undelete
-----------------------------------------------------
.. tag ctl_chef_undelete

Use the ``chef undelete`` subcommand to recover a deleted policy or policy group. This command:

* Does not detect conflicts. If a deleted item has been recreated, running this command will overwrite it
* Does not include cookbooks that may be referenced by policy files; cookbooks that are cleaned after running this command may not be fully restorable to their previous state
* Does not store access control data

.. end_tag

Syntax
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. tag ctl_chef_undelete_syntax

This subcommand has the following syntax:

.. code-block:: bash

   $ chef undelete (options)

When run with no arguments, returns a list of available operations.

.. end_tag

Options
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. tag ctl_chef_undelete_options

This subcommand has the following options:

``-c CONFIG_FILE``, ``--config CONFIG_FILE``
   The path to the knife configuration file.

``-D``, ``--debug``
   Enable stack traces and other debug output.

``-h``, ``--help``
   Show help for the command.

``-i ID``, ``--id ID``
   Undo the delete operation specified by ``ID``.

``-l``, ``--last``
   Undo the most recent delete operation.

``--list``
   Default. Return a list of available operations.

``-v``, ``--version``
   The Chef Infra Client version.

.. end_tag

Examples
+++++++++++++++++++++++++++++++++++++++++++++++++++++
None.

chef update
-----------------------------------------------------
.. tag ctl_chef_update

Use the ``chef update`` subcommand to read the ``Policyfile.rb`` file, and then apply any changes. This will resolve dependencies and will create a ``Policyfile.lock.json`` file. The locked policy will reflect any changes to the run-list and will pull in any cookbook updates that are compatible with any version constraints defined in the ``Policyfile.rb`` file.

.. end_tag

Syntax
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. tag ctl_chef_update_syntax

This subcommand has the following syntax:

.. code-block:: bash

   $ chef update POLICY_FILE (options)

.. end_tag

Options
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. tag ctl_chef_update_options

This subcommand has the following options:

``-a``, ``--attributes``
   Update attributes. Default value: ``false``.

``-D``, ``--debug``
   Enable stack traces and other debug output. Default value: ``false``.

``-h``, ``--help``
   Show help for the command.

``-v``, ``--version``
   The Chef Infra Client version.

.. end_tag

Examples
+++++++++++++++++++++++++++++++++++++++++++++++++++++
None.
