.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


The ``cleanse`` subcommand is used to re-set the |chef manage| to the state it was in prior to the first time the ``reconfigure`` subcommand is run. This command will destroy all data, configuration files, and logs. The software that was put on-disk by the package installation will remain; re-run ``opscode-manage-ctl reconfigure`` to recreate the default data and configuration files.

This subcommand has the following syntax:

.. code-block:: bash

   $ opscode-manage-ctl cleanse
