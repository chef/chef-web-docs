.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


Before you use the |chef delivery| CLI from a workstation, you need to provide it with details such as the URL of the Delivery server, and the names of the relevant enterprise, organization, and user. The ``delivery setup`` subcommand creates a configuration file named ``.delivery/cli.toml`` with the required information.
 
The placement of the ``.delivery`` directory in your file hierarchy is significant. Like Git, |chef delivery| CLI commands search the current directory and parent directories to locate server settings. Because server settings are unique to an organization, we recommend that you create a directory for each organization you belong to and run the ``delivery setup`` command from that directory.

.. code-block:: bash

   $ delivery setup --server=DELIVERY_SERVER_IP_ADDR --ent=ENTERPRISE --org=ORGANIZATION --user=USERNAME
