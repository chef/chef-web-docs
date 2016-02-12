.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

.. To test if eth0 is a secondary interface for bond0:

.. code-block:: ruby

   describe bond('bond0') do
     it { should exist }
     it { should have_interface 'eth0' }
   end
