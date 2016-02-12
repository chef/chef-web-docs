.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


The standalone installation of |chef server| creates a working installation on a single server. This installation is also useful when you are installing |chef server| in a virtual machine, for proof-of-concept deployments, or as a part of a development or testing loop.

To install |chef server| 12:

#. Download the package from http://downloads.chef.io/chef-server/.
#. Upload the package to the machine that will run the |chef server|, and then record its location on the file system. The rest of these steps assume this location is in the ``/tmp`` directory.

#. Install the |chef server| package on the server, using the name of the package provided by |company_name|. For |redhat| and |centos| 6:

   .. code-block:: bash
      
      $ rpm -Uvh /tmp/chef-server-core-<version>.rpm

   For |ubuntu|:

   .. code-block:: bash
      
      $ dpkg -i /tmp/chef-server-core-<version>.deb

   After a few minutes, the |chef server| will be installed.

#. Run the following to start all of the services:

   .. code-block:: bash
      
      $ chef-server-ctl reconfigure

   Because the |chef server| is composed of many different services that work together to create a functioning system, this step may take a few minutes to complete.

#. .. include:: ../../step_ctl_chef_server/step_ctl_chef_server_user_create_admin.rst

#. .. include:: ../../step_ctl_chef_server/step_ctl_chef_server_org_create.rst
 
#. .. include:: ../../includes_ctl_chef_server/includes_ctl_chef_server_install_features.rst

   **Use Downloads**

   .. include:: ../../includes_ctl_chef_server/includes_ctl_chef_server_install_features_download.rst

   **Use Local Packages**

   .. include:: ../../includes_ctl_chef_server/includes_ctl_chef_server_install_features_manual.rst

