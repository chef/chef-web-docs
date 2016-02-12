.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

.. To test the group identifier for the root group:

.. code-block:: ruby

   describe group('root') do
     it { should exist }
     its('gid') { should eq 0 }
   end
