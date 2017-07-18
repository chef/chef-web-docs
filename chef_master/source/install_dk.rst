=====================================================
Install the Chef DK
=====================================================
`[edit on GitHub] <https://github.com/chef/chef-web-docs/blob/master/chef_master/source/install_dk.rst>`__

The omnibus installer is used to set up the Chef development kit on a workstation, including the chef-client itself, an embedded version of Ruby, RubyGems, OpenSSL, key-value stores, parsers, libraries, command line utilities, and community tools such as Kitchen, Berkshelf, and ChefSpec. The omnibus installer puts everything into a unique directory (``opt/chefdk/``) so that these components will not interfere with other applications that may be running on the target machine. Once installed, the chef-client requires a few more configuration steps before it can be run as a workstation.

.. note:: The omnibus installer requires that an installation be done as a root user.

Install on a Workstation
=====================================================
The following sections describe how to install the Chef development kit on a workstation:

#. Identify the Chef server type: hosted or on-premises
#. Review the prerequisites
#. Select the omnibus installer for the desired platform
#. Run the omnibus installer
#. Set the system Ruby
#. Install git
#. Set up the chef-repo
#. Create the .chef directory
#. Get the .pem files and knife.rb files
#. Move files to the .chef directory
#. Add omnibus Ruby to the $PATH environment variable
#. Get SSL certificates from the Chef server
#. Verify the chef-client install

See the following sections for more information about each step.

Review prerequisites
-----------------------------------------------------
Ensure that the workstation meets all of the software prerequisites and that it has access to a Chef server and to a machine that can host a node.

The following items are prerequisites for installing the chef-client on a workstation:

* A computer running UNIX, Linux, macOS or Microsoft Windows
* Apple XCode is installed on machines running macOS; this application can be downloaded from Apple for free
* A GitHub account; the chef-repo must be downloaded and/or cloned from GitHub
* Access to a Chef server: a hosted Chef server account or an on-premises Chef server. If you have a proxy, information on configuring chef-client to work with it is :doc:`here </proxies>`
* Access to a machine (physical or virtual) that can be used as the first node; the FQDN or IP address for a machine is required by the ``knife bootstrap`` subcommand during a bootstrap operation

Get Package, Run Installer
-----------------------------------------------------
To install the Chef development kit:

#. Visit this page: https://downloads.chef.io/chefdk/. The Chef development kit supports macOS, Red Hat Enterprise Linux, Ubuntu, and Microsoft Windows.
#. Select a platform, and then a package. (chef-docs uses the macOS setup within the documentation.)
#. Click the download button.
#. Follow the steps in the installer and install the Chef development kit to your machine. The Chef development kit is installed to ``/opt/chefdk/`` on UNIX and Linux systems.
#. Optional. Set the default shell. On Microsoft Windows it is strongly recommended to use Windows PowerShell and cmd.exe.

Set System Ruby
-----------------------------------------------------
For many users of Chef, the Chef development kit version of Ruby that is included in the Chef development kit should be configured as the default version of Ruby.

#. Open a command window and enter the following:

   .. code-block:: bash

      $ which ruby

   which will return something like ``/usr/bin/ruby``.
#. To use the Chef development kit version of Ruby as the default Ruby, edit the ``$PATH`` and ``GEM`` environment variables to include paths to the Chef development kit. For example, on a machine that runs Bash, run:

   .. code-block:: bash

      echo 'eval "$(chef shell-init bash)"' >> ~/.bash_profile

   where ``bash`` and ``~/.bash_profile`` represents the name of the shell.

   If zsh is your preferred shell then run the following:

   .. code-block:: bash

    echo 'eval "$(chef shell-init zsh)"' >> ~/.zshrc

#. Run ``which ruby`` again. It should return ``/opt/chefdk/embedded/bin/ruby``.

.. note:: Using the Chef development kit-provided Ruby as your system Ruby is optional. This just depends on how you are using Ruby on your system. For many users, Ruby is primarily used for authoring Chef cookbooks and recipes. If that's true for you, then using the Chef development kit-provided Ruby as your system Ruby is recommended. But for other users who are already using tools like rbenv to manage Ruby versions, then that's OK too.

PowerShell
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. tag ruby_set_system_ruby_as_chefdk_ruby_windows

You can use ``chef shell-init`` with Windows PowerShell.

To try it in your current session:

.. code-block:: bash

   chef shell-init powershell | Invoke-Expression

To enable it permanently:

.. code-block:: bash

   "chef shell-init powershell | Invoke-Expression" >> $PROFILE

.. end_tag

**Set the execution policy on new machines**

.. tag ruby_set_system_ruby_as_chefdk_ruby_windows_admin

For new Microsoft Windows machines, Windows PowerShell scripts will not work until an administrator runs the following command:

.. code-block:: bash

   Set-ExecutionPolicy RemoteSigned

.. end_tag

**Create a $PROFILE on new machines**

.. tag ruby_set_system_ruby_as_chefdk_ruby_windows_user_profile

For new Microsoft Windows machines, commands cannot be appended to ``$PROFILE`` if the folder does not exist or if there is a new user profile, an error similar to the following may be returned:

.. code-block:: bash

   PS C:\Users\Stuart> "chef shell-init powershell | Invoke-Expression" >> $PROFILE
   out-file : Could not find a part of the path
   'C:\Users\Stuart\Documents\WindowsPowerShell\Microsoft.PowerShell_profile.ps1'.
   At line:1 char:1
   + "chef shell-init powershell | Invoke-Expression" >> $PROFILE
   + ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
       + CategoryInfo          : OpenError: (:) [Out-File], DirectoryNotFoundException
       + FullyQualifiedErrorId : FileOpenFailure,Microsoft.PowerShell.Commands.OutFileCommand

In this situation, run the following ``chef shell-init`` command instead:

.. code-block:: bash

   if(Test-Path $PROFILE){ chef shell-init powershell | Add-Content $PROFILE } else { New-Item -Force -ItemType File $PROFILE; chef shell-init powershell | Add-Content $PROFILE }

.. end_tag

Microsoft Windows
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. tag windows_set_system_ruby

To set the system Ruby for the Microsoft Windows platform `the steps described for all platforms are true </install_dk.html#set-system-ruby>`_, but then require the following manual edits to the ``chef shell-init bash`` output for the Microsoft Windows platform:

#. Add quotes around the variable assignment strings.
#. Convert ``C:/`` to ``/c/``.
#. Save those changes.

.. end_tag

Install git
-----------------------------------------------------
An open source distributed version control system called git must be installed before the chef-repo can be cloned to the workstation from GitHub.

To install git:

#. Go to the following URL: https://help.github.com/articles/set-up-git.

#. Follow the directions, install git (http://git-scm.com/downloads), and then complete the remaining configuration steps on that page.

.. note:: It is not necessary to create or fork a repository in order to clone the chef-repo from GitHub.

Set up the chef-repo
-----------------------------------------------------
There are two ways to create the chef-repo:

* Use the starter kit built into the Chef server web user interface
* Manually, by using the ``chef generate app`` subcommand in the chef command-line tool that is packaged in the Chef development kit

Starter Kit
+++++++++++++++++++++++++++++++++++++++++++++++++++++
If you have access to Chef server (hosted or on premises), you can download the starter kit. The starter kit will create the necessary configuration files---the .chef directory, knife.rb, the ORGANIZATION-validator.pem, and USER.pem files) with the correct information that is required to interact with the Chef server. Simply download the starter kit and then move it to the desired location on your workstation.

Manually (w/ Webui)
+++++++++++++++++++++++++++++++++++++++++++++++++++++
Use the following steps to manually set up the chef-repo and to use the Chef management console to get the .pem and knife.rb files.

**Create the chef-repo**

Use `the chef generate app command </ctl_chef.html#chef-generate-app>`__ to create the chef-repo.

**Create .chef Directory**

.. tag install_chef_client_repo_manual_chef_directory

The .chef directory is used to store three files:

* knife.rb
* ORGANIZATION-validator.pem
* USER.pem

Where ``ORGANIZATION`` and ``USER`` represent strings that are unique to each organization. These files must be present in the .chef directory in order for a workstation to be able to connect to a Chef server.

To create the .chef directory:

#. In a command window, enter the following:

   .. code-block:: bash

      mkdir -p ~/chef-repo/.chef

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

.. end_tag

**Get Config Files**

For a workstation that will interact with the Chef server (including the hosted Chef server), log on and download the following files:

* knife.rb. This configuration file can be downloaded from the **Organizations** page.
* ORGANIZATION-validator.pem. This private key can be downloaded from the **Organizations** page.
* USER.pem. This private key an be downloaded from the **Change Password** section of the **Account Management** page.

**Move Config Files**

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

Manually (w/o Webui)
+++++++++++++++++++++++++++++++++++++++++++++++++++++
Use the following steps to manually set up the chef-repo, create the ORGANIZATION-validator.pem and USER.pem files with the chef-server-ctl command line tool, and then create the knife.rb file.

**Create the chef-repo**

Use `the chef generate app command </ctl_chef.html#chef-generate-app>`__ to create the chef-repo.

**Create .chef Directory**

.. tag install_chef_client_repo_manual_chef_directory

The .chef directory is used to store three files:

* knife.rb
* ORGANIZATION-validator.pem
* USER.pem

Where ``ORGANIZATION`` and ``USER`` represent strings that are unique to each organization. These files must be present in the .chef directory in order for a workstation to be able to connect to a Chef server.

To create the .chef directory:

#. In a command window, enter the following:

   .. code-block:: bash

      mkdir -p ~/chef-repo/.chef

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

.. end_tag

**Create an Organization**

On the Chef server machine create the ORGANIZATION-validator.pem from the command line using chef-server-ctl. Run the following command:

.. code-block:: bash

   $ chef-server-ctl org-create ORG_NAME ORG_FULL_NAME -f FILE_NAME

where

* The name must begin with a lower-case letter or digit, may only contain lower-case letters, digits, hyphens, and underscores, and must be between 1 and 255 characters. For example: ``chef``
* The full name must begin with a non-white space character and must be between 1 and 1023 characters. For example: ``"Chef Software, Inc."``
* ``-f FILE_NAME``: Write the ORGANIZATION-validator.pem to ``FILE_NAME`` instead of printing it to ``STDOUT``. For example: ``/tmp/chef.key``.

For example, an organization named ``chef``, with a full name of ``Chef Software, Inc.``, and with the ORGANIZATION-validator.pem file saved to ``/tmp/chef.key``:

.. code-block:: bash

   $ chef-server-ctl org-create chef "Chef Software, Inc." -f /tmp/chef.key

**Create a User**

On the Chef server machine create the USER.pem from the command line using chef-server-ctl. Run the following command:

.. code-block:: bash

   $ chef-server-ctl user-create USER_NAME FIRST_NAME LAST_NAME EMAIL PASSWORD -f FILE_NAME

where

* Write the USER.pem to a file instead of ``STDOUT``. For example: ``/tmp/grantmc.key``.

For example, a user named ``grantmc``, with a first and last name of ``Grant McLennan``, an email address of ``grantmc@chef.io``, a poorly-chosen password, and with the USER.pem file saved to ``/tmp/grantmc.key``:

.. code-block:: bash

   $ chef-server-ctl user-create grantmc Grant McLennan grantmc@chef.io p@s5w0rD! -f /tmp/grantmc.key

**Move .pem Files**

The ORGANIZATION-validator.pem and USER.pem files must be moved to the .chef directory after they are downloaded from the Chef server.

To move files to the .chef directory:

#. In a command window, enter each of the following:

   .. code-block:: bash

      cp /path/to/ORGANIZATION-validator.pem ~/chef-repo/.chef

   and:

   .. code-block:: bash

      cp /path/to/USERNAME.pem ~/chef-repo/.chef

   where ``/path/to/`` represents the path to the location in which these three files were placed after they were downloaded.

#. Verify that the files are in the .chef folder.

**Create the knife.rb File**

The knife.rb file must be created in the .chef folder. It should look similar to:

.. code-block:: ruby

   current_dir = File.dirname(__FILE__)
   log_level                :info
   log_location             STDOUT
   node_name                'node_name'
   client_key               "#{current_dir}/USER.pem"
   validation_client_name   'ORG_NAME-validator'
   validation_key           "#{current_dir}/ORGANIZATION-validator.pem"
   chef_server_url          'https://api.chef.io/organizations/ORG_NAME'
   cache_type               'BasicFile'
   cache_options( :path => "#{ENV['HOME']}/.chef/checksums" )
   cookbook_path            ["#{current_dir}/../cookbooks"]

At a minimum, you must update the following settings with the appropriate values:

* ``client_key`` should point to the location of the Chef server user's ``.pem`` file on your workstation.
* ``validation_client_name`` should be updated with the name of the desired organization that was created on the Chef server.
* ``validation_key`` should point to the location of your organization's ``.pem`` file on your workstation. 
* ``chef_server_url`` must be updated with the domain or IP address used to access the Chef server.

See the `knife documentation </config_rb_knife.html>`__ for more details. 

Add Ruby to $PATH
-----------------------------------------------------
The chef-client includes a stable version of Ruby as part of the omnibus installer. The path to this version of Ruby must be added to the ``$PATH`` environment variable and saved in the configuration file for the command shell (Bash, csh, and so on) that is used on the workstation. In a command window, type the following:

.. code-block:: bash

   echo 'export PATH="/opt/chefdk/embedded/bin:$PATH"' >> ~/.configuration_file && source ~/.configuration_file

where ``configuration_file`` is the name of the configuration file for the specific command shell. For example, if Bash were the command shell and the configuration file were named ``bash_profile``, the command would look something like the following:

.. code-block:: bash

   echo 'export PATH="/opt/chefdk/embedded/bin:$PATH"' >> ~/.bash_profile && source ~/.bash_profile

.. warning:: On Microsoft Windows, ``C:/opscode/chefdk/bin`` must be before ``C:/opscode/chefdk/embedded/bin`` in the ``PATH``.

Get SSL Certificates
-----------------------------------------------------
Chef server 12 enables SSL verification by default for all requests made to the server, such as those made by knife and the chef-client. The certificate that is generated during the installation of the Chef server is self-signed, which means there isn't a signing certificate authority (CA) to verify. In addition, this certificate must be downloaded to any machine from which knife and/or the chef-client will make requests to the Chef server.

Use the ``knife ssl fetch`` subcommand to pull the SSL certificate down from the Chef server:

.. code-block:: bash

   knife ssl fetch

See `SSL Certificates </chef_client_security.html#ssl-certificates>`__ for more information about how knife and the chef-client use SSL certificates generated by the Chef server.

Verify Install
-----------------------------------------------------
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

Chef DK and Windows
=====================================================
The following sections describe issues that are known to users of the Chef development kit on the Microsoft Windows platform.

Spaces and Directories
-----------------------------------------------------
.. tag windows_spaces_and_directories

Directories that are used by Chef on the Microsoft Windows platform cannot have spaces. For example, ``/c/Users/Steven Danno`` will not work, but ``/c/Users/StevenDanno`` will.

A different issue exists with the knife command line tool that is also related to spaces and directories. The ``knife cookbook site install`` subcommand will fail when the Microsoft Windows directory contains a space.

.. end_tag

Top-level Directory Names
-----------------------------------------------------
.. tag windows_top_level_directory_names

Paths can be longer in UNIX and Linux environments than they can be in Microsoft Windows. Microsoft Windows will throw errors when path name lengths are too long. For this reason, it's often helpful to use a very short top-level directory in Microsoft Windows, much like what is done in UNIX and Linux. For example, Chef uses ``/opt/`` to install the Chef development kit on macOS. A similar approach can be done on Microsoft Windows, by creating a top-level directory with a short name. For example: ``c:\chef``.

.. end_tag

Uninstall
=====================================================
.. tag uninstall_chef_dk

The Chef development kit can be uninstalled using the steps below that are appropriate for the platform on which the Chef development kit is installed.

.. end_tag

In Chef development kit versions prior to 1.0.3, you may need to complete uninstalling the program with the additional step of removing the directory ``~/.chefdk``.  

.. code-block:: bash

   $ rm -fr ~/.chefdk

Debian
-----------------------------------------------------
.. tag uninstall_chef_dk_ubuntu

Use the following command to remove the Chef development kit on Debian-based platforms:

.. code-block:: bash

   $ dpkg -P chefdk

.. end_tag

macOS
-----------------------------------------------------
.. tag uninstall_chef_dk_mac

Use the following commands to remove the Chef development kit on macOS.

To remove installed files:

.. code-block:: bash

   $ sudo rm -rf /opt/chefdk

To remove the system installation entry:

.. code-block:: bash

   $ sudo pkgutil --forget com.getchef.pkg.chefdk

To remove symlinks:

* For chef-client version 12.x, under ``/usr/local/bin``:

  .. code-block:: bash

     $ sudo find /usr/local/bin -lname '/opt/chefdk/*' -delete

* For chef-client version 11.x, under ``/usr/bin``:

  .. code-block:: bash

     $ sudo find /usr/bin -lname '/opt/chefdk/*' -delete

.. end_tag

Red Hat Enterprise Linux
-----------------------------------------------------
.. tag uninstall_chef_dk_redhat

Use the following commands to remove the Chef development kit on Red Hat Enterprise Linux-based platforms:

.. code-block:: bash

   $ rpm -qa *chefdk*
   $ sudo yum remove -y <package>

.. end_tag

Microsoft Windows
-----------------------------------------------------
.. tag uninstall_chef_dk_windows

Use **Add / Remove Programs** to remove the Chef development kit on the Microsoft Windows platform.

.. end_tag
