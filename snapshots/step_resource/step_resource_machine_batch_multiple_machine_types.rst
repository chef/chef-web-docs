.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


The **machine_batch** resource can be used to converge multiple machine types, in-parallel, even if each machine type has different drivers. For example:

.. code-block:: ruby

   machine_batch do
     machine 'db' do
       recipe 'mysql'
     end
     1.upto(50) do |i|
       machine "#{web}#{i}" do
         recipe 'apache'
       end
     end
   end
