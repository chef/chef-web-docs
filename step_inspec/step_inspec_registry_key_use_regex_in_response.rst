.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

.. To use a regular expression in the response: 

.. code-block:: ruby

   describe registry_key({
     hive: 'HKEY_LOCAL_MACHINE',
     key: 'SOFTWARE\Microsoft\Windows NT\CurrentVersion'
   }) do
     its('ProductName') { should match /^[a-zA-Z0-9\(\)\s]*2012\s[rR]2[a-zA-Z0-9\(\)\s]*$/ }
   end
