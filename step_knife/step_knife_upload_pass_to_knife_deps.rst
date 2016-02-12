.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

.. Use the output of |subcommand knife deps| to pass a command to |subcommand knife upload|. For example:

.. code-block:: bash

   $ knife upload `knife deps nodes/*.json`
