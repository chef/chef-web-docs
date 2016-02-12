.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


This command has the following syntax:

.. code-block:: bash

   chef-shell OPTION VALUE OPTION VALUE ...

This command has the following options:

``-a``, ``--standalone``
   |chef_shell mode standalone|

``-c CONFIG``, ``--config CONFIG``
   |config chef-client|

``-h``, ``--help``
   |help subcommand|

``-j PATH``, ``--json-attributes PATH``
   |json attributes|

   .. include:: ../../includes_node/includes_node_ctl_run_list.rst

   .. warning:: .. include:: ../../includes_node/includes_node_ctl_attribute.rst

``-l LEVEL``, ``--log-level LEVEL``
   |log_level|

``-s``, ``--solo``
   |chef_shell mode solo|

``-S CHEF_SERVER_URL``, ``--server CHEF_SERVER_URL``
   |chef_server_url|

``-v``, ``--version``
   |version chef|

``-z``, ``--client``
   |chef_shell mode client|

