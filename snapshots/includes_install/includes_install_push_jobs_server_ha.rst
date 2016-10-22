.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics. 

To set up the Chef push jobs server for a high availability configuration:

#. Install the package on all servers that are running the Chef server. For example on Ubuntu:

   .. code-block:: bash

      $ sudo dpkg -i opscode-push-jobs-server_2.1.0-1_amd64.deb

#. Reconfigure the primary backend Chef push jobs server:

   .. code-block:: bash

      $ opscode-push-jobs-server-ctl reconfigure

#. Copy the entire ``/etc/opscode-push-jobs-server`` directory from the backend primary to all frontend and backend servers. For example, from each server run:

   .. code-block:: bash
      
      $ scp -r <Bootstrap server IP>:/etc/opscode-push-jobs-server /etc

   or from the backend primary server:

   .. code-block:: bash
      
      $ scp -r /etc/opscode-push-jobs-server <each servers IP>:/etc

#. TCP protocol ports 10000 and 10003 must be open. These are the heartbeat and command ports respectively. They allow the Chef push jobs server to communicate with the Chef push jobs clients. In a configuration with both frontend and backend servers, these ports only need to be open on the backend servers. The Chef push jobs server waits for connections from the Chef push jobs client (and never makes a connection to a Chef push jobs client).

#. Reconfigure the remaining Chef push jobs servers:

   .. code-block:: bash

      $ opscode-push-jobs-server-ctl reconfigure

#. Run the following command on each of the backend servers:

   .. code-block:: bash

      $ chef-server-ctl reconfigure

   This ensures that the Keepalived scripts are regenerated so they are aware of Chef push jobs.

#. Restart all servers on which Chef push jobs will run:

   .. code-block:: bash

      $ chef-server-ctl restart opscode-pushy-server

#. Verify the installation:

   .. code-block:: bash

      $ opscode-push-jobs-server-ctl test
