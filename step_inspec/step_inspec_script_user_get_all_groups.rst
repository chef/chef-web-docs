.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

.. To get all groups of Administrator user: 

.. code-block:: ruby

   myscript = <<-EOH
     # find user
     $user = Get-WmiObject Win32_UserAccount -filter "Name = 'Administrator'"
     # get related groups
     $groups = $user.GetRelated('Win32_Group') | Select-Object -Property Caption, Domain, Name, LocalAccount, SID, SIDType, Status
     $groups | ConvertTo-Json
   EOH
   
   describe script(myscript) do
     its('stdout') { should_not eq '' }
   end
