.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


The chef-client can be run as a daemon. Use the **chef-client** cookbook to configure the chef-client as a daemon. Add the ``default`` recipe to a node's run-list, and then use attributes in that cookbook to configure the behavior of the chef-client. For more information about these configuration options, see the `chef-client cookbook repository on github <https://github.com/chef-cookbooks/chef-client/>`_.

When the chef-client is run as a daemon, the following signals may be used:

``HUP``
   Use to reconfigure the chef-client.

``INT``
   Use to terminate immediately without waiting for the current chef-client run to finish.

``QUIT``
   Use to dump a stack trace, and continue to run.

``TERM``
   Use to terminate but wait for the current chef-client run to finish, and then exit.

``USR1``
   Use to wake up sleeping chef-client and trigger node convergence.

On Microsoft Windows, both the ``HUP`` and ``QUIT`` signals are not supported.
