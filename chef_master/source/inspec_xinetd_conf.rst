=====================================================
xinetd_conf
=====================================================

.. include:: ../../includes_inspec_resources/includes_inspec_resource_xinetd_conf.rst

Syntax
-----------------------------------------------------
.. include:: ../../includes_inspec_resources/includes_inspec_resource_xinetd_conf_syntax.rst

Matchers
-----------------------------------------------------
.. include:: ../../includes_inspec_resources/includes_inspec_resource_generic_no_matchers.rst

Examples
-----------------------------------------------------
.. include:: ../../includes_inspec_resources/includes_inspec_resource_generic_examples_intro.rst

**Test a socket_type**

The network socket type: ``dgram`` (a datagram-based service), ``raw`` (a service that requires direct access to an IP address), ``stream`` (a stream-based service), or ``seqpacket`` (a service that requires a sequenced packet).

.. code-block:: ruby

   describe xinetd_conf.services('service_name') do
      its('socket_types') { should include 'dgram' }
   end

**Test a service type**

The type of service: ``INTERNAL`` (a service provided by |xinetd|), ``RPC`` (an RPC-based service), ``TCPMUX`` (a service that is started on a well-known TPCMUX port), or ``UNLISTED`` (a service that is not listed in a standard system file location).

.. code-block:: ruby

   describe xinetd_conf.services('service_name') do
      its('type') { should include 'RPC' }
   end

**Test the telnet service**

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
