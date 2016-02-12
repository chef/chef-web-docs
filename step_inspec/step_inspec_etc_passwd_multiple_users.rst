.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

.. To test for multiple root users:

.. code-block:: ruby

   describe passwd.uid(0) do
     its('username') { should eq 'root' }
     its('count') { should eq 1 }
   end

   describe passwd.uid(33) do
     its('username') { should eq 'www-data' }
     its('count') { should eq 1 }
   end
