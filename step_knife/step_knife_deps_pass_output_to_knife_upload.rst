.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


The output of |subcommand knife deps| can be passed to |subcommand knife upload|:

.. code-block:: bash

   $ knife upload `knife deps nodes/*.json
