.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics. 

To set up the |push jobs| server for a standalone configuration:

#. Install the |push jobs| server. For example on |ubuntu|:

   .. code-block:: bash

      $ dpkg -i opscode-push-jobs-server_0.0.1+20130307070157.git.98.c04f587-1.ubuntu.10.04_amd64.deb

   This step is required on each of the servers in the |chef server| deployment. For example, in a configuration with two backend servers and three frontend servers, this command would need to be run on all five servers.

#. TCP protocol ports 10000 and 10003 must be open. These are the heartbeat and command ports respectively. They allow the |push jobs| server to communicate with the |push jobs| clients. In a configuration with both frontend and backend servers, these ports only need to be open on the backend servers. The |push jobs| server waits for connections from the |push jobs| client (and never makes a connection to a |push jobs| client).

#. Reconfigure the |push jobs| servers:

   .. code-block:: bash

      $ opscode-push-jobs-server-ctl reconfigure

   This step is required for each of the servers in the |chef server| deployment. After this has been completed, run the following command on each of the backend servers:

   .. code-block:: bash

      $ chef-server-ctl reconfigure

   This ensures that the |keepalived| scripts are regenerated so they are aware of |push jobs|.

#. Restart the |push jobs| components:

   .. code-block:: bash

      $ chef-server-ctl restart opscode-pushy-server

#. Verify the installation:

   .. code-block:: bash

      $ opscode-push-jobs-server-ctl test
