.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

.. To test the start time for the Schedule service: 

.. code-block:: ruby

   describe registry_key('Task Scheduler','HKEY_LOCAL_MACHINE\...\Schedule') do
     its('Start') { should eq 2 }
   end

where ``'HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\services\Schedule'`` is the full path to the setting.
