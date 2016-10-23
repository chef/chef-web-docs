.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

.. To use the flags attribute:

.. code-block:: ruby

   powershell_script 'Install IIS' do
     code <<-EOH
     Import-Module ServerManager
     Add-WindowsFeature Web-Server
     EOH
     flags '-NoLogo, -NonInteractive, -NoProfile, -ExecutionPolicy Unrestricted, -InputFormat None, -File'
     guard_interpreter :powershell_script
     not_if '(Get-WindowsFeature -Name Web-Server).Installed'
   end
