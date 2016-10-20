.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


This subcommand has the following syntax:

.. code-block:: bash

   $ delivery token (options)

.. note:: You can also pass in your Chef Automate password through an environment variable to the `delivery token` subcommand. If this variable is set, you will not be asked to input your password.

   .. code-block:: bash

      $ AUTOMATE_PASSWORD=secret delivery token -s automate.example.com -e myent -u token
