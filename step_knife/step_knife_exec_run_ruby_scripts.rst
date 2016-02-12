.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


There are three ways to use |subcommand knife exec| to run |ruby| script files. For example:

.. code-block:: bash

   $ knife exec /path/to/script_file

or:

.. code-block:: bash

   $ knife exec -E 'RUBY CODE'

or:

.. code-block:: bash

   $ knife exec
   RUBY CODE
   ^D