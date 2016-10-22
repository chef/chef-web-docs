.. THIS PAGE DOCUMENTS chef-client version 11.16

=====================================================
Install Chef 11.x on a Workstation
=====================================================

.. include:: ../../includes_chef/includes_chef.rst

The omnibus installer is used to set up a workstation. The omnibus installer uses a single command to install the chef-client and all of its dependencies, including an embedded version of Ruby, RubyGems, OpenSSL, key-value stores, parsers, libraries, and command line utilities. The omnibus installer puts everything into a unique directory (``opt/opscode/``) so that the chef-client will not interfere with other applications that may be running on the target machine. Once installed, the chef-client requires a few more configuration steps before it can be run as a workstation.

.. note:: The omnibus installer requires that an installation be done as a root user.

The following sections describe how to install the chef-client on a workstation. The steps for installing the chef-client on a machine that runs Linux, UNIX, or Mac OS X are identical:

#. Identify the Chef server type: Open Source Chef, hosted Enterprise Chef, or Enterprise Chef
#. Review the prerequisites
#. Select the omnibus installer
#. Run the omnibus installer
#. Install git
#. Set up the chef-repo
#. Create the .chef directory
#. Get the .pem files and knife.rb files
#. Move files to the .chef directory
#. Add omnibus Ruby to the $PATH environment variable
#. Verify the chef-client install

See the following sections for more information about each step.

Identify the Chef server type
=====================================================
The chef-client communicates with a Chef server as part of the configuration process. Sign up for hosted Enterprise Chef, install Enterprise Chef, or install the open source Chef server.

Review prerequisites
=====================================================
Ensure that the workstation meets all of the software prerequisites and that it has access to a Chef server and to a machine that can host a node.

The following items are prerequisites for installing the chef-client on a workstation:

* A computer running UNIX, Linux, Mac OS X or Microsoft Windows; (for installing the chef-client on Microsoft Windows, see :doc:`install_windows`)
* Apple XCode is installed on machines running Mac OS X; this application can be downloaded from Apple for free
* A GitHub account; the chef-repo must be downloaded and/or cloned from GitHub
* Access to a Chef server: a hosted Enterprise Chef account, a local install of Enterprise Chef, or the open source Chef server
* Access to a machine (physical or virtual) that can be used as the first node; the FQDN or IP address for a machine is required by the ``knife bootstrap`` command during a bootstrap operation

Select the omnibus installer
=====================================================
The bits for the chef-client omnibus installer are available as a download from Chef.

To download the omnibus installer for the chef-client:

#. Go to: |url chef_install|.
#. Select the operating system, version, and architecture appropriate for your environment.
#. Identify the URL that will be used to download the package or download the package directly.

Run the omnibus installer
=====================================================
To install the chef-client on a workstation, you must run the omnibus installer. To run the omnibus installer:

#. Run the command that appears (for UNIX and Linux environments) or download the omnibus installer (for Microsoft Windows environments). For example, for the Mac OS X:

   .. code-block:: bash

      curl -L https://www.chef.io/chef/install.sh | sudo bash

   and then enter the password for the local machine.
#. As the chef-client is being installed, the command window will show something like the following:

   .. code-block:: bash

      Downloading Chef for mac_os_x...
        % Total    % Received  % Xferd   Average  Speed    Time     Time      Time   Current
                                         Dload   Upload    Total    Spent     Left   Speed
      100 23.9M  100 23.9M     0     0    944k       0   0:00:26  0:00:26  --:--:--   838k
      Installing Chef

#. When the installation is finished enter the following to verify that the chef-client was installed:

   .. code-block:: bash

      chef-client -v

   When the chef-client is installed correctly, the command shell will return a note that says the version of that was installed. For example:

   .. code-block:: bash

      Chef: 11.4.0

#. After the chef-client has been installed, the following folder structure will be present on the local machine::

      /opt
         /chef
            /bin
            /embedded
               /bin
               /include
               /lib
               /share
               /ssl


Install git
=====================================================
An open source distributed version control system called git must be installed before the chef-repo can be cloned to the workstation from GitHub. 

To install git:

#. Go to the following URL: https://help.github.com/articles/set-up-git.
   
#. Follow the directions, install git (http://git-scm.com/downloads), and then complete the remaining configuration steps on that page. 

.. note:: It is not necessary to create or fork a repository in order to clone the chef-repo from GitHub.

Set up the chef-repo
=====================================================
There are two ways to create the chef-repo:

* Use the starter kit built into the Enterprise Chef web user interface
* Manually

Starter Kit
-----------------------------------------------------
If you have access to Enterprise Chef (hosted or on premises), you can download the starter kit. The starter kit will create the necessary configuration files---the .chef directory, knife.rb, the ORGANIZATION-validator.pem, and USER.pem files) with the correct information that is required to interact with the Chef server. Simply download the starter kit and then move it to the desired location on your workstation.

Manually
-----------------------------------------------------
Use the following steps to manually set up the chef-repo:

Clone the chef-repo
+++++++++++++++++++++++++++++++++++++++++++++++++++++
The chef-repo on GitHub must be cloned to every workstation that will interact with a Chef server.

To clone the chef-repo:

#. In a command window, open the home directory:

   .. code-block:: bash

      $ cd ~

   and then clone the chef-repo:

   .. code-block:: bash

      $ git clone git://github.com/chef/chef-repo.git

#. While the chef-repo is being cloned on the local machine, the command window will show something like the following:

   .. code-block:: bash

      Cloning into 'chef-repo'...
      remote: Counting objects: 199, done.
      remote: Compressing objects: 100% (119/119), done.
      remote: Total 199 (delta 71), reused 160 (delta 47)
      Receiving objects: 100% (199/199), 30.45 KiB, done.
      Resolving deltas: 100% (71/71), done.

#. After the chef-repo has been cloned, the following folder structure will be present on the local machine::

      chef-repo/
         certificates/
         config/
         cookbooks/
         data_bags
         environments/
         roles/


Create .chef Directory
+++++++++++++++++++++++++++++++++++++++++++++++++++++
The .chef directory is used to store three files:

* knife.rb
* ORGANIZATION-validator.pem
* USER.pem

Where ``ORGANIZATION`` and ``USER`` represent strings that are unique to each organization. These files must be present in the .chef directory in order for a workstation to be able to connect to a Chef server.

To create the .chef directory:

#. In a command window, enter the following:

   .. code-block:: bash

      sudo mkdir -p ~/chef-repo/.chef

   .. note:: ``sudo`` is not always required, but it often is.

#. After the .chef directory has been created, the following folder structure will be present on the local machine::

      chef-repo/
         .chef/        << the hidden directory
         certificates/
         config/
         cookbooks/
         data_bags
         environments/
         roles/

#. Add ``.chef`` to the ``.gitignore`` file to prevent uploading the contents of the ``.chef`` folder to GitHub. For example:

   .. code-block:: bash

      $ echo '.chef' >> ~/chef-repo/.gitignore


Get Config Files
+++++++++++++++++++++++++++++++++++++++++++++++++++++
The Chef server provides three files that must be in the chef-repo and are required when connecting to the Chef server.

**Enterprise Chef**

For a workstation that will interact with Enterprise Chef (including hosted Enterprise Chef), log on and download the following files:

* knife.rb. This configuration file can be downloaded from the **Organizations** page.
* ORGANIZATION-validator.pem. This private key can be downloaded from the **Organizations** page.
* USER.pem. This private key an be downloaded from the **Change Password** section of the **Account Management** page.

**Open Source Chef Server**

For a workstation that will interact with the open source Chef server, do the following:

* Create a knife.rb file. This `configuration file <https://docs.chef.io/config_rb_knife.html>`_ must be created by running ``knife configure --initial`` on the machine that will be run as a workstation. The ``validation_key`` attribute in the knife.rb file must specify the path to the validation key. The ``validation_client_name`` attribute defaults to ``chef-validator`` (which is the chef-validator.pem private key created by the open source Chef server on startup). When prompted for the URL for the Chef server, use the FQDN for the Chef server.
* Create a USER.pem file. (This private key is created at the same time as the knife.rb file when running ``knife configure --initial``.)
* Find the chef-validator.pem file on the open source Chef server. This private key is created by the open source Chef server on startup and is located in the ``/etc/chef-server`` folder on the server after it is created.

These files will be moved into the .chef directory, which is a hidden directory that must be created in the chef-repo.

Move Config Files
+++++++++++++++++++++++++++++++++++++++++++++++++++++
The knife.rb, ORGANIZATION-validator.pem, and USER.pem files must be moved to the .chef directory after they are downloaded from the Chef server.

To move files to the .chef directory:

#. In a command window, enter each of the following:

   .. code-block:: bash

      cp /path/to/knife.rb ~/chef-repo/.chef

   and:

   .. code-block:: bash

      cp /path/to/ORGANIZATION-validator.pem ~/chef-repo/.chef

   and:

   .. code-block:: bash

      cp /path/to/USERNAME.pem ~/chef-repo/.chef

   where ``/path/to/`` represents the path to the location in which these three files were placed after they were downloaded.

#. Verify that the files are in the .chef folder.

Add Ruby to the $PATH environment variable
=====================================================
The chef-client includes a stable version of Ruby as part of the omnibus installer. The path to this version of Ruby must be added to the ``$PATH`` environment variable and saved in the configuration file for the command shell (Bash, csh, and so on) that is used on the workstation. In a command window, type the following:

.. code-block:: bash

   echo 'export PATH="/opt/chef/embedded/bin:$PATH"' >> ~/.configuration_file && source ~/.configuration_file

where ``configuration_file`` is the name of the configuration file for the specific command shell. For example, if Bash were the command shell and the configuration file were named ``bash_profile``, the command would look something like the following:

.. code-block:: bash

   echo 'export PATH="/opt/chef/embedded/bin:$PATH"' >> ~/.bash_profile && source ~/.bash_profile

Verify the chef-client install
=====================================================
A workstation is installed correctly when it is able to use knife to communicate with the Chef server.

To verify that a workstation can connect to the Chef server:

#. In a command window, navigate to the chef-repo:

   .. code-block:: bash

      cd ~/chef-repo

#. In a command window, enter the following:

   .. code-block:: bash

      knife client list

   to return a list of clients (registered nodes and workstations) that have access to the Chef server. For example:

   .. code-block:: bash

       workstation
       registered_node

