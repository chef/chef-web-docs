.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

A ``registry_key`` |inspec resource| block declares the item in the |windows| registry, the path to a setting under that item, and then one (or more) name/value pairs to be tested.

Use a registry key name and path:

.. code-block:: ruby

   describe registry_key('Task Scheduler','HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\services\Schedule') do
     its('Start') { should eq 2 }
   end

Use only a registry key path:

.. code-block:: ruby

   describe registry_key('Task Scheduler','HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\services\Schedule') do
     its('Start') { should eq 2 }
   end

Or use a |ruby hash|:

.. code-block:: ruby

   describe registry_key({
     name: 'Task Scheduler',
     hive: 'HKEY_LOCAL_MACHINE',
     key: '\SYSTEM\CurrentControlSet\services\Schedule'
   }) do
     its('Start') { should eq 2 }
   end

