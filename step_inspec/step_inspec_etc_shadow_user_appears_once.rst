.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

.. To test that a user appears one time:

.. code-block:: ruby

   describe shadow.users('bin') do
     its('passwords') { should cmp 'x' }
     its('count') { should eq 1 }
   end
