.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

The following example shows how to use the InSpec ``file`` audit resource to verify if the ``ntp.conf`` and ``leap-seconds`` files are present, and then the ``command`` resource to verify if Network Time Protocol (NTP) is installed and running:

.. code-block:: ruby

   describe file('/etc/ntp.conf') do
      it { should be_file }
   end
   
   describe file('/etc/ntp.leapseconds') do
     it { should be_file }
   end
   
   describe command('pgrep ntp') do
      its('exit_status') { should eq 0 }
   end
