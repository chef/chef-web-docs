=====================================================
Install the |chef dk_title|
=====================================================

The |omnibus installer| is used to set up the |chef dk| on a workstation, including the |chef client| itself, an embedded version of |ruby|, |rubygems|, |open ssl|, key-value stores, parsers, libraries, command line utilities, and community tools such as |kitchen|, |berkshelf|, and |chef spec|. The |omnibus installer| puts everything into a unique directory (``opt/chefdk/``) so that these components will not interfere with other applications that may be running on the target machine. Once installed, the |chef client| requires a few more configuration steps before it can be run as a workstation.

.. note:: The |omnibus installer| requires that an installation be done as a root user.


Install on a Workstation
=====================================================
The following sections describe how to install the |chef dk| on a workstation:

#. Identify the |chef server| type: hosted or on-premises
#. Review the prerequisites
#. Select the |omnibus installer| for the desired platform
#. Run the |omnibus installer|
#. Set the system |ruby|
#. Install |git|
#. Set up the |chef repo|
#. Create the |chef repo hidden| directory
#. Get the .pem files and |knife rb| files
#. Move files to the |chef repo hidden| directory
#. Add omnibus |ruby| to the $PATH environment variable
#. Get |ssl| certificates from the |chef server|
#. Verify the |chef client| install

See the following sections for more information about each step.

Review prerequisites
-----------------------------------------------------
Ensure that the workstation meets all of the software prerequisites and that it has access to a |chef server| and to a machine that can host a node.

The following items are prerequisites for installing the |chef client| on a workstation:

* A computer running |unix|, |linux|, |mac os x| or |windows|
* |apple xcode| is installed on machines running |mac os x|; this application can be downloaded from |apple| for free
* A |github| account; the |chef repo| must be downloaded and/or cloned from |github|
* Access to a |chef server|: a hosted |chef server| account or an on-premises |chef server|. If you have a proxy, information on configuring |chef client| to work with it is :doc:`here </proxies>`
* Access to a machine (physical or virtual) that can be used as the first node; the |fqdn| or IP address for a machine is required by the |subcommand knife bootstrap| command during a bootstrap operation

Get Package, Run Installer
-----------------------------------------------------
.. include:: ../../includes_install/includes_install_chef_dk.rst

Set System |ruby|
-----------------------------------------------------
.. include:: ../../step_ruby/step_ruby_set_system_ruby_as_chefdk_ruby.rst

PowerShell
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../step_ruby/step_ruby_set_system_ruby_as_chefdk_ruby_windows.rst

**Set the execution policy on new machines**

.. include:: ../../step_ruby/step_ruby_set_system_ruby_as_chefdk_ruby_windows_admin.rst

**Create a $PROFILE on new machines**

.. include:: ../../step_ruby/step_ruby_set_system_ruby_as_chefdk_ruby_windows_user_profile.rst

|windows|
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_windows/includes_windows_set_system_ruby.rst

Install |git|
-----------------------------------------------------
An open source distributed version control system called |git| must be installed before the |chef repo| can be cloned to the workstation from |github|.

To install |git|:

#. Go to the following URL: https://help.github.com/articles/set-up-git.

#. Follow the directions, install |git| (http://git-scm.com/downloads), and then complete the remaining configuration steps on that page.

.. note:: It is not necessary to create or fork a repository in order to clone the |chef repo| from |github|.

Set up the |chef repo|
-----------------------------------------------------
.. include:: ../../includes_install/includes_install_chef_client_repo.rst

Starter Kit
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_install/includes_install_chef_client_repo_starter_kit.rst

Manually (w/ Webui)
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_install/includes_install_chef_client_repo_manual_via_webui.rst

**Create the chef-repo**

Use `the chef generate app command <https://docs.chef.io/ctl_chef.html#chef-generate-app>`__ to create the |chef repo|.

**Create .chef Directory**

.. include:: ../../includes_install/includes_install_chef_client_repo_manual_chef_directory.rst

**Get Config Files**

.. include:: ../../includes_install/includes_install_chef_client_repo_manual_get_config.rst

**Move Config Files**

.. include:: ../../includes_install/includes_install_chef_client_repo_manual_move_pem_and_config.rst

Manually (w/o Webui)
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_install/includes_install_chef_client_repo_manual_no_webui.rst

**Create the chef-repo**

Use `the chef generate app command <https://docs.chef.io/ctl_chef.html#chef-generate-app>`__ to create the |chef repo|.

**Create .chef Directory**

.. include:: ../../includes_install/includes_install_chef_client_repo_manual_chef_directory.rst

**Create an Organization**

.. include:: ../../includes_install/includes_install_chef_client_repo_manual_create_org.rst

**Create a User**

.. include:: ../../includes_install/includes_install_chef_client_repo_manual_create_user.rst

**Move .pem Files**

.. include:: ../../includes_install/includes_install_chef_client_repo_manual_move_pem.rst

**Create the knife.rb File**

.. include:: ../../includes_install/includes_install_chef_client_repo_manual_create_config.rst

Add |ruby| to $PATH
-----------------------------------------------------
The |chef client| includes a stable version of |ruby| as part of the |omnibus installer|. The path to this version of |ruby| must be added to the ``$PATH`` environment variable and saved in the configuration file for the command shell (|bash|, |csh|, and so on) that is used on the workstation. In a command window, type the following:

.. code-block:: bash

   echo 'export PATH="/opt/chefdk/embedded/bin:$PATH"' >> ~/.configuration_file && source ~/.configuration_file

where ``configuration_file`` is the name of the configuration file for the specific command shell. For example, if |bash| were the command shell and the configuration file were named ``bash_profile``, the command would look something like the following:

.. code-block:: bash

   echo 'export PATH="/opt/chefdk/embedded/bin:$PATH"' >> ~/.bash_profile && source ~/.bash_profile

.. warning:: On |windows|, ``C:/opscode/chefdk/bin`` must be before ``C:/opscode/chefdk/embedded/bin`` in the ``PATH``.

Get |ssl| Certificates
-----------------------------------------------------
|chef server| 12 enables |ssl| verification by default for all requests made to the server, such as those made by |knife| and the |chef client|. The certificate that is generated during the installation of the |chef server| is self-signed, which means there isn't a signing |ca| to verify. In addition, this certificate must be downloaded to any machine from which |knife| and/or the |chef client| will make requests to the |chef server|.

Use the |subcommand knife ssl_fetch| command to pull the |ssl| certificate down from the |chef server|:

.. code-block:: bash

   knife ssl fetch

See `SSL Certificates <https://docs.chef.io/chef_client_security.html#ssl-certificates>`__ for more information about how |knife| and the |chef client| use |ssl| certificates generated by the |chef server|.

Verify Install
-----------------------------------------------------
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


|chef dk_title| and Windows
=====================================================
The following sections describe issues that are known to users of the |chef dk| on the |windows| platform.

Spaces and Directories
-----------------------------------------------------
.. include:: ../../includes_windows/includes_windows_spaces_and_directories.rst

Top-level Directory Names
-----------------------------------------------------
.. include:: ../../includes_windows/includes_windows_top_level_directory_names.rst


Uninstall
=====================================================
.. include:: ../../includes_uninstall/includes_uninstall_chef_dk.rst

|debian|
-----------------------------------------------------
.. include:: ../../includes_uninstall/includes_uninstall_chef_dk_ubuntu.rst

|mac os x|
-----------------------------------------------------
.. include:: ../../includes_uninstall/includes_uninstall_chef_dk_mac.rst

|redhat enterprise linux|
-----------------------------------------------------
.. include:: ../../includes_uninstall/includes_uninstall_chef_dk_redhat.rst

|windows|
-----------------------------------------------------
.. include:: ../../includes_uninstall/includes_uninstall_chef_dk_windows.rst
