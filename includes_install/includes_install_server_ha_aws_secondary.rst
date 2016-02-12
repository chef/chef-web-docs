.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

Use the following steps to set up the secondary backend |chef server|:

#. Install the ``chef-server-core`` package. For |redhat| and |centos| 6:

   .. code-block:: bash
      
      $ rpm -Uvh /tmp/chef-server-core-<version>.rpm

   For |ubuntu|:

   .. code-block:: bash
      
      $ dpkg -i /tmp/chef-server-core-<version>.deb

   After a few minutes, the |chef server| will be installed.
#. Install ``chef-ha`` package. For |redhat| and |centos| 6:

   .. code-block:: bash
      
      $ rpm -Uvh /tmp/chef-ha-<version>.rpm

   For |ubuntu|:

   .. code-block:: bash
      
      $ dpkg -i /tmp/chef-ha-<version>.deb

#. Install |lvm| tools. For |redhat| and |centos| 6:

   .. code-block:: bash
      
      $ sudo yum install lvm2

   For |ubuntu|:

   .. code-block:: bash
      
      $ sudo apt-get install lvm2

#. Create the ``/etc/opscode/`` directory, and then copy the contents of the entire ``/etc/opscode`` directory from the primary server, including all certificates and the |chef server rb|.

#. .. include:: ../../step_install/step_install_chef_server_reconfigure.rst

   This will reconfigure the |chef server|, start |keepalived|, and configure it as the secondary backend server.

#. Verify the secondary backend server:

   .. code-block:: bash
      
      $ sudo chef-server-ctl ha-status

   This should indicate that the server is ``BACKUP``.
