=====================================================
ChefDK on Windows Workstations
=====================================================
`[edit on GitHub] <https://github.com/chef/chef-web-docs/blob/master/chef_master/source/dk_windows.rst>`__

This guide details some of the common considerations that come into play when using the Chef Development Kit on Windows. Download the ChefDK by following the installation instructions on `Installing the ChefDK </install_dk.html>`_.

.. note:: `Chef Workstation <https://downloads.chef.io/chef-workstation/>`__ gives you everything you need to get started with Chef — ad hoc remote execution, remote scanning, configuration tasks, cookbook creation tools as well as robust dependency and testing software — all in one easy-to-install package. Chef Workstation replaces ChefDK, combining all the existing features with new features, such as ad-hoc task support and the new Chef Workstation desktop application. Chef will continue to maintain ChefDK, but new development will take place in Chef Workstation without backporting features.

Workstations
=====================================================
.. tag workstation_summary

A workstation is a computer running the `Chef Development Kit </about_chefdk.html>`__ (ChefDK) that is used to author cookbooks, interact with the Chef server, and interact with nodes.

The workstation is where users do most of their work, including:

* Developing and testing cookbooks and recipes
* Testing Chef code
* Keeping the Chef repository synchronized with version source control
* Configuring organizational policy, including defining roles and environments, and ensuring that critical data is stored in data bags
* Interacting with nodes, as (or when) required, such as performing a bootstrap operation

.. end_tag

Installing ChefDK on Windows

Configure Environment
-----------------------------------------------------
.. tag ruby_set_system_ruby_as_chefdk_ruby_windows

You can use the ``chef shell-init`` command with Windows PowerShell to add the appropriate variables to your environment.

To try it in your current session:

.. code-block:: bash

   chef shell-init powershell | Invoke-Expression

To enable it permanently:

.. code-block:: bash

   "chef shell-init powershell | Invoke-Expression" >> $PROFILE

.. end_tag

If ``$PROFILE`` does not exist, continue to the next section.

Create a Profile
-----------------------------------------------------
.. tag ruby_set_system_ruby_as_chefdk_ruby_windows_user_profile

On new Windows machines, commands cannot be appended to ``$PROFILE`` if the folder does not exist, or if there is a new user profile. This will result in an error similar to the following:

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

Set the Execution Policy
-----------------------------------------------------
.. tag ruby_set_system_ruby_as_chefdk_ruby_windows_admin

On new Windows machines, PowerShell scripts will not work until an administrator runs the following command:

.. code-block:: bash

   Set-ExecutionPolicy RemoteSigned

.. end_tag

Spaces and Directories
-----------------------------------------------------
.. tag windows_spaces_and_directories

Directories that are used by Chef on Windows cannot have spaces. For example, ``C:\Users\Steven Danno`` will not work, but ``C:\Users\StevenDanno`` will. Because of this, the ``knife supermarket install`` subcommand will fail if the directory contains a space.

.. end_tag

Top-level Directory Names
-----------------------------------------------------
.. tag windows_top_level_directory_names

Windows will throw errors when path name lengths are too long. For this reason, it's often helpful to use a very short top-level directory, much like what is done in UNIX and Linux. For example, Chef uses ``/opt/`` to install the Chef development kit on macOS. A similar approach can be done on Microsoft Windows, by creating a top-level directory with a short name. For example: ``C:\chef``.

.. end_tag
