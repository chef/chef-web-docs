=====================================================
ChefDK on Windows Workstations
=====================================================
`[edit on GitHub] <https://github.com/chef/chef-web-docs/blob/master/chef_master/source/dk_windows.rst>`__

This guide details some of the common considerations that come into play when using the Chef Development Kit on Windows. Download ChefDK by following the installation instructions on `Installing ChefDK </install_dk.html>`_.

.. tag workstation_summary

A workstation is a computer running Chef Workstation that is used to author cookbooks, interact with the Chef server, and interact with nodes.

The workstation is where users do most of their work, including:

* Developing and testing cookbooks and recipes
* Testing Chef code
* Keeping the Chef repository synchronized with version source control
* Configuring organizational policy, including defining roles and environments, and ensuring that critical data is stored in data bags
* Interacting with nodes, as (or when) required, such as performing a bootstrap operation

.. end_tag

Installing ChefDK on Windows

Installation and Setup
=====================================================
#. Visit the `ChefDK downloads page <https://downloads.chef.io/chefdk>`_ and select the appropriate package for your Windows version. Click on the **Download** button.
#. Follow the steps to accept the license and install the Chef development kit. You will have the option to change your install location; by default the installer uses the ``C:\opscode\chefdk\`` directory.
#. **Optional:** Set the default shell. On Microsoft Windows it is strongly recommended to use Windows PowerShell and ``cmd.exe``.

Verify the ChefDK Installation
-----------------------------------------------------
.. code-block:: PowerShell
    chef -v

Which returns the versions of all installed Chef tools.

.. code-block:: PowerShell

Chef Development Kit Version: 3.2.30
chef-client version: 14.4.56
berks version: 7.0.6
kitchen version: 1.23.2
inspec version: 2.2.70

The command chef shell-init lets you achieve this by generating the correct initialization script for your environment, and so all we need to do is run this command whenever we start a new session by placing a call to this command in the shell’s start up (i.e., in the file located at $PROFILE on Windows and in ∼/.bash_profile or ∼/.zshrc on Mac OS X and Linux).

Configure the Windows Environment
-----------------------------------------------------

Use the ``chef shell-init`` command to configure your environment to use the ChefDK locations for Chef and Ruby.  The ``chef shell-init`` command creates the initialization script for your environment.

First, newer Windows machines, PowerShell scripts will not work until an administrator runs the following command:

.. code-block:: bash

   Set-ExecutionPolicy RemoteSigned

Once the execution policy is in place, initialize the Windows environment with the following commands: 

Create a $PROFILE file if one doesn’t exist already:

.. code-block:: PowerShell

PS C:\Users\<username>> if(!(Test-Path $PROFILE)) { New-Item -Force -ItemType File $PROFILE }

Next, add the output of ``chef shell-init powershell`` to your ``$PROFILE`` (This command does not print the output onto the screen):

.. code-block:: PowerShell

PS C:\Users\<username>> chef shell-init powershell | Add-Content $PROFILE

Once initialized, your paths and environment variables are set up correctly for every new PowerShell session. See your environment settings by using ``cat $PROFILE``:

.. code-block:: PowerShell

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
A good visual code editor is not a requirement for working with CHef, but a good code editor can save you time.
A code editor should supports the following: Themes and Plugins, Snippets, Syntax Ruby code coloring/highlighting, Multiple cursors, a tree view of the entire folder/repository you are working with, and a Git integration.

These are a few common editors: 

Visual Studio Code (free/open source) - http://code.visualstudio.com
GitHub Atom - (free/open source) - http://atom.io
Sublime Text - ($70 USD) - http://sublimetext.com

Install and Optimize Git for Chef Development
-------------------------------------------------------
To install Git on Windows, navigate to https://git-scm.com/downloads and download the Windows installer. 

Download the installer and launch the Git Setup Wizard. Follow the on-screen instructions. We recommend adjusting the following settings to get the optimal set up for Chef development.

* When given the option to adjust your PATH environment you should select the option to ``Use Git from the Windows Command Prompt`` to ensure Git is available to all processes on the system, as shown in Figure
* When asked to configure the terminal emulator to use with Git Bash, select ``Use Windows`` default console window as shown in Figure 1-11 as this is most compatible with the command-line tools used in Chef development.
* When given the option for a Git integration, select your code editor from the list.

Install the Windows Tools
-------------------------------------------------------

* Azure-cli 
``azure.microsoft.com/en-gb/downloads``
follow installation
* PsGet--TODO: Compare to the Azure PowerShell tools
* If you have a copy of Visual Studio installed on your machine, I recommend adding the Microsoft Azure SDK for .NET though - this will give you some visual help writing Azure Resource Manager deployment templates in JSON.

* Install-Module AzureRM
* Install-AzureRM
