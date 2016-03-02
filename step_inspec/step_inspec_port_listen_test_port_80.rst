.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

.. To test port 80, on a specific address:

A specific port address may be checked using either of the following examples:

.. code-block:: ruby

   describe port(80) do
     it { should be_listening }
     its('addresses') {should include '0.0.0.0'}
   end

or:

.. code-block:: ruby

   describe port('0.0.0.0', 80) do
     it { should be_listening }
   end