.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

.. To test if a file is a symbolic link:

.. code-block:: bash

   describe file('/dev/stdout') do
     its('type') { should eq 'symlink' }
     it { should be_symlink }
     it { should_not be_file }
     it { should_not be_directory }
   end
