.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

.. To test an exit status code:

.. code-block:: ruby

   describe command('exit 123') do
     its('stdout') { should eq '' }
     its('stderr') { should eq '' }
     its('exit_status') { should eq 123 }
   end
