.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

A ``bridge`` |inspec resource| block declares the bridge to be tested and what interface it should be associated with:

.. code-block:: ruby

   describe bridge('br0') do
     it { should exist }
     it { should have_interface 'eth0' }
   end
