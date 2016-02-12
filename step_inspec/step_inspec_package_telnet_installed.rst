.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

.. To test if telnet is installed:

.. code-block:: ruby

   describe package('telnetd') do
     it { should_not be_installed }
   end

   describe inetd_conf do
     its('telnet') { should eq nil }
   end
