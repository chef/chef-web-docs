.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


On back-end servers in a high availability topology, Keepalived is used by the clustering service to determine whether a service should be running. If the ``status`` subcommand is run against any of these nodes, a few things change:

* On the back-end node that is currently the backup server, it is normal to see only one running process: Keepalived
* On the back-end node that is currently the master server, it is normal to see all services running. It is also normal to see some services in a down state if the server, on reboot, did not attempt to start the services because Keepalived determines which services are restarted based on the state of the cluster

A sample status line for a service that is running on the master server in a high availability topology:

.. code-block:: bash

   run: opscode-solr4: (pid 25341) 239s, normally down; run: log: (pid 5700) 145308s
