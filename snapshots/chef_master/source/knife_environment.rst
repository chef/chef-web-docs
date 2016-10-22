=====================================================
knife environment 
=====================================================

.. include:: ../../includes_environment/includes_environment.rst

.. include:: ../../includes_knife/includes_knife_environment.rst

.. note:: .. include:: ../../includes_knife/includes_knife_common_see_common_options_link.rst

compare
=====================================================
.. include:: ../../includes_knife/includes_knife_environment_compare.rst

Syntax
-----------------------------------------------------
.. include:: ../../includes_knife/includes_knife_environment_compare_syntax.rst

Options
-----------------------------------------------------
.. include:: ../../includes_knife/includes_knife_environment_compare_options.rst

Examples
-----------------------------------------------------
The following examples show how to use this knife subcommand:

**Compare cookbook versions in a single environment**

To compare cookbook versions for a single environment:

.. code-block:: bash

   $ knife environment compare development

to return something similar to:

.. code-block:: bash

              development
   apache     2.3.1
   windows    4.1.2


**Compare cookbook versions for multiple environments**

To compare cookbook versions for multiple environments:

.. code-block:: bash

   $ knife environment compare development staging

to return something similar to:

.. code-block:: bash

                 development    staging
   apache        2.3.1          1.2.2
   windows       4.1.2          1.0.0
   postgresql    1.0.0          1.0.0

**Compare cookbook versions for all environments**

To compare all cookbook versions for all environments:

.. code-block:: bash

   $ knife environment compare --all

to return something similar to:

.. code-block:: bash

                      staging  development
   ulimit             latest   latest
   redisio            latest   latest
   journly            latest   latest
   aws                latest   latest
   test               latest   latest
   unicorn            latest   latest
   sensu              latest   latest
   runit              latest   latest
   templater          latest   latest
   powershell         latest   latest
   openssl            latest   latest
   rbenv              latest   latest
   rabbitmq           latest   latest
   postgresql         latest   latest
   mysql              latest   latest
   ohai               latest   latest
   git                latest   latest
   erlang             latest   latest
   ssh_known_hosts    latest   latest
   nginx              latest   latest
   database           latest   latest
   yum                latest   latest
   xfs                latest   latest
   apt                latest   latest
   dmg                latest   latest
   chef_handler       latest   latest
   windows            1.0.0    4.1.2

create
=====================================================
.. include:: ../../includes_knife/includes_knife_environment_create.rst

Syntax
-----------------------------------------------------
.. include:: ../../includes_knife/includes_knife_environment_create_syntax.rst

Options
-----------------------------------------------------
.. include:: ../../includes_knife/includes_knife_environment_create_options.rst

.. note:: .. include:: ../../includes_knife/includes_knife_common_see_all_config_options.rst

Examples
-----------------------------------------------------
The following examples show how to use this knife subcommand:

**Create an environment**

.. include:: ../../step_knife/step_knife_environment_create.rst


delete
=====================================================
.. include:: ../../includes_knife/includes_knife_environment_delete.rst

Syntax
-----------------------------------------------------
.. include:: ../../includes_knife/includes_knife_environment_delete_syntax.rst

Options
-----------------------------------------------------
This command does not have any specific options.

Examples
-----------------------------------------------------
The following examples show how to use this knife subcommand:

**Delete an environment**

.. include:: ../../step_knife/step_knife_environment_delete.rst


edit
=====================================================
.. include:: ../../includes_knife/includes_knife_environment_edit.rst

Syntax
-----------------------------------------------------
.. include:: ../../includes_knife/includes_knife_environment_edit_syntax.rst

Options
-----------------------------------------------------
This command does not have any specific options.

Examples
-----------------------------------------------------
The following examples show how to use this knife subcommand:

**Edit an environment**

.. include:: ../../step_knife/step_knife_environment_edit.rst


from file
=====================================================
.. include:: ../../includes_knife/includes_knife_environment_from_file.rst

Syntax
-----------------------------------------------------
.. include:: ../../includes_knife/includes_knife_environment_from_file_syntax.rst

Options
-----------------------------------------------------
.. include:: ../../includes_knife/includes_knife_environment_from_file_options.rst

.. note:: .. include:: ../../includes_knife/includes_knife_common_see_all_config_options.rst

Examples
-----------------------------------------------------
The following examples show how to use this knife subcommand:

**Create an environment from a JSON file**

.. include:: ../../step_knife/step_knife_environment_from_file.rst


list
=====================================================
.. include:: ../../includes_knife/includes_knife_environment_list.rst

Syntax
-----------------------------------------------------
.. include:: ../../includes_knife/includes_knife_environment_list_syntax.rst

Options
-----------------------------------------------------
.. include:: ../../includes_knife/includes_knife_environment_list_options.rst

Examples
-----------------------------------------------------
The following examples show how to use this knife subcommand:

**View a list of environments**

.. include:: ../../step_knife/step_knife_environment_list.rst


show
=====================================================
.. include:: ../../includes_knife/includes_knife_environment_show.rst

Syntax
-----------------------------------------------------
.. include:: ../../includes_knife/includes_knife_environment_show_syntax.rst

Options
-----------------------------------------------------
.. include:: ../../includes_knife/includes_knife_environment_show_options.rst

Examples
-----------------------------------------------------
The following examples show how to use this knife subcommand:

**Show environments**

.. include:: ../../step_knife/step_knife_environment_show.rst

**Show environments as JSON**

.. include:: ../../step_knife/step_knife_environment_show_json.rst
