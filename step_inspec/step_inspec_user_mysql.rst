.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

.. To verify available users for the MySQL server:

.. code-block:: ruby

   describe user('root') do
     it { should exist }
     it { should belong_to_group 'root' }
     its('uid') { should eq 0 }
     its('groups') { should eq ['root'] }
   end

   describe user('mysql') do
    it { should_not exist }
   end
