.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics. 

To upgrade to |chef server| 12 from a standalone |chef server oec| server, do the following:

#. Verify that the ``make`` command is available on the |chef server oec| server. If it is not available, install the ``make`` command.

#. Run the following command to make sure all services are in a sane state.

   .. code-block:: bash
      
      $ private-chef-ctl reconfigure

#. Stop the server:

   .. code-block:: bash
      
      $ private-chef-ctl stop

#. Run |debian dpkg| or |rpm|. For |debian dpkg|:

   .. code-block:: bash
      
      $ dpkg -D10 -i /path/to/chef-server-core-<version>.deb

   where ``-D`` enables debugging and ``10`` creates output for each file that is processed during the upgrade. See the man pages for |debian dpkg| for more information about this option.
   
   For |rpm|:

   .. code-block:: bash
      
      $ rpm -Uvh --nopostun /path/to/chef-server-core-<version>.rpm

#. Upgrade the server with the following command:

   .. code-block:: bash
      
      $ chef-server-ctl upgrade

#. Start |chef server| 12:

   .. code-block:: bash
      
      $ chef-server-ctl start

#. After the upgrade process is complete and everything is tested and verified to be working properly, clean up the server by removing all of the old data:

   .. code-block:: bash
      
      $ chef-server-ctl cleanup

#. .. include:: ../../includes_ctl_chef_server/includes_ctl_chef_server_install_features.rst

   **Use Downloads**

   .. include:: ../../includes_ctl_chef_server/includes_ctl_chef_server_install_features_download.rst

   **Use Local Packages**

   .. include:: ../../includes_ctl_chef_server/includes_ctl_chef_server_install_features_manual.rst


