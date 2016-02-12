.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

.. To test a cookbook version in a policyfile.lock.json file:

.. code-block:: ruby

   describe json('policyfile.lock.json') do
     its('cookbook_locks.omnibus.version') { should eq('2.2.0') }
   end
