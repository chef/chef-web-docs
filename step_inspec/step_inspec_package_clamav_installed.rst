.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

.. To test if ClamAV (an antivirus engine) is installed and running:

.. code-block:: ruby

   describe package('clamav') do
     it { should be_installed }
     its('version') { should eq '0.98.7' }
   end

   describe service('clamd') do
     it { should_not be_enabled }
     it { should_not be_installed }
     it { should_not be_running }
   end
