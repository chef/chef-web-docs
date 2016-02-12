.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics. 

To upgrade to |chef server| 12 from a high availability |chef server| server, do the following:

#. Verify that the ``make`` command is available on the primary backend |chef server| server. If it is not available, install the ``make`` command.

#. Run the following on all servers to make sure all services are in a sane state.

   .. code-block:: bash
      
      $ chef-server-ctl reconfigure

#. Stop all of the front end servers:

   .. code-block:: bash
      
      $ chef-server-ctl stop

#. Identify the name of the original non-bootstrap backend server. This is the back end server that does **not** have ``:bootstrap => true`` in ``/etc/opscode/private-chef.rb``.

#. Stop |keepalived| on the original non-bootstrap backend server. This will ensure that the bootstrap back end server is the active server. This action may trigger a failover.

   .. code-block:: bash
      
      $ chef-server-ctl stop keepalived

#. Run |debian dpkg| or |rpm| on all servers. For |debian dpkg|:

   .. code-block:: bash
      
      $ dpkg -D10 -i /path/to/chef-server-core-<version>.deb

   where ``-D`` enables debugging and ``10`` creates output for each file that is processed during the upgrade. See the man pages for |debian dpkg| for more information about this option.
   
   For |rpm|:

   .. code-block:: bash
      
      $ rpm -Uvh --nopostun /path/to/chef-server-core-<version>.rpm

#. On the primary back end server, stop all services except |keepalived|. With |chef server| 12, the |keepalived| service will not be stopped with the following command:

   .. code-block:: bash
      
      $ chef-server-ctl stop

   If the upgrade process times out, re-run the command until it finishes successfully.


#. Upgrade the back end primary server with the following command:

   .. code-block:: bash
      
      $ chef-server-ctl upgrade

   If the upgrade process times out, re-run the command until it finishes successfully.

#. Copy the entire ``/etc/opscode`` directory from the back end primary server to all front and back end nodes. For example, from each server run:

   .. code-block:: bash
      
      $ scp -r <Bootstrap server IP>:/etc/opscode /etc

   or from the back end primary server:

   .. code-block:: bash
      
      $ scp -r /etc/opscode <each servers IP>:/etc

#. Upgrade the back end secondary server with the following command:

   .. code-block:: bash
      
      $ chef-server-ctl upgrade

   In some instances, after the upgrade processes is complete, it may be required to stop |keepalived| on the back end secondary server, then restart |keepalived| on the back end primary server, and then restart |keepalived| on the back end secondary server.

#. Upgrade all front end servers with the following commands:

   .. code-block:: bash
      
      $ chef-server-ctl upgrade

#. Run the following command on all front end servers and the primary back end server:

   .. code-block:: bash
      
      $ chef-server-ctl start

   .. note:: Do not run this command on the secondary back-end server!

#. After the upgrade process is complete, the state of the system after the upgrade has been tested and verified, and everything looks satisfactory, remove old data, services, and configuration by running the following command on each server:

   .. code-block:: bash
      
      $ chef-server-ctl cleanup

   .. note:: The message ``[ERROR] opscode-chef-mover is not running`` is expected, does not indicate an actual error, and is safe to ignore.

#. .. include:: ../../includes_ctl_chef_server/includes_ctl_chef_server_install_features.rst

   **Use Downloads**

   .. include:: ../../includes_ctl_chef_server/includes_ctl_chef_server_install_features_download.rst

   **Use Local Packages**

   .. include:: ../../includes_ctl_chef_server/includes_ctl_chef_server_install_features_manual.rst


