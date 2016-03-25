.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


Use the ``join-cluster`` subcommand to configure a node to be a member of the backend HA cluster as a peer of the node at the specified ``PEER_NODE_IP`` IP address. This command will query the existing cluster to identify any necessary configuration information. If the ``--publish-address`` and ``--vip-interface`` options are not specified, and are specified in ``chef-backend.rb``, the command will prompt with a list of items from which to choose.

This command will return an error message and a non-zero exit code when:

#. The ``--secrets-file-path`` option is specified, a non-empty secrets file already exists at ``/etc/chef-backend/secrets.json``, and the user declines to overwrite it.
#. The ``--secrets-file-path`` option is specified, but does not specify a valid file and/or the file at ``/etc/chef-backend/secrets.json`` is empty or does not exist.
#. The IP address specified by the ``--publish-address`` option does not exist on the node.
#. The interface specified by the ``--vip-interface`` option does not exist on the node.
#. Any IP address on the node is already registered in the backend HA cluster.
#. The node is already configured for the backend HA cluster and the ``--recovery`` option is not specified.
#. The ``--recovery`` option is specified, but no existing installation is found.
#. ``--publish-address`` and/or ``--vip-interface`` are specified, but a non-empty ``chef-backend.rb`` file already exists. (This command will not overwrite a ``chef-backend.rb`` file.)

If successful, this command will generate a ``chef-backend.rb`` file at ``/etc/chef-backend/chef-backend.rb`` with the values for the ``publish_address``, ``vip_interface``, and ``vip`` added automatically.
