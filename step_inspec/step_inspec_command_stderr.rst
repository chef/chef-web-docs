.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

.. To test standard error (stderr):

.. code-block:: ruby

   describe command('>&2 echo error') do
     its('stdout') { should eq '' }
     its('stderr') { should eq 'error\n' }
     its('exit_status') { should eq 0 }
   end
