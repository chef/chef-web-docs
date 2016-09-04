.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

The ``children`` matcher return all of the child items of a registry key. A regular expression may be used to filter child items:

.. code-block:: ruby

   describe registry_key('Key Name', '\path\to\key').children(regex)
     ...
   end

For example, to get all child items for a registry key:

.. code-block:: ruby

   describe registry_key('Task Scheduler','HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet').children do
     it { should_not eq [] }
   end

The following example shows how find a property that may exist against multiple registry keys, and then test that property for every registry key in which that property is located:

.. code-block:: ruby

   describe registry_key({
     hive: HKEY_USERS
   }).children(/^S-1-5-21-[0-9]+-[0-9]+-[0-9]+-[0-9]{3,}\\Software\\Policies\\Microsoft\\Windows\\Installer/).each
     { |key|
       describe registry_key(key) do
         its('AlwaysInstallElevated') { should eq 'value' }
       end
     }
