.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

.. To only accept requests on secure ports:

.. code-block:: ruby

   describe port(80) do
     it { should_not be_listening }
   end

   describe port(443) do
     it { should be_listening }
     its('protocols') {should eq ['tcp']}
   end
