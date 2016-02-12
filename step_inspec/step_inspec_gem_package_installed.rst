.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

.. To verify that a gem package is installed, with a specific version:

.. code-block:: ruby

   describe gem('rubocop') do
     it { should be_installed }
     its('version') { should eq '0.33.0' }
   end
