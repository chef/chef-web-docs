.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


To set up the Reporting server:

#. Install the package on each frontend and backend Chef server:

   .. code-block:: bash
      
      $ chef-server-ctl install opscode-reporting

#. Reconfigure the Chef server on the backend primary server (bootstrap):

   .. code-block:: bash

      $ chef-server-ctl reconfigure

#. Reconfigure the Reporting server on the backend primary server (bootstrap):

   .. code-block:: bash

      $ opscode-reporting-ctl reconfigure

   .. note:: Starting with Reporting 1.6.0, the `Chef MLSA <https://docs.chef.io/chef_license.html>`__ must be accepted when reconfiguring the product. If the Chef MLSA has not already been accepted, the reconfigure process will prompt for a ``yes`` to accept it. Or run ``opscode-reporting-ctl reconfigure --accept-license`` to automatically accept the license.

#. Copy the entire ``/etc/opscode-reporting`` directory from the backend primary server to all frontend and backend servers. For example, from each server run:

   .. code-block:: bash
      
      $ scp -r <Bootstrap server IP>:/etc/opscode-reporting /etc

   or from the backend primary server:

   .. code-block:: bash
      
      $ scp -r /etc/opscode-reporting <each servers IP>:/etc

#. Reconfigure any Chef server on which Reporting services have been installed:

   .. code-block:: bash

      $ chef-server-ctl reconfigure

#. Reconfigure Reporting services on each server:

   .. code-block:: bash

      $ opscode-reporting-ctl reconfigure

#. Verify the installation:

   .. code-block:: bash

      $ opscode-reporting-ctl test
