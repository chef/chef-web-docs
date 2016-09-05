.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

.. To test that port 22 is listening and that 65432 is not listening:

.. code-block:: ruby

   describe port(22) do
     it { should be_listening }
     its('protocols') { should include('tcp') }
     its('protocols') { should_not include('udp') }
   end
   
   describe port(65432) do
     it { should_not be_listening }
   end
