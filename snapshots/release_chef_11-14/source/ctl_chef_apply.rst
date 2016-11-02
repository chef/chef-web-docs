

=====================================================
chef-apply (executable)
=====================================================

.. tag ctl_chef_apply_24

chef-apply is an executable program that runs a single recipe from the command line:

* Is part of the Chef development kit
* A great way to explore resources
* Is **NOT** how Chef is run in production

.. end_tag

Options
=====================================================
.. tag 2_options

This command has the following syntax:

.. code-block:: bash

   $ chef-apply name_of_recipe.rb

This tool has the following options:

``-e RECIPE_TEXT``, ``--execute RECIPE_TEXT``
   Execute a resource using a string.

``-l LEVEL``, ``--log_level LEVEL``
   The level of logging to be stored in a log file.

``-s``, ``--stdin``
   Execute a resource using standard input.

``-v``, ``--version``
   The version of the chef-client.

``-W``, ``--why-run``
   Run the executable in why-run mode, which is a type of chef-client run that does everything except modify the system. Use why-run mode to understand why the chef-client makes the decisions that it makes and to learn more about the current and proposed state of the system.

``-h``, ``--help``
   Show help for the command.

.. end_tag

Examples
=====================================================

**Run a recipe**

.. tag ctl_chef_apply_run_recipe

Run a recipe named ``machinations.rb``:

.. code-block:: bash

   $ chef-apply machinations.rb

.. end_tag

**Install Emacs**

.. tag ctl_chef_apply_install_emacs

Run:

.. code-block:: bash

   $ sudo chef-apply -e "package 'emacs'"

Returns:

.. code-block:: bash

   Recipe: (chef-apply cookbook)::(chef-apply recipe)
     * package[emacs] action install
       - install version 23.1-25.el6 of package emacs

.. end_tag

**Install nano**

.. tag ctl_chef_apply_install_nano

Run:

.. code-block:: bash

   $ sudo chef-apply -e "package 'nano'"

Returns:

.. code-block:: bash

   Recipe: (chef-apply cookbook)::(chef-apply recipe)
     * package[nano] action install
       - install version 2.0.9-7.el6 of package nano

.. end_tag

**Install vim**

.. tag ctl_chef_apply_install_vim

Run:

.. code-block:: bash

   $ sudo chef-apply -e "package 'vim'"

Returns:

.. code-block:: bash

   Recipe: (chef-apply cookbook)::(chef-apply recipe)
     * package[vim] action install
       - install version 7.2.411-1.8.el6 of package vim-enhanced

.. end_tag

