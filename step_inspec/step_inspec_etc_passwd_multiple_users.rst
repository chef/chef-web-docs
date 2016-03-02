.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

.. To test for multiple root users:

.. code-block:: ruby

   describe passwd.uids(0) do
     its('users') { should cmp 'root' }
     its('count') { should eq 1 }
   end

   describe passwd.filter(user: 'www-data') do
     its('uids') { should cmp 33 }
     its('count') { should eq 1 }
   end
