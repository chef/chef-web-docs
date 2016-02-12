.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

.. To test if a path is a directory:

.. code-block:: bash

   describe file('/tmp') do
    its('type') { should eq :directory }
    it { should be_directory }
   end
