.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


Run:

.. code-block:: bash

   $ chef generate repo --help

Returns:

.. code-block:: none

   Usage: chef generate repo NAME [options]
   
     -C, --copyright COPYRIGHT        Name of the copyright holder
     -m, --email EMAIL                Email address of the author
     -I, --license LICENSE            all_rights, apache2, mit, gplv2, gplv3
     -p, --policy-only                Create a repository for policy only, 
                                        not cookbooks
     -g GENERATOR_COOKBOOK_PATH,      Use GENERATOR_COOKBOOK_PATH for the 
                                        code_generator cookbook
        --generator-cookbook
