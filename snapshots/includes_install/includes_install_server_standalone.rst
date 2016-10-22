.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


The standalone installation of Chef server creates a working installation on a single server. This installation is also useful when you are installing Chef server in a virtual machine, for proof-of-concept deployments, or as a part of a development or testing loop.

To install Chef server 12:

#. Download the package from http://downloads.chef.io/chef-server/.
#. Upload the package to the machine that will run the Chef server, and then record its location on the file system. The rest of these steps assume this location is in the ``/tmp`` directory.

#. .. include:: ../../step_install/step_install_chef_server_install_package.rst

#. Run the following to start all of the services:

   .. code-block:: bash
      
      $ chef-server-ctl reconfigure

   Because the Chef server is composed of many different services that work together to create a functioning system, this step may take a few minutes to complete.

#. .. include:: ../../step_ctl_chef_server/step_ctl_chef_server_user_create_admin.rst

#. .. include:: ../../step_ctl_chef_server/step_ctl_chef_server_org_create.rst
 
#. .. include:: ../../includes_ctl_chef_server/includes_ctl_chef_server_install_features.rst

   **Use Downloads**

   .. include:: ../../includes_ctl_chef_server/includes_ctl_chef_server_install_features_download.rst

   **Use Local Packages**

   .. include:: ../../includes_ctl_chef_server/includes_ctl_chef_server_install_features_manual.rst

