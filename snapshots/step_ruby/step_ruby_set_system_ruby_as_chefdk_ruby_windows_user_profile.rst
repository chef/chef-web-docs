.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

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
