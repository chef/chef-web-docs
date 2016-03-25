.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


This subcommand has the following options:

``-i INTERFACE``, ``--vip-interface INTERFACE``
   The network interface to which the backend VIP will bind in the event that this node becomes leader. If not provided, and if not specified in ``chef-backend.rb``, this command will prompt to choose from a list of interfaces that are currently available on the node.

   .. note:: This option should only be used the first time a node joins the backend HA cluster.

``-p IP_ADDRESS``, ``--publish-address IP_ADDRESS``
   The IP address that is published within the backend HA cluster. This IP address must be accessible to all nodes in the backend HA cluster. If not provided, and if not specified in ``chef-backend.rb``, this command will prompt to choose from a list of IP addresses that are currently bound on the node.

   .. note:: This option should only be used the first time a node joins the backend HA cluster.

``--recovery``
  Force this node to rejoin the backend HA cluster if it has been removed via the ``chef-backend-ctl remove-node`` or ``chef-backend-ctl bootstrap --with-quorum-recovery`` commands.

   .. note:: This option will run against the existing ``chef-backend.rb`` file, which means the ``--vip-interface`` and ``--publish-address`` options should not be specified. (They are already defined in the ``chef-backend.rb`` file.)

``-s PATH``, ``--secrets-file-path PATH``
   The path to the location of the ``secrets.json`` file on the bootstrapping node. Default value: ``/etc/chef-backend/secrets.json``.

``-y``, ``--yes``
   |no_confirmation|
