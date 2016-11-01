================================================
Lab One - Install a Text Editor
================================================

.. revealjs::

 .. revealjs:: Install a text editor

  * Every workstation needs an $EDITOR
  * Use $EDITOR to edit files
  * $EDITOR is your favorite command line text editor: vim, emacs, nano, etc.

 .. revealjs:: Objectives

  Install a text editor using chef-apply:

  * vim
  * Emacs
  * GNU nano

 .. revealjs:: Login to your lab machine

  Run:

  .. code-block:: bash

     $ ssh chef@54.164.75.30

  Returns:

  .. code-block:: bash

     The authenticity of host '54.165.227.226' can't be established.
     RSA key fingerprint is c1:ec:ab:66:fb:22:4a:8f:c2:c5:9b:26:77:f3:dd:b3.
     Are you sure you want to continue connecting (yes/no)? yes
     Warning: Permanently added '54.165.227.226' (RSA) to known hosts.
     chef@54.165.227.226's password:

 .. revealjs:: Welcome to your workstation

  * ChefDK version 0.3.5 is installed
  * chef --version
  * Chef user has passwordless sudo access
  * sudo cat /etc/shadow

 .. revealjs:: Is $EDITOR installed?

  Run:

  .. code-block:: bash

     $ which vim

  Returns:

  .. code-block:: bash

     /usr/bin/which: no vim in (
       /opt/chefdk/
       bin:/home/chef/.chefdk/gem/ruby/2.1.0/
       bin:/opt/chefdk/embedded/
       bin:/usr/local/bin:/bin:/usr/
       bin:/usr/local/sbin:/usr/sbin:/sbin:/home/chef/bin
       )

 .. revealjs:: About chef-apply

  .. tag ctl_chef_apply_24

  chef-apply is an executable program that runs a single recipe from the command line:

  * Is part of the Chef development kit
  * A great way to explore resources
  * Is **NOT** how Chef is run in production

  .. end_tag

 .. revealjs:: What does chef-apply do?

  Run:

  .. code-block:: bash

     $ chef-apply --help

  Returns:

  .. code-block:: bash

     Usage: chef-apply [RECIPE_FILE] [-e RECIPE_TEXT] [-s]
      --[no-]color                Use colored output, defaults to enabled
      -e, --execute RECIPE_TEXT   Execute resources supplied in a string
      -l, --log_level LEVEL       Set the log level (debug, info, warn,
                                    error, fatal)
      -s, --stdin                 Execute resources read from STDIN
      -v, --version               Show chef version
      -W, --why-run               Enable whyrun mode
      -h, --help                  Show this message

 .. revealjs:: Install vim

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

 .. revealjs:: Install emacs

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

 .. revealjs:: Install nano

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

 .. revealjs:: Resources

  * Describe the desired state
  * Do not need to tell Chef how to get there
  * What happens if you re-run the chef-apply command?

 .. revealjs:: Install $EDITOR again with chef-apply

  .. tag ctl_chef_apply_rerun_recipe

  Run:

  .. code-block:: bash

     $ sudo chef-apply -e "package 'vim'"

  Returns:

  .. code-block:: bash

     Recipe: (chef-apply cookbook)::(chef-apply recipe)
       * package[vim] action install (up to date)

  .. end_tag

 .. revealjs:: Recap

  * Installed vim, emacs, or nano using chef-apply

 .. revealjs:: Questions

  .. tag slides_core_questions

  .. Use this slide every time the slide deck stops for Q/A sessions with attendees.

  .. image:: ../../images/slides_questions.png

  .. end_tag

 .. revealjs:: More Info About chef-apply

  For more information, see:

  * |url slides_docs_chef_io|
