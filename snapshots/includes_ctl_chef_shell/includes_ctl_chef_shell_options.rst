.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


This command has the following syntax:

.. code-block:: bash

   chef-shell OPTION VALUE OPTION VALUE ...

This command has the following options:

``-a``, ``--standalone``
   Run chef-shell in standalone mode.

``-c CONFIG``, ``--config CONFIG``
   The configuration file to use.

``-h``, ``--help``
   Show help for the command.

``-j PATH``, ``--json-attributes PATH``
   The path to a file that contains JSON data.

   .. include:: ../../includes_node/includes_node_ctl_run_list.rst

   .. warning:: .. include:: ../../includes_node/includes_node_ctl_attribute.rst

``-l LEVEL``, ``--log-level LEVEL``
   The level of logging to be stored in a log file.

``-s``, ``--solo``
   Run chef-shell in chef-solo mode.

``-S CHEF_SERVER_URL``, ``--server CHEF_SERVER_URL``
   The URL for the Chef server.

``-v``, ``--version``
   The version of the chef-client.

``-z``, ``--client``
   Run chef-shell in chef-client mode.

