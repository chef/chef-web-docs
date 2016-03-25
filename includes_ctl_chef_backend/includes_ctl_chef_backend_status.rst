.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


Use the ``status`` subcommand to show the status of all services available to a node in the backend HA cluster. This subcommand has the following syntax:

.. code-block:: bash

   $ chef-backend-ctl status

and will return the status for all services. Status can be returned for individual services by specifying the name of the service as part of the command:

.. code-block:: bash

   $ chef-backend-ctl status SERVICE_NAME

For example, full output:

.. code-block:: bash

   $ chef-backend-ctl status

is similar to:

.. code-block:: bash

   Service        Local Status        Time in State  Distributed Node Status 
   elasticsearch  running (pid 6661)  1d 5h 59m 41s  state: green; nodes online: 3/3
   etcd           running (pid 6742)  1d 5h 59m 39s  health: green; healthy nodes: 3/3 
   leaderl        running (pid 6788)  1d 5h 59m 35s  leader: 1; waiting: 0; follower: 2; total: 3
   postgresql     running (pid 6640)  1d 5h 59m 43s  leader: 1; offline: 0; syncing: 0; synced: 2

which shows status for a healthy backend HA cluster. The first three columns--``Service``, ``Local Status``, and ``Time in State`` summarize the local state. The ``Distributed Node Status`` columm shows:

* A three node cluster
* All nodes healthy and online
* A leader selected with two followers (for both leader/follower status for the ``leaderl`` service and a leader/synced state for the ``postgresql`` service)

Simple output:

.. code-block:: bash

   $ chef-backend-ctl status --simple

is similar to:

.. code-block:: bash

   run: elasticsearch: (pid 6661) 106983s; run: log: (pid 6667) 106983s
   run: etcd: (pid 6742) 106981s; run: log: (pid 6630) 106984s
   run: leaderl: (pid 6788) 106976s; run: log: (pid 6739) 106982s
   run: postgresql: (pid 6640) 106984s; run: log: (pid 6653) 106983s

which shows the state of the services, process identifiers, and uptime (in seconds). Simple output is useful if one (or more) nodes in the backend HA cluster are down or in a degraded state.
