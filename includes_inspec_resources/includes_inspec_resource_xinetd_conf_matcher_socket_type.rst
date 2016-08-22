.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

The network socket type: ``dgram`` (a datagram-based service), ``raw`` (a service that requires direct access to an IP address), ``stream`` (a stream-based service), or ``seqpacket`` (a service that requires a sequenced packet).

.. code-block:: ruby

   describe xinetd_conf.services('service_name') do
      its('socket_types') { should include 'dgram' }
   end
