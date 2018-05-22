=====================================================
Chef DK on Windows
=====================================================
`[edit on GitHub] <https://github.com/chef/chef-web-docs/blob/master/chef_master/source/dk_windows.rst>`__

This guide details some of the common considerations that come into play when using the Chef Development Kit on Windows.

Configure Environment
=====================================================
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
=====================================================
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
=====================================================
.. tag ruby_set_system_ruby_as_chefdk_ruby_windows_admin

On new Windows machines, PowerShell scripts will not work until an administrator runs the following command:

.. code-block:: bash

   Set-ExecutionPolicy RemoteSigned

.. end_tag

Spaces and Directories
=====================================================
.. tag windows_spaces_and_directories

Directories that are used by Chef on Windows cannot have spaces. For example, ``C:\Users\Steven Danno`` will not work, but ``C:\Users\StevenDanno`` will. Because of this, the ``knife cookbook site install`` subcommand will fail if the directory contains a space.

.. end_tag

Top-level Directory Names
=====================================================
.. tag windows_top_level_directory_names

Windows will throw errors when path name lengths are too long. For this reason, it's often helpful to use a very short top-level directory, much like what is done in UNIX and Linux. For example, Chef uses ``/opt/`` to install the Chef development kit on macOS. A similar approach can be done on Microsoft Windows, by creating a top-level directory with a short name. For example: ``C:\chef``.

.. end_tag
