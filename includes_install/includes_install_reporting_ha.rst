.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


To set up the |reporting| server:

#. Install the package on each frontend and backend |chef server|:

   .. code-block:: bash
      
      $ chef-server-ctl install opscode-reporting

#. Reconfigure the |chef server| on the backend primary server (bootstrap):

   .. code-block:: bash

      $ chef-server-ctl reconfigure

#. Reconfigure the |reporting| server on the backend primary server (bootstrap):

   .. code-block:: bash

      $ opscode-reporting-ctl reconfigure

#. Copy the entire ``/etc/opscode-reporting`` directory from the backend primary server to all frontend and backend servers. For example, from each server run:

   .. code-block:: bash
      
      $ scp -r <Bootstrap server IP>:/etc/opscode-reporting /etc

   or from the backend primary server:

   .. code-block:: bash
      
      $ scp -r /etc/opscode-reporting <each servers IP>:/etc

#. Reconfigure any |chef server| on which |reporting| services have been installed:

   .. code-block:: bash

      $ chef-server-ctl reconfigure

#. Reconfigure |reporting| services on each server:

   .. code-block:: bash

      $ opscode-reporting-ctl reconfigure

#. Verify the installation:

   .. code-block:: bash

      $ opscode-reporting-ctl test
