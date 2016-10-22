.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


.. To create multiple machines using a loop:

.. code-block:: ruby

   1.upto(10) do |i|
     machine "hadoop#{i}" do
       recipe 'hadoop'
     end
   end
