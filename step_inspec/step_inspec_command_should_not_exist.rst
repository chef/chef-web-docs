.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

.. To test for a command that should not exist:

.. code-block:: ruby

   describe command('this is not existing').exist? do
     it { should eq false }
   end
