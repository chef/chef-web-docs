.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

.. To build machines dynamically:

.. code-block:: ruby

   machine 'mario' do
     recipe 'postgresql'
     recipe 'mydb'
     tag 'mydb_master'
   end
   
   num_webservers = 1
   
   1.upto(num_webservers) do |i|
     machine "luigi#{i}" do
       recipe 'apache'
       recipe 'mywebapp'
     end
   end
