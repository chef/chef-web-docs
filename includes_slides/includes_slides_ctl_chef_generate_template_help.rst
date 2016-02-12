.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


Run:

.. code-block:: bash

   $ chef generate template --help

Returns:

.. code-block:: bash

   Usage: chef generate template [path/to/cookbook] NAME [options]
     -C, --copyright COPYRIGHT        Name of the copyright holder - defaults to 'The Authors'
     -m, --email EMAIL                Email address of the author - defaults to 'you@example.com'
     -I, --license LICENSE            all_rights, apache2, mit, gplv2, gplv3 - defaults to all_rights
     -s, --source SOURCE_FILE         Copy content from SOURCE_FILE
     -g GENERATOR_COOKBOOK_PATH,      Use GENERATOR_COOKBOOK_PATH for the code_generator cookbook
        --generator-cookbook
