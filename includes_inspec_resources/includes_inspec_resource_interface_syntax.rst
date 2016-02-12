.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

An ``interface`` |inspec resource| block declares network interface properties to be tested:

.. code-block:: ruby

   describe interface do
     it { should be_up }
     its('speed') { should eq 1000 }
     its('name') { should eq eth0 }
   end
