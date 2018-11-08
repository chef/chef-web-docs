=====================================================
Installing Chef on Windows
=====================================================
`[edit on GitHub] <https://github.com/chef/chef-web-docs/blob/master/chef_master/source/dk_windows.rst>`__

Chef Workstation
=====================================================

Start your infrastructure automation quickly and easily with `Chef Workstation <https://www.chef.sh/>`__ Chef Workstation gives you everything you need to get started with Chef — ad hoc remote execution, remote scanning, configuration tasks, cookbook creation tools as well as robust dependency and testing software — all in one easy-to-install package.

Chef Workstation replaces ChefDK, combining all the existing features with new features, such as ad-hoc task support and the new Chef Workstation desktop application. Chef will continue to maintain ChefDK, but new development will take place in Chef Workstation without back-porting features.

`Download Chef Workstation <https://https://downloads.chef.io/chef-workstation/>`__ 

Chef Workstation Supported Platforms
-----------------------------------------------------

Supported Host Operating Systems:

.. list-table:: Supported Host Operating System
   :widths: 15 15 
   :header-rows: 1
  
   * - Platform
     - Version
   * - Apple macOS
     - 10.11, 10.12, 10.13
   * - Microsoft Windows
     - 10, Server 2008 R2, Server 2012, Server 2012 R2, Server 2016
   * - Red Hat Enterprise Linux / CentOS
     - 6.x, 7.x
   * - SUSE Enterprise Linux Server
     - 11 SP4, 12 SP1+
   * - Ubuntu 
     - 14.04, 16.04, 18.04
   * - Debian
     - 7.x, 8.x, 9.x

.. list-table:: Supported Target Operating System
   :widths: 15 15 
   :header-rows: 1

   * - Platform
     - Version
   * - Microsoft Windows
     - 10, Server 2008 R2, Server 2012, Server 2012 R2, Server 2016
   * - Red Hat Enterprise Linux
     - 6.x, 7.x
   * - SUSE Enterprise Linux Server
     - 11 SP4, 12 SP1+
   * - Ubuntu
     - 14.04, 16.04, 18.04
   * - Debian
     - 7.x, 8.x, 9.x

Chef Workstation System Requirements
----------------------------------------------------

Minimum system requirements:

* RAM: 2GB
* Disk: 4GB
* Running minimum settings may limit your ability to take advantage of Chef
  Workstation tools such as Test Kitchen which creates and manages virtualized
  test environments.

Recommended system requirements:

* RAM: 4GB
* Disk 8GB

Chef Workstation App
-----------------------------------------------------

* Windows: No additional requirements
* Mac: No additional requirements
* Linux:
   - You must have a graphical window manager running
   - Additional libraries may be required. See `Running the Chef Workstation App <https://chef-workstation-app.html>`_ for more details.

Installing ChefDK
==================================================

In some cases, such as if you're working with older or unsupported systems, you may need to use ChefDK instead of Chef Workstation. Download ChefDK by following the installation instructions on `Installing ChefDK </install_dk.html>`_.

#. Visit the `ChefDK downloads page <https://downloads.chef.io/chefdk>`_ and select the appropriate package for your Windows version. Click on the **Download** button.
#. Follow the steps to accept the license and install the Chef development kit. You will have the option to change your install location; by default the installer uses the ``C:\opscode\chefdk\`` directory.
#. **Optional:** Set the default shell. On Microsoft Windows it is strongly recommended to use Windows PowerShell and ``cmd.exe``.

Verify the ChefDK Installation
-----------------------------------------------------

To verify the ChefDK installation, run:

.. code-block:: shell

   chef -v

Which returns the versions of all installed Chef tools:

.. code-block:: shell

   Chef Development Kit Version: 3.2.30
   chef-client version: 14.4.56
   berks version: 7.0.6
   kitchen version: 1.23.2
   inspec version: 2.2.70

Configure the Windows Environment
-----------------------------------------------------

Use the ``chef shell-init`` command to configure your environment to use the ChefDK locations for Chef and Ruby. The ``chef shell-init`` command creates the initialization script for your environment.

Set the Execution Policy
+++++++++++++++++++++++++++++++++++++++++++++++++++++

On newer Windows machines, PowerShell scripts will not work until an administrator runs the following command:

.. code-block:: bash

   Set-ExecutionPolicy RemoteSigned

Create a Profile
+++++++++++++++++++++++++++++++++++++++++++++++++++++

Once the execution policy is in place, initialize the Windows environment with the following commands: 

Create a ``$PROFILE`` file if one doesn’t exist already:

.. code-block:: shell

   PS C:\Users\<username>> if(!(Test-Path $PROFILE)) { New-Item -Force -ItemType File $PROFILE }

Next, add the output of ``chef shell-init powershell`` to your ``$PROFILE`` (This command does not print the output onto the screen):

.. code-block:: shell

   PS C:\Users\<username>> chef shell-init powershell | Add-Content $PROFILE

Once initialized, your paths and environment variables are set up correctly for every new PowerShell session. See your environment settings by using ``cat $PROFILE``:

.. code-block:: shell

    PS C:\Users|<username>> cat $PROFILE
    $env:PATH="C:/opscode/chefdk/bin;C:/Users/<username>/AppData/Local/chefdk/gem/ruby/2.5.0/bin;C:/opscode/chefdk/embedded/bin;C:/opscode/chefdk/embedded/git/usr/bin"
    $env:GEM_ROOT="C:/opscode/chefdk/embedded/lib/ruby/gems/2.5.0"
    $env:GEM_HOME="C:/Users/<username>/AppData/Local/chefdk/gem/ruby/2.5.0"
    $env:GEM_PATH="C:/Users/<username>/AppData/Local/chefdk/gem/ruby/2.5.0;C:/opscode/chefdk/embedded/lib/ruby/gems/2.5.0"

Spaces and Directories
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. tag windows_spaces_and_directories

Directories that are used by Chef on Windows cannot have spaces. For example, ``C:\Users\User Name`` will not work, but ``C:\Users\UserName`` will. Because of this, the ``knife supermarket install`` subcommand will fail if the directory contains a space.

.. end_tag

Top-level Directory Names
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. tag windows_top_level_directory_names

Windows will throw errors when path name lengths are too long. For this reason, it's often helpful to use a very short top-level directory, much like what is done in UNIX and Linux. For example, Chef uses ``/opt/`` to install the Chef development kit on macOS. A similar approach can be done on Microsoft Windows, by creating a top-level directory with a short name. For example: ``C:\chef``.

.. end_tag

Install a Code Editor
-------------------------------------------------------
A good visual code editor is not a requirement for working with Chef, but a good code editor can save you time.
A code editor should support the following: themes, plugins, snippets, syntax Ruby code coloring/highlighting, multiple cursors, a tree view of the entire folder/repository you are working with, and a Git integration.

These are a few common editors: 

   * Visual Studio Code (free/open source) - http://code.visualstudio.com
   * GitHub Atom - (free/open source) - http://atom.io
   * Sublime Text - ($70 USD) - http://sublimetext.com

Install and Optimize Git for Chef Development
-------------------------------------------------------
To install Git on Windows, navigate to https://git-scm.com/downloads and download the Windows installer. 

Download the installer and launch the Git Setup Wizard. Follow the on-screen instructions. We recommend adjusting the following settings to get the optimal set up for Chef development.

* When given the option to adjust your PATH environment you should select the option to ``Use Git from the Windows Command Prompt`` to ensure Git is available to all processes on the system, as shown in Figure
* When asked to configure the terminal emulator to use with Git Bash, select ``Use Windows`` default console window as shown in Figure 1-11 as this is most compatible with the command-line tools used in Chef development.
* When given the option for a Git integration, select your code editor from the list.

Install the Windows Tools
-------------------------------------------------------

 * The Azure-cli ``azure.microsoft.com/en-gb/downloads`` follow installation
 * The Azure Resource Manager Tools
 * If you are using Visual Studio Code, add the Microsoft Azure SDK for .NET for help with writing Azure Resource Manager JSON deployment templates.
 * ``Install-Module AzureRM``
 * ``Install-AzureRM``

