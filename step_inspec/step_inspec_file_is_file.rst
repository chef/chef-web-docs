.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

.. To test if a path is a file and not a directory:

.. code-block:: bash

   describe file('/proc/version') do
     its('type') { should eq 'file' }
     it { should be_file }
     it { should_not be_directory }
   end
