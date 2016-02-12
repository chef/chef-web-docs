.. THIS PAGE DOCUMENTS chef-client version 11.14

=====================================================
Install Chef 11.x on a Workstation
=====================================================

.. include:: ../../includes_chef/includes_chef.rst

The |omnibus installer| is used to set up a workstation. The |omnibus installer| uses a single command to install the |chef client| and all of its dependencies, including an embedded version of |ruby|, |rubygems|, |open ssl|, key-value stores, parsers, libraries, and command line utilities. The |omnibus installer| puts everything into a unique directory (``opt/opscode/``) so that the |chef client| will not interfere with other applications that may be running on the target machine. Once installed, the |chef client| requires a few more configuration steps before it can be run as a workstation.

.. note:: The |omnibus installer| requires that an installation be done as a root user.

The following sections describe how to install the |chef client| on a workstation. The steps for installing the |chef client| on a machine that runs |linux|, |unix|, or |mac os x| are identical:

#. Identify the |chef server| type: |chef server osc|, hosted |chef server oec|, or |chef server oec|
#. Review the prerequisites
#. Select the |omnibus installer|
#. Run the |omnibus installer|
#. Install |git|
#. Set up the |chef repo|
#. Create the |chef repo hidden| directory
#. Get the .pem files and |knife rb| files
#. Move files to the |chef repo hidden| directory
#. Add omnibus |ruby| to the $PATH environment variable
#. Verify the |chef client| install

See the following sections for more information about each step.

Identify the |chef server| type
=====================================================
The |chef client| communicates with a |chef server| as part of the configuration process. Sign up for hosted |chef server oec|, install |chef server oec|, or install the open source |chef server|.

Review prerequisites
=====================================================
Ensure that the workstation meets all of the software prerequisites and that it has access to a |chef server| and to a machine that can host a node.

The following items are prerequisites for installing the |chef client| on a workstation:

* A computer running |unix|, |linux|, |mac os x| or |windows|; (for installing the |chef client| on |windows|, see :doc:`install_windows`)
* |apple xcode| is installed on machines running |mac os x|; this application can be downloaded from |apple| for free
* A |github| account; the |chef repo| must be downloaded and/or cloned from |github|
* Access to a |chef server|: a hosted |chef server oec| account, a local install of |chef server oec|, or the open source |chef server|
* Access to a machine (physical or virtual) that can be used as the first node; the |fqdn| or IP address for a machine is required by the |subcommand knife bootstrap| command during a bootstrap operation

Select the |omnibus installer|
=====================================================
The bits for the |chef client| |omnibus installer| are available as a download from |company_name|.

To download the |omnibus installer| for the |chef client|:

#. Go to: |url chef_install|.
#. Select the operating system, version, and architecture appropriate for your environment.
#. Identify the URL that will be used to download the package or download the package directly.

Run the |omnibus installer|
=====================================================
To install the |chef client| on a workstation, you must run the |omnibus installer|. To run the |omnibus installer|:

#. Run the command that appears (for |unix| and |linux| environments) or download the |omnibus installer| (for |windows| environments). For example, for the |mac os x|:

   .. code-block:: bash

      curl -L https://www.chef.io/chef/install.sh | sudo bash

   and then enter the password for the local machine.
#. As the |chef client| is being installed, the command window will show something like the following:

   .. code-block:: bash

      Downloading Chef for mac_os_x...
        % Total    % Received  % Xferd   Average  Speed    Time     Time      Time   Current
                                         Dload   Upload    Total    Spent     Left   Speed
      100 23.9M  100 23.9M     0     0    944k       0   0:00:26  0:00:26  --:--:--   838k
      Installing Chef

#. When the installation is finished enter the following to verify that the |chef client| was installed:

   .. code-block:: bash

      chef-client -v

   When the |chef client| is installed correctly, the command shell will return a note that says the version of that was installed. For example:

   .. code-block:: bash

      Chef: 11.4.0

#. After the |chef client| has been installed, the following folder structure will be present on the local machine::

      /opt
         /chef
            /bin
            /embedded
               /bin
               /include
               /lib
               /share
               /ssl


Install |git|
=====================================================
An open source distributed version control system called |git| must be installed before the |chef repo| can be cloned to the workstation from |github|. 

To install |git|:

#. Go to the following URL: https://help.github.com/articles/set-up-git.
   
#. Follow the directions, install |git| (http://git-scm.com/downloads), and then complete the remaining configuration steps on that page. 

.. note:: It is not necessary to create or fork a repository in order to clone the |chef repo| from |github|.

Set up the |chef repo|
=====================================================
There are two ways to create the |chef repo|:

* Use the starter kit built into the |chef server oec| web user interface
* Manually

Starter Kit
-----------------------------------------------------
If you have access to |chef server oec| (hosted or on premises), you can download the starter kit. The starter kit will create the necessary configuration files---the |chef repo hidden| directory, |knife rb|, the |organization pem|, and |user pem| files) with the correct information that is required to interact with the |chef server|. Simply download the starter kit and then move it to the desired location on your workstation.

Manually
-----------------------------------------------------
Use the following steps to manually set up the |chef repo|:

Clone the |chef repo|
+++++++++++++++++++++++++++++++++++++++++++++++++++++
The |chef repo| on |github| must be cloned to every workstation that will interact with a |chef server|.

To clone the |chef repo|:

#. In a command window, open the home directory:

   .. code-block:: bash

      $ cd ~

   and then clone the |chef repo|:

   .. code-block:: bash

      $ git clone git://github.com/chef/chef-repo.git

#. While the |chef repo| is being cloned on the local machine, the command window will show something like the following:

   .. code-block:: bash

      Cloning into 'chef-repo'...
      remote: Counting objects: 199, done.
      remote: Compressing objects: 100% (119/119), done.
      remote: Total 199 (delta 71), reused 160 (delta 47)
      Receiving objects: 100% (199/199), 30.45 KiB, done.
      Resolving deltas: 100% (71/71), done.

#. After the |chef repo| has been cloned, the following folder structure will be present on the local machine::

      chef-repo/
         certificates/
         config/
         cookbooks/
         data_bags
         environments/
         roles/


Create .chef Directory
+++++++++++++++++++++++++++++++++++++++++++++++++++++
The |chef repo hidden| directory is used to store three files:

* |knife rb|
* |organization pem|
* |user pem|

Where ``ORGANIZATION`` and ``USER`` represent strings that are unique to each organization. These files must be present in the |chef repo hidden| directory in order for a workstation to be able to connect to a |chef server|.

To create the |chef repo hidden| directory:

#. In a command window, enter the following:

   .. code-block:: bash

      sudo mkdir -p ~/chef-repo/.chef

   .. note:: ``sudo`` is not always required, but it often is.

#. After the |chef repo hidden| directory has been created, the following folder structure will be present on the local machine::

      chef-repo/
         .chef/        << the hidden directory
         certificates/
         config/
         cookbooks/
         data_bags
         environments/
         roles/

#. Add ``.chef`` to the ``.gitignore`` file to prevent uploading the contents of the ``.chef`` folder to |github|. For example:

   .. code-block:: bash

      $ echo '.chef' >> ~/chef-repo/.gitignore


Get Config Files
+++++++++++++++++++++++++++++++++++++++++++++++++++++
The |chef server| provides three files that must be in the |chef repo| and are required when connecting to the |chef server|.

**Enterprise Chef**

For a workstation that will interact with |chef server oec| (including hosted |chef server oec|), log on and download the following files:

* |knife rb|. This configuration file can be downloaded from the **Organizations** page.
* |organization pem|. This private key can be downloaded from the **Organizations** page.
* |user pem|. This private key an be downloaded from the **Change Password** section of the **Account Management** page.

**Open Source Chef Server**

For a workstation that will interact with the open source |chef server|, do the following:

* Create a |knife rb| file. This `configuration file <https://docs.chef.io/config_rb_knife.html>`_ must be created by running the ``knife configure --initial`` command on the machine that will be run as a workstation. The ``validation_key`` attribute in the |knife rb| file must specify the path to the validation key. The ``validation_client_name`` attribute defaults to ``chef-validator`` (which is the |chef validator pem| private key created by the open source |chef server| on startup). When prompted for the URL for the |chef server|, use the |fqdn| for the |chef server|.
* Create a |user pem| file. (This private key is created at the same time as the |knife rb| file from the ``knife configure --initial`` command.)
* Find the |chef validator pem| file on the open source |chef server|. This private key is created by the open source |chef server| on startup and is located in the ``/etc/chef-server`` folder on the server after it is created.

These files will be moved into the |chef repo hidden| directory, which is a hidden directory that must be created in the |chef repo|.

Move Config Files
+++++++++++++++++++++++++++++++++++++++++++++++++++++
The |knife rb|, |organization pem|, and |user pem| files must be moved to the |chef repo hidden| directory after they are downloaded from the |chef server|.

To move files to the |chef repo hidden| directory:

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

#. Verify that the files are in the |chef repo hidden| folder.

Add |ruby| to the $PATH environment variable
=====================================================
The |chef client| includes a stable version of |ruby| as part of the |omnibus installer|. The path to this version of |ruby| must be added to the ``$PATH`` environment variable and saved in the configuration file for the command shell (|bash|, |csh|, and so on) that is used on the workstation. In a command window, type the following:

.. code-block:: bash

   echo 'export PATH="/opt/chef/embedded/bin:$PATH"' >> ~/.configuration_file && source ~/.configuration_file

where ``configuration_file`` is the name of the configuration file for the specific command shell. For example, if |bash| were the command shell and the configuration file were named ``bash_profile``, the command would look something like the following:

.. code-block:: bash

   echo 'export PATH="/opt/chef/embedded/bin:$PATH"' >> ~/.bash_profile && source ~/.bash_profile

Verify the |chef client| install
=====================================================
A workstation is installed correctly when it is able to use |knife| to communicate with the |chef server|.

To verify that a workstation can connect to the |chef server|:

#. In a command window, navigate to the |chef repo|:

   .. code-block:: bash

      cd ~/chef-repo

#. In a command window, enter the following:

   .. code-block:: bash

      knife client list

   to return a list of clients (registered nodes and workstations) that have access to the |chef server|. For example:

   .. code-block:: bash

       workstation
       registered_node

