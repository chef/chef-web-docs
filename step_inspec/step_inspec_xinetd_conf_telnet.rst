.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

.. To test if the yum repo exists:

For example, a ``telnet`` file under ``/etc/xinet.d`` contains the following settings:

.. code-block:: ruby

   service telnet
   {
     disable         = yes
     flags           = REUSE
     socket_type     = stream
     wait            = no
     user            = root
     server          = /usr/sbin/in.telnetd
     log_on_failure  += USERID
   }

Some examples of |inspec| tests that can be run against that file include:

.. code-block:: ruby

   describe xinetd_conf.services('telnet') do
     it { should be_disabled }
   end

and

.. code-block:: ruby

   describe xinetd_conf.services('telnet') do
     its('socket_type') { should include 'stream' }
   end

and

.. code-block:: ruby

   describe xinetd_conf.services('telnet') do
     its('wait') { should eq 'no' }
   end

All three settings can be tested in the same block as well:

.. code-block:: ruby

   describe xinetd_conf.services('telnet') do
     it { should be_disabled }
     its('socket_type') { should include 'stream' }
     its('wait') { should eq 'no' }
   end
