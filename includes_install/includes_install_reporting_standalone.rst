.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


To set up the |reporting| server:

#. Install the package on the |chef server|:

   .. code-block:: bash

      $ chef-server-ctl install opscode-reporting

#. Reconfigure the |chef server|:

   .. code-block:: bash

      $ chef-server-ctl reconfigure

#. Reconfigure |reporting| services on each server:

   .. code-block:: bash

      $ opscode-reporting-ctl reconfigure

   .. note:: .. include:: ../../includes_chef_license/includes_chef_license_reconfigure_reporting.rst

#. Verify the installation:

   .. code-block:: bash

      $ opscode-reporting-ctl test
