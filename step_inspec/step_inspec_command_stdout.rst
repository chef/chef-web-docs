.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

.. To test standard output (stdout):

.. code-block:: ruby

   describe command('echo hello') do
     its('stdout') { should eq 'hello\n' }
     its('stderr') { should eq '' }
     its('exit_status') { should eq 0 }
   end
