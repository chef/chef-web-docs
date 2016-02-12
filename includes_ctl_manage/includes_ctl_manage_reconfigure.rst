.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


The ``reconfigure`` subcommand is used when changes are made to the |manage rb| file to reconfigure the server. When changes are made to the |manage rb| file, they will not be applied to the |chef manage| configuration until after this command is run.

This subcommand has the following syntax:

.. code-block:: bash

   $ opscode-manage-ctl reconfigure
