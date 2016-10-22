.. THIS PAGE DOCUMENTS Open Source Chef server version 11.1

=====================================================
Install Open Source Chef
=====================================================

The Open Source Chef server may be installed in a standalone configuration. This creates a working installation on a single server. This approach is also useful for installing the Chef server in a virtual machine, for proof-of-concept deployments, or as a part of a development or testing loop.

To install the Open Source Chef server:

#. Upload the package provided to the server on which the Chef server will be installed, and then record its location on the file system. The rest of this section assumes this location is in ``/tmp`` directory.

#. Install the Chef server package on the server, using the name of the package provided by Chef. For Red Hat and CentOS 6:

   .. code-block:: bash
      
      $ rpm -Uvh /tmp/chef-server-core-<version>.rpm

   For Ubuntu:

   .. code-block:: bash
      
      $ dpkg -i /tmp/chef-server-core-<version>.deb

   The Chef server is now installed on the server.

#. Run the following to start all of the services:

   .. code-block:: bash
      
      $ chef-server-ctl reconfigure

   Because the Chef server is composed of many different services that work together to create a functioning system, this step may take a few minutes to complete.




